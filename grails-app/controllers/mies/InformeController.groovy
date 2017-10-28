package mies

import mies.seguridad.Usro

class InformeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

//    def kerberosService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Informe"], default: "Informe List")

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        if (!params.sort) {
            params.sort = "id"
        }
        if (!params.order) {
            params.order = "asc"
        }

        def offset = params.offset?.toInteger() ?: 0
        def busca = params.busca?.trim()

        def ifBusca = params.busca && busca != ""

        def c = Informe.createCriteria()
        def informeInstanceList = c.list {
            if (ifBusca) {
                or {
                    responsableProyecto {
                        proyecto {
                            ilike("nombre", "%" + busca + "%")
                        }
                    }
                    ilike("avance", "%" + busca + "%")
                }
            }
            maxResults(params.max)
            firstResult offset
            order(params.sort, params.order)
        }

        c = Informe.createCriteria()
        def lista = c.list {
            if (ifBusca) {
                or {
                    responsableProyecto {
                        proyecto {
                            ilike("nombre", "%" + busca + "%")
                        }
                    }
                    ilike("avance", "%" + busca + "%")
                }
            }
        }

        def informeInstanceTotal = lista.size()

        [informeInstanceList: informeInstanceList, informeInstanceTotal: informeInstanceTotal, title: title, params: params]
    }

    def error = {
        return [params: params]
    }

    def form = {
        def title
        def informeInstance

        def usuario = session.usuario
        def lista = ResponsableProyecto.findAllByResponsable(usuario)

        def c = ResponsableProyecto.createCriteria()
        lista = c.list {
            eq("responsable", usuario)
            tipo {
                eq("codigo", "E")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        if (lista.size() < 1) {
            redirect(action: "error", params: [usuario: usuario])
        } else {

            def resps = []

            lista.each {
                def m = [:]
                m.id = it.id
                m.texto = "Proyecto: " + it.proyecto.nombre + " - " + it.responsable.persona.nombre + " " + it.responsable.persona.apellido + " "
                resps.add(m)
            }

            if (params.source == "create") {
                informeInstance = new Informe()
                informeInstance.properties = params
                title = g.message(code: "default.create.label", args: ["Informe"], default: "crearInforme")
            } else if (params.source == "edit") {
                informeInstance = Informe.get(params.id)
                if (!informeInstance) {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
                    redirect(action: "list")
                }
                title = g.message(code: "default.edit.label", args: ["Informe"], default: "editarInforme")
            }

            return [informeInstance: informeInstance, title: title, source: params.source, resps: resps]
        }
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

//    def alertaInformes(Usro de, List para, String mensaje, Informe informeInstance) {
    def alertaInformes(Usro de, para, String mensaje, Informe informeInstance) {
/*
        para.each {
            kerberosService.generarAlerta(de, it, mensaje, "informe", "show", informeInstance.id)
        }
*/
    }

    def save = {
        def title

        // TODO VERIFICAR A QUIEN SE MANDAN LAS ALERTAS: RESPONSABLE DE INGRESO DEL PROYECTO
        //            def usuarios = Sesn.findAllByPerfil(Prfl.findByNombre("Administrador")).usuario

        def responsableProyecto = mies.ResponsableProyecto.get(params.responsableProyecto.id)
        def proyecto = responsableProyecto.proyecto

        def c = ResponsableProyecto.createCriteria()
        def usuarios = c.list {
            eq("proyecto", proyecto)
            tipo {
                eq("codigo", "I")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        usuarios = usuarios.responsable

        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Informe"], default: "Edit Informe")
            def informeInstance = Informe.get(params.id)
            if (informeInstance) {
                informeInstance.properties = params
                //nuevo, dominio, perfil, usuario, actionName, controllerName, session
/*
                if (!informeInstance.hasErrors() && kerberosService.saveObject(informeInstance, Informe, session.perfil, session.usuario, 'save', 'informe', session)*/
/*informeInstance.save(flush: true)*//*
) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'informe.label', default: 'Informe'), informeInstance.id])}"

                    alertaInformes(session.usuario, usuarios, "ALERTA: Se modificó un informe", informeInstance)
                    redirect(action: "show", id: informeInstance.id)
                }
                else {
                    render(view: "form", model: [informeInstance: informeInstance, title: title, source: "edit"])
                }
*/
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Informe"], default: "Create Informe")
            def informeInstance = new Informe(params)
/*
            if (kerberosService.saveObject(informeInstance, Informe, session.perfil, session.usuario, 'save', 'informe', session)*/
/*informeInstance.save(flush: true)*//*
) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'informe.label', default: 'Informe'), informeInstance.id])}"

                alertaInformes(session.usuario, usuarios, "ALERTA: Se creó un informe", informeInstance)
                redirect(action: "show", id: informeInstance.id)
            }
            else {
                render(view: "form", model: [informeInstance: informeInstance, title: title, source: "create"])
            }
*/
        }
    }

    def update = {
        def informeInstance = Informe.get(params.id)
        if (informeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (informeInstance.version > version) {

                    informeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'informe.label', default: 'Informe')] as Object[], "Another user has updated this Informe while you were editing")
                    render(view: "edit", model: [informeInstance: informeInstance])
                    return
                }
            }
            informeInstance.properties = params
            if (!informeInstance.hasErrors() && informeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'informe.label', default: 'Informe'), informeInstance.id])}"
                redirect(action: "show", id: informeInstance.id)
            }
            else {
                render(view: "edit", model: [informeInstance: informeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def informeInstance = Informe.get(params.id)
        if (!informeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Informe"], default: "Show Informe")

            [informeInstance: informeInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def informeInstance = Informe.get(params.id)
        if (informeInstance) {
            try {
                informeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'informe.label', default: 'Informe'), params.id])}"
            redirect(action: "list")
        }
    }
}
