package mies

import mies.seguridad.Shield

class ObjetivoEspecificoController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "objetivoEspecifico.list", default: "Objetivo Especifico")

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [objetivoEspecificoInstanceList: ObjetivoEspecifico.list(params).sort{it.descripcion}, objetivoEspecificoInstanceTotal: ObjetivoEspecifico.count(), title: title, params: params]
    }

    def form = {
        def title
        def objetivoEspecificoInstance

        if (params.source == "create") {
            objetivoEspecificoInstance = new ObjetivoEspecifico()
            objetivoEspecificoInstance.properties = params
            title = g.message(code: "objetivoEspecifico.create", default: "Nuevo Objetivo Específico")
        } else if (params.source == "edit") {
            objetivoEspecificoInstance = ObjetivoEspecifico.get(params.id)
            if (!objetivoEspecificoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "objetivoEspecifico.edit", default: "Editar Objetivo Específico")
        }

        return [objetivoEspecificoInstance: objetivoEspecificoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "objetivoEspecifico.edit", default: "Editar Objetivo Específico")
            def objetivoEspecificoInstance = ObjetivoEspecifico.get(params.id)
            if (objetivoEspecificoInstance) {
                objetivoEspecificoInstance.properties = params
                if (!objetivoEspecificoInstance.hasErrors() && objetivoEspecificoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), objetivoEspecificoInstance.id])}"
                    redirect(action: "show", id: objetivoEspecificoInstance.id)
                }
                else {
                    render(view: "form", model: [objetivoEspecificoInstance: objetivoEspecificoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "objetivoEspecifico.create", default: "Crear Objetivo Específico")
            def objetivoEspecificoInstance = new ObjetivoEspecifico(params)
            if (objetivoEspecificoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), objetivoEspecificoInstance.id])}"
                redirect(action: "show", id: objetivoEspecificoInstance.id)
            }
            else {
                render(view: "form", model: [objetivoInstitucionalInstance: objetivoEspecificoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def objetivoEspecificoInstance = ObjetivoEspecifico.get(params.id)
        if (objetivoEspecificoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (objetivoEspecificoInstance.version > version) {

                    objetivoEspecificoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico')] as Object[], "")
                    render(view: "edit", model: [objetivoEspecificoInstance: objetivoEspecificoInstance])
                    return
                }
            }
            objetivoEspecificoInstance.properties = params
            if (!objetivoEspecificoInstance.hasErrors() && objetivoEspecificoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), objetivoEspecificoInstance.id])}"
                redirect(action: "show", id: objetivoEspecificoInstance.id)
            }
            else {
                render(view: "edit", model: [objetivoEspecificoInstance: objetivoEspecificoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def objetivoEspecificoInstance = ObjetivoEspecifico.get(params.id)
        if (!objetivoEspecificoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
            redirect(action: "list")
        }
        else {
            def title = g.message(code: "objetivoEspecifico.show", default: "Ver Objetivo Específico")
            [objetivoEspecificoInstance: objetivoEspecificoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
//        println("params " + params)
        def objetivoEspecificoInstance = ObjetivoEspecifico.get(params.id)
        if (objetivoEspecificoInstance) {
            try {
                objetivoEspecificoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
//                redirect(action: "list")
                render "ok"
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
//                redirect(action: "show", id: params.id)
                render "no"
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico'), params.id])}"
//            redirect(action: "list")
            render "no"
        }
    }
}
