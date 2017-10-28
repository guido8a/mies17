package mies

class TipoProcedenciaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoProcedencia"], default: "TipoProcedencia List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoProcedenciaInstanceList: TipoProcedencia.list(params), tipoProcedenciaInstanceTotal: TipoProcedencia.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoProcedenciaInstance

        if (params.source == "create") {
            tipoProcedenciaInstance = new TipoProcedencia()
            tipoProcedenciaInstance.properties = params
            title = "Crear Tipo de procedencia"
        } else if (params.source == "edit") {
            tipoProcedenciaInstance = TipoProcedencia.get(params.id)
            if (!tipoProcedenciaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de procedencia"
        }

        return [tipoProcedenciaInstance: tipoProcedenciaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoProcedencia"], default: "Edit TipoProcedencia")
            def tipoProcedenciaInstance = TipoProcedencia.get(params.id)
            if (tipoProcedenciaInstance) {
                tipoProcedenciaInstance.properties = params
                if (!tipoProcedenciaInstance.hasErrors() && tipoProcedenciaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), tipoProcedenciaInstance.id])}"
                    redirect(action: "show", id: tipoProcedenciaInstance.id)
                }
                else {
                    render(view: "form", model: [tipoProcedenciaInstance: tipoProcedenciaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoProcedencia"], default: "Create TipoProcedencia")
            def tipoProcedenciaInstance = new TipoProcedencia(params)
            if (tipoProcedenciaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), tipoProcedenciaInstance.id])}"
                redirect(action: "show", id: tipoProcedenciaInstance.id)
            }
            else {
                render(view: "form", model: [tipoProcedenciaInstance: tipoProcedenciaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoProcedenciaInstance = TipoProcedencia.get(params.id)
        if (tipoProcedenciaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoProcedenciaInstance.version > version) {

                    tipoProcedenciaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia')] as Object[], "Another user has updated this TipoProcedencia while you were editing")
                    render(view: "edit", model: [tipoProcedenciaInstance: tipoProcedenciaInstance])
                    return
                }
            }
            tipoProcedenciaInstance.properties = params
            if (!tipoProcedenciaInstance.hasErrors() && tipoProcedenciaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), tipoProcedenciaInstance.id])}"
                redirect(action: "show", id: tipoProcedenciaInstance.id)
            }
            else {
                render(view: "edit", model: [tipoProcedenciaInstance: tipoProcedenciaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoProcedenciaInstance = TipoProcedencia.get(params.id)
        if (!tipoProcedenciaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoProcedencia"], default: "Show TipoProcedencia")

            [tipoProcedenciaInstance: tipoProcedenciaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoProcedenciaInstance = TipoProcedencia.get(params.id)
        if (tipoProcedenciaInstance) {
            try {
                tipoProcedenciaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoProcedencia.label', default: 'TipoProcedencia'), params.id])}"
            redirect(action: "list")
        }
    }
}
