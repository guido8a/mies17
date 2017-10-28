package mies

class EjecucionUEController {

    def dbConnectionService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "ejecucionue.list", default: "EjecucionUE List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [ejecucionUEInstanceList: EjecucionUE.list(params), ejecucionUEInstanceTotal: EjecucionUE.count(), title: title, params: params]
    }

    def form = {
        def title
        def ejecucionUEInstance

        if (params.source == "create") {
            ejecucionUEInstance = new EjecucionUE()
            ejecucionUEInstance.properties = params
            title = g.message(code: "ejecucionue.create", default: "Create EjecucionUE")
        } else if (params.source == "edit") {
            ejecucionUEInstance = EjecucionUE.get(params.id)
            if (!ejecucionUEInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "ejecucionue.edit", default: "Edit EjecucionUE")
        }

        return [ejecucionUEInstance: ejecucionUEInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "ejecucionue.edit", default: "Edit EjecucionUE")
            def ejecucionUEInstance = EjecucionUE.get(params.id)
            if (ejecucionUEInstance) {
                ejecucionUEInstance.properties = params
                if (!ejecucionUEInstance.hasErrors() && ejecucionUEInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), ejecucionUEInstance.id])}"
                    redirect(action: "show", id: ejecucionUEInstance.id)
                }
                else {
                    render(view: "form", model: [ejecucionUEInstance: ejecucionUEInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "ejecucionue.create", default: "Create EjecucionUE")
            def ejecucionUEInstance = new EjecucionUE(params)
            if (ejecucionUEInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), ejecucionUEInstance.id])}"
                redirect(action: "show", id: ejecucionUEInstance.id)
            }
            else {
                render(view: "form", model: [ejecucionUEInstance: ejecucionUEInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def ejecucionUEInstance = EjecucionUE.get(params.id)
        if (ejecucionUEInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ejecucionUEInstance.version > version) {

                    ejecucionUEInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'ejecucionUE.label', default: 'EjecucionUE')] as Object[], "Another user has updated this EjecucionUE while you were editing")
                    render(view: "edit", model: [ejecucionUEInstance: ejecucionUEInstance])
                    return
                }
            }
            ejecucionUEInstance.properties = params
            if (!ejecucionUEInstance.hasErrors() && ejecucionUEInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), ejecucionUEInstance.id])}"
                redirect(action: "show", id: ejecucionUEInstance.id)
            }
            else {
                render(view: "edit", model: [ejecucionUEInstance: ejecucionUEInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def ejecucionUEInstance = EjecucionUE.get(params.id)
        if (!ejecucionUEInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "ejecucionue.show", default: "Show EjecucionUE")

            [ejecucionUEInstance: ejecucionUEInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def ejecucionUEInstance = EjecucionUE.get(params.id)
        if (ejecucionUEInstance) {
            try {
                ejecucionUEInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucionUE.label', default: 'EjecucionUE'), params.id])}"
            redirect(action: "list")
        }
    }

    /** subir el archivo **/

    def subirEsigef = {
    }

    def subirArchivo = {
        //println "Parametros de subirArchivo: $params"
        def parametros = [:]
        parametros.unidad = params.unidad
        parametros.anio   = params.anio
        parametros.fuente = params.fuente
        def cn = dbConnectionService.getConnection()
        def txSql = ""
        def resultado = []
        def str = ""
        def enter = "<br/>"
        def errores = ""
        def warns = ""

        def webRootDir = servletContext.getRealPath("/")
        def uploadedFile = request.getFile('file')
        if (!uploadedFile.empty) {
            //println "archivo subido... $"
            def userDir = new File(webRootDir, "/esigef")
            userDir.mkdirs()

            def nom = uploadedFile.originalFilename
            nom = nom.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç !¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")
            println "archivo a almacenar en ../esigef/$nom"
            def input = new File(userDir, nom)
            if (!input.exists()) {
                uploadedFile.transferTo(new File(userDir, nom))
                //println "No existe el archivo"
                // carga datos
            } else {
                //println "Ya existe el archivo"
                str += "Ya existe un archivo con ese nombre, por favor cambielo e intente de nuevo"
                //return
            }
            parametros.directorio= userDir
            parametros.archivo   = nom
            resultado = ejecucion(parametros)
        }
        str += enter + enter
        str += errores + enter + enter + warns + enter + enter
        str += (g.link(action: "ejecucion") { "Ver Resultados" })

        def datos =[:]
//        txSql = "select p.pgps__id as pgps,a.prsp__id as prsp,a.fnte__id as fnte,sum(a.asgnplan) as sum from asgn a,mrlg m,proy p where a.mrlg__id=m.mrlg__id and m.proy__id=p.proy__id and a.unej__id=${params.unidad.toInteger()} group by 1,2,3"
        txSql = "select p.pgps__id as pgps,a.prsp__id as prsp,sum(a.asgnplan) as sum from asgn a,mrlg m,proy p where a.mrlg__id=m.mrlg__id and m.proy__id=p.proy__id and a.unej__id=${params.unidad.toInteger()} group by 1,2"
        println "tzt "+txSql
        def tmp = [:]
        cn.eachRow(txSql){r ->
            //println "row "+r
            if (!datos[r.pgps.toString()]){
                tmp.put(r.prsp.toString(),r.sum)
                datos.put(r.pgps.toString(),tmp)

            }else{
                if (!datos[r.pgps.toString()][r.prsp.toString()]){
                    datos[r.pgps.toString()].put(r.prsp.toString(),r.sum)
                }else{
                    datos[r.pgps.toString()][r.prsp.toString()]+=r.sum

                }
            }
            tmp=[:]
        }


        println "datos "+datos

        txSql = "select pgps__id as pgps,prsp__id as prsp,sum(asgnplan) as sum from asgn where unej__id=${params.unidad.toInteger()} group by 1,2 order by 1,2"
        println "corrientes "+txSql
        cn.eachRow(txSql){r ->
//            println "row "+r
            if (!datos[r.pgps.toString()]){
                tmp.put(r.prsp.toString(),r.sum)
                datos.put(r.pgps.toString(),tmp)
                println "1 puso "+r.pgps+" "+r.prsp+"   --> "+datos[r.pgps.toString()]
            }else{
                // println "no encontro "+r.pgps.toString()
                if (!datos[r.pgps.toString()][r.prsp.toString()]){
                    println "2"
                    datos[r.pgps.toString()].put(r.prsp.toString(),r.sum)
                }else{

                    datos[r.pgps.toString()][r.prsp.toString()]+=r.sum
                    println "3 "+  datos[r.pgps.toString()]

                }
            }
            tmp=[:]
        }
//        println "datos !! "+datos
        //render str
        //println "---------------------- $resultado"
        render(view: "ejecucion", model: [resultado: resultado,datos:datos])
    }

    /** jecución eSIGEF, obtenida para una UE, y gastos corrientes
     * Parámetros: Archivo, Unidad Ejecutora, año,fuente
     * **/
    def ejecucion(pr) {
        def resultado = []
        def p_file = new File(pr.directorio, pr.archivo)
        def p_unej = pr.unidad //Mies Bolivar -> 63
        def p_anio = pr.anio   // 2012 -> 3
        def p_fnte = pr.fuente // recursos fiscales -> 1
        //println procesaLinea('primera, linea de datos, 1,2,3,01230013  , "124,213" , "212,21"')
        def unej = UnidadEjecutora.get(p_unej)
        def anio = Anio.get(p_anio)
        def fnte = Fuente.get(p_fnte)

        def fecha = new Date()
        def datos = []

        def primera = 1
        def i = 0
        def diff = 0.0
        def plan = 0.0
        p_file.eachLine { ln ->
            if (primera) {
                primera = 0
            } else {
                println "antes:" + ln.split(",")
                if (ln?.size() > 10) {
                    def dt = procesaLinea(ln)
//                      println " linea "+dt
//                    println "programa "+dt[17].tokenize()[0]
//                    println "presupuesto "+dt[20].tokenize()[0]
//                    println "vigente "+  dt[7]
//                    println "compromentido "+dt[9]
//                    println "fuente "+dt[20]
                    // println " 16 "+dt[16]
                    // println " 17 "+dt[17]
                    //println " 18 "+dt[20]

                    def pgps = ProgramaPresupuestario.findByCodigo(dt[17].tokenize()[0])
                    //  println "pgps "+pgps+"    "+dt[17]
                    def prsp = Presupuesto.findByNumero(dt[20].tokenize()[0])
                    def fuenteDato = Fuente.findByCodigo(dt[20].tokenize()[2])
                    def error = ""
                    if (!fuenteDato)
                        error+="Fuente no registrada en el sistema (${dt[20].tokenize()[2]}); "
                    if (!pgps)
                        error+="Programa no registrado en el sistema (${dt[17].tokenize()[0]}); "
                    if (!prsp)
                        error+="Partida no registrada en el sistema (${dt[20].tokenize()[0]}); "



                    def datosEsigef= new DatosEsigef([fecha:fecha, programa: pgps, presupuesto:prsp, vigente: dt[7].toDouble(), compromentido:dt[9].toDouble(), fuente:fuenteDato, errores:error, unidad:unej])
                    def repetidos = DatosEsigef.findAll("from DatosEsigef  where  programa=${pgps?.id} and presupuesto=${prsp?.id} and fuente=${fuenteDato?.id} and unidad=${unej.id}")
                    //println "sql rep "+"from DatosEsigef  where  programa=${pgps?.id} and presupuesto=${prsp?.id} and fuente=${fuenteDato?.id} and unidad=${unej.id}"

                    def repetido
                    repetidos.each {rp->
                        if(rp.fecha==fecha)
                            repetido=rp
                    }
                    //println "r " +repetido?.id
                    if (repetido){

                        // println "repetido !!!! "+repetido
                        repetido.vigente+=dt[7].toDouble()
                        repetido.comprometido+=dt[9].toDouble()
                        if (!repetido.save(flush: true))
                            println "error dato repetido "+datosEsigef.errors
//                        println "1era "+repetido
//                        println "2da "+datosEsigef
//                        println ln
//                        println " -----------------------------------   2012-05-16 11:11:09.279   "
                    }else{
                        //println "no repetido "+datosEsigef.presupuesto+"  "+datosEsigef.vigente
                        if (!datosEsigef.save(flush: true))
                            println "error dato "+datosEsigef.errors
                        else
                            datos.add(datosEsigef)
                    }




//                    println "fin linea ----------------------------------------------------------------------------------------------------- "
///*
//                def asgn = Asignacion.findAll("from Asignacion as asgn where prsp__id = :prsp and unej__id = :unej and " +
//                       "anio__id = :anio and pgps__id = :pgps",[prsp: prsp.id, unej: unej.id, anio: anio.id, pgps: pgps.id])
//*/
//                    def asgn = Asignacion.withCriteria{
//                        and{
//                            eq("presupuesto", prsp)
//                            eq("unidad", unej)
//                            eq("anio", anio)
//                            //eq("programa", pgps)
//                        }
//                        projections {
//                            sum "planificado"
//                        }
//
//                    }
//                    plan = asgn.sum()? asgn.sum() : 0
//
//                    if (plan == 0.0) {  // ver si hay dineros en Inversión
//                        txSql = "select sum(asgnplan) suma from asgn, proy, mrlg where prsp__id = ${prsp?.id} and " +
///*
//                              "mrlg.mrlg__id = asgn.mrlg__id and proy.proy__id = mrlg.proy__id and proy.pgps__id = " +
//                              "${pgps?.id} and asgn.unej__id = ${unej?.id} and asgn.anio__id = ${anio?.id}"
//*/
//                                "mrlg.mrlg__id = asgn.mrlg__id and proy.proy__id = mrlg.proy__id and " +
//                                "asgn.unej__id = ${unej?.id} and asgn.anio__id = ${anio?.id}"
//                        //println txSql
//                        cn.eachRow(txSql){r ->
//                            plan = r.suma? r.suma : 0
//                        }
//                    }
//
//                    diff = dt[7]?.toFloat() - plan
//                    resultado << [programa: dt[5].tokenize()[3], partida: dt[20].tokenize()[0], vigente: dt[7], planificado: plan, diferencia: diff]
//                    resultado = resultado.sort({it.partida})
//                    //println "Programa ${dt[18].tokenize()[3]} Partida: ${dt[20].tokenize()[0]}, vigente: ${dt[7]}, planificado: ${plan}" +
//                    " diferencia: ${diff}"
//
///*
//                if (i < 10) {
//                    //println "presupuesto: ${prsp?.id}, unej: ${unej?.id}, anio: ${anio?.id} pgps: ${pgps?.id}"
//                    println "Programa ${dt[18].tokenize()[3]} Partida: ${dt[20].tokenize()[0]}, vigente: ${dt[7]}, planificado: ${plan}" +
//                            " diferencia: ${diff}"
//                    i++
//                }
//*/

                }
            }
        }
        datos.sort{it.programa?.id?.toInteger()}
        return datos
    }

    /** lee la linea CSV e interpreta los números con comas expresados con "99,99" como 99.99 **/
    def procesaLinea(ln) {
        def data = []
        def i = 0
        def tx = ''
        while (i < ln.size()) {
            if (ln[i] == '"') {
                i++
                def numero = ln[i]
                i++
                while (ln[i] != '"') {
                    numero += ln[i]
                    i++
                }
                i++
                numero = numero.replaceAll(/,/, '.')
                if (i < ln.size() - 1) tx = numero; else data << numero
                continue
            }
            if (ln[i] == ',' || ln[i]==";") {
                data << tx.trim()
                tx = ''
            } else {
                //tx.replaceAll('"','')

                tx += ln[i]
            }
            i++

        }
        if (tx) data << tx.trim()
        return data
    }

}
