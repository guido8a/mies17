package mies

class PasoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Paso"], default: "Paso List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [pasoInstanceList: Paso.list(params), pasoInstanceTotal: Paso.count(), title: title, params: params]
    }

    def form = {
        def title
        def pasoInstance

        if (params.source == "create") {
            pasoInstance = new Paso()
            pasoInstance.properties = params
            pasoInstance.proceso = Proceso.get(params.proceso)
            title = g.message(code: "default.create.label", args: ["Paso"], default: "crearPaso")
        } else if (params.source == "edit") {
            pasoInstance = Paso.get(params.id)
            if (!pasoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Paso"], default: "editarPaso")
        }

        return [pasoInstance: pasoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Paso"], default: "Edit Paso")
            def pasoInstance = Paso.get(params.id)
            if (pasoInstance) {
                pasoInstance.properties = params
                if (!pasoInstance.hasErrors() && pasoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'paso.label', default: 'Paso'), pasoInstance.id])}"
//                    redirect(action: "show", id: pasoInstance.id)
                    redirect(controller: 'proceso', action: "show", id: pasoInstance.proceso.id)
                }
                else {
                    render(view: "form", model: [pasoInstance: pasoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Paso"], default: "Create Paso")
            def pasoInstance = new Paso(params)
            if (pasoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'paso.label', default: 'Paso'), pasoInstance.id])}"
//                redirect(action: "show", id: pasoInstance.id)
                redirect(controller: 'proceso', action: "show", id: pasoInstance.proceso.id)
            }
            else {
                render(view: "form", model: [pasoInstance: pasoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def pasoInstance = Paso.get(params.id)
        if (pasoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (pasoInstance.version > version) {

                    pasoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'paso.label', default: 'Paso')] as Object[], "Another user has updated this Paso while you were editing")
                    render(view: "edit", model: [pasoInstance: pasoInstance])
                    return
                }
            }
            pasoInstance.properties = params
            if (!pasoInstance.hasErrors() && pasoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'paso.label', default: 'Paso'), pasoInstance.id])}"
                redirect(action: "show", id: pasoInstance.id)
            }
            else {
                render(view: "edit", model: [pasoInstance: pasoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def pasoInstance = Paso.get(params.id)
        if (!pasoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Paso"], default: "Show Paso")

            [pasoInstance: pasoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def pasoInstance = Paso.get(params.id)
        if (pasoInstance) {
            try {
                pasoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'paso.label', default: 'Paso'), params.id])}"
            redirect(action: "list")
        }
    }
}
