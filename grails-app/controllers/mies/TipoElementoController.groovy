package mies

class TipoElementoController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "tipoelemento.list", default: "TipoElemento List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoElementoInstanceList: TipoElemento.list(params), tipoElementoInstanceTotal: TipoElemento.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoElementoInstance

        if (params.source == "create") {
            tipoElementoInstance = new TipoElemento()
            tipoElementoInstance.properties = params
            title = "Crear Tipo de elemento"
        } else if (params.source == "edit") {
            tipoElementoInstance = TipoElemento.get(params.id)
            if (!tipoElementoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de elemento"
        }

        return [tipoElementoInstance: tipoElementoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "tipoelemento.edit", default: "Edit TipoElemento")
            def tipoElementoInstance = TipoElemento.get(params.id)
            if (tipoElementoInstance) {
                tipoElementoInstance.properties = params
                if (!tipoElementoInstance.hasErrors() && tipoElementoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), tipoElementoInstance.id])}"
                    redirect(action: "show", id: tipoElementoInstance.id)
                }
                else {
                    render(view: "form", model: [tipoElementoInstance: tipoElementoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "tipoelemento.create", default: "Create TipoElemento")
            def tipoElementoInstance = new TipoElemento(params)
            if (tipoElementoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), tipoElementoInstance.id])}"
                redirect(action: "show", id: tipoElementoInstance.id)
            }
            else {
                render(view: "form", model: [tipoElementoInstance: tipoElementoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoElementoInstance = TipoElemento.get(params.id)
        if (tipoElementoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoElementoInstance.version > version) {

                    tipoElementoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoElemento.label', default: 'TipoElemento')] as Object[], "Another user has updated this TipoElemento while you were editing")
                    render(view: "edit", model: [tipoElementoInstance: tipoElementoInstance])
                    return
                }
            }
            tipoElementoInstance.properties = params
            if (!tipoElementoInstance.hasErrors() && tipoElementoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), tipoElementoInstance.id])}"
                redirect(action: "show", id: tipoElementoInstance.id)
            }
            else {
                render(view: "edit", model: [tipoElementoInstance: tipoElementoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoElementoInstance = TipoElemento.get(params.id)
        if (!tipoElementoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "tipoelemento.show", default: "Show TipoElemento")

            [tipoElementoInstance: tipoElementoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoElementoInstance = TipoElemento.get(params.id)
        if (tipoElementoInstance) {
            try {
                tipoElementoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoElemento.label', default: 'TipoElemento'), params.id])}"
            redirect(action: "list")
        }
    }
}
