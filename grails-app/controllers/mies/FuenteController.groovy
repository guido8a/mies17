package mies

class FuenteController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Fuente"], default: "Fuente List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [fuenteInstanceList: Fuente.list(params), fuenteInstanceTotal: Fuente.count(), title: title, params: params]
    }

    def form = {
        def title
        def fuenteInstance

        if (params.source == "create") {
            fuenteInstance = new Fuente()
            fuenteInstance.properties = params
            title = "Crear Fuente de financiamiento"
        } else if (params.source == "edit") {
            fuenteInstance = Fuente.get(params.id)
            if (!fuenteInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Fuente de financiamiento"
        }

        return [fuenteInstance: fuenteInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Fuente"], default: "Edit Fuente")
            def fuenteInstance = Fuente.get(params.id)
            if (fuenteInstance) {
                fuenteInstance.properties = params
                if (!fuenteInstance.hasErrors() && fuenteInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'fuente.label', default: 'Fuente'), fuenteInstance.id])}"
                    redirect(action: "show", id: fuenteInstance.id)
                }
                else {
                    render(view: "form", model: [fuenteInstance: fuenteInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Fuente"], default: "Create Fuente")
            def fuenteInstance = new Fuente(params)
            if (fuenteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'fuente.label', default: 'Fuente'), fuenteInstance.id])}"
                redirect(action: "show", id: fuenteInstance.id)
            }
            else {
                render(view: "form", model: [fuenteInstance: fuenteInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def fuenteInstance = Fuente.get(params.id)
        if (fuenteInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (fuenteInstance.version > version) {

                    fuenteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'fuente.label', default: 'Fuente')] as Object[], "Another user has updated this Fuente while you were editing")
                    render(view: "edit", model: [fuenteInstance: fuenteInstance])
                    return
                }
            }
            fuenteInstance.properties = params
            if (!fuenteInstance.hasErrors() && fuenteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'fuente.label', default: 'Fuente'), fuenteInstance.id])}"
                redirect(action: "show", id: fuenteInstance.id)
            }
            else {
                render(view: "edit", model: [fuenteInstance: fuenteInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Fuente"], default: "Show Fuente")

            [fuenteInstance: fuenteInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def fuenteInstance = Fuente.get(params.id)
        if (fuenteInstance) {
            try {
                fuenteInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fuente.label', default: 'Fuente'), params.id])}"
            redirect(action: "list")
        }
    }
}
