package mies

class ActividadPresupuestoController extends mies.seguridad.Shield {

    def index() { }

    def list = {
        def title = "Lista de Actividades"
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [actividadPresupuestoInstanceList: ActividadPresupuesto.list(params), actividadPresupuestoInstanceTotal: ActividadPresupuesto.count(), title: title, params: params]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def form = {
        def title
        def actividadPresupuestoInstance

        if (params.source == "create") {
            actividadPresupuestoInstance = new ActividadPresupuesto()
            actividadPresupuestoInstance.properties = params
            title = g.message(code: "actividadPresupuesto.create", default: "Nueva Actividad Presupuestaria")
        } else if (params.source == "edit") {
            actividadPresupuestoInstance = ActividadPresupuesto.get(params.id)
            if (!actividadPresupuestoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad Presupuestaria'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "actividadPresupuesto.edit", default: "Editar Actividad")
        }

        return [actividadPresupuestoInstance: actividadPresupuestoInstance, title: title, source: params.source]
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "actividadPresupuesto.edit", default: "Editar Actividad")
            def actividadPresupuestoInstance = ActividadPresupuesto.get(params.id)
            if (actividadPresupuestoInstance) {
                actividadPresupuestoInstance.properties = params
                if (!actividadPresupuestoInstance.hasErrors() && actividadPresupuestoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), actividadPresupuestoInstance.id])}"
                    redirect(action: "show", id: actividadPresupuestoInstance.id)
                }
                else {
                    render(view: "form", model: [actividadPresupuestoInstance: actividadPresupuestoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "actividadPresupuesto.create", default: "Nueva Actividad Presupuestaria")
            def actividadPresupuestoInstance = new ActividadPresupuesto(params)
            if (actividadPresupuestoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), actividadPresupuestoInstance.id])}"
                redirect(action: "show", id: actividadPresupuestoInstance.id)
            }
            else {
                render(view: "form", model: [componenteInstance: actividadPresupuestoInstance, title: title, source: "create"])
            }
        }
    }

    def show = {
        def actividadPresupuestoInstance = ActividadPresupuesto.get(params.id)
        if (!actividadPresupuestoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), params.id])}"
            redirect(action: "list")
        }
        else {
            def title = g.message(code: "actividadPresupuesto.show", default: "Ver Actividad")
            [actividadPresupuestoInstance: actividadPresupuestoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def actividadPresupuestoInstance = ActividadPresupuesto.get(params.id)
        if (actividadPresupuestoInstance) {
            try {
                actividadPresupuestoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'actividadPresupuesto.label', default: 'Actividad'), params.id])}"
            redirect(action: "list")
        }
    }




}
