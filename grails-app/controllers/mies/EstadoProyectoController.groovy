package mies

class EstadoProyectoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["EstadoProyecto"], default: "EstadoProyecto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [estadoProyectoInstanceList: EstadoProyecto.list(params), estadoProyectoInstanceTotal: EstadoProyecto.count(), title: title, params: params]
    }

    def form = {
        def title
        def estadoProyectoInstance

        if (params.source == "create") {
            estadoProyectoInstance = new EstadoProyecto()
            estadoProyectoInstance.properties = params
            title = "Crear Estado de proyecto"
        } else if (params.source == "edit") {
            estadoProyectoInstance = EstadoProyecto.get(params.id)
            if (!estadoProyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Estado de proyecto"
        }

        return [estadoProyectoInstance: estadoProyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["EstadoProyecto"], default: "Edit EstadoProyecto")
            def estadoProyectoInstance = EstadoProyecto.get(params.id)
            if (estadoProyectoInstance) {
                estadoProyectoInstance.properties = params
                if (!estadoProyectoInstance.hasErrors() && estadoProyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), estadoProyectoInstance.id])}"
                    redirect(action: "show", id: estadoProyectoInstance.id)
                }
                else {
                    render(view: "form", model: [estadoProyectoInstance: estadoProyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["EstadoProyecto"], default: "Create EstadoProyecto")
            def estadoProyectoInstance = new EstadoProyecto(params)
            if (estadoProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), estadoProyectoInstance.id])}"
                redirect(action: "show", id: estadoProyectoInstance.id)
            }
            else {
                render(view: "form", model: [estadoProyectoInstance: estadoProyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def estadoProyectoInstance = EstadoProyecto.get(params.id)
        if (estadoProyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (estadoProyectoInstance.version > version) {

                    estadoProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'estadoProyecto.label', default: 'EstadoProyecto')] as Object[], "Another user has updated this EstadoProyecto while you were editing")
                    render(view: "edit", model: [estadoProyectoInstance: estadoProyectoInstance])
                    return
                }
            }
            estadoProyectoInstance.properties = params
            if (!estadoProyectoInstance.hasErrors() && estadoProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), estadoProyectoInstance.id])}"
                redirect(action: "show", id: estadoProyectoInstance.id)
            }
            else {
                render(view: "edit", model: [estadoProyectoInstance: estadoProyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def estadoProyectoInstance = EstadoProyecto.get(params.id)
        if (!estadoProyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["EstadoProyecto"], default: "Show EstadoProyecto")

            [estadoProyectoInstance: estadoProyectoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def estadoProyectoInstance = EstadoProyecto.get(params.id)
        if (estadoProyectoInstance) {
            try {
                estadoProyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estadoProyecto.label', default: 'EstadoProyecto'), params.id])}"
            redirect(action: "list")
        }
    }
}
