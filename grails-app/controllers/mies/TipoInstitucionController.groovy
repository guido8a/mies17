package mies

class TipoInstitucionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "tipoinstitucion.list", default: "TipoInstitucion List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [tipoInstitucionInstanceList: TipoInstitucion.list(params), tipoInstitucionInstanceTotal: TipoInstitucion.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoInstitucionInstance

        if (params.source == "create") {
            tipoInstitucionInstance = new TipoInstitucion()
            tipoInstitucionInstance.properties = params
            title = g.message(code: "tipoinstitucion.create", default: "Create TipoInstitucion")
        } else if (params.source == "edit") {
            tipoInstitucionInstance = TipoInstitucion.get(params.id)
            if (!tipoInstitucionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "tipoinstitucion.edit", default: "Edit TipoInstitucion")
        }

        return [tipoInstitucionInstance: tipoInstitucionInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "tipoinstitucion.edit", default: "Edit TipoInstitucion")
            def tipoInstitucionInstance = TipoInstitucion.get(params.id)
            if (tipoInstitucionInstance) {
                tipoInstitucionInstance.properties = params
                if (!tipoInstitucionInstance.hasErrors() && tipoInstitucionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), tipoInstitucionInstance.id])}"
                    redirect(action: "show", id: tipoInstitucionInstance.id)
                }
                else {
                    render(view: "form", model: [tipoInstitucionInstance: tipoInstitucionInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "tipoinstitucion.create", default: "Create TipoInstitucion")
            def tipoInstitucionInstance = new TipoInstitucion(params)
            if (tipoInstitucionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), tipoInstitucionInstance.id])}"
                redirect(action: "show", id: tipoInstitucionInstance.id)
            }
            else {
                render(view: "form", model: [tipoInstitucionInstance: tipoInstitucionInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoInstitucionInstance = TipoInstitucion.get(params.id)
        if (tipoInstitucionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoInstitucionInstance.version > version) {

                    tipoInstitucionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion')] as Object[], "Another user has updated this TipoInstitucion while you were editing")
                    render(view: "edit", model: [tipoInstitucionInstance: tipoInstitucionInstance])
                    return
                }
            }
            tipoInstitucionInstance.properties = params
            if (!tipoInstitucionInstance.hasErrors() && tipoInstitucionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), tipoInstitucionInstance.id])}"
                redirect(action: "show", id: tipoInstitucionInstance.id)
            }
            else {
                render(view: "edit", model: [tipoInstitucionInstance: tipoInstitucionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoInstitucionInstance = TipoInstitucion.get(params.id)
        if (!tipoInstitucionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "tipoinstitucion.show", default: "Show TipoInstitucion")

            [tipoInstitucionInstance: tipoInstitucionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoInstitucionInstance = TipoInstitucion.get(params.id)
        if (tipoInstitucionInstance) {
            try {
                tipoInstitucionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInstitucion.label', default: 'TipoInstitucion'), params.id])}"
            redirect(action: "list")
        }
    }
}
