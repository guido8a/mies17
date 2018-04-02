package mies

import mies.seguridad.Shield

class ObjetivoOperativoController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "objetivoOperativo.list", default: "Objetivo Operativo")

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [objetivoOperativoInstanceList: ObjetivoOperativo.list(params).sort{it.objetivoEspecifico.descripcion}, objetivoOperativoInstanceTotal: ObjetivoOperativo.count(), title: title, params: params]
    }

    def form = {
        def title
        def objetivoOperativoInstance

        if (params.source == "create") {
            objetivoOperativoInstance = new ObjetivoOperativo()
            objetivoOperativoInstance.properties = params
            title = g.message(code: "objetivoOperativo.create", default: "Nuevo Objetivo Operativo")
        } else if (params.source == "edit") {
            objetivoOperativoInstance = ObjetivoOperativo.get(params.id)
            if (!objetivoOperativoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "objetivoOperativo.edit", default: "Editar Objetivo Operativo")
        }

        return [objetivoOperativoInstance: objetivoOperativoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "objetivoOperativo.edit", default: "Editar Objetivo Operativo")
            def objetivoOperativoInstance = ObjetivoOperativo.get(params.id)
            if (objetivoOperativoInstance) {
                objetivoOperativoInstance.properties = params
                if (!objetivoOperativoInstance.hasErrors() && objetivoOperativoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), objetivoOperativoInstance.id])}"
                    redirect(action: "show", id: objetivoOperativoInstance.id)
                }
                else {
                    render(view: "form", model: [objetivoOperativoInstance: objetivoOperativoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "objetivoOperativo.create", default: "Crear Objetivo Operativo")
            def objetivoOperativoInstance = new ObjetivoOperativo(params)
            if (objetivoOperativoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'objetivoOperativo.label', default: 'Plan de Desarrollo'), objetivoOperativoInstance.id])}"
                redirect(action: "show", id: objetivoOperativoInstance.id)
            }
            else {
                render(view: "form", model: [objetivoOperativoInstance: objetivoOperativoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def objetivoOperativoInstance = ObjetivoOperativo.get(params.id)
        if (objetivoOperativoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (objetivoOperativoInstance.version > version) {

                    objetivoOperativoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo')] as Object[], "Another user has updated this ProgramaPresupuestario while you were editing")
                    render(view: "edit", model: [objetivoOperativoInstance: objetivoOperativoInstance])
                    return
                }
            }
            objetivoOperativoInstance.properties = params
            if (!objetivoOperativoInstance.hasErrors() && objetivoOperativoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), objetivoOperativoInstance.id])}"
                redirect(action: "show", id: objetivoOperativoInstance.id)
            }
            else {
                render(view: "edit", model: [objetivoOperativoInstance: objetivoOperativoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def objetivoOperativoInstance = ObjetivoOperativo.get(params.id)
        if (!objetivoOperativoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
            redirect(action: "list")
        }
        else {
            def title = g.message(code: "objetivoOperativo.show", default: "Ver Plan de Desarrollo")
            [objetivoOperativoInstance: objetivoOperativoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
//        println("params " + params)
        def objetivoOperativoInstance = ObjetivoOperativo.get(params.id)
        if (objetivoOperativoInstance) {
            try {
                objetivoOperativoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
//                redirect(action: "list")
                render "ok"
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
//                redirect(action: "show", id: params.id)
                render "no"
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoOperativo.label', default: 'Objetivo Operativo'), params.id])}"
//            redirect(action: "list")
            render "no"
        }
    }
}
