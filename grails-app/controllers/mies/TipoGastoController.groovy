package mies

class TipoGastoController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoGasto"], default: "TipoGasto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoGastoInstanceList: TipoGasto.list(params), tipoGastoInstanceTotal: TipoGasto.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoGastoInstance

        if (params.source == "create") {
            tipoGastoInstance = new TipoGasto()
            tipoGastoInstance.properties = params
            title = "Crear Tipo de gasto"
        } else if (params.source == "edit") {
            tipoGastoInstance = TipoGasto.get(params.id)
            if (!tipoGastoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de gasto"
        }

        return [tipoGastoInstance: tipoGastoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoGasto"], default: "Edit TipoGasto")
            def tipoGastoInstance = TipoGasto.get(params.id)
            if (tipoGastoInstance) {
                tipoGastoInstance.properties = params
                if (!tipoGastoInstance.hasErrors() && tipoGastoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), tipoGastoInstance.id])}"
                    redirect(action: "show", id: tipoGastoInstance.id)
                }
                else {
                    render(view: "form", model: [tipoGastoInstance: tipoGastoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoGasto"], default: "Create TipoGasto")
            def tipoGastoInstance = new TipoGasto(params)
            if (tipoGastoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), tipoGastoInstance.id])}"
                redirect(action: "show", id: tipoGastoInstance.id)
            }
            else {
                render(view: "form", model: [tipoGastoInstance: tipoGastoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoGastoInstance = TipoGasto.get(params.id)
        if (tipoGastoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoGastoInstance.version > version) {

                    tipoGastoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoGasto.label', default: 'TipoGasto')] as Object[], "Another user has updated this TipoGasto while you were editing")
                    render(view: "edit", model: [tipoGastoInstance: tipoGastoInstance])
                    return
                }
            }
            tipoGastoInstance.properties = params
            if (!tipoGastoInstance.hasErrors() && tipoGastoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), tipoGastoInstance.id])}"
                redirect(action: "show", id: tipoGastoInstance.id)
            }
            else {
                render(view: "edit", model: [tipoGastoInstance: tipoGastoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoGastoInstance = TipoGasto.get(params.id)
        if (!tipoGastoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoGasto"], default: "Show TipoGasto")

            [tipoGastoInstance: tipoGastoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoGastoInstance = TipoGasto.get(params.id)
        if (tipoGastoInstance) {
            try {
                tipoGastoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGasto.label', default: 'TipoGasto'), params.id])}"
            redirect(action: "list")
        }
    }
}
