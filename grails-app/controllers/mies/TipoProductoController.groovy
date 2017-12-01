package mies

class TipoProductoController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoProducto"], default: "TipoProducto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoProductoInstanceList: TipoProducto.list(params), tipoProductoInstanceTotal: TipoProducto.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoProductoInstance

        if (params.source == "create") {
            tipoProductoInstance = new TipoProducto()
            tipoProductoInstance.properties = params
            title = "Crear Tipo de producto"
        } else if (params.source == "edit") {
            tipoProductoInstance = TipoProducto.get(params.id)
            if (!tipoProductoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de producto"
        }

        return [tipoProductoInstance: tipoProductoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoProducto"], default: "Edit TipoProducto")
            def tipoProductoInstance = TipoProducto.get(params.id)
            if (tipoProductoInstance) {
                tipoProductoInstance.properties = params
                if (!tipoProductoInstance.hasErrors() && tipoProductoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), tipoProductoInstance.id])}"
                    redirect(action: "show", id: tipoProductoInstance.id)
                }
                else {
                    render(view: "form", model: [tipoProductoInstance: tipoProductoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoProducto"], default: "Create TipoProducto")
            def tipoProductoInstance = new TipoProducto(params)
            if (tipoProductoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), tipoProductoInstance.id])}"
                redirect(action: "show", id: tipoProductoInstance.id)
            }
            else {
                render(view: "form", model: [tipoProductoInstance: tipoProductoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoProductoInstance = TipoProducto.get(params.id)
        if (tipoProductoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoProductoInstance.version > version) {

                    tipoProductoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoProducto.label', default: 'TipoProducto')] as Object[], "Another user has updated this TipoProducto while you were editing")
                    render(view: "edit", model: [tipoProductoInstance: tipoProductoInstance])
                    return
                }
            }
            tipoProductoInstance.properties = params
            if (!tipoProductoInstance.hasErrors() && tipoProductoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), tipoProductoInstance.id])}"
                redirect(action: "show", id: tipoProductoInstance.id)
            }
            else {
                render(view: "edit", model: [tipoProductoInstance: tipoProductoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoProductoInstance = TipoProducto.get(params.id)
        if (!tipoProductoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoProducto"], default: "Show TipoProducto")

            [tipoProductoInstance: tipoProductoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoProductoInstance = TipoProducto.get(params.id)
        if (tipoProductoInstance) {
            try {
                tipoProductoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])}"
            redirect(action: "list")
        }
    }
}
