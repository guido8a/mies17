package mies

class EstudiosTecnicosController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["EstudiosTecnicos"], default: "EstudiosTecnicos List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [estudiosTecnicosInstanceList: EstudiosTecnicos.list(params), estudiosTecnicosInstanceTotal: EstudiosTecnicos.count(), title: title, params: params]
    }

    def form = {
        def title
        def estudiosTecnicosInstance

        if (params.source == "create") {
            estudiosTecnicosInstance = new EstudiosTecnicos()
            estudiosTecnicosInstance.properties = params
            title = g.message(code: "default.create.label", args: ["EstudiosTecnicos"], default: "crearEstudiosTecnicos")
        } else if (params.source == "edit") {
            estudiosTecnicosInstance = EstudiosTecnicos.get(params.id)
            if (!estudiosTecnicosInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["EstudiosTecnicos"], default: "editarEstudiosTecnicos")
        }

        return [estudiosTecnicosInstance: estudiosTecnicosInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["EstudiosTecnicos"], default: "Edit EstudiosTecnicos")
            def estudiosTecnicosInstance = EstudiosTecnicos.get(params.id)
            if (estudiosTecnicosInstance) {
                estudiosTecnicosInstance.properties = params
                if (!estudiosTecnicosInstance.hasErrors() && estudiosTecnicosInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), estudiosTecnicosInstance.id])}"
                    redirect(action: "show", id: estudiosTecnicosInstance.id)
                }
                else {
                    render(view: "form", model: [estudiosTecnicosInstance: estudiosTecnicosInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["EstudiosTecnicos"], default: "Create EstudiosTecnicos")
            def estudiosTecnicosInstance = new EstudiosTecnicos(params)
            if (estudiosTecnicosInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), estudiosTecnicosInstance.id])}"
                redirect(action: "show", id: estudiosTecnicosInstance.id)
            }
            else {
                render(view: "form", model: [estudiosTecnicosInstance: estudiosTecnicosInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def estudiosTecnicosInstance = EstudiosTecnicos.get(params.id)
        if (estudiosTecnicosInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (estudiosTecnicosInstance.version > version) {

                    estudiosTecnicosInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos')] as Object[], "Another user has updated this EstudiosTecnicos while you were editing")
                    render(view: "edit", model: [estudiosTecnicosInstance: estudiosTecnicosInstance])
                    return
                }
            }
            estudiosTecnicosInstance.properties = params
            if (!estudiosTecnicosInstance.hasErrors() && estudiosTecnicosInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), estudiosTecnicosInstance.id])}"
                redirect(action: "show", id: estudiosTecnicosInstance.id)
            }
            else {
                render(view: "edit", model: [estudiosTecnicosInstance: estudiosTecnicosInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def estudiosTecnicosInstance = EstudiosTecnicos.get(params.id)
        if (!estudiosTecnicosInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["EstudiosTecnicos"], default: "Show EstudiosTecnicos")

            [estudiosTecnicosInstance: estudiosTecnicosInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def estudiosTecnicosInstance = EstudiosTecnicos.get(params.id)
        if (estudiosTecnicosInstance) {
            try {
                estudiosTecnicosInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos'), params.id])}"
            redirect(action: "list")
        }
    }
}
