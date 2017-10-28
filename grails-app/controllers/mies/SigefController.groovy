package mies

class SigefController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"sigef.list", default:"Sigef List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [sigefInstanceList: Sigef.list(params), sigefInstanceTotal: Sigef.count(), title: title, params:params]
    }

    def form = {
        def title
        def sigefInstance

        if(params.source == "create") {
            sigefInstance = new Sigef()
            sigefInstance.properties = params
            sigefInstance.fecha = new Date()
            title = g.message(code:"sigef.create", default:"Cargar datos desde el eSIGEF")
        } else if(params.source == "edit") {
            sigefInstance = Sigef.get(params.id)
            if (!sigefInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code:"sigef.edit", default:"Editar datos de ejeción presupuestaria eSIGEF")
        }

        return [sigefInstance: sigefInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"sigef.edit", default:"Edit Sigef")
            def sigefInstance = Sigef.get(params.id)
            if (sigefInstance) {
                sigefInstance.properties = params
                if (!sigefInstance.hasErrors() && sigefInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sigef.label', default: 'Sigef'), sigefInstance.id])}"
                    redirect(action: "show", id: sigefInstance.id)
                }
                else {
                    render(view: "form", model: [sigefInstance: sigefInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"sigef.create", default:"Create Sigef")
            def sigefInstance = new Sigef(params)
            if (sigefInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'sigef.label', default: 'Sigef'), sigefInstance.id])}"
                redirect(action: "show", id: sigefInstance.id)
            }
            else {
                render(view: "form", model: [sigefInstance: sigefInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def sigefInstance = Sigef.get(params.id)
        if (sigefInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sigefInstance.version > version) {
                    
                    sigefInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sigef.label', default: 'Sigef')] as Object[], "Another user has updated this Sigef while you were editing")
                    render(view: "edit", model: [sigefInstance: sigefInstance])
                    return
                }
            }
            sigefInstance.properties = params
            if (!sigefInstance.hasErrors() && sigefInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sigef.label', default: 'Sigef'), sigefInstance.id])}"
                redirect(action: "show", id: sigefInstance.id)
            }
            else {
                render(view: "edit", model: [sigefInstance: sigefInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def sigefInstance = Sigef.get(params.id)
        if (!sigefInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"sigef.show", default:"Show Sigef")

            [sigefInstance: sigefInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def sigefInstance = Sigef.get(params.id)
        if (sigefInstance) {
            try {
                sigefInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sigef.label', default: 'Sigef'), params.id])}"
            redirect(action: "list")
        }
    }
}
