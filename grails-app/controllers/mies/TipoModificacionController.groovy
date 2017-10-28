package mies

class TipoModificacionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoModificacion"], default: "TipoModificacion List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoModificacionInstanceList: TipoModificacion.list(params), tipoModificacionInstanceTotal: TipoModificacion.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoModificacionInstance

        if (params.source == "create") {
            tipoModificacionInstance = new TipoModificacion()
            tipoModificacionInstance.properties = params
            title = "Crear Tipo de modificación"
        } else if (params.source == "edit") {
            tipoModificacionInstance = TipoModificacion.get(params.id)
            if (!tipoModificacionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de modificación"
        }

        return [tipoModificacionInstance: tipoModificacionInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoModificacion"], default: "Edit TipoModificacion")
            def tipoModificacionInstance = TipoModificacion.get(params.id)
            if (tipoModificacionInstance) {
                tipoModificacionInstance.properties = params
                if (!tipoModificacionInstance.hasErrors() && tipoModificacionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), tipoModificacionInstance.id])}"
                    redirect(action: "show", id: tipoModificacionInstance.id)
                }
                else {
                    render(view: "form", model: [tipoModificacionInstance: tipoModificacionInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoModificacion"], default: "Create TipoModificacion")
            def tipoModificacionInstance = new TipoModificacion(params)
            if (tipoModificacionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), tipoModificacionInstance.id])}"
                redirect(action: "show", id: tipoModificacionInstance.id)
            }
            else {
                render(view: "form", model: [tipoModificacionInstance: tipoModificacionInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoModificacionInstance = TipoModificacion.get(params.id)
        if (tipoModificacionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoModificacionInstance.version > version) {

                    tipoModificacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoModificacion.label', default: 'TipoModificacion')] as Object[], "Another user has updated this TipoModificacion while you were editing")
                    render(view: "edit", model: [tipoModificacionInstance: tipoModificacionInstance])
                    return
                }
            }
            tipoModificacionInstance.properties = params
            if (!tipoModificacionInstance.hasErrors() && tipoModificacionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), tipoModificacionInstance.id])}"
                redirect(action: "show", id: tipoModificacionInstance.id)
            }
            else {
                render(view: "edit", model: [tipoModificacionInstance: tipoModificacionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoModificacionInstance = TipoModificacion.get(params.id)
        if (!tipoModificacionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoModificacion"], default: "Show TipoModificacion")

            [tipoModificacionInstance: tipoModificacionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoModificacionInstance = TipoModificacion.get(params.id)
        if (tipoModificacionInstance) {
            try {
                tipoModificacionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoModificacion.label', default: 'TipoModificacion'), params.id])}"
            redirect(action: "list")
        }
    }
}
