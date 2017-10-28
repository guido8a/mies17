package mies

class UnidadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Unidad"], default: "Unidad List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [unidadInstanceList: Unidad.list(params), unidadInstanceTotal: Unidad.count(), title: title, params: params]
    }

    def form = {
        def title
        def unidadInstance

        if (params.source == "create") {
            unidadInstance = new Unidad()
            unidadInstance.properties = params
            title = "Crear Unidad de medida"
        } else if (params.source == "edit") {
            unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Unidad de medida"
        }

        return [unidadInstance: unidadInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Unidad"], default: "Edit Unidad")
            def unidadInstance = Unidad.get(params.id)
            if (unidadInstance) {
                unidadInstance.properties = params
                if (!unidadInstance.hasErrors() && unidadInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unidad.label', default: 'Unidad'), unidadInstance.id])}"
                    redirect(action: "show", id: unidadInstance.id)
                }
                else {
                    render(view: "form", model: [unidadInstance: unidadInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Unidad"], default: "Create Unidad")
            def unidadInstance = new Unidad(params)
            if (unidadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'unidad.label', default: 'Unidad'), unidadInstance.id])}"
                redirect(action: "show", id: unidadInstance.id)
            }
            else {
                render(view: "form", model: [unidadInstance: unidadInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def unidadInstance = Unidad.get(params.id)
        if (unidadInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (unidadInstance.version > version) {

                    unidadInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'unidad.label', default: 'Unidad')] as Object[], "Another user has updated this Unidad while you were editing")
                    render(view: "edit", model: [unidadInstance: unidadInstance])
                    return
                }
            }
            unidadInstance.properties = params
            if (!unidadInstance.hasErrors() && unidadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unidad.label', default: 'Unidad'), unidadInstance.id])}"
                redirect(action: "show", id: unidadInstance.id)
            }
            else {
                render(view: "edit", model: [unidadInstance: unidadInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Unidad"], default: "Show Unidad")

            [unidadInstance: unidadInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def unidadInstance = Unidad.get(params.id)
        if (unidadInstance) {
            try {
                unidadInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unidad.label', default: 'Unidad'), params.id])}"
            redirect(action: "list")
        }
    }
}
