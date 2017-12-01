package mies

class TipoInversionController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoInversion"], default: "TipoInversion List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoInversionInstanceList: TipoInversion.list(params), tipoInversionInstanceTotal: TipoInversion.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoInversionInstance

        if (params.source == "create") {
            tipoInversionInstance = new TipoInversion()
            tipoInversionInstance.properties = params
            title = "Crear Tipo de inversión"
        } else if (params.source == "edit") {
            tipoInversionInstance = TipoInversion.get(params.id)
            if (!tipoInversionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de inversión"
        }

        return [tipoInversionInstance: tipoInversionInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoInversion"], default: "Edit TipoInversion")
            def tipoInversionInstance = TipoInversion.get(params.id)
            if (tipoInversionInstance) {
                tipoInversionInstance.properties = params
                if (!tipoInversionInstance.hasErrors() && tipoInversionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), tipoInversionInstance.id])}"
                    redirect(action: "show", id: tipoInversionInstance.id)
                }
                else {
                    render(view: "form", model: [tipoInversionInstance: tipoInversionInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoInversion"], default: "Create TipoInversion")
            def tipoInversionInstance = new TipoInversion(params)
            if (tipoInversionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), tipoInversionInstance.id])}"
                redirect(action: "show", id: tipoInversionInstance.id)
            }
            else {
                render(view: "form", model: [tipoInversionInstance: tipoInversionInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoInversionInstance = TipoInversion.get(params.id)
        if (tipoInversionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoInversionInstance.version > version) {

                    tipoInversionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoInversion.label', default: 'TipoInversion')] as Object[], "Another user has updated this TipoInversion while you were editing")
                    render(view: "edit", model: [tipoInversionInstance: tipoInversionInstance])
                    return
                }
            }
            tipoInversionInstance.properties = params
            if (!tipoInversionInstance.hasErrors() && tipoInversionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), tipoInversionInstance.id])}"
                redirect(action: "show", id: tipoInversionInstance.id)
            }
            else {
                render(view: "edit", model: [tipoInversionInstance: tipoInversionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoInversionInstance = TipoInversion.get(params.id)
        if (!tipoInversionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoInversion"], default: "Show TipoInversion")

            [tipoInversionInstance: tipoInversionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoInversionInstance = TipoInversion.get(params.id)
        if (tipoInversionInstance) {
            try {
                tipoInversionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInversion.label', default: 'TipoInversion'), params.id])}"
            redirect(action: "list")
        }
    }
}
