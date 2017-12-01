package mies

class CalificacionController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Calificacion"], default: "Calificacion List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [calificacionInstanceList: Calificacion.list(params), calificacionInstanceTotal: Calificacion.count(), title: title, params: params]
    }

    def form = {
        def title
        def calificacionInstance

        if (params.source == "create") {
            calificacionInstance = new Calificacion()
            calificacionInstance.properties = params
            title = "Crear Calificación"
        } else if (params.source == "edit") {
            calificacionInstance = Calificacion.get(params.id)
            if (!calificacionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Calificación"
        }

        return [calificacionInstance: calificacionInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Calificacion"], default: "Edit Calificacion")
            def calificacionInstance = Calificacion.get(params.id)
            if (calificacionInstance) {
                calificacionInstance.properties = params
                if (!calificacionInstance.hasErrors() && calificacionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), calificacionInstance.id])}"
                    redirect(action: "show", id: calificacionInstance.id)
                }
                else {
                    render(view: "form", model: [calificacionInstance: calificacionInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Calificacion"], default: "Create Calificacion")
            def calificacionInstance = new Calificacion(params)
            if (calificacionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), calificacionInstance.id])}"
                redirect(action: "show", id: calificacionInstance.id)
            }
            else {
                render(view: "form", model: [calificacionInstance: calificacionInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def calificacionInstance = Calificacion.get(params.id)
        if (calificacionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (calificacionInstance.version > version) {

                    calificacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'calificacion.label', default: 'Calificacion')] as Object[], "Another user has updated this Calificacion while you were editing")
                    render(view: "edit", model: [calificacionInstance: calificacionInstance])
                    return
                }
            }
            calificacionInstance.properties = params
            if (!calificacionInstance.hasErrors() && calificacionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), calificacionInstance.id])}"
                redirect(action: "show", id: calificacionInstance.id)
            }
            else {
                render(view: "edit", model: [calificacionInstance: calificacionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def calificacionInstance = Calificacion.get(params.id)
        if (!calificacionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Calificacion"], default: "Show Calificacion")

            [calificacionInstance: calificacionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def calificacionInstance = Calificacion.get(params.id)
        if (calificacionInstance) {
            try {
                calificacionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'calificacion.label', default: 'Calificacion'), params.id])}"
            redirect(action: "list")
        }
    }
}
