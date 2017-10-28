package mies

class ActividadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Actividad"], default: "Actividad List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [actividadInstanceList: Actividad.list(params), actividadInstanceTotal: Actividad.count(), title: title, params: params]
    }

    def form = {
        def title
        def actividadInstance

        if (params.source == "create") {
            actividadInstance = new Actividad()
            actividadInstance.properties = params
            title ="Crear Actividad de gasto corriente"
        } else if (params.source == "edit") {
            actividadInstance = Actividad.get(params.id)
            if (!actividadInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
                redirect(action: "list")
            }
            title ="Editar Actividad de gasto corriente"
        }

        return [actividadInstance: actividadInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Actividad"], default: "Edit Actividad")
            def actividadInstance = Actividad.get(params.id)
            if (actividadInstance) {
                actividadInstance.properties = params
                if (!actividadInstance.hasErrors() && actividadInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'actividad.label', default: 'Actividad'), actividadInstance.id])}"
                    redirect(action: "show", id: actividadInstance.id)
                }
                else {
                    render(view: "form", model: [actividadInstance: actividadInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Actividad"], default: "Create Actividad")
            def actividadInstance = new Actividad(params)
            if (actividadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'actividad.label', default: 'Actividad'), actividadInstance.id])}"
                redirect(action: "show", id: actividadInstance.id)
            }
            else {
                render(view: "form", model: [actividadInstance: actividadInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def actividadInstance = Actividad.get(params.id)
        if (actividadInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (actividadInstance.version > version) {

                    actividadInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'actividad.label', default: 'Actividad')] as Object[], "Another user has updated this Actividad while you were editing")
                    render(view: "edit", model: [actividadInstance: actividadInstance])
                    return
                }
            }
            actividadInstance.properties = params
            if (!actividadInstance.hasErrors() && actividadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'actividad.label', default: 'Actividad'), actividadInstance.id])}"
                redirect(action: "show", id: actividadInstance.id)
            }
            else {
                render(view: "edit", model: [actividadInstance: actividadInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def actividadInstance = Actividad.get(params.id)
        if (!actividadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Actividad"], default: "Show Actividad")

            [actividadInstance: actividadInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def actividadInstance = Actividad.get(params.id)
        if (actividadInstance) {
            try {
                actividadInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividad.label', default: 'Actividad'), params.id])}"
            redirect(action: "list")
        }
    }
}
