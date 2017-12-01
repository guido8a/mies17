package mies

class TipoMetaController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoMeta"], default: "TipoMeta List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoMetaInstanceList: TipoMeta.list(params), tipoMetaInstanceTotal: TipoMeta.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoMetaInstance

        if (params.source == "create") {
            tipoMetaInstance = new TipoMeta()
            tipoMetaInstance.properties = params
            title = "Crear Tipo de meta"
        } else if (params.source == "edit") {
            tipoMetaInstance = TipoMeta.get(params.id)
            if (!tipoMetaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de meta"
        }

        return [tipoMetaInstance: tipoMetaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoMeta"], default: "Edit TipoMeta")
            def tipoMetaInstance = TipoMeta.get(params.id)
            if (tipoMetaInstance) {
                tipoMetaInstance.properties = params
                if (!tipoMetaInstance.hasErrors() && tipoMetaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), tipoMetaInstance.id])}"
                    redirect(action: "show", id: tipoMetaInstance.id)
                }
                else {
                    render(view: "form", model: [tipoMetaInstance: tipoMetaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoMeta"], default: "Create TipoMeta")
            def tipoMetaInstance = new TipoMeta(params)
            if (tipoMetaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), tipoMetaInstance.id])}"
                redirect(action: "show", id: tipoMetaInstance.id)
            }
            else {
                render(view: "form", model: [tipoMetaInstance: tipoMetaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoMetaInstance = TipoMeta.get(params.id)
        if (tipoMetaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoMetaInstance.version > version) {

                    tipoMetaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoMeta.label', default: 'TipoMeta')] as Object[], "Another user has updated this TipoMeta while you were editing")
                    render(view: "edit", model: [tipoMetaInstance: tipoMetaInstance])
                    return
                }
            }
            tipoMetaInstance.properties = params
            if (!tipoMetaInstance.hasErrors() && tipoMetaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), tipoMetaInstance.id])}"
                redirect(action: "show", id: tipoMetaInstance.id)
            }
            else {
                render(view: "edit", model: [tipoMetaInstance: tipoMetaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoMetaInstance = TipoMeta.get(params.id)
        if (!tipoMetaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoMeta"], default: "Show TipoMeta")

            [tipoMetaInstance: tipoMetaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoMetaInstance = TipoMeta.get(params.id)
        if (tipoMetaInstance) {
            try {
                tipoMetaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoMeta.label', default: 'TipoMeta'), params.id])}"
            redirect(action: "list")
        }
    }
}
