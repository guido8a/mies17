package mies

class SubSecretariaController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["SubSecretaria"], default: "SubSecretaria List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [subSecretariaInstanceList: SubSecretaria.list(params), subSecretariaInstanceTotal: SubSecretaria.count(), title: title, params: params]
    }

    def form = {
        def title
        def subSecretariaInstance

        if (params.source == "create") {
            subSecretariaInstance = new SubSecretaria()
            subSecretariaInstance.properties = params
            title = g.message(code: "default.create.label", args: ["SubSecretaria"], default: "crearSubSecretaria")
        } else if (params.source == "edit") {
            subSecretariaInstance = SubSecretaria.get(params.id)
            if (!subSecretariaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["SubSecretaria"], default: "editarSubSecretaria")
        }

        return [subSecretariaInstance: subSecretariaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["SubSecretaria"], default: "Edit SubSecretaria")
            def subSecretariaInstance = SubSecretaria.get(params.id)
            if (subSecretariaInstance) {
                subSecretariaInstance.properties = params
                if (!subSecretariaInstance.hasErrors() && subSecretariaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), subSecretariaInstance.id])}"
                    redirect(action: "show", id: subSecretariaInstance.id)
                }
                else {
                    render(view: "form", model: [subSecretariaInstance: subSecretariaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["SubSecretaria"], default: "Create SubSecretaria")
            def subSecretariaInstance = new SubSecretaria(params)
            if (subSecretariaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), subSecretariaInstance.id])}"
                redirect(action: "show", id: subSecretariaInstance.id)
            }
            else {
                render(view: "form", model: [subSecretariaInstance: subSecretariaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def subSecretariaInstance = SubSecretaria.get(params.id)
        if (subSecretariaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (subSecretariaInstance.version > version) {

                    subSecretariaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'subSecretaria.label', default: 'SubSecretaria')] as Object[], "Another user has updated this SubSecretaria while you were editing")
                    render(view: "edit", model: [subSecretariaInstance: subSecretariaInstance])
                    return
                }
            }
            subSecretariaInstance.properties = params
            if (!subSecretariaInstance.hasErrors() && subSecretariaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), subSecretariaInstance.id])}"
                redirect(action: "show", id: subSecretariaInstance.id)
            }
            else {
                render(view: "edit", model: [subSecretariaInstance: subSecretariaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def subSecretariaInstance = SubSecretaria.get(params.id)
        if (!subSecretariaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["SubSecretaria"], default: "Show SubSecretaria")

            [subSecretariaInstance: subSecretariaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def subSecretariaInstance = SubSecretaria.get(params.id)
        if (subSecretariaInstance) {
            try {
                subSecretariaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSecretaria.label', default: 'SubSecretaria'), params.id])}"
            redirect(action: "list")
        }
    }
}
