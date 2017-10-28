package mies


class ModificacionProyectoController extends mies.seguridad.Shield {

    def kerberosService

    def solicitarModificacion = {
        if (params.id) {
            session.proyecto = Proyecto.get(params.id)
            [modificacion: new ModificacionProyecto(), msn: params.msn, proyecto: Proyecto.get(params.id)]
        } else {
            redirect(controller: "proyecto", action: "list")
        }
    }

    def solicitarModificacionUnidad = {
        if (params.unidad) {
            session.unidad = UnidadEjecutora.get(params.unidad)
            session.anio = Anio.get(params.anio)
            [modificacion: new ModificacionProyecto(), msn: params.msn, unidad: session.unidad]
        } else {
            redirect(controller: "inicio", action: "index")
        }
    }

    def guardarSolicitud = {
        println "guardar " + params
        session.modificacion = new ModificacionProyecto(params)
        session.modificacion.solicitante=session.usuario
        session.modificacion.proyecto = session.proyecto
        session.modificacion.fecha = new Date()
        redirect(action: "informeModificacion")
    }
    def guardarSolicitudUnidad = {
        println "guardar unidad " + params
        if (session.unidad && session.anio) {
            session.modificacion = new ModificacionProyecto(params)
            session.modificacion.solicitante=session.usuario
            session.modificacion.unidad = session.unidad
            session.modificacion.anio = session.anio
            session.modificacion.fecha = new Date()
            redirect(action: "informeModificacionUnidad")
        } else
            response.sendError(403)
    }

    def informeModificacion = {
        def res = ResponsableProyecto.findAllByProyectoAndTipo(session.proyecto, TipoResponsable.get(2))

        def c = ResponsableProyecto.createCriteria()
        res = c.list {
//            maxResults(params.max)
            tipo {
                eq("codigo", "S")
            }
            and {
                proyecto {
                    eq("id", session.proyecto.id)
                }
                order("desde", "asc")
                order("hasta", "asc")
                order("tipo", "asc")
            }
        }

        println "res " + res + " proy  " + session.proyecto.id
        def resp = []
        res.each {
            println "hasta " + it.hasta
            if (it.desde.before(new Date()) && it.hasta.after(new Date())) {
                resp.add(it)
                session.resp = it.responsable
                println "seesion " + session
            }
        }

        [resp: resp]
    }

    def informeModificacionUnidad = {
        def resps = ResponsableProyecto.findAll("from ResponsableProyecto where proyecto is null and tipo=5")
        def res

        resps.each {

            if (it.responsable.unidad.id == session.unidad.id && it.desde.before(new Date()) && it.hasta.after(new Date())) {

                session.resp = it
                session.responsable = it.responsable
            }
        }
        [res: session.resp]
    }

    def guardarInforme = {

        params.fecha = params.fecha_day + "/" + params.fecha_month + "/" + params.fecha_year
        def informe = kerberosService.save(params, Informe, session.perfil, session.usuario)
        session.modificacion.informe = informe
        def mod = kerberosService.saveObject(session.modificacion, ModificacionProyecto, session.perfil, session.usuario, "guardarInforme", "modificacionProyecto", session)
        kerberosService.generarAlerta(session.usuario, (session.responsable) ? session.responsable : session.resp, "Nueva solicitud de modificación", "modificacionProyecto", "verSolicitud", mod.id)
        session.modificacion = null
        session.resp = null
        session.responsable = null
        session.unidad = null
        session.anio = null
        redirect(action: "solicitarModificacion", params: [id: session.proyecto?.id, msn: "Solicitud enviada"])

    }

    def listaSolicitudes = {
           /*TODO esto hayq ue cambiar xq salens 2 veces*/
        def resp = ResponsableProyecto.findAll("from ResponsableProyecto where responsable=${session.usuario.id} and tipo!=1 ")
        def proys = []
        def unidades = []
        def mods = []
        resp.each {
            if (it.desde.before(new Date()) && it.hasta.after(new Date()))
                if(it.proyecto)
                    proys += it.proyecto
                else
                    unidades+=it.responsable.unidad
        }
        proys.each {
            def temp = ModificacionProyecto.findAllByProyectoAndEstado(it, 0)
            if (temp)
                mods += temp
        }
        unidades.each {
            def temp = ModificacionProyecto.findAllByUnidadAndEstado(it, 0)
            if (temp)
                mods += temp
        }


        println "mods " + mods
        [mods: mods]
    }

    def verSolicitud = {
        def modificacion = ModificacionProyecto.get(params.id)
        [modificacion: modificacion]
    }


    def listaAprobadas = {
        def mods = ModificacionProyecto.findAllByEstadoAndSolicitante(2,session.usuario)
        [mods: mods]

    }


    def usarModificacion = {
        println "usar mod " + params
        def mod = ModificacionProyecto.get(params.id)
        if (mod.estado.toInteger() == 2) {
            session.modificacion = mod
            session.proyecto = mod.proyecto
            session.unidad = mod.unidad
            session.anio = mod.anio
            def accion = ""
            switch (session.modificacion.tipoModificacion.id.toInteger()) {

                case 1:
                    accion = "modificacion"
                    break;
                case 2:
                    accion = "modificarCronograma"
                    break;
                case 3:
                    accion = "modificarProgramacion"
                    break;
                case 4:
                    accion = "modificarPresupuesto"
                    break;
                case 5:
                    accion = "modificarPac"
                    break;

            }
            redirect(controller: "modificacion", action: accion, id: mod.proyecto.id)
        } else {
            response.sendError(403)
        }
    }

    def modificarMarco = {
        def proyecto = session.proyecto
        def fin = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Fin"), [sort: "id", order: "desc", max: 1])

        if (fin)
            fin = fin[0]
        def indicadores
        def medios = []
        def sup
        def indiProps
        def mediosProp = []
        def supProp
        if (proyecto) {
            if (fin) {
                indicadores = Indicador.findAllByMarcoLogico(fin)
                sup = Supuesto.findAllByMarcoLogico(fin)
            }
            indicadores.each {
                medios += MedioVerificacion.findAllByIndicador(it)
            }

        }
        def proposito = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Proposito"), [sort: "id", order: "desc", max: 1])
        if (proposito)
            proposito = proposito[0]
        if (proposito) {
            indiProps = Indicador.findAllByMarcoLogico(proposito)
            indiProps.each {
                mediosProp += MedioVerificacion.findAllByIndicador(it)
            }
            supProp = Supuesto.findAllByMarcoLogico(proposito)
        }

        [fin: fin, indicadores: indicadores, medios: medios, sup: sup, proyecto: proyecto, proposito: proposito, indiProps: indiProps, mediosProp: mediosProp, supProp: supProp]
    }

    def guardarDatosMarco = {
        def proyecto = Proyecto.get(params.proyecto)
        def ml = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion(params.tipo), [sort: "id", order: "desc", max: 1])
        if (ml)
            ml = ml[0]
        println "nl!!! " + ml.id
        def indicadores = Indicador.findAllByMarcoLogico(ml)
        def supuestos = Supuesto.findAllByMarcoLogico(ml)
        println "indis " + indicadores + " sups " + supuestos
        def nuevo = new MarcoLogico()
        def band = true
        if (ml) {
            if (ml.objeto != params.datos) {
                nuevo.proyecto = proyecto
                nuevo.tipoElemento = ml.tipoElemento
                nuevo.modificacionProyecto = session.modificacion
                nuevo.objeto = params.datos
                nuevo = kerberosService.saveObject(nuevo, MarcoLogico, session.perfil, session.usuario, "guardarDatosMarco", "modificacionProyecto", session)
                println "grabando nuevo " + nuevo.errors + "   " + nuevo.id + " ml " + ml.id
                if (nuevo.errors.getErrorCount() == 0) {
                    println "entro despues del save " + ml.id
                    indicadores.each {
                        println "each indicador " + it
                        it.marcoLogico = nuevo
                        if (!it.save(flush: true))
                            band = false
                    }
                    supuestos.each {
                        println "each sup " + it
                        it.marcoLogico = nuevo
                        if (!it.save(flush: true))
                            band = false
                    }
                } else {
                    band = false
                }
                if (!band) {
                    render "no"
                } else {
                    session.modificacion.estado = 3
                    kerberosService.saveObject(session.modificacion, ModificacionProyecto, session.perfil, session.usuario, "guardarDatosMarco", "modificacionProyecto", session)
                    session.modificacion = null
                    render "ok"
                }

            }

        } else {

            render "no"

        }

    }

    def arbolMarco = {

        def arbol = "<ul>"
        def mod = ModificacionProyecto.get(params.mod)
        def proyecto = mod.proyecto
        def fin = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Fin"), [sort: "id", order: "desc", max: 1])
        if (fin)
            fin = fin[0]
        def prop = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Proposito"), [sort: "id", order: "desc", max: 1])
        if (prop)
            prop = prop[0]
        arbol += "<li style='margin:10px' iden='" + fin.id + "' tipo='1'><input type='checkbox' class='chk' value='${fin.id}' tipo='1'><a href='#'>Fin</a>"
        arbol += "<ul>"
        arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre'><a href='#'>Indicadores</a>"
        arbol += "<ul>"
        Indicador.findAllByMarcoLogicoAndEstado(fin, 0).each { indi ->
            arbol += "<li style='margin:10px' iden='" + indi.id + "' tipo='3'><input type='checkbox' class='chk' value='${indi.id}' tipo='3'><a href='#'>${indi}</a>"
            arbol += "<ul>"
            arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Medios de verificación</a>"
            arbol += "<ul>"
            MedioVerificacion.findAllByIndicadorAndEstado(indi, 0).each { md ->
                arbol += "<li style='margin:10px' iden='" + md.id + "' tipo='7'><input type='checkbox' class='chk' value='${md.id}' tipo='7'><a href='#'>${md}</a></li>"
            }
            arbol += "</ul></li>"
            arbol += "</ul></li>"
        }
        arbol += "</ul></li>"
        arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Supuestos</a>"
        arbol += "<ul>"
        Supuesto.findAllByMarcoLogicoAndEstado(fin, 0).each { sup ->
            arbol += "<li style='margin:10px' iden='" + sup.id + "' tipo='5'><input type='checkbox' class='chk' value='${sup.id}' tipo='5'><a href='#'>Supuesto: ${sup}</a></li>"

        }
        arbol += "</ul></li>"
        arbol += "</ul></li>"
//   FIN
        arbol += "<li style='margin:10px' iden='" + prop.id + "' tipo='1'><input type='checkbox' class='chk' value='${prop.id}' tipo='2'><a href='#'>Proposito</a>"
        arbol += "<ul>"
        arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' ><a href='#'>Indicadores</a>"
        arbol += "<ul>"
        Indicador.findAllByMarcoLogicoAndEstado(prop, 0).each { indi ->
            arbol += "<li style='margin:10px' iden='" + indi.id + "' tipo='3'><input type='checkbox' class='chk' value='${indi.id}' tipo='3'><a href='#'>${indi}</a>"
            arbol += "<ul>"
            arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Medios de verificación</a>"
            arbol += "<ul>"
            MedioVerificacion.findAllByIndicadorAndEstado(indi, 0).each { md ->
                arbol += "<li style='margin:10px' iden='" + md.id + "' tipo='7'><input type='checkbox' class='chk' value='${md.id}' tipo='7'><a href='#'>${md}</a></li>"
            }
            arbol += "</ul></li>"
            arbol += "</ul></li>"
        }
        arbol += "</ul></li>"
        arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Supuestos</a>"
        arbol += "<ul>"
        Supuesto.findAllByMarcoLogicoAndEstado(prop, 0).each { sup ->
            arbol += "<li style='margin:10px' iden='" + sup.id + "' tipo='5'><input type='checkbox' class='chk' value='${sup.id}' tipo='5'><a href='#'>Supuesto: ${sup}</a></li>"

        }
        arbol += "</ul></li>"
        arbol += "</ul></li>"

//        proposito
        arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Componentes</a><ul>"
        def comps = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Componente"))

        comps.eachWithIndex {cmp, i ->
            if (cmp.estado == 0) {

                arbol += "<li style='margin:10px' iden='" + cmp.id + "' tipo='1'><input type='checkbox' class='chk' value='${cmp.id}' tipo='8'><a href='#'>Componente #${i + 1}</a>"
                arbol += "<ul>"
                arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Indicadores</a>"
                arbol += "<ul>"
                Indicador.findAllByMarcoLogicoAndEstado(cmp, 0).each { indi ->
                    arbol += "<li style='margin:10px' iden='" + indi.id + "' tipo='3'><input type='checkbox' class='chk' value='${indi.id}' tipo='3'><a href='#'>${indi}</a>"
                    arbol += "<ul>"
                    arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Medios de verificación</a>"
                    arbol += "<ul>"
                    MedioVerificacion.findAllByIndicadorAndEstado(indi, 0).each { md ->
                        arbol += "<li style='margin:10px' iden='" + md.id + "' tipo='7'><input type='checkbox' class='chk' value='${md.id}' tipo='7'><a href='#'>${md}</a></li>"
                    }
                    arbol += "</ul></li>"
                    arbol += "</ul></li>"
                }
                arbol += "</ul></li>"
                arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Supuestos</a>"
                arbol += "<ul>"
                Supuesto.findAllByMarcoLogicoAndEstado(cmp, 0).each { sup ->
                    arbol += "<li style='margin:10px' iden='" + sup.id + "' tipo='5'><input type='checkbox' class='chk' value='${sup.id}' tipo='5'><a href='#'>Supuesto: ${sup}</a></li>"

                }
                arbol += "</ul></li>"

                arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Actividades</a><ul>"
                def acts = MarcoLogico.findAllByMarcoLogicoAndEstado(cmp, 0)
                acts.eachWithIndex {a, j ->
                    arbol += "<li style='margin:10px' iden='" + a.id + "' tipo='1'><input type='checkbox' class='chk' value='${a.id}' tipo='6'><a href='#'>Actividad #${j + 1}: ${a}</a>"
                    arbol += "<ul>"
                    arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Indicadores</a>"
                    arbol += "<ul>"
                    Indicador.findAllByMarcoLogicoAndEstado(a, 0).each { indi ->
                        arbol += "<li style='margin:10px' iden='" + indi.id + "' tipo='3'><input type='checkbox' class='chk' value='${indi.id}' tipo='3'><a href='#'>${indi}</a></li>"

                    }
                    arbol += "</ul></li>"
                    arbol += "<li style='margin:10px'><input type='checkbox' class='chk padre' value='${}' tipo='${}'><a href='#'>Supuestos</a></li>"
                    arbol += "<ul>"
                    Supuesto.findAllByMarcoLogicoAndEstado(a, 0).each { sup ->
                        arbol += "<li style='margin:10px' iden='" + sup.id + "' tipo='5'><input type='checkbox' class='chk' value='${sup.id}' tipo='5'><a href='#'>Supuesto: ${sup}</a></li>"

                    }
                    arbol += "</ul></li>"
                    arbol += "</ul></li>"

                }
                arbol += "</ul></li>"
                arbol += "</ul></li>"
            }

        }

        arbol += "</ul></li>"
        arbol += "</ul>"

        [arbol: arbol]

    }

    def aprobarModificacion = {
        if (request.method == 'POST') {
            //println "params " + params
            if (session.usuario.autorizacion == params.ssap.encodeAsMD5()) {
                def mod = ModificacionProyecto.get(params.mod)
                def msg = ""
                if (params.tipo == "a") {
                    mod.estado = 2
                    msg = "Solicitud de modificación aprobada"
                }
                if (params.tipo == "n") {
                    mod.estado = 1
                    msg = "Solicitud de modificación negada"
                }
                mod.fechaAprobacion = new Date()
                mod.responsable = session.usuario
                kerberosService.saveObject(mod, ModificacionProyecto, session.perfil, session.usuario, "aprobarModificacion", "modificacionProyecto", session)
                def resp = ResponsableProyecto.findByProyectoAndTipo(mod.proyecto, TipoResponsable.get(2))
                kerberosService.generarAlerta(session.usuario, resp, msg, "modificacionProyecto", "verSolicitudRevizada", mod.id)
                if (params.data && params?.data?.trim()?.size() > 0) {
                    println "data " + params.data
                    def duplas = params.data.split("X")
                    duplas.each {
                        println "dupla " + it
                        def partes = it.split(":")
                        def modificable = new Modificables()
                        modificable.tipo = partes[0].toInteger()
                        modificable.id_remoto = partes[1].toInteger()
                        modificable.modificacion = mod
                        kerberosService.saveObject(modificable, Modificables, session.perfil, session.usuario, "aprobarModificacion", "modificacionProyecto", session)
                    }
                }

                render "ok"
            } else {
                render "no"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }


}
