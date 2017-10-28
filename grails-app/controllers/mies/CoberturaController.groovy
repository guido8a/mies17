package mies

class CoberturaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Cobertura"], default: "Cobertura List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [coberturaInstanceList: Cobertura.list(params), coberturaInstanceTotal: Cobertura.count(), title: title, params: params]
    }

    def form = {
        def title
        def coberturaInstance

        if (params.source == "create") {
            coberturaInstance = new Cobertura()
            coberturaInstance.properties = params
            title = "Crear Cobertura de proyecto"
        } else if (params.source == "edit") {
            coberturaInstance = Cobertura.get(params.id)
            if (!coberturaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Cobertura de proyecto"
        }

        return [coberturaInstance: coberturaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Cobertura"], default: "Edit Cobertura")
            def coberturaInstance = Cobertura.get(params.id)
            if (coberturaInstance) {
                coberturaInstance.properties = params
                if (!coberturaInstance.hasErrors() && coberturaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), coberturaInstance.id])}"
                    redirect(action: "show", id: coberturaInstance.id)
                }
                else {
                    render(view: "form", model: [coberturaInstance: coberturaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Cobertura"], default: "Create Cobertura")
            def coberturaInstance = new Cobertura(params)
            if (coberturaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), coberturaInstance.id])}"
                redirect(action: "show", id: coberturaInstance.id)
            }
            else {
                render(view: "form", model: [coberturaInstance: coberturaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def coberturaInstance = Cobertura.get(params.id)
        if (coberturaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (coberturaInstance.version > version) {

                    coberturaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cobertura.label', default: 'Cobertura')] as Object[], "Another user has updated this Cobertura while you were editing")
                    render(view: "edit", model: [coberturaInstance: coberturaInstance])
                    return
                }
            }
            coberturaInstance.properties = params
            if (!coberturaInstance.hasErrors() && coberturaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), coberturaInstance.id])}"
                redirect(action: "show", id: coberturaInstance.id)
            }
            else {
                render(view: "edit", model: [coberturaInstance: coberturaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def coberturaInstance = Cobertura.get(params.id)
        if (!coberturaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Cobertura"], default: "Show Cobertura")

            [coberturaInstance: coberturaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def coberturaInstance = Cobertura.get(params.id)
        if (coberturaInstance) {
            try {
                coberturaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cobertura.label', default: 'Cobertura'), params.id])}"
            redirect(action: "list")
        }
    }
}
