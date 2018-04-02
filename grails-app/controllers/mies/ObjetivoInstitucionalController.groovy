package mies

import mies.seguridad.Shield

class ObjetivoInstitucionalController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "objetivoInstitucional.list", default: "Objetivo Institucional")

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [objetivoInstitucionalInstanceList: ObjetivoInstitucional.list(params).sort{it.descripcion}, objetivoInstitucionalInstanceTotal: ObjetivoInstitucional.count(), title: title, params: params]
    }

    def form = {
        def title
        def objetivoInstitucionalInstance

        if (params.source == "create") {
            objetivoInstitucionalInstance = new ObjetivoInstitucional()
            objetivoInstitucionalInstance.properties = params
            title = g.message(code: "objetivoInstitucional.create", default: "Nuevo Objetivo Institucional")
        } else if (params.source == "edit") {
            objetivoInstitucionalInstance = ObjetivoInstitucional.get(params.id)
            if (!objetivoInstitucionalInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "objetivoInstitucional.edit", default: "Editar Objetivo Institucional")
        }

        return [objetivoInstitucionalInstance: objetivoInstitucionalInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "objetivoInstitucional.edit", default: "Editar Objetivo Institucional")
            def objetivoInstitucionalInstance = ObjetivoInstitucional.get(params.id)
            if (objetivoInstitucionalInstance) {
                objetivoInstitucionalInstance.properties = params
                if (!objetivoInstitucionalInstance.hasErrors() && objetivoInstitucionalInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), objetivoInstitucionalInstance.id])}"
                    redirect(action: "show", id: objetivoInstitucionalInstance.id)
                }
                else {
                    render(view: "form", model: [objetivoInstitucionalInstance: objetivoInstitucionalInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "objetivoInstitucional.create", default: "Crear Objetivo Institucional")
            def objetivoInstitucionalInstance = new ObjetivoInstitucional(params)
            if (objetivoInstitucionalInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), objetivoInstitucionalInstance.id])}"
                redirect(action: "show", id: objetivoInstitucionalInstance.id)
            }
            else {
                render(view: "form", model: [objetivoInstitucionalInstance: objetivoInstitucionalInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def objetivoInstitucionalInstance = ObjetivoInstitucional.get(params.id)
        if (objetivoInstitucionalInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (objetivoInstitucionalInstance.version > version) {

                    objetivoInstitucionalInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional')] as Object[], "")
                    render(view: "edit", model: [objetivoInstitucionalInstance: objetivoInstitucionalInstance])
                    return
                }
            }
            objetivoInstitucionalInstance.properties = params
            if (!objetivoInstitucionalInstance.hasErrors() && objetivoInstitucionalInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), objetivoInstitucionalInstance.id])}"
                redirect(action: "show", id: objetivoInstitucionalInstance.id)
            }
            else {
                render(view: "edit", model: [objetivoInstitucionalInstance: objetivoInstitucionalInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def objetivoInstitucionalInstance = ObjetivoInstitucional.get(params.id)
        if (!objetivoInstitucionalInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
            redirect(action: "list")
        }
        else {
            def title = g.message(code: "objetivoInstitucional.show", default: "Ver Objetivo Institucional")
            [objetivoInstitucionalInstance: objetivoInstitucionalInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
//        println("params " + params)
        def objetivoInstitucionalInstance = ObjetivoInstitucional.get(params.id)
        if (objetivoInstitucionalInstance) {
            try {
                objetivoInstitucionalInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
//                redirect(action: "list")
                render "ok"
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
//                redirect(action: "show", id: params.id)
                render "no"
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoInstitucional.label', default: 'Objetivo Institucional'), params.id])}"
//            redirect(action: "list")
            render "no"
        }
    }
}
