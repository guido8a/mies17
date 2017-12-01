package mies

class FaseController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Fase"], default: "Fase List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [faseInstanceList: Fase.list(params), faseInstanceTotal: Fase.count(), title: title, params: params]
    }

    def form = {
        def title
        def faseInstance

        if (params.source == "create") {
            faseInstance = new Fase()
            faseInstance.properties = params
            title = "Crear Fase de proyecto"
        } else if (params.source == "edit") {
            faseInstance = Fase.get(params.id)
            if (!faseInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Fase de proyecto"
        }

        return [faseInstance: faseInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Fase"], default: "Edit Fase")
            def faseInstance = Fase.get(params.id)
            if (faseInstance) {
                faseInstance.properties = params
                if (!faseInstance.hasErrors() && faseInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'fase.label', default: 'Fase'), faseInstance.id])}"
                    redirect(action: "show", id: faseInstance.id)
                }
                else {
                    render(view: "form", model: [faseInstance: faseInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Fase"], default: "Create Fase")
            def faseInstance = new Fase(params)
            if (faseInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'fase.label', default: 'Fase'), faseInstance.id])}"
                redirect(action: "show", id: faseInstance.id)
            }
            else {
                render(view: "form", model: [faseInstance: faseInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def faseInstance = Fase.get(params.id)
        if (faseInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (faseInstance.version > version) {

                    faseInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'fase.label', default: 'Fase')] as Object[], "Another user has updated this Fase while you were editing")
                    render(view: "edit", model: [faseInstance: faseInstance])
                    return
                }
            }
            faseInstance.properties = params
            if (!faseInstance.hasErrors() && faseInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'fase.label', default: 'Fase'), faseInstance.id])}"
                redirect(action: "show", id: faseInstance.id)
            }
            else {
                render(view: "edit", model: [faseInstance: faseInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def faseInstance = Fase.get(params.id)
        if (!faseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Fase"], default: "Show Fase")

            [faseInstance: faseInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def faseInstance = Fase.get(params.id)
        if (faseInstance) {
            try {
                faseInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), params.id])}"
            redirect(action: "list")
        }
    }
}
