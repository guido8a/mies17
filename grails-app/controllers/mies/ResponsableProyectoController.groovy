package mies

class ResponsableProyectoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["ResponsableProyecto"], default: "ResponsableProyecto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [responsableProyectoInstanceList: ResponsableProyecto.list(params), responsableProyectoInstanceTotal: ResponsableProyecto.count(), title: title, params: params]
    }

    def form = {
        def title
        def responsableProyectoInstance

        if (params.source == "create") {
            responsableProyectoInstance = new ResponsableProyecto()
            responsableProyectoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["ResponsableProyecto"], default: "crearResponsableProyecto")
        } else if (params.source == "edit") {
            responsableProyectoInstance = ResponsableProyecto.get(params.id)
            if (!responsableProyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["ResponsableProyecto"], default: "editarResponsableProyecto")
        }

        return [responsableProyectoInstance: responsableProyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["ResponsableProyecto"], default: "Edit ResponsableProyecto")
            def responsableProyectoInstance = ResponsableProyecto.get(params.id)
            if (responsableProyectoInstance) {
                responsableProyectoInstance.properties = params
                if (!responsableProyectoInstance.hasErrors() && responsableProyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), responsableProyectoInstance.id])}"
                    redirect(action: "show", id: responsableProyectoInstance.id)
                }
                else {
                    render(view: "form", model: [responsableProyectoInstance: responsableProyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["ResponsableProyecto"], default: "Create ResponsableProyecto")
            def responsableProyectoInstance = new ResponsableProyecto(params)
            if (responsableProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), responsableProyectoInstance.id])}"
                redirect(action: "show", id: responsableProyectoInstance.id)
            }
            else {
                render(view: "form", model: [responsableProyectoInstance: responsableProyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def responsableProyectoInstance = ResponsableProyecto.get(params.id)
        if (responsableProyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (responsableProyectoInstance.version > version) {

                    responsableProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto')] as Object[], "Another user has updated this ResponsableProyecto while you were editing")
                    render(view: "edit", model: [responsableProyectoInstance: responsableProyectoInstance])
                    return
                }
            }
            responsableProyectoInstance.properties = params
            if (!responsableProyectoInstance.hasErrors() && responsableProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), responsableProyectoInstance.id])}"
                redirect(action: "show", id: responsableProyectoInstance.id)
            }
            else {
                render(view: "edit", model: [responsableProyectoInstance: responsableProyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def responsableProyectoInstance = ResponsableProyecto.get(params.id)
        if (!responsableProyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["ResponsableProyecto"], default: "Show ResponsableProyecto")

            [responsableProyectoInstance: responsableProyectoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def responsableProyectoInstance = ResponsableProyecto.get(params.id)
        if (responsableProyectoInstance) {
            try {
                responsableProyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'responsableProyecto.label', default: 'ResponsableProyecto'), params.id])}"
            redirect(action: "list")
        }
    }
}
