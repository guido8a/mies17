package mies

class ProvinciaController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Provincia"], default: "Provincia List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [provinciaInstanceList: Provincia.list(params), provinciaInstanceTotal: Provincia.count(), title: title, params: params]
    }

    def form = {
        def title
        def provinciaInstance

        if (params.source == "create") {
            provinciaInstance = new Provincia()
            provinciaInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Provincia"], default: "crearProvincia")
        } else if (params.source == "edit") {
            provinciaInstance = Provincia.get(params.id)
            if (!provinciaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Provincia"], default: "editarProvincia")
        }

        return [provinciaInstance: provinciaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Provincia"], default: "Edit Provincia")
            def provinciaInstance = Provincia.get(params.id)
            if (provinciaInstance) {
                provinciaInstance.properties = params
                if (!provinciaInstance.hasErrors() && provinciaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'provincia.label', default: 'Provincia'), provinciaInstance.id])}"
                    redirect(action: "show", id: provinciaInstance.id)
                }
                else {
                    render(view: "form", model: [provinciaInstance: provinciaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Provincia"], default: "Create Provincia")
            def provinciaInstance = new Provincia(params)
            if (provinciaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'provincia.label', default: 'Provincia'), provinciaInstance.id])}"
                redirect(action: "show", id: provinciaInstance.id)
            }
            else {
                render(view: "form", model: [provinciaInstance: provinciaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def provinciaInstance = Provincia.get(params.id)
        if (provinciaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (provinciaInstance.version > version) {

                    provinciaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'provincia.label', default: 'Provincia')] as Object[], "Another user has updated this Provincia while you were editing")
                    render(view: "edit", model: [provinciaInstance: provinciaInstance])
                    return
                }
            }
            provinciaInstance.properties = params
            if (!provinciaInstance.hasErrors() && provinciaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'provincia.label', default: 'Provincia'), provinciaInstance.id])}"
                redirect(action: "show", id: provinciaInstance.id)
            }
            else {
                render(view: "edit", model: [provinciaInstance: provinciaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def provinciaInstance = Provincia.get(params.id)
        if (!provinciaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Provincia"], default: "Show Provincia")

            [provinciaInstance: provinciaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def provinciaInstance = Provincia.get(params.id)
        if (provinciaInstance) {
            try {
                provinciaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'provincia.label', default: 'Provincia'), params.id])}"
            redirect(action: "list")
        }
    }
}
