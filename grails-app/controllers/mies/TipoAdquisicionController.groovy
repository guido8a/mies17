package mies

class TipoAdquisicionController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["TipoAdquisicion"], default: "TipoAdquisicion List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [tipoAdquisicionInstanceList: TipoAdquisicion.list(params), tipoAdquisicionInstanceTotal: TipoAdquisicion.count(), title: title, params: params]
    }

    def form = {
        def title
        def tipoAdquisicionInstance

        if (params.source == "create") {
            tipoAdquisicionInstance = new TipoAdquisicion()
            tipoAdquisicionInstance.properties = params
            title = "Crear Tipo de adquisición"
        } else if (params.source == "edit") {
            tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
            if (!tipoAdquisicionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Tipo de adquisición"
        }

        return [tipoAdquisicionInstance: tipoAdquisicionInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["TipoAdquisicion"], default: "Edit TipoAdquisicion")
            def tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
            if (tipoAdquisicionInstance) {
                tipoAdquisicionInstance.properties = params
                if (!tipoAdquisicionInstance.hasErrors() && tipoAdquisicionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), tipoAdquisicionInstance.id])}"
                    redirect(action: "show", id: tipoAdquisicionInstance.id)
                }
                else {
                    render(view: "form", model: [tipoAdquisicionInstance: tipoAdquisicionInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["TipoAdquisicion"], default: "Create TipoAdquisicion")
            def tipoAdquisicionInstance = new TipoAdquisicion(params)
            if (tipoAdquisicionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), tipoAdquisicionInstance.id])}"
                redirect(action: "show", id: tipoAdquisicionInstance.id)
            }
            else {
                render(view: "form", model: [tipoAdquisicionInstance: tipoAdquisicionInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
        if (tipoAdquisicionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoAdquisicionInstance.version > version) {

                    tipoAdquisicionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion')] as Object[], "Another user has updated this TipoAdquisicion while you were editing")
                    render(view: "edit", model: [tipoAdquisicionInstance: tipoAdquisicionInstance])
                    return
                }
            }
            tipoAdquisicionInstance.properties = params
            if (!tipoAdquisicionInstance.hasErrors() && tipoAdquisicionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), tipoAdquisicionInstance.id])}"
                redirect(action: "show", id: tipoAdquisicionInstance.id)
            }
            else {
                render(view: "edit", model: [tipoAdquisicionInstance: tipoAdquisicionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
        if (!tipoAdquisicionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["TipoAdquisicion"], default: "Show TipoAdquisicion")

            [tipoAdquisicionInstance: tipoAdquisicionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def tipoAdquisicionInstance = TipoAdquisicion.get(params.id)
        if (tipoAdquisicionInstance) {
            try {
                tipoAdquisicionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'TipoAdquisicion.label', default: 'TipoAdquisicion'), params.id])}"
            redirect(action: "list")
        }
    }
}
