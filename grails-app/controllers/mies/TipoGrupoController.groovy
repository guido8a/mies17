package mies

class TipoGrupoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoGrupo"], default: "TipoGrupo List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoGrupoInstanceList: TipoGrupo.list(params), tipoGrupoInstanceTotal: TipoGrupo.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoGrupoInstance

        if (params.source == "create") {
            tipoGrupoInstance = new TipoGrupo()
            tipoGrupoInstance.properties = params
            title = "Crear Tipo de grupo de atenci&oacute;n"
        } else if (params.source == "edit") {
            tipoGrupoInstance = TipoGrupo.get(params.id)
            if (!tipoGrupoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de grupo de atenci&oacute;n"
        }

        return [tipoGrupoInstance: tipoGrupoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoGrupo"], default: "Edit TipoGrupo")
            def tipoGrupoInstance = TipoGrupo.get(params.id)
            if (tipoGrupoInstance) {
                tipoGrupoInstance.properties = params
                if (!tipoGrupoInstance.hasErrors() && tipoGrupoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), tipoGrupoInstance.id])}"
                    redirect(action: "show", id: tipoGrupoInstance.id)
                }
                else {
                    render(view: "form", model: [tipoGrupoInstance: tipoGrupoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoGrupo"], default: "Create TipoGrupo")
            def tipoGrupoInstance = new TipoGrupo(params)
            if (tipoGrupoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), tipoGrupoInstance.id])}"
                redirect(action: "show", id: tipoGrupoInstance.id)
            }
            else {
                render(view: "form", model: [tipoGrupoInstance: tipoGrupoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoGrupoInstance = TipoGrupo.get(params.id)
        if (tipoGrupoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoGrupoInstance.version > version) {

                    tipoGrupoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoGrupo.label', default: 'TipoGrupo')] as Object[], "Another user has updated this TipoGrupo while you were editing")
                    render(view: "edit", model: [tipoGrupoInstance: tipoGrupoInstance])
                    return
                }
            }
            tipoGrupoInstance.properties = params
            if (!tipoGrupoInstance.hasErrors() && tipoGrupoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), tipoGrupoInstance.id])}"
                redirect(action: "show", id: tipoGrupoInstance.id)
            }
            else {
                render(view: "edit", model: [tipoGrupoInstance: tipoGrupoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoGrupoInstance = TipoGrupo.get(params.id)
        if (!tipoGrupoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoGrupo"], default: "Show TipoGrupo")

            [tipoGrupoInstance: tipoGrupoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoGrupoInstance = TipoGrupo.get(params.id)
        if (tipoGrupoInstance) {
            try {
                tipoGrupoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoGrupo.label', default: 'TipoGrupo'), params.id])}"
            redirect(action: "list")
        }
    }
}
