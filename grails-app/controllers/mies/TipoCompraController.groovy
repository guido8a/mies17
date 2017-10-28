package mies

class TipoCompraController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def prueba = {

    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoCompra"], default: "TipoCompra List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoCompraInstanceList: TipoCompra.list(params), tipoCompraInstanceTotal: TipoCompra.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoCompraInstance

        if (params.source == "create") {
            tipoCompraInstance = new TipoCompra()
            tipoCompraInstance.properties = params
            title = "Crear Tipo de compra"
        } else if (params.source == "edit") {
            tipoCompraInstance = TipoCompra.get(params.id)
            if (!tipoCompraInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de compra"
        }

        return [tipoCompraInstance: tipoCompraInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoCompra"], default: "Edit TipoCompra")
            def tipoCompraInstance = TipoCompra.get(params.id)
            if (tipoCompraInstance) {
                tipoCompraInstance.properties = params
                if (!tipoCompraInstance.hasErrors() && tipoCompraInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), tipoCompraInstance.id])}"
                    redirect(action: "show", id: tipoCompraInstance.id)
                }
                else {
                    render(view: "form", model: [tipoCompraInstance: tipoCompraInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoCompra"], default: "Create TipoCompra")
            def tipoCompraInstance = new TipoCompra(params)
            if (tipoCompraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), tipoCompraInstance.id])}"
                redirect(action: "show", id: tipoCompraInstance.id)
            }
            else {
                render(view: "form", model: [tipoCompraInstance: tipoCompraInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoCompraInstance = TipoCompra.get(params.id)
        if (tipoCompraInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoCompraInstance.version > version) {

                    tipoCompraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoCompra.label', default: 'TipoCompra')] as Object[], "Another user has updated this TipoCompra while you were editing")
                    render(view: "edit", model: [tipoCompraInstance: tipoCompraInstance])
                    return
                }
            }
            tipoCompraInstance.properties = params
            if (!tipoCompraInstance.hasErrors() && tipoCompraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), tipoCompraInstance.id])}"
                redirect(action: "show", id: tipoCompraInstance.id)
            }
            else {
                render(view: "edit", model: [tipoCompraInstance: tipoCompraInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoCompraInstance = TipoCompra.get(params.id)
        if (!tipoCompraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoCompra"], default: "Show TipoCompra")

            [tipoCompraInstance: tipoCompraInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoCompraInstance = TipoCompra.get(params.id)
        if (tipoCompraInstance) {
            try {
                tipoCompraInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoCompra.label', default: 'TipoCompra'), params.id])}"
            redirect(action: "list")
        }
    }
}
