package mies

import jxl.Cell
import jxl.Sheet
import jxl.Workbook
import jxl.WorkbookSettings

class InicioController extends mies.seguridad.Shield{


    def getValorReal(aa){
        if(aa.reubicada=="S"){
            if (aa.planificado==0)
                return aa.planificado
//            println "ASIGNACION aa --> "+aa.id+" val "+aa.planificado
            def dist = DistribucionAsignacion.findAllByAsignacion(aa)

//            def valor = getValorSinModificacion(aa)
            def valor = aa.planificado
//            println "valor inicial "+valor
            Asignacion.findAllByPadreAndUnidadNotEqual(aa,aa.marcoLogico.proyecto.unidadEjecutora,[sort: "id"]).each { hd->
//                println "hijo directo ------------------>  "+hd.id+" sumando "+hd.planificado
                valor+=getValorHijo(hd)
            }
//            println "valor hijos "+valor
//            def vs = getValorSinModificacion(aa)
            def vs=0
            def mas = ModificacionAsignacion.findAllByDesde(aa)
            def menos = ModificacionAsignacion.findAllByRecibe(aa)

            mas.each {
//                println "asignacion ${aa.id} tienen modificaciones 1 ${it.id}"


                if(it.recibe?.padre?.id==it.desde.id){
//                    println "sumo"
                    vs+=it.valor
                }
//                else
//                    println "no sumo"


            }
//            menos.each {
//                println "asignacion ${aa.id} tienen modificaciones 2 ${it.id}"
//
//                    vs-=it.valor
//                    println "resto"
//
//
//            }
//            println "valor de la original sin mods "+vs
//
//            println "valor total "+(valor+vs)
            valor+=vs
            dist.each {
                println "restando distribucion "+it.id+" -->  "+it.valor
                valor=valor-it.valor
            }
//            println "valor "+valor
//            println "-------------------------------"

            if (valor>aa.planificado)
                valor=aa.planificado
            if (valor<0)
                valor=0

            return valor
        }else{
            return aa.planificado
        }

    }

    def getValorHijo(asg){
        // println "get valor hijo "+asg.id
        def hijos = Asignacion.findAllByPadre(asg)
        //println "hijos "+hijos
        def val=0
        hijos.each {
            val += getValorHijo(it)
        }
        // println "return "+(val+asg.planificado)
        val = val+getValorSinModificacion(asg)
//        println "valor hijo "+asg.id+"  --> "+val
//        println ""
        return val
    }

    def getValorSinModificacion(asg){

        def valor = asg.planificado
        def mas = ModificacionAsignacion.findAllByDesde(asg)
        def menos = ModificacionAsignacion.findAllByRecibe(asg)

        mas.each {
//            println "asignacion ${asg.id} tienen modificaciones 1 ${it.id}"


            if(it.recibe?.padre?.id!=it.desde.id){
                println "sumo"
                valor+=it.valor
            }
//
//            }else
//                println "no sumo"


        }
        menos.each {
//            println "asignacion ${asg.id} tienen modificaciones 2 ${it.id}"

            if(it.recibe?.padre?.id!=it.desde.id && it.desde?.padre?.id!=it.recibe.id){
                valor-=it.valor
            }
//                println "resto"
//            }else
//                println "no sumo"



        }

//        println "valor mods  "+asg.id+"  --> "+valor

        return valor


    }


    def index = {

//        def asi = Asignacion.get(2631)
//        def val = 450000
//        def hijos = Asignacion.findAllByPadre(asi)
//        println "hijos "+hijos
//        def mods= ModificacionAsignacion.findAllByDesdeOrRecibe(asi,asi,[sort: "id"])
//        mods.each {
//
//            if (it.desde.id==2631){
//                println "+  "+it.id+"  "+it.fecha+"  "+it.valor+"  "+it.desde.id
//                val=val-it.valor
//            }else{
//                println "-  "+it.id+"  "+it.fecha+"  "+it.valor +"  "+it.recibe.id
//                val=val+it.valor
//            }
//        }
//        println "valor final "+val

        if(!session.unidad){
            redirect(controller:"login",action: "logout")
        }
//
//        def aa = Asignacion.get(4469)
//        println "get valor real "+getValorReal(aa)






    }

    def mostrarAlertas = {
        //ejemplo de como mandar alertas
        //kerberosService.generarAlerta(session.usuario,finix.seguridad.Usro.get(48),"que eres pal burro","proceso","show",8)
        //        println "alertas "+alertas
        def alertas = mies.alertas.Alerta.findAllByUsroAndFec_recibido(session.usuario,null,[sort:"fec_envio"])
        return [alertas:alertas]
    }

    def showAlerta = {
        def alerta = mies.alertas.Alerta.get(params.id)
        alerta.fec_recibido=new Date()
        alerta.save(flush:true)
        params.id=alerta.id_remoto
        redirect(controller:alerta.controlador,action:alerta.accion,params:params)
    }

    def parametros = {

    }

    def verificarSession = {
        println "verificando session "
        if(session.usuario && session.perfil)
            render "ok"
        else
            render "no"
    }




    def cargarExcel() {

    }

    def uploadFile() {

        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {

                fileName = "xlsAsg_" + new Date().format("yyyyMMdd_HHmmss")

                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos"
                def fila = 0
                def cnta = 0
                def cntaEr = 0
                def actual = 0
                def zona = ""
                def coor = ""
                def busca = ""
                def unej
                def txto = ""
                def nmbr
                def bsca
                def meses = []

                def error = ""
                def eranUnej = ""
                def contunej = [:]
                def err_unej = ""
                def err_obop = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
                            fila++
//                        println row*.getContents()

                            if (row[4].getContents().trim() != 'PROVINCIA' && row[3].getContents().trim().size() > 10) {
                                zona = row[0].getContents().split('_').toList()[0]
                                coor = row[2].getContents().split('_').toList()
                                if(coor.size() > 2) {
                                    nmbr = "${coor[0]} ${coor[1]} ${coor[2]}"
                                } else {
                                    nmbr = "${coor[0]} ${coor[1]}"
                                }
                                bsca = "%${nmbr}%"
                                busca = row[2].getContents().replaceAll('_', ' ')
                                unej = hallaUnej(zona, coor, nmbr, bsca)

                                if (unej) {
                                    cnta++
//                                    if (actual != unej.id) {
//                                        txto += "\n${unej.id} ${unej.nombre}"
//                                        actual = unej.id
//                                    }
                                } else {
                                    error = "UNEJ"
                                    contunej[nmbr] = contunej.get(nmbr,0) + 1
                                    if(eranUnej != nmbr) {
                                        eranUnej = nmbr
                                        err_unej += "$nmbr<br/>"
                                    }
                                }
                                txto = row[7].getContents()[4..25]
                                def plnd = PlanDesarrollo.findByDescripcionIlike("%${txto}%")
//                                println "busca: '${txto}', plan: $plnd"

                                txto = row[10].getContents()
                                txto = txto[15..txto.size() - 5]
                                def obop = ObjetivoOperativo.findByDescripcionIlike("%${txto}%")
                                if(!obop) {
                                    error = "OBOP"
                                    contunej[txto] = contunej.get(txto,0) + 1
                                    if(eranUnej != txto) {
                                        eranUnej = txto
                                    }
                                    println "en $fila no halla: '${txto}'"
                                    cntaEr++
                                }

                                txto = row[31].getContents()
                                def pgps = ProgramaPresupuestario.findByCodigo(txto)
                                if(!pgps) {
                                    error = "PGPS"
                                    println "en $fila no halla PGPS: '${txto}'"
                                    cntaEr++
                                }

                                txto = row[33].getContents()
                                def acps = ActividadPresupuesto.findByCodigo(txto)
                                if(!pgps) {
                                    error = "PGPS"
                                    println "en $fila no halla PGPS: '${txto}'"
                                    cntaEr++
                                }

                                txto = row[35].getContents()
                                def plig = null
                                if(txto != '00 00'){
                                    plig = PoliticasIgualdad.findByCodigo(txto)
                                    if(!plig) {
                                        error = "PLIG"
                                        println "en $fila no halla PLIG: '${txto}'"
                                        cntaEr++
                                    }
                                }

                                txto = row[38].getContents()
                                def prsp = Presupuesto.findByNumero(txto)
                                if(!pgps) {
                                    error = "PRSP"
                                    println "en $fila no halla PRSP: '${txto}'"
                                    cntaEr++
                                }

                            }
                        }
                    }


                }

                println "procesados $cnta registros, con $cntaEr errores"
                println txto

                def str = "<h3>Se han ingresado correctamente ${cnta - 1} registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                    str += contunej.sort{it.value}
                    str += err_unej
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
            flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
            redirect(action: 'cargarExcel')
            }
        } else {
        flash.message = "Seleccione un archivo para procesar"
        redirect(action: 'cargarExcel')
    }

}

    def subeEsigef() {
        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
                fileName = "tbla_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos"
                def cnta = 0
                def html = ""
                def error = ""
                def ok = false
                def actual = 0
                def prgrcdgo = ""
                def prgrdscr = ""
                def actvcdgo = ""
                def actvdscr = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
//                        println row*.getContents()
//                        println row[4].getContents()

                            if (row[0].getContents().trim() != 'NO.' && row[0].getContents().trim()) {

                                println "--- ${row[0].getContents()} ----- ${row[1].getContents()}"

                                prgrcdgo = row[0].getContents()
                                prgrdscr = row[1].getContents()
                                actvcdgo = row[2].getContents()
                                actvdscr = row[3].getContents()

                                def pgps = ProgramaPresupuestario.findAllByCodigo(prgrcdgo)
                                if (pgps.size() == 1) {
                                    //ok
                                    pgps = pgps[0]
//                                } else if (pgps.size() == 0) {
                                } else {
                                    pgps = new ProgramaPresupuestario()
                                    pgps.codigo = row[0].getContents()
                                    pgps.descripcion = row[1].getContents()
                                }
                                if (pgps.save(flush: true)) {
                                    def acps = ActividadPresupuesto.findAllByProgramaPresupuestarioAndCodigo(pgps, actvcdgo)
                                    if (acps.size() == 1) {
                                        ok = false
                                        error += "<li>actividad repetida: ${actvcdgo} ${actvdscr}</li>"
                                    } else {
                                        acps = new ActividadPresupuesto()
                                        acps.programaPresupuestario = pgps
                                        acps.codigo = row[2].getContents()
                                        acps.descripcion = row[3].getContents()
                                        acps.save(flush: true)
                                        cnta++
                                    }
                                }

//                            println "halla: ${unej?.nombre}"

                            }
                        }
                    }

                }

                def str = "<h3>Se han ingresado correctamente " + cnta + " registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'cargarExcel')
            }

        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarExcel')
        }

    }

    def subePlig() {
        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
                fileName = "plig_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos"
                def cnta = 0
                def html = ""
                def error = ""
                def ok = false
                def actual = 0
                def cdgo = ""
                def dscr = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {   hallaUnej(zona, coor, nmbr, busca)
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
//                        println row*.getContents()
//                        println row[4].getContents()

                            if (row[0].getContents().trim() != 'NO.' && row[0].getContents().trim()) {

                                println "--- ${row[0].getContents()} ----- ${row[1].getContents()}"

                                cdgo = row[0].getContents()
                                dscr = row[1].getContents()

                                def plig = PoliticasIgualdad.findAllByCodigo(cdgo)
                                if (plig.size() == 0) {
                                    plig = new PoliticasIgualdad()
                                    plig.codigo = cdgo
                                    plig.descripcion = dscr
                                }
                                if (plig.save(flush: true)) {
                                    cnta++
                                }
                           }
                        }
                    }

                }

                def str = "<h3>Se han ingresado correctamente " + cnta + " registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'cargarExcel')
            }

        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarExcel')
        }

    }

    def subeObei() {
        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
                fileName = "ob_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos obei"
                def cnta = 0
                def html = ""
                def error = ""
                def ok = false
                def actual = 0
                def cdgo = ""
                def dscr = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
//                        println row*.getContents()
//                        println row[4].getContents()

                            if (row[0].getContents().trim() != 'NO.' && row[0].getContents().trim()) {

                                println "--- ${row[0].getContents()} ----- ${row[1].getContents()}"

                                cdgo = row[0].getContents().trim()
                                dscr = row[1].getContents().trim()

                                def obei = ObjetivoInstitucional.findAllByDescripcionIlike(dscr + '%')
                                if (obei.size() == 0) {
                                    obei = new ObjetivoInstitucional()
                                    obei.codigo = cdgo
                                    obei.descripcion = dscr
                                    if (obei.save(flush: true)) {
                                        cnta++
                                    }
                                }
                           }
                        }
                    }

                }

                def str = "<h3>Se han ingresado correctamente " + cnta + " registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'cargarExcel')
            }

        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarExcel')
        }

    }

    def subeObep() {
        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
                fileName = "ob_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos obei"
                def cnta = 1
                def html = ""
                def error = ""
                def ok = false
                def actual = 0
                def obei = ""
                def dscr = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
//                        println row*.getContents()
//                        println row[4].getContents()

                            if (row[0].getContents().trim() != 'N1' && row[0].getContents().trim()) {

//                                println "--- ${row[0].getContents()} ----- ${row[1].getContents()}"

                                obei = row[0].getContents().trim()
                                dscr = row[1].getContents().trim()

                                def objt = ObjetivoInstitucional.findAllByDescripcionIlike(obei + '%')
                                def obep
                                println "halla: ${objt.id}, ${objt.size()}"
                                if (objt.size() == 1) {
                                    def ob = objt[0]
                                    obep = new ObjetivoEspecifico()
                                    obep.codigo = cnta
                                    obep.objetivoInstitucional = ob
                                    obep.descripcion = dscr
                                    println "...creando ${ob.id} con $obei"
                                    if (obep.save(flush: true)) {
                                        cnta++
                                    }
                                } else {
                                    println "no se ha encontrado: ${obei}"
                                    error += "<li>obei</li>"
                                }
                           }
                        }
                    }

                }

                def str = "<h3>Se han ingresado correctamente ${cnta - 1} registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'cargarExcel')
            }

        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarExcel')
        }

    }

    def subeObop() {
        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
                fileName = "obn4_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos obop"
                def cnta = 1
                def html = ""
                def error = ""
                def ok = false
                def actual = 0
                def obei = ""
                def dscr = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
//                        println row*.getContents()
//                        println row[4].getContents()

                            if (row[0].getContents().trim() != 'N1' && row[0].getContents().trim()) {

//                                println "--- ${row[0].getContents()} ----- ${row[1].getContents()}"

                                obei = row[1].getContents().trim()
                                dscr = row[2].getContents().trim()

                                def objt = ObjetivoEspecifico.findAllByDescripcionIlike(obei + '%')
                                def obop
                                println "halla N2: ${objt.id}, ${objt.size()}"
                                if (objt.size() == 1) {
                                    def ob = objt[0]
                                    obop = new ObjetivoOperativo()
                                    obop.codigo = cnta
                                    obop.objetivoEspecifico = ob
                                    obop.descripcion = dscr
                                    println "...creando ${ob.id} con $obei"
                                    if (obop.save(flush: true)) {
                                        cnta++
                                    }
                                } else {
                                    println "no se ha encontrado: ${obei}"
                                    error += "<li>obei</li>"
                                }
                           }
                        }
                    }

                }

                def str = "<h3>Se han ingresado correctamente ${cnta - 1} registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'cargarExcel')
            }

        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarExcel')
        }

    }

    def subePrsp() {
        def path = servletContext.getRealPath("/") + "xls/"   //web-app/archivos
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
                fileName = "prsp_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                println "carga el archivo en $pathFile"

                def file = new File(pathFile)
                WorkbookSettings ws = new WorkbookSettings();
                ws.setEncoding("Cp1252");
                Workbook workbook = Workbook.getWorkbook(file, ws)
                println "inicia proceso de datos obop"
                def cnta = 1
                def html = ""
                def error = ""
                def ok = false
                def actual = 0
                def nmro = ""
                def dscr = ""

                workbook.getNumberOfSheets().times { sheet ->
//                println("hojas " + sheet)
                    Sheet s = workbook.getSheet(sheet)

                    if (!s.getSettings().isHidden()) {
                        Cell[] row = null
                        s.getRows().times { j ->
                            row = s.getRow(j)
//                        println row*.getContents()
//                        println row[4].getContents()

                            if (row[0].getContents().trim() != 'NO.' && row[0].getContents().trim()) {

//                                println "--- ${row[0].getContents()} ----- ${row[1].getContents()}"

                                nmro = row[0].getContents().trim()
                                dscr = row[1].getContents().trim()

                                def prsp
                                    prsp = new Presupuesto()
                                    prsp.numero = nmro
                                    prsp.descripcion = dscr
                                    if (prsp.save(flush: true)) {
                                        cnta++
                                    }

                           }
                        }
                    }

                }

                def str = "<h3>Se han ingresado correctamente ${cnta - 1} registros</h3>"
                if (error != "") {
                    str += "<ol>" + error + "</ol>"
                }
                flash.message = str
                println "Rerealizado...."

                redirect(action: "mensajeUpload")

            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'cargarExcel')
            }

        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarExcel')
        }

    }


    def mensajeUpload = {

    }

    def hallaUnej(zona, coor, nmbr, busca) {
        def unej
        if ((zona == 'COORDINACIONES') && (coor[0] == 'COORDINACIÓN')) {
//                                println "busca: $nmbr, zona: $zona"
            unej = UnidadEjecutora.findByNombreIlike(nmbr)
        } else if (zona == 'COORDINACIONES') {
//                                println "+++busca: %${coor[2]}%"
            unej = UnidadEjecutora.findByNombreIlike("%${coor[2]}%")
        } else if (zona == 'PLANTA') {
            unej = UnidadEjecutora.findByNombreIlike("%${busca}%")
        }
//                            println "halla: ${unej?.nombre}"
        if (unej) {
            return unej
        } else {
            return null
        }
    }

}



