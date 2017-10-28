package mies

class LineaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Linea"], default: "Linea List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [lineaInstanceList: Linea.list(params), lineaInstanceTotal: Linea.count(), title: title, params: params]
    }

    def form = {
        def title
        def lineaInstance

        if (params.source == "create") {
            lineaInstance = new Linea()
            lineaInstance.properties = params
            title = "Crear Lineamiento de inversión"
        } else if (params.source == "edit") {
            lineaInstance = Linea.get(params.id)
            if (!lineaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Lineamiento de inversión"
        }

        return [lineaInstance: lineaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Linea"], default: "Edit Linea")
            def lineaInstance = Linea.get(params.id)
            if (lineaInstance) {
                lineaInstance.properties = params
                if (!lineaInstance.hasErrors() && lineaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'linea.label', default: 'Linea'), lineaInstance.id])}"
                    redirect(action: "show", id: lineaInstance.id)
                }
                else {
                    render(view: "form", model: [lineaInstance: lineaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Linea"], default: "Create Linea")
            def lineaInstance = new Linea(params)
            if (lineaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'linea.label', default: 'Linea'), lineaInstance.id])}"
                redirect(action: "show", id: lineaInstance.id)
            }
            else {
                render(view: "form", model: [lineaInstance: lineaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def lineaInstance = Linea.get(params.id)
        if (lineaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (lineaInstance.version > version) {

                    lineaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'linea.label', default: 'Linea')] as Object[], "Another user has updated this Linea while you were editing")
                    render(view: "edit", model: [lineaInstance: lineaInstance])
                    return
                }
            }
            lineaInstance.properties = params
            if (!lineaInstance.hasErrors() && lineaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'linea.label', default: 'Linea'), lineaInstance.id])}"
                redirect(action: "show", id: lineaInstance.id)
            }
            else {
                render(view: "edit", model: [lineaInstance: lineaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def lineaInstance = Linea.get(params.id)
        if (!lineaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Linea"], default: "Show Linea")

            [lineaInstance: lineaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def lineaInstance = Linea.get(params.id)
        if (lineaInstance) {
            try {
                lineaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linea.label', default: 'Linea'), params.id])}"
            redirect(action: "list")
        }
    }
}
