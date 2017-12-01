package mies

class ParroquiaController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Parroquia"], default: "Parroquia List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [parroquiaInstanceList: Parroquia.list(params), parroquiaInstanceTotal: Parroquia.count(), title: title, params: params]
    }

    def form = {
        def title
        def parroquiaInstance

        if (params.source == "create") {
            parroquiaInstance = new Parroquia()
            parroquiaInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Parroquia"], default: "crearParroquia")
        } else if (params.source == "edit") {
            parroquiaInstance = Parroquia.get(params.id)
            if (!parroquiaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Parroquia"], default: "editarParroquia")
        }

        return [parroquiaInstance: parroquiaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Parroquia"], default: "Edit Parroquia")
            def parroquiaInstance = Parroquia.get(params.id)
            if (parroquiaInstance) {
                parroquiaInstance.properties = params
                if (!parroquiaInstance.hasErrors() && parroquiaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), parroquiaInstance.id])}"
                    redirect(action: "show", id: parroquiaInstance.id)
                }
                else {
                    render(view: "form", model: [parroquiaInstance: parroquiaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Parroquia"], default: "Create Parroquia")
            def parroquiaInstance = new Parroquia(params)
            if (parroquiaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), parroquiaInstance.id])}"
                redirect(action: "show", id: parroquiaInstance.id)
            }
            else {
                render(view: "form", model: [parroquiaInstance: parroquiaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def parroquiaInstance = Parroquia.get(params.id)
        if (parroquiaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (parroquiaInstance.version > version) {

                    parroquiaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'parroquia.label', default: 'Parroquia')] as Object[], "Another user has updated this Parroquia while you were editing")
                    render(view: "edit", model: [parroquiaInstance: parroquiaInstance])
                    return
                }
            }
            parroquiaInstance.properties = params
            if (!parroquiaInstance.hasErrors() && parroquiaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), parroquiaInstance.id])}"
                redirect(action: "show", id: parroquiaInstance.id)
            }
            else {
                render(view: "edit", model: [parroquiaInstance: parroquiaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def parroquiaInstance = Parroquia.get(params.id)
        if (!parroquiaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Parroquia"], default: "Show Parroquia")

            [parroquiaInstance: parroquiaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def parroquiaInstance = Parroquia.get(params.id)
        if (parroquiaInstance) {
            try {
                parroquiaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parroquia.label', default: 'Parroquia'), params.id])}"
            redirect(action: "list")
        }
    }
}
