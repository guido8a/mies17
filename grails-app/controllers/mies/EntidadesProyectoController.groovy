package mies

class EntidadesProyectoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["EntidadesProyecto"], default: "EntidadesProyecto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [entidadesProyectoInstanceList: EntidadesProyecto.list(params), entidadesProyectoInstanceTotal: EntidadesProyecto.count(), title: title, params: params]
    }

    def form = {
        def title
        def entidadesProyectoInstance

        if (params.source == "create") {
            entidadesProyectoInstance = new EntidadesProyecto()
            entidadesProyectoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["EntidadesProyecto"], default: "crearEntidadesProyecto")
        } else if (params.source == "edit") {
            entidadesProyectoInstance = EntidadesProyecto.get(params.id)
            if (!entidadesProyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["EntidadesProyecto"], default: "editarEntidadesProyecto")
        }

        return [entidadesProyectoInstance: entidadesProyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["EntidadesProyecto"], default: "Edit EntidadesProyecto")
            def entidadesProyectoInstance = EntidadesProyecto.get(params.id)
            if (entidadesProyectoInstance) {
                entidadesProyectoInstance.properties = params
                if (!entidadesProyectoInstance.hasErrors() && entidadesProyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), entidadesProyectoInstance.id])}"
                    redirect(action: "show", id: entidadesProyectoInstance.id)
                }
                else {
                    render(view: "form", model: [entidadesProyectoInstance: entidadesProyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["EntidadesProyecto"], default: "Create EntidadesProyecto")
            def entidadesProyectoInstance = new EntidadesProyecto(params)
            if (entidadesProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), entidadesProyectoInstance.id])}"
                redirect(action: "show", id: entidadesProyectoInstance.id)
            }
            else {
                render(view: "form", model: [entidadesProyectoInstance: entidadesProyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def entidadesProyectoInstance = EntidadesProyecto.get(params.id)
        if (entidadesProyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (entidadesProyectoInstance.version > version) {

                    entidadesProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto')] as Object[], "Another user has updated this EntidadesProyecto while you were editing")
                    render(view: "edit", model: [entidadesProyectoInstance: entidadesProyectoInstance])
                    return
                }
            }
            entidadesProyectoInstance.properties = params
            if (!entidadesProyectoInstance.hasErrors() && entidadesProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), entidadesProyectoInstance.id])}"
                redirect(action: "show", id: entidadesProyectoInstance.id)
            }
            else {
                render(view: "edit", model: [entidadesProyectoInstance: entidadesProyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def entidadesProyectoInstance = EntidadesProyecto.get(params.id)
        if (!entidadesProyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["EntidadesProyecto"], default: "Show EntidadesProyecto")

            [entidadesProyectoInstance: entidadesProyectoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def entidadesProyectoInstance = EntidadesProyecto.get(params.id)
        if (entidadesProyectoInstance) {
            try {
                entidadesProyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto'), params.id])}"
            redirect(action: "list")
        }
    }
}
