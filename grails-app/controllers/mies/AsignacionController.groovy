package mies

class AsignacionController extends mies.seguridad.Shield {

    def kerberosService

    static allowedMethods = [guardarAsignacion: "POST"]

//    def kerberosService

    /*TODO chequear el estado de los proyectos antes de sacar las asignaciones*/

    def asignacionesProyecto = {
        println "params " + params
        def unidad = UnidadEjecutora.get(params.id)
        def proyectos = Proyecto.findAllByUnidadEjecutora(unidad)
        def datos = []
        def fuentes = [:]
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        proyectos.each {proyecto ->
            fuentes.put(proyecto.id.toString(), Financiamiento.findAllByProyecto(proyecto).fuente)
            def componentes = MarcoLogico.findAll("from MarcoLogico where proyecto = ${proyecto.id} and tipoElemento = 2 and estado = 0")
            if (componentes.size() > 0) {
                def temp = new HashMap()
                temp.put("" + proyecto.id + "!" + proyecto.toStringLargo(), componentes)
                datos.add(temp)
            }

        }

        [unidad: unidad, datos: datos, fuentes: fuentes, actual: actual]

    }


    def asignacionProyecto = {
        //println "params " + params
        def proyecto = Proyecto.get(params.id)
        def fuentes = Financiamiento.findAllByProyecto(proyecto).fuente
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()


        [fuentes: fuentes, actual: actual, proyecto: proyecto]


    }


    def asignacionProyectov2 = {
        println "params " + params
        def proyecto = Proyecto.get(params.id)
        def asignaciones = []
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()

        def total = 0
        def totalUnidad = 0
        def maxInv = 0
        MarcoLogico.findAll("from MarcoLogico where proyecto = ${proyecto.id} and tipoElemento=3 and estado=0").each {
            def asig = Asignacion.findAll("from Asignacion where marcoLogico=${it.id} and anio=${actual.id} and unidad=${proyecto.unidadEjecutora.id}  order by id")
            if (asig){
                asignaciones += asig
                asig.each{asg->
                    total = total+asg.getValorReal()
                }
            }
        }
        asignaciones.sort{it.presupuesto.numero}

        Asignacion.findAllByUnidadAndMarcoLogicoIsNotNull(proyecto.unidadEjecutora).each{
            totalUnidad = totalUnidad+it.getValorReal()
        }
        maxInv=PresupuestoUnidad.findByAnioAndUnidad(actual,proyecto.unidadEjecutora)?.maxInversion

        println("--- " + proyecto.unidadEjecutora.nombre)

        [asignaciones: asignaciones, actual: actual, proyecto: proyecto,total: total,totalUnidad: totalUnidad,maxInv:maxInv]


    }

//    def enviarUnidad = {
//        def asg = Asignacion.get(params.id)
//        if (params.unidad!="-1")
//            asg.unidadRecibe=UnidadEjecutora.get(params.unidad)
//        else
//            asg.unidadRecibe=null
//        asg = kerberosService.saveObject(asg, Asignacion, session.perfil, session.usuario, "enviarUnidad", "asginacion", session)
//        render "ok"
//    }


    def programacionInversion = {
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        //def unidad =UnidadEjecutora.get(params.id)
        def unidad = UnidadEjecutora.get(params.id)
        def dist = DistribucionAsignacion.findAllByUnidadEjecutora(unidad)
        def asg = []
        dist.each {
            if(it.asignacion.anio==actual){
                asg.add(it.asignacion)
            }
        }
        def asgInv = Asignacion.findAll("from Asignacion  where marcoLogico is not null and unidad=${unidad.id} " )
        def meses = []
        12.times {meses.add(it + 1)}
        [inversiones: asgInv,dist: asg, actual: actual, meses: meses,unidad: unidad]
    }

    def programacionAsignacionesInversion = {
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        //def unidad =UnidadEjecutora.get(params.id)

        def proyecto = Proyecto.get(params.id)

        def asgProy = []
        MarcoLogico.findAll("from MarcoLogico where proyecto = ${proyecto.id} and tipoElemento=3 and estado=0").each {
            def asig = Asignacion.findAllByMarcoLogicoAndAnio(it, actual, [sort: "id"])
            if (asig)
                asgProy += asig
        }
        def meses = []
        12.times {meses.add(it + 1)}
        [inversiones: asgProy, actual: actual, meses: meses, proyecto: proyecto]
    }

    def asinacionesInversion = {

        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        def unidad = UnidadEjecutora.get(params.id)

        def asg = []
        def dist = DistribucionAsignacion.findAllByUnidadEjecutora(unidad)
        dist.each {
            if(it.asignacion.anio==actual){
                asg.add(it.asignacion)
            }
        }
        def asgInv = Asignacion.findAll("from Asignacion  where marcoLogico is not null and unidad = ${unidad.id}  order by id desc" )
        // println "asgInv "+asgInv.id

        def proyectos = Proyecto.findAllByUnidadEjecutora(unidad)

        def marcos = MarcoLogico.findAllByProyectoAndTipoElemento(Proyecto.get(7),TipoElemento.get(3))
        println "marcos "+marcos.id
        def a = []
        def total = 0
        marcos.each {marco->
            def tmp = Asignacion.findAllByMarcoLogico(marco)
            tmp.each {
                total+=it.planificado
            }
//            if (tmp)
//                a+=tmp
        }

//        a.each {a1->
//             Asignacion.findAllByPadre(a1).each {a2->
//                 Asignacion.findAllByPadre(a2).each {a3->
//                      total+=a3.planificado
//                 }
//                 total+=a2.planificado
//             }
//            total+=a1.planificado
//        }

        println "total "+total

        [asgs:asg, proyectos:proyectos, actual: actual, unidad: unidad, asgInv:asgInv]

    }

    def enviarUnidad = {
        println("params " + params)
        def asgn = Asignacion.get(params.id)
        if(params.unidad){

            def unidad = UnidadEjecutora.get(params.unidad)
            def monto = params.monto.toDouble()

            def dist = new DistribucionAsignacion()
            def ds = DistribucionAsignacion.findByAsignacionAndUnidadEjecutora(asgn,unidad)
            if (ds)
                dist=ds
            dist.valor=dist.valor+monto
            dist.unidadEjecutora=unidad
            dist.asignacion=asgn
            dist = kerberosService.saveObject(dist,DistribucionAsignacion,session.perfil,session.usuario,"enviarUnidad","asginacion",session)
            if (asgn.reubicada!="S"){
                asgn.reubicada="S"
                asgn.save(flush: true)
            }
        }

        def d = DistribucionAsignacion.findAllByAsignacion(asgn,[sort: "id"])
        [dist:d,asg: asgn]

    }




    def eliminarDistribucion = {
        def asgn = DistribucionAsignacion.get(params.id).asignacion
        def dist = kerberosService.delete(params,DistribucionAsignacion,session.perfil,session.usuario)
        if (!DistribucionAsignacion.findAllByAsignacion(asgn)){
            asgn.reubicada="N"
            asgn.save(flush: true)
        }
        redirect(action: "enviarUnidad",params: [id: asgn.id])

    }

    def asignacionesCorrientes = {

        def unidad = UnidadEjecutora.get(params.id)
        def cinco = Actividad.findAll("from Actividad where codigo like '5%' order by codigo")
        def ocho = Actividad.findAll("from Actividad where codigo like '8%' order by codigo")
        def nueve = Actividad.findAll("from Actividad where codigo like '9%' order by codigo")
        def fuentes = Fuente.list([sort: 'descripcion'])
        def programas = ProgramaPresupuestario.list([sort: 'descripcion'])
        def tipoGastos = TipoGasto.list([sort: 'descripcion'])
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()

        [unidad: unidad, cinco: cinco, ocho: ocho, nueve: nueve, actual: actual, fuentes: fuentes, programas: programas, tipoGastos: tipoGastos]


    }

    def cambiarPrograma = {
//        println params
        def asg = Asignacion.get(params.idAsg)
        def prog = ProgramaPresupuestario.get(params.progs)
        def act = ActividadPresupuesto.get(params.act)
        asg.programa = prog
        asg.actividadPresupuesto = act
        asg = kerberosService.saveObject(asg, Asignacion, session.perfil, session.usuario, actionName, controllerName, session)
        if (asg.errors.getErrorCount() == 0) {
            flash.message = "Asignación cambiada al programa <b>" + prog.codigo+": "+prog.descripcion + "</b>"
            flash.clase = "ui-state-highlight ui-corner-all"
        } else {
            flash.message = "Ha ocurrido un error al cambiar el programa de la asignación"
            flash.clase = "ui-state-error ui-corner-all"
        }
        redirect(action: 'asignacionesCorrientesv2', params: [id: params.id, anio: params.anio, programa: params.programa])
    }
    def cambiarProgramaEditar = {
//        println params
        def asg = Asignacion.get(params.idAsg)
        def prog = ProgramaPresupuestario.get(params.progs)
        asg.programa = prog
        asg = kerberosService.saveObject(asg, Asignacion, session.perfil, session.usuario, actionName, controllerName, session)
        if (asg.errors.getErrorCount() == 0) {
            flash.message = "Asignación cambiada al programa <b>" + prog.codigo+": "+prog.descripcion + "</b>"
            flash.clase = "ui-state-highlight ui-corner-all"
        } else {
            flash.message = "Ha ocurrido un error al cambiar el programa de la asignación"
            flash.clase = "ui-state-error ui-corner-all"
        }
        redirect(action: 'editarAsignacionesAdm', params: [id: params.id, anio: params.anio])
    }

    def asignacionesCorrientesv2 = {
        def band = true

        if(!session.unidad){
            redirect(controller: 'login',action: 'logout')
        }

        if (params.id.toLong() != session.unidad.id.toLong()) {
            band = false
        }
        if (session.perfil.id.toLong() == 1.toLong()) {
            band = true
        }
        if (!band) {
            response.sendError(404)
        } else {

            def unidad = UnidadEjecutora.get(params.id)
            def fuentes = Fuente.list([sort: 'descripcion'])
            def programas = ProgramaPresupuestario.list()
            programas = programas.sort { it.codigo.toInteger()}
            def actual, programa
            def componentes = Componente.list([sort: 'descripcion'])
//            def componente
            if (params.anio) {
                actual = Anio.get(params.anio)
            } else {
                actual = Anio.findByAnio(new Date().format("yyyy"))
            }


            if (params.programa) {
                programa = ProgramaPresupuestario.get(params.programa)
            }
            if (params.componente)
                componente = Componente.get(params.componente)

            if (!actual) {
                actual = Anio.list([sort: 'anio', order: 'desc']).pop()
            }
            if (!programa) {
                programa = programas[0]
            }
//        def asignaciones = Asignacion.findAll("from Asignacion where anio=${actual.id} and unidad=${unidad.id} and marcoLogico is null and actividad is not null order by id")

            def c = Asignacion.createCriteria()

            def asignaciones = c.list {
                and {
                    eq("anio", actual)
                    eq("unidad", unidad)
                    eq("programa", programa)
                    isNull("marcoLogico")
                }
                order("id", "asc")
            }

            c = Asignacion.createCriteria()
            def asgs = c.list {
                and {
                    eq("anio", actual)
                    eq("unidad", unidad)
                    isNull("marcoLogico")
                }
            }

            if (params.todo == "1") {
                asignaciones = asgs
            }

            def total = 0
            asgs.each { asg ->
                total += ((asg.redistribucion == 0) ? asg.planificado.toDouble() : asg.redistribucion.toDouble())
            }

            def maxUnidad
            def max
            if (PresupuestoUnidad.findByUnidadAndAnio(unidad, actual)) {
                max = PresupuestoUnidad.findByUnidadAndAnio(unidad, actual)
                maxUnidad =max.maxCorrientes
            } else {
                maxUnidad = 0
            }

            [unidad: unidad, actual: actual, asignaciones: asignaciones, fuentes: fuentes, programas: programas, programa: programa, totalUnidad: total, maxUnidad: maxUnidad, componentes: componentes,max: max]
        }
    }

    def asignacionesInversionv2 = {
        def band = true

        if(!session.unidad){
            redirect(controller: 'login',action: 'logout')
        }

        if (params.id.toLong() != session.unidad.id.toLong()) {
            band = false
        }
        if (session.perfil.id.toLong() == 1.toLong()) {
            band = true
        }
        if (!band) {
            response.sendError(404)
        } else {

            def unidad = UnidadEjecutora.get(params.id)
            def fuentes = Fuente.list([sort: 'descripcion'])
            def programas = ProgramaPresupuestario.list()
            programas = programas.sort { it.codigo.toInteger()}
            def actual, programa
            def componentes = Componente.list([sort: 'descripcion'])
//            def componente
            if (params.anio) {
                actual = Anio.get(params.anio)
            } else {
                actual = Anio.findByAnio(new Date().format("yyyy"))
            }


            if (params.programa) {
                programa = ProgramaPresupuestario.get(params.programa)
            }
            if (params.componente)
                componente = Componente.get(params.componente)

            if (!actual) {
                actual = Anio.list([sort: 'anio', order: 'desc']).pop()
            }
            if (!programa) {
                programa = programas[0]
            }
//        def asignaciones = Asignacion.findAll("from Asignacion where anio=${actual.id} and unidad=${unidad.id} and marcoLogico is null and actividad is not null order by id")

            def c = Asignacion.createCriteria()

            def asignaciones = c.list {
                and {
                    eq("anio", actual)
                    eq("unidad", unidad)
                    eq("programa", programa)
                    isNull("marcoLogico")
                }
                order("id", "asc")
            }

            c = Asignacion.createCriteria()
            def asgs = c.list {
                and {
                    eq("anio", actual)
                    eq("unidad", unidad)
                    isNull("marcoLogico")
                }
            }

            if (params.todo == "1") {
                asignaciones = asgs
            }

            def total = 0
            asgs.each { asg ->
                total += ((asg.redistribucion == 0) ? asg.planificado.toDouble() : asg.redistribucion.toDouble())
            }

            def maxUnidad
            def max
            if (PresupuestoUnidad.findByUnidadAndAnio(unidad, actual)) {
                max = PresupuestoUnidad.findByUnidadAndAnio(unidad, actual)
                maxUnidad =max.maxCorrientes
            } else {
                maxUnidad = 0
            }

            [unidad: unidad, actual: actual, asignaciones: asignaciones, fuentes: fuentes, programas: programas, programa: programa, totalUnidad: total, maxUnidad: maxUnidad, componentes: componentes,max: max]
        }
    }




    def listaAsignaciones = {
        println "lista " + params
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def asig = []
        if (params.parametro && params.parametro.trim().size() > 0) {
            def valor
            try {
                valor = params.parametro.toDouble()
            } catch (e) {
                valor = 0
            }
            if (valor > 0) {
                asig = Asignacion.findAllByPlanificadoGreaterThan(valor - 1, params)
            } else {
                def mls = MarcoLogico.findAllByTipoElementoAndObjetoIlike(TipoElemento.findByDescripcion("Actividad"), "%" + params.parametro + "%")
                def actvs = Actividad.findAllByDescripcionIlike("%" + params.parametro + "%")
                mls.each {
                    asig += Asignacion.findAllByMarcoLogico(it, params)
                }
                actvs.each {
                    asig += Asignacion.findAllByActividad(it, params)
                }

            }
        } else {
            asig = Asignacion.list(params)
        }


        [asig: asig, total: asig.count(), parametro: params.parametro]

    }


    def show = {
        def asignacionInstance = Asignacion.get(params.id)
        [asignacionInstance: asignacionInstance]
    }
    def form = {
        def title
        def asignacionInstance
        params.source = "edit"
        if (params.source == "create") {
            asignacionInstance = new Asignacion()
            asignacionInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Asignaciones"], default: "Asignación")
        } else if (params.source == "edit") {
            asignacionInstance = Asignacion.get(params.id)
            if (!asignacionInstance) {
                flash.message = "No se encontro la asignación"
                redirect(action: "listaAsignaciones")
            }
            title = "Editar asignación"
        }

        return [asignacionInstance: asignacionInstance, title: title, source: params.source]
    }

    def save = {
        println "save " + params
        def asg = kerberosService.save(params, Asignacion, session.perfil, session.usuario)
        if (asg.errors.getErrorCount() != 0) {
            render(view: "form", model: [asignacionInstance: asg])
        } else {
            redirect(action: "pacAsignacion", params: [id: asg.id])
        }
    }


    def eliminarAsignacion = {
        println "params elim asignacion" + params

        if (params.id) {
            def band = true


            def asig = Asignacion.get(params.id)
            def unidad = asig.unidad
            def anio=asig.anio
            def padre = asig.padre
            def obras = Obra.findAllByAsignacion(asig)
            def prgAsg = ProgramacionAsignacion.findAllByAsignacion(asig)
            def hijos = Asignacion.findAllByPadre(asig)
            def res = verificarHijas(asig)
            def valor = 0

            def total = 0
            Asignacion.findAll("from Asignacion where anio=${anio.id} and unidad=${unidad.id} and marcoLogico is not null").each{
                total+= it.getValorReal()
            }

            if(res){
                obras.each { obra ->
                    def p = [:]

                    p.id = obra.id
                    p.controllerName = "Asignacion"
                    p.actionName = "eliminarAsignacion"
                    if (!kerberosService.delete(p, Obra, session.perfil, session.usuario)) {
                        band = false
                    }
                }

                prgAsg.each { asg ->
                    def p = [:]

                    p.id = asg.id
                    p.controllerName = "Asignacion"
                    p.actionName = "eliminarAsignacion"
                    if (!kerberosService.delete(p, ProgramacionAsignacion, session.perfil, session.usuario)) {
                        band = false
                    }
                }

                hijos.each { asg ->
                    Asignacion.findAllByPadre(asg).each{ hh->
                        def p = [:]
                        p.id = hh.id
                        p.controllerName = "Asignacion"
                        p.actionName = "eliminarAsignacion"

                        Obra.findAllByAsignacion(hh).each { obra ->
                            def pr = [:]

                            pr.id = obra.id
                            pr.controllerName = "Asignacion"
                            pr.actionName = "eliminarAsignacion"
                            if (!kerberosService.delete(pr, Obra, session.perfil, session.usuario)) {
                                band = false
                            }
                        }

                        ProgramacionAsignacion.findAllByAsignacion(hh).each { pasg ->
                            def pr = [:]

                            pr.id = pasg.id
                            pr.controllerName = "Asignacion"
                            pr.actionName = "eliminarAsignacion"
                            if (!kerberosService.delete(pr, ProgramacionAsignacion, session.perfil, session.usuario)) {
                                band = false
                            }
                        }


                        hh.padre.planificado+=hh.planificado
                        valor+=hh.planificado
                        kerberosService.saveObject(hh.padre,Asignacion,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                        if (!kerberosService.delete(p, Asignacion, session.perfil, session.usuario)) {
                            band = false
                        }
                    }
                    def p = [:]
                    p.id = asg.id
                    p.controllerName = "Asignacion"
                    p.actionName = "eliminarAsignacion"

                    Obra.findAllByAsignacion(asg).each { obra ->
                        def pr = [:]

                        pr.id = obra.id
                        pr.controllerName = "Asignacion"
                        pr.actionName = "eliminarAsignacion"
                        if (!kerberosService.delete(pr, Obra, session.perfil, session.usuario)) {
                            band = false
                        }
                    }

                    ProgramacionAsignacion.findAllByAsignacion(asg).each { pasg ->
                        def pr = [:]

                        pr.id = pasg.id
                        pr.controllerName = "Asignacion"
                        pr.actionName = "eliminarAsignacion"
                        if (!kerberosService.delete(pr, ProgramacionAsignacion, session.perfil, session.usuario)) {
                            band = false
                        }
                    }

                    asg.padre.planificado+=asg.planificado
                    kerberosService.saveObject(asg.padre,Asignacion,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                    valor+=asg.planificado
                    if (!kerberosService.delete(p, Asignacion, session.perfil, session.usuario)) {
                        band = false
                    }
                }
                valor+=asig.planificado
                if (asig.padre){
                    asig.padre.planificado+=asig.planificado

                    kerberosService.saveObject(asig.padre,Asignacion,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                }
                if (!kerberosService.delete(params, Asignacion, session.perfil, session.usuario)) {
                    band = false
                }

                if (band) {
                    println "1"
                    def origen = PresupuestoUnidad.findByAnioAndUnidad(anio,unidad)
                    if (!origen){
                        origen=new PresupuestoUnidad()
                        origen.anio=anio
                        origen.unidad=unidad
                        origen.maxCorrientes=0
                        origen.maxInversion=total
                        kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                    }
                    if (total>=origen.maxInversion){
                        println "total mas que origen"
                        if(padre){
                            println "con padre"
                            if(padre?.unidad?.id?.toInteger()!=unidad.id.toInteger()){
                                println "con padre -- diferente"

                                def destino = PresupuestoUnidad.findByAnioAndUnidad(anio,padre.unidad)
                                if (origen.maxInversion>0){
                                    def mod = new ModificacionTechos()
                                    mod.desde=origen
                                    mod.recibe=destino
                                    mod.valor=valor
                                    mod.usuario=session.usuario
                                    mod.fecha=new Date()
                                    mod.tipo=3
                                    kerberosService.saveObject(mod,ModificacionTechos,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                    origen.maxInversion-=valor
                                    destino.maxInversion+=valor
                                    kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                    kerberosService.saveObject(destino,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                }else{
                                    def val = 0
                                    Asignacion.findAll("from Asignacion where unidad=${unidad.id} and anio=${anio.id} and marcoLogico is not null").each{ am->
                                        val+=am.getValorReal()
                                    }
                                    origen.maxInversion=val
                                    kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion-calculado","asignacion",session)
                                    destino.maxInversion+=valor
                                    kerberosService.saveObject(destino,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                }
                            }else{
                                println "con padre -- igual"

                                if (origen?.maxInversion>0){
                                    println "con padre -- igual > 0"
                                    def mod = new ModificacionTechos()
                                    mod.desde=origen
                                    mod.recibe=null
                                    mod.valor=valor
                                    mod.usuario=session.usuario
                                    mod.fecha=new Date()
                                    mod.tipo=3
                                    kerberosService.saveObject(mod,ModificacionTechos,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                    origen.maxInversion-=valor
                                    kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                }else{
                                    println "con padre -- max inv nada "
                                    def val = 0
                                    Asignacion.findAll("from Asignacion where unidad=${unidad.id} and anio=${anio.id} and marcoLogico is not null").each{ am->
                                        val+=am.getValorReal()
                                    }
                                    origen.maxInversion=val
                                    kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion-calculado","asignacion",session)
                                }
                            }

                        }else{
                            println "sin padre"

                            if (origen?.maxInversion>0){
                                println "sin padre > 0"
                                def mod = new ModificacionTechos()
                                mod.desde=origen
                                mod.recibe=null
                                mod.valor=valor
                                mod.usuario=session.usuario
                                mod.fecha=new Date()
                                mod.tipo=3
                                kerberosService.saveObject(mod,ModificacionTechos,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                                origen.maxInversion-=valor
                                kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion","asignacion",session)
                            }else{
                                println "sin padre error"
                                def val = 0
                                Asignacion.findAll("from Asignacion where unidad=${unidad.id} and anio=${anio.id} and marcoLogico is not null").each{ am->
                                    val+=am.getValorReal()
                                }
                                origen.maxInversion=val
                                kerberosService.saveObject(origen,PresupuestoUnidad,session.perfil,session.usuario,"eliminarAsignacion-calculado","asignacion",session)
                            }
                        }
                    } else{
                        println "total menos que origen"
                    }


                    render("OK")
                } else {
                    println "2"
                    render("NO")
                }
            }else{
                render "no"
            }

        } else {
            println "3"
            render("NO")
        }
    }

    def guardarAsignacion = {
        println "params guardar asignacion " + params

        params.planificado = params.planificado.replaceAll("\\.", "")
        params.planificado = params.planificado.replaceAll(",", "\\.")
        params.planificado = params.planificado.toDouble()
        def band = true
//        if (params?.componente?.id == "-1") {
//            params.remove("componente.id")
//            band = false
//        }

        def actividadPresupuestaria
        if(params.actividadPresupuestaria != null){
            actividadPresupuestaria = ActividadPresupuesto.get(params.actividadPresupuestaria)
        }else{
            band = false
        }

        def asg
        if (params.id) {
            asg = Asignacion.get(params.id)

            asg.indicador = params.indicador
            asg.modalidad = params.met
            if(params.meta){
                asg.meta = params.meta.toInteger()
            }

            if (!band) {
                asg.componente = null
            }
        } else {
            asg = new Asignacion()

            params.indicador = params.indicador
            if(params.meta){
                asg.meta = params.meta.toInteger()
            }
             asg.modalidad = params.met

        }

        params.componente = null
        asg.properties = params
        asg.actividadPresupuesto = actividadPresupuestaria
        asg.unidadAdministrativa = params.unidadA

        asg = kerberosService.saveObject(asg, Asignacion, session.perfil, session.usuario, "guardarAsignacion", "asignacion", session)
        if (asg.errors.getErrorCount() == 0) {
            render guardarPras(asg)
        } else {
            render 0
        }
    }

    def guardarPras(asg) {
        if (asg) {
            def total = (asg.redistribucion == 0) ? (asg.planificado) : (asg.redistribucion)
            def valor = (total / 12).toFloat().round(2)
            def residuo = 0
            if (valor * 12 != total) {
                residuo = (total.toDouble() - valor.toDouble() * 12).toFloat().round(2)
            }
            println "total " + total + " valor " + valor + " res " + residuo

            12.times {
                def mes = Mes.get(it + 1)
                ProgramacionAsignacion.findByAsignacionAndMes(asg, mes)?.delete(flush: true)
                def programacion = new ProgramacionAsignacion()
                programacion.asignacion = asg
                programacion.mes = mes
                if (it < 11) {
                    programacion.valor = valor
                } else {
                    programacion.valor = valor + residuo
                }
                programacion = kerberosService.saveObject(programacion, ProgramacionAsignacion, session.perfil, session.usuario, "guardarAsignacion", "asignacion", session)
            }
            return asg.id
        } else {
            return 0
        }
    }

/*
    def guardarPras(asg, unidad) {
        println "guardar pras! mod inv"
        def dist = DistribucionAsignacion.findByAsignacionAndUnidadEjecutora(asg,unidad)
        if (asg) {
            def total = dist.getValorReal()
            def valor = (total / 12).toFloat().round(2)
            def residuo = 0
            if (valor * 12 != total) {
                residuo = (total.toDouble() - valor.toDouble() * 12).toFloat().round(2)
            }
            println "total " + total + " valor " + valor + " res " + residuo

            12.times {
                def mes = Mes.get(it + 1)
                ProgramacionAsignacion.findByDistribucionAndMes(dist, mes)?.delete(flush: true)
                def programacion = new ProgramacionAsignacion()
                programacion.distribucion = dist
                programacion.mes = mes
                if (it < 11) {
                    programacion.valor = valor
                } else {
                    programacion.valor = valor + residuo
                }
                programacion = kerberosService.saveObject(programacion, ProgramacionAsignacion, session.perfil, session.usuario, "guardarAsignacion", "asignacion", session)
            }
            return asg.id
        } else {
            return 0
        }
    }
*/

    def  programacionAsignaciones = {
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        def unidad = UnidadEjecutora.get(params.id)
        def asgProy = Asignacion.findAll("from Asignacion where unidad=${unidad.id} and marcoLogico is not null and anio=${actual.id} order by id")
        def asgCor = Asignacion.findAll("from Asignacion where unidad=${unidad.id} and actividad is not null and anio=${actual.id} and marcoLogico is null order by id")
        def max = PresupuestoUnidad.findByUnidadAndAnio(unidad,actual)
        def meses = []
        12.times {meses.add(it + 1)}
        [unidad: unidad, corrientes: asgCor, inversiones: asgProy, actual: actual, meses: meses,max: max]
    }

    def guardarProgramacion = {

        def asig = Asignacion.get(params.asignacion)
        def datos = params.datos.split(";")
        datos.each {
            def partes = it.split(":")

            def prog = ProgramacionAsignacion.findByAsignacionAndMes(asig, Mes.get(partes[0]))
            if (!prog) {
                prog = new ProgramacionAsignacion()
                prog.asignacion = asig
                prog.mes = Mes.get(partes[0])
            }
            prog.valor = partes[1].toDouble()
            prog = kerberosService.saveObject(prog, ProgramacionAsignacion, session.perfil, session.usuario, "guardarProgramacion", "asignacion", session)
            println "errores" + prog.errors


        }
        render "ok"
    }

    def guardarProgramacionDistribucion = {
        println "guardarProgramacionDistribucion "+params
        def asig = Asignacion.get(params.asignacion)
        def unidad = UnidadEjecutora.get(params.unidad)
        def dist = DistribucionAsignacion.findByAsignacionAndUnidadEjecutora(asig,unidad)
        def datos = params.datos.split(";")
        datos.each {
            def partes = it.split(":")

            def prog = ProgramacionAsignacion.findByDistribucionAndMes(dist, Mes.get(partes[0]))
            if (!prog) {
                prog = new ProgramacionAsignacion()
                prog.distribucion = dist
                prog.mes = Mes.get(partes[0])
            }
            prog.valor = partes[1].toDouble()
            prog = kerberosService.saveObject(prog, ProgramacionAsignacion, session.perfil, session.usuario, "guardarProgramacion", "asignacion", session)
            println "errores" + prog.errors


        }
        render "ok"
    }


    def nuevaAsignacionGastoCorriente = {

    }
    def buscarPresupuesto = {
        println "buscar " + params
        def prsp = []
        if (!params.tipo) {
            if (params.parametro && params.parametro.trim().size() > 0) {
                prsp = Presupuesto.findAll("from Presupuesto where numero like '%${params.parametro}%' and movimiento=1 order by numero")
            } else {
                println "aqui "
                prsp = Presupuesto.findAllByMovimiento(1, [sort: "numero", max: 20])
            }
        } else {
            if (params.tipo == "1") {
                if (params.parametro && params.parametro.trim().size() > 0) {
                    prsp = Presupuesto.findAll("from Presupuesto where numero like '%${params.parametro}%' and movimiento=1 order by numero")
                } else {
                    prsp = Presupuesto.findAllByMovimiento(1, [sort: "numero", max: 20])
                }
            } else {
                if (params.parametro && params.parametro.trim().size() > 0) {
                    prsp = Presupuesto.findAll("from Presupuesto where lower(descripcion) like lower('%${params.parametro}%') and movimiento=1 order by numero")
                } else {
                    prsp = Presupuesto.findAllByMovimiento(1, [sort: "descripcion", max: 20])
                }
            }
        }
        [prsp: prsp]
    }

    def guardarAsignacionGastoCorriente = {
        println "save " + params
        def asg = kerberosService.save(params, Asignacion, session.perfil, session.usuario)
        if (asg.errors.getErrorCount() != 0) {
            render(view: "nuevaAsignacionGastoCorriente", model: [asignacionInstance: asg])
        } else {
            redirect(action: "pacAsignacion", params: [id: asg.id])
        }
    }

    def pacAsignacion = {
        def asignacion = Asignacion.get(params.id)
        def pac = Obra.findAllByAsignacion(asignacion)
        [asignacion: asignacion, obras: pac]
    }

    def buscarCcp = {
        println "buscar " + params
        def ccps = []
        if (!params.tipo) {
            if (params.parametro && params.parametro.trim().size() > 0) {
                ccps = CodigoComprasPublicas.findAll("from CodigoComprasPublicas where numero like '%${params.parametro}%'  and movimiento=1 order by numero", [max: 20])
            } else {
                println "aqui "
                ccps = CodigoComprasPublicas.findAllByMovimiento(1, [sort: "numero", max: 20])
            }
        } else {
            if (params.tipo == "1") {
                if (params.parametro && params.parametro.trim().size() > 0) {
                    ccps = CodigoComprasPublicas.findAll("from CodigoComprasPublicas where numero like '%${params.parametro}%' and movimiento=1 order by numero", [max: 20])
                } else {
                    ccps = CodigoComprasPublicas.findAllByMovimiento(1, [sort: "numero", max: 20])
                }
            } else {
                if (params.parametro && params.parametro.trim().size() > 0) {
                    ccps = CodigoComprasPublicas.findAll("from CodigoComprasPublicas where lower(descripcion) like lower('%${params.parametro.toUpperCase()}%') and movimiento=1 order by numero", [max: 20])
                } else {
                    ccps = CodigoComprasPublicas.findAllByMovimiento(1, [sort: "descripcion", max: 20])
                }
            }
        }
        [ccps: ccps]
    }


    def buscarActividad = {
        println "buscar act " + params
        def acts = []
        if (!params.tipo) {
            if (params.parametro && params.parametro.trim().size() > 0) {
                acts = Actividad.findAll("from Actividad where codigo like '%${params.parametro}%'   order by codigo")
            } else {
                println "aqui "
                acts = Actividad.list([sort: "codigo", max: 20])
            }
        } else {
            if (params.tipo == "1") {
                if (params.parametro && params.parametro.trim().size() > 0) {
                    acts = Actividad.findAll("from Actividad where codigo like '%${params.parametro}%'  order by codigo")
                } else {
                    acts = Actividad.list([sort: "codigo", max: 20])
                }
            } else {
                if (params.parametro && params.parametro.trim().size() > 0) {
                    acts = Actividad.findAll("from Actividad where descripcion like '%${params.parametro}%'  order by descripcion")
                } else {
                    acts = Actividad.list([sort: "descripcion", max: 20])
                }
            }
        }
        [acts: acts]
    }

    def agregaAsignacion = {
        println "parametros agregaAsignacion:" + params
        def listaFuentes = Financiamiento.findAllByProyectoAndAnio(Proyecto.get(params.proy), Anio.get(params.anio)).fuente
        def asgnInstance = Asignacion.get(params.id)
        def dist = null
        if (params.dist && params.dist!="" && params.dist!="undefined")
            dist=DistribucionAsignacion.get(params.dist)
        render(view: 'crear', model: ['asignacionInstance': asgnInstance, 'fuentes': listaFuentes,'dist':dist])
    }
    def agregaAsignacionMod = {
        println "parametros agregaAsignacion mod:" + params
        def fuentes = Fuente.list([sort: 'descripcion'])
        def asgnInstance = Asignacion.get(params.id)
        def unidad = UnidadEjecutora.get(params.unidad)
        return ['asignacionInstance': asgnInstance, 'fuentes': fuentes,unidad: unidad]
    }


    def creaHijo = {
        println "parametros creaHijo:" + params
        if (params.id){
            def nueva = new Asignacion()
            def valor = params.valor.toFloat()
            def asgn = Asignacion.get(params.id)
            def fnte = Fuente.get(params.fuente)
            def prsp = Presupuesto.get(params.partida)
            def resultado = 0
            // debe borrar el registro actual de pras y crear uno nuevo con los nuevos valores
            ProgramacionAsignacion.findAllByAsignacion(Asignacion.get(params.id)).each {
                //println "proceso la asignación ${it}"
                def p = [id: it.id, controllerName: 'asignacion', actionName: 'creaHijo']
                //println "parametros de borrado: " + p
                kerberosService.delete(p, ProgramacionAsignacion, session.perfil, session.usuario)
            }
            asgn.planificado -= valor
            asgn = kerberosService.saveObject(asgn, Asignacion, session.perfil, session.usuario, "agregaAsignacion", "asignacion", session)
            if (asgn.errors.getErrorCount() == 0) {
                resultado += guardarPras(asgn)
            } else {
                resultado = 0
            }
            if (resultado) {
                nueva.marcoLogico=asgn.marcoLogico
                nueva.programa=asgn.programa
                nueva.actividad=asgn.actividad
                nueva.anio=asgn.anio
                nueva.indicador=asgn.indicador
                nueva.meta=asgn.meta
                nueva.componente=asgn.componente
                nueva.padre = asgn
                nueva.fuente = fnte
                nueva.presupuesto = prsp
                nueva.planificado = valor
                nueva.unidad=asgn.unidad

//            println "pone padre: ${nueva.padre}  ${nueva.unidad}"
                nueva = kerberosService.saveObject(nueva, Asignacion, session.perfil, session.usuario, "agregaAsignacion", "asignacion", session)
                if (nueva.errors.getErrorCount() == 0) {
                    println "crea la progrmaación de " + nueva.id
                    resultado += guardarPras(nueva)
                } else {
                    resultado = 0
                }
            }
            render(nueva.id)
        }

    }



    def creaHijoInversion = {
        println "parametros creaHijo inversion:" + params
        def nueva = new Asignacion()
        def valor = params.valor.toFloat()
        def asgn = Asignacion.get(params.id)
        def fnte = Fuente.get(params.fuente)
        def prsp = Presupuesto.get(params.partida)
        def unidad = UnidadEjecutora.get(params.unidad)
        def resultado = 0
        // debe borrar el registro actual de pras y crear uno nuevo con los nuevos valores

        //println "proceso la asignación ${it}"
        ProgramacionAsignacion.findAllByAsignacion(asgn).each{
            def p = [id: it.id, controllerName: 'asignacion', actionName: 'creaHijoInversion']
            //println "parametros de borrado: " + p
            kerberosService.delete(p, ProgramacionAsignacion, session.perfil, session.usuario)
        }




        asgn.planificado -= valor
        asgn = kerberosService.saveObject(asgn, Asignacion, session.perfil, session.usuario, "agregaAsignacionInversion", "asignacion", session)
        /*TODO verificar esto!! */
        if (asgn.errors.getErrorCount() == 0) {

                resultado += guardarPras(asgn)

        } else {
            resultado = 0
        }
        if (resultado) {
//            nueva.properties = asgn.properties
            nueva.marcoLogico=asgn.marcoLogico
            nueva.programa=asgn.programa
            nueva.actividad=asgn.actividad
            nueva.anio=asgn.anio
            nueva.indicador=asgn.indicador
            nueva.meta=asgn.meta
            nueva.componente=asgn.componente
            nueva.unidad=unidad
            nueva.reubicada='N'
            nueva.padre = asgn
            nueva.fuente = fnte
            nueva.presupuesto = prsp
            nueva.planificado = valor

            if (asgn.unidad!=unidad)
                nueva.unidad= unidad
            //println "pone padre: ${nueva.padre}"
            nueva = kerberosService.saveObject(nueva, Asignacion, session.perfil, session.usuario, "agregaAsignacionInversion", "asignacion", session)
            if (nueva.errors.getErrorCount() == 0) {
                println "crea la progrmaación de " + nueva.id
                resultado += guardarPras(nueva)
            } else {
                resultado = 0
            }
        }
        render(nueva.id)
    }

    def creaHijoMod = {

        println "reasignacion mod!! "+params
        def path = servletContext.getRealPath("/") + "modificacionesPoa/"
        new File(path).mkdirs()

        def f = request.getFile('archivo')
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename()
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
            def reps = [
                    "a": "[àáâãäåæ]",
                    "e": "[èéêë]",
                    "i": "[ìíîï]",
                    "o": "[òóôõöø]",
                    "u": "[ùúûü]",

                    "A": "[ÀÁÂÃÄÅÆ]",
                    "E": "[ÈÉÊË]",
                    "I": "[ÌÍÎÏ]",
                    "O": "[ÒÓÔÕÖØ]",
                    "U": "[ÙÚÛÜ]",

                    "n": "[ñ]",
                    "c": "[ç]",

                    "N": "[Ñ]",
                    "C": "[Ç]",

                    "": "[\\!@\\\$%\\^&*()='\"\\/<>:;\\.,\\?]",

                    "_": "[\\s]"
            ]

            reps.each { k, v ->
                fileName = (fileName.trim()).replaceAll(v, k)
            }

            fileName = fileName+"." + "pdf"

            def pathFile = path + File.separatorChar + fileName
            def src = new File(pathFile)
            def msn

            if (src.exists()) {
                msn="Ya existe un archivo con ese nombre. Por favor cámbielo."
                redirect(action: 'poaCorrientesMod',params: [msn:msn,id:params.unidad])


            } else {
                println "parametros creaHijo:" + params
                def nueva = new Asignacion()
                def valor = params.valor.toFloat()
                def asgn = Asignacion.get(params.id)
                def fnte = Fuente.get(params.fuente)
                def prsp = Presupuesto.get(params.presupuesto.id)
                def resultado = 0
                // debe borrar el registro actual de pras y crear uno nuevo con los nuevos valores
                ProgramacionAsignacion.findAllByAsignacion(Asignacion.get(params.id)).each {
                    //println "proceso la asignación ${it}"
                    def p = [id: it.id, controllerName: 'asignacion', actionName: 'creaHijoMod']
                    //println "parametros de borrado: " + p
                    kerberosService.delete(p, ProgramacionAsignacion, session.perfil, session.usuario)
                }
                asgn.planificado -= valor
                asgn = kerberosService.saveObject(asgn, Asignacion, session.perfil, session.usuario, "agregaAsignacion", "asignacion", session)
                if (asgn.errors.getErrorCount() == 0) {
                    resultado += guardarPras(asgn)
                } else {
                    resultado = 0
                }
                if (resultado) {
                    nueva.properties = asgn.properties
                    nueva.padre = asgn
                    nueva.fuente = fnte
                    nueva.presupuesto = prsp
                    nueva.planificado = valor
                    //println "pone padre: ${nueva.padre}"
                    nueva = kerberosService.saveObject(nueva, Asignacion, session.perfil, session.usuario, "agregaAsignacion", "asignacion", session)
                    if (nueva.errors.getErrorCount() == 0) {
                        f.transferTo(new File(pathFile))
                        println "crea la progrmaación de " + nueva.id
                        resultado += guardarPras(nueva)
                        def mod = new ModificacionAsignacion()
                        mod.desde=asgn
                        mod.recibe=nueva
                        mod.fecha=new Date()
                        mod.valor=nueva.planificado
                        mod.pdf=fileName
                        mod.save(flush: true)
                    } else {
                        resultado = 0
                    }
                }
                msn = "Modificación procesada"
                redirect(controller: "modificacion",action: "poaCorrientesMod",params: [msn:msn,id:params.unidad])
            }
        }
    }


    def borrarAsignacion = {
        println "parametros borrarAsignacion:" + params
        def asgn = Asignacion.get(params.id)
        def pdre = Asignacion.get(asgn.padre.id)
        def p = [:]
        // debe borrar el registro actual de pras y crear uno nuevo con los nuevos valores
        ProgramacionAsignacion.findAllByAsignacion(asgn).each {
            p = [id: it.id, controllerName: 'asignacion', actionName: 'borrarAsignacion']
            kerberosService.delete(p, ProgramacionAsignacion, session.perfil, session.usuario)
        }
        p = [id: asgn.id, controllerName: 'asignacion', actionName: 'borrarAsignacion']
        def del = kerberosService.delete(p, Asignacion, session.perfil, session.usuario)
        if (del){
            pdre.planificado += asgn.planificado
            pdre = kerberosService.saveObject(pdre, Asignacion, session.perfil, session.usuario, "agregaAsignacion", "asignacion", session)
            ProgramacionAsignacion.findAllByAsignacion(pdre).each {
                p = [id: it.id, controllerName: 'asignacion', actionName: 'borrarAsignacion']
                kerberosService.delete(p, ProgramacionAsignacion, session.perfil, session.usuario)
            }
            if (pdre.errors.getErrorCount() == 0) {
                guardarPras(pdre)
            }
            render("ok")
        }else{
            render("Error")
        }
    }


    def aprobarCorrientes = {
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        def unidad = UnidadEjecutora.get(params.id)
        def asg = Asignacion.findAllByUnidadAndMarcoLogicoIsNull(unidad)
        def totCorrientes = 0
        asg.each {
            totCorrientes+=it.planificado
        }
        def max = PresupuestoUnidad.findByUnidadAndAnio(unidad,actual)
        [unidad:unidad,asg :asg,max: max,actual: actual,totCorrientes:totCorrientes]

    }

    def aprobarAsgCorrientes = {

        println "aprobar corrientes "+params

        def unidad = UnidadEjecutora.get(params.unidad)
        def anio = Anio.get(params.anio)
        def pass = params.ssap
        println "claves "+ session.usuario.autorizacion+ " "+params.ssap.encodeAsMD5()
        if (session.usuario.autorizacion == params.ssap.encodeAsMD5()){
            def max = PresupuestoUnidad.findByUnidadAndAnio(unidad,anio)
            if (max){
                max.aprobadoCorrientes=1
                max = kerberosService.saveObject(max,PresupuestoUnidad,session.perfil,session.usuario,"AsignacionController","aprobarAsgCorrientes",session)
                if (max.errors.getErrorCount()!=0){
                    render "error"
                }else{
                    render "ok"
                }
            }else{
                render "error"
            }
        }else{
            render "no"
        }

    }

    def aprobarInversion = {

    }

    def editarAsignacionesAdm = {
        if(session.usuario.id==3){
            def actual
            if (params.anio)
                actual = Anio.get(params.anio)
            else
                actual = Anio.findByAnio(new Date().format("yyyy"))

            def unidad = UnidadEjecutora.get(params.id)
            def corrientes = Asignacion.findAll("from Asignacion  where anio=${actual.id} and unidad=${unidad.id} and marcoLogico is null");
            [actual:actual,unidad: unidad,corrientes: corrientes,fuentes:Fuente.list([sort: "descripcion"])]
        }else{
            response.sendError(403)
        }

    }

    def guardarDatosEdicionAdm = {
        println "editar adm "+params
        if(session.usuario.id==3){
            params.actionName="guardarDatosEdicionAdm"
            params.controllerName="asginacion"
            def band = true
            def asg = kerberosService.save(params, Asignacion, session.perfil, session.usuario)
            if (asg.errors.getErrorCount() == 0) {
                render guardarPras(asg)
            } else {
                render 0
            }
        }else{
            response.sendError(403)
        }
    }

    def programacionEditarAdm = {
        if(session.usuario.id==3){
            def asg= Asignacion.get(params.id)
            def programacion = ProgramacionAsignacion.findAllByAsignacion(asg)
            def meses = []
            12.times {meses.add(it + 1)}
            [asg:asg,programa: programacion,meses: meses]
        }else{
            response.sendError(403)
        }
    }



    def agregarAsignacionInv = {

        println "crear asgn inv "+params
        def proy = Proyecto.get(params.id)
        def unidad = proy.unidadEjecutora

        def comp = MarcoLogico.findAllByProyectoAndTipoElemento(proy,TipoElemento.get(2),[sort: "id"])
        def cmp
        def acts = []

        def fuentes = Fuente.list()

        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))

        if (params.comp){
            cmp = MarcoLogico.get(params.comp)

        }else{
            if (comp.size()>0)
                cmp=comp[0]
        }

        if (cmp)
            acts = MarcoLogico.findAllByMarcoLogico(cmp)

        def asgn = []
        acts.each {
            def a =  Asignacion.findAllByMarcoLogicoAndUnidad(it,unidad)
            if (a.size()>0)
                asgn+=a
        }

        def totalUnidad=0
        Asignacion.findAll("from Asignacion where anio=${actual.id} and unidad=${unidad.id} and marcoLogico is not null").each{
            totalUnidad+= it.getValorReal()
        }
        def maxUnidad = PresupuestoUnidad.findByAnioAndUnidad(actual,unidad)
        if (maxUnidad)
            maxUnidad=maxUnidad.maxInversion
        else
            maxUnidad=0


        [proy:proy,comp:comp,fuentes: fuentes,unidad: unidad,actual: actual,cmp:cmp,acts: acts,asgn:asgn,totalUnidad:totalUnidad ,maxUnidad:maxUnidad ]

    }


    boolean verificarHijas(asgn){
        def hijas = Asignacion.findAllByPadre(asgn)
        def res = true

        hijas.each {
            res = verificarHijas(it)
            if (!res)
                return false
            if( DistribucionAsignacion.findAllByAsignacion(it).size()>0){
                return false
            }
            if(ModificacionAsignacion.findAllByDesdeOrRecibe(it,it).size()>0){
                return false
            }
            if(Certificacion.findAllByAsignacion(it).size()>0)
                return false
        }


        if( DistribucionAsignacion.findAllByAsignacion(asgn).size()>0){
            return false
        }
        if(ModificacionAsignacion.findAllByDesdeOrRecibe(asgn,asgn).size()>0){
            return false
        }
        if(Certificacion.findAllByAsignacion(asgn).size()>0)
            return false

        return true
    }

    def actividad_ajax () {

        def programa = ProgramaPresupuestario.get(params.programa)
        def actividades = ActividadPresupuesto.findAllByProgramaPresupuestario(programa)
        def actividad
        if(params.actividad != 'null'){
            actividad = Actividad.get(params.actividad)
        }

        return[actividades: actividades, actividad: actividad]
    }

    def cargarActividad_ajax () {
        println("params " + params)
        def programa = ProgramaPresupuestario.get(params.programa)
        def actividades = ActividadPresupuesto.findAllByProgramaPresupuestario(programa)
        return [actividades: actividades]
    }

}