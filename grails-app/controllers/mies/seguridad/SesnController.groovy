package mies.seguridad

class SesnController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "sesn.list", default: "Sesn List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [sesnInstanceList: Sesn.list(params), sesnInstanceTotal: Sesn.count(), title: title, params: params]
    }

    def form = {
        def title
        def sesnInstance

        if (params.source == "create") {
            sesnInstance = new Sesn()
            sesnInstance.properties = params
            title = g.message(code: "sesn.create", default: "Create Sesn")
        } else if (params.source == "edit") {
            sesnInstance = Sesn.get(params.id)
            if (!sesnInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "sesn.edit", default: "Edit Sesn")
        }

        return [sesnInstance: sesnInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "sesn.edit", default: "Edit Sesn")
            def sesnInstance = Sesn.get(params.id)
            if (sesnInstance) {
                sesnInstance.properties = params
                if (!sesnInstance.hasErrors() && sesnInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sesn.label', default: 'Sesn'), sesnInstance.id])}"
                    redirect(action: "show", id: sesnInstance.id)
                }
                else {
                    render(view: "form", model: [sesnInstance: sesnInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "sesn.create", default: "Create Sesn")
            def sesnInstance = new Sesn(params)
            if (sesnInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'sesn.label', default: 'Sesn'), sesnInstance.id])}"
                redirect(action: "show", id: sesnInstance.id)
            }
            else {
                render(view: "form", model: [sesnInstance: sesnInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def sesnInstance = Sesn.get(params.id)
        if (sesnInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sesnInstance.version > version) {

                    sesnInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sesn.label', default: 'Sesn')] as Object[], "Another user has updated this Sesn while you were editing")
                    render(view: "edit", model: [sesnInstance: sesnInstance])
                    return
                }
            }
            sesnInstance.properties = params
            if (!sesnInstance.hasErrors() && sesnInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sesn.label', default: 'Sesn'), sesnInstance.id])}"
                redirect(action: "show", id: sesnInstance.id)
            }
            else {
                render(view: "edit", model: [sesnInstance: sesnInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def sesnInstance = Sesn.get(params.id)
        if (!sesnInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "sesn.show", default: "Show Sesn")

            [sesnInstance: sesnInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def sesnInstance = Sesn.get(params.id)
        if (sesnInstance) {
            try {
                sesnInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sesn.label', default: 'Sesn'), params.id])}"
            redirect(action: "list")
        }
    }
}
