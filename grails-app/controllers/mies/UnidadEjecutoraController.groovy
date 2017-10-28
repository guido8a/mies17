package mies

class UnidadEjecutoraController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["UnidadEjecutora"], default: "UnidadEjecutora List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [unidadEjecutoraInstanceList: UnidadEjecutora.list(params), unidadEjecutoraInstanceTotal: UnidadEjecutora.count(), title: title, params: params]
    }

    def form = {
        def title
        def unidadEjecutoraInstance

        if (params.source == "create") {
            unidadEjecutoraInstance = new UnidadEjecutora()
            unidadEjecutoraInstance.properties = params
            title = g.message(code: "default.create.label", args: ["UnidadEjecutora"], default: "crearUnidadEjecutora")
        } else if (params.source == "edit") {
            unidadEjecutoraInstance = UnidadEjecutora.get(params.id)
            if (!unidadEjecutoraInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["UnidadEjecutora"], default: "editarUnidadEjecutora")
        }

        return [unidadEjecutoraInstance: unidadEjecutoraInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["UnidadEjecutora"], default: "Edit UnidadEjecutora")
            def unidadEjecutoraInstance = UnidadEjecutora.get(params.id)
            if (unidadEjecutoraInstance) {
                unidadEjecutoraInstance.properties = params
                if (!unidadEjecutoraInstance.hasErrors() && unidadEjecutoraInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutoraInstance.id])}"
                    redirect(action: "show", id: unidadEjecutoraInstance.id)
                }
                else {
                    render(view: "form", model: [unidadEjecutoraInstance: unidadEjecutoraInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["UnidadEjecutora"], default: "Create UnidadEjecutora")
            def unidadEjecutoraInstance = new UnidadEjecutora(params)
            if (unidadEjecutoraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutoraInstance.id])}"
                redirect(action: "show", id: unidadEjecutoraInstance.id)
            }
            else {
                render(view: "form", model: [unidadEjecutoraInstance: unidadEjecutoraInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def unidadEjecutoraInstance = UnidadEjecutora.get(params.id)
        if (unidadEjecutoraInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (unidadEjecutoraInstance.version > version) {

                    unidadEjecutoraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora')] as Object[], "Another user has updated this UnidadEjecutora while you were editing")
                    render(view: "edit", model: [unidadEjecutoraInstance: unidadEjecutoraInstance])
                    return
                }
            }
            unidadEjecutoraInstance.properties = params
            if (!unidadEjecutoraInstance.hasErrors() && unidadEjecutoraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutoraInstance.id])}"
                redirect(action: "show", id: unidadEjecutoraInstance.id)
            }
            else {
                render(view: "edit", model: [unidadEjecutoraInstance: unidadEjecutoraInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def unidadEjecutoraInstance = UnidadEjecutora.get(params.id)
        if (!unidadEjecutoraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["UnidadEjecutora"], default: "Show UnidadEjecutora")

            [unidadEjecutoraInstance: unidadEjecutoraInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def unidadEjecutoraInstance = UnidadEjecutora.get(params.id)
        if (unidadEjecutoraInstance) {
            try {
                unidadEjecutoraInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])}"
            redirect(action: "list")
        }
    }
}
