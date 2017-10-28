package mies

class FinanciamientoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Financiamiento"], default: "Financiamiento List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [financiamientoInstanceList: Financiamiento.list(params), financiamientoInstanceTotal: Financiamiento.count(), title: title, params: params]
    }

    def form = {
        def title
        def financiamientoInstance

        if (params.source == "create") {
            financiamientoInstance = new Financiamiento()
            financiamientoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Financiamiento"], default: "crearFinanciamiento")
        } else if (params.source == "edit") {
            financiamientoInstance = Financiamiento.get(params.id)
            if (!financiamientoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Financiamiento"], default: "editarFinanciamiento")
        }

        return [financiamientoInstance: financiamientoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Financiamiento"], default: "Edit Financiamiento")
            def financiamientoInstance = Financiamiento.get(params.id)
            if (financiamientoInstance) {
                financiamientoInstance.properties = params
                if (!financiamientoInstance.hasErrors() && financiamientoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), financiamientoInstance.id])}"
                    redirect(action: "show", id: financiamientoInstance.id)
                }
                else {
                    render(view: "form", model: [financiamientoInstance: financiamientoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Financiamiento"], default: "Create Financiamiento")
            def financiamientoInstance = new Financiamiento(params)
            if (financiamientoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), financiamientoInstance.id])}"
                redirect(action: "show", id: financiamientoInstance.id)
            }
            else {
                render(view: "form", model: [financiamientoInstance: financiamientoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def financiamientoInstance = Financiamiento.get(params.id)
        if (financiamientoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (financiamientoInstance.version > version) {

                    financiamientoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'financiamiento.label', default: 'Financiamiento')] as Object[], "Another user has updated this Financiamiento while you were editing")
                    render(view: "edit", model: [financiamientoInstance: financiamientoInstance])
                    return
                }
            }
            financiamientoInstance.properties = params
            if (!financiamientoInstance.hasErrors() && financiamientoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), financiamientoInstance.id])}"
                redirect(action: "show", id: financiamientoInstance.id)
            }
            else {
                render(view: "edit", model: [financiamientoInstance: financiamientoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def financiamientoInstance = Financiamiento.get(params.id)
        if (!financiamientoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Financiamiento"], default: "Show Financiamiento")

            [financiamientoInstance: financiamientoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def financiamientoInstance = Financiamiento.get(params.id)
        if (financiamientoInstance) {
            try {
                financiamientoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'financiamiento.label', default: 'Financiamiento'), params.id])}"
            redirect(action: "list")
        }
    }
}
