package mies

class TipoParticipacionController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoParticipacion"], default: "TipoParticipacion List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoParticipacionInstanceList: TipoParticipacion.list(params), tipoParticipacionInstanceTotal: TipoParticipacion.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoParticipacionInstance

        if (params.source == "create") {
            tipoParticipacionInstance = new TipoParticipacion()
            tipoParticipacionInstance.properties = params
            title = "Crear Tipo de participación"
        } else if (params.source == "edit") {
            tipoParticipacionInstance = TipoParticipacion.get(params.id)
            if (!tipoParticipacionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de participación"
        }

        return [tipoParticipacionInstance: tipoParticipacionInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoParticipacion"], default: "Edit TipoParticipacion")
            def tipoParticipacionInstance = TipoParticipacion.get(params.id)
            if (tipoParticipacionInstance) {
                tipoParticipacionInstance.properties = params
                if (!tipoParticipacionInstance.hasErrors() && tipoParticipacionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), tipoParticipacionInstance.id])}"
                    redirect(action: "show", id: tipoParticipacionInstance.id)
                }
                else {
                    render(view: "form", model: [tipoParticipacionInstance: tipoParticipacionInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoParticipacion"], default: "Create TipoParticipacion")
            def tipoParticipacionInstance = new TipoParticipacion(params)
            if (tipoParticipacionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), tipoParticipacionInstance.id])}"
                redirect(action: "show", id: tipoParticipacionInstance.id)
            }
            else {
                render(view: "form", model: [tipoParticipacionInstance: tipoParticipacionInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoParticipacionInstance = TipoParticipacion.get(params.id)
        if (tipoParticipacionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoParticipacionInstance.version > version) {

                    tipoParticipacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion')] as Object[], "Another user has updated this TipoParticipacion while you were editing")
                    render(view: "edit", model: [tipoParticipacionInstance: tipoParticipacionInstance])
                    return
                }
            }
            tipoParticipacionInstance.properties = params
            if (!tipoParticipacionInstance.hasErrors() && tipoParticipacionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), tipoParticipacionInstance.id])}"
                redirect(action: "show", id: tipoParticipacionInstance.id)
            }
            else {
                render(view: "edit", model: [tipoParticipacionInstance: tipoParticipacionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoParticipacionInstance = TipoParticipacion.get(params.id)
        if (!tipoParticipacionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoParticipacion"], default: "Show TipoParticipacion")

            [tipoParticipacionInstance: tipoParticipacionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoParticipacionInstance = TipoParticipacion.get(params.id)
        if (tipoParticipacionInstance) {
            try {
                tipoParticipacionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoParticipacion.label', default: 'TipoParticipacion'), params.id])}"
            redirect(action: "list")
        }
    }
}
