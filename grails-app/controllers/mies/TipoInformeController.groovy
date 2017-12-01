package mies

class TipoInformeController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoInforme"], default: "TipoInforme List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoInformeInstanceList: TipoInforme.list(params), tipoInformeInstanceTotal: TipoInforme.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoInformeInstance

        if (params.source == "create") {
            tipoInformeInstance = new TipoInforme()
            tipoInformeInstance.properties = params
            title = "Crear Tipo de informe"
        } else if (params.source == "edit") {
            tipoInformeInstance = TipoInforme.get(params.id)
            if (!tipoInformeInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de informe"
        }

        return [tipoInformeInstance: tipoInformeInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoInforme"], default: "Edit TipoInforme")
            def tipoInformeInstance = TipoInforme.get(params.id)
            if (tipoInformeInstance) {
                tipoInformeInstance.properties = params
                if (!tipoInformeInstance.hasErrors() && tipoInformeInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), tipoInformeInstance.id])}"
                    redirect(action: "show", id: tipoInformeInstance.id)
                }
                else {
                    render(view: "form", model: [tipoInformeInstance: tipoInformeInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoInforme"], default: "Create TipoInforme")
            def tipoInformeInstance = new TipoInforme(params)
            if (tipoInformeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), tipoInformeInstance.id])}"
                redirect(action: "show", id: tipoInformeInstance.id)
            }
            else {
                render(view: "form", model: [tipoInformeInstance: tipoInformeInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoInformeInstance = TipoInforme.get(params.id)
        if (tipoInformeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoInformeInstance.version > version) {

                    tipoInformeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoInforme.label', default: 'TipoInforme')] as Object[], "Another user has updated this TipoInforme while you were editing")
                    render(view: "edit", model: [tipoInformeInstance: tipoInformeInstance])
                    return
                }
            }
            tipoInformeInstance.properties = params
            if (!tipoInformeInstance.hasErrors() && tipoInformeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), tipoInformeInstance.id])}"
                redirect(action: "show", id: tipoInformeInstance.id)
            }
            else {
                render(view: "edit", model: [tipoInformeInstance: tipoInformeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoInformeInstance = TipoInforme.get(params.id)
        if (!tipoInformeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoInforme"], default: "Show TipoInforme")

            [tipoInformeInstance: tipoInformeInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoInformeInstance = TipoInforme.get(params.id)
        if (tipoInformeInstance) {
            try {
                tipoInformeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoInforme.label', default: 'TipoInforme'), params.id])}"
            redirect(action: "list")
        }
    }
}
