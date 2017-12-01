package mies

class EjecucionController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"ejecucion.list", default:"Ejecucion List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [ejecucionInstanceList: Ejecucion.list(params), ejecucionInstanceTotal: Ejecucion.count(), title: title, params:params]
    }

    def form = {
        def title
        def ejecucionInstance

        if(params.source == "create") {
            ejecucionInstance = new Ejecucion()
            ejecucionInstance.properties = params
            title = g.message(code:"ejecucion.create", default:"Create Ejecucion")
        } else if(params.source == "edit") {
            ejecucionInstance = Ejecucion.get(params.id)
            if (!ejecucionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code:"ejecucion.edit", default:"Edit Ejecucion")
        }

        return [ejecucionInstance: ejecucionInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"ejecucion.edit", default:"Edit Ejecucion")
            def ejecucionInstance = Ejecucion.get(params.id)
            if (ejecucionInstance) {
                ejecucionInstance.properties = params
                if (!ejecucionInstance.hasErrors() && ejecucionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), ejecucionInstance.id])}"
                    redirect(action: "show", id: ejecucionInstance.id)
                }
                else {
                    render(view: "form", model: [ejecucionInstance: ejecucionInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"ejecucion.create", default:"Create Ejecucion")
            def ejecucionInstance = new Ejecucion(params)
            if (ejecucionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), ejecucionInstance.id])}"
                redirect(action: "show", id: ejecucionInstance.id)
            }
            else {
                render(view: "form", model: [ejecucionInstance: ejecucionInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def ejecucionInstance = Ejecucion.get(params.id)
        if (ejecucionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ejecucionInstance.version > version) {
                    
                    ejecucionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'ejecucion.label', default: 'Ejecucion')] as Object[], "Another user has updated this Ejecucion while you were editing")
                    render(view: "edit", model: [ejecucionInstance: ejecucionInstance])
                    return
                }
            }
            ejecucionInstance.properties = params
            if (!ejecucionInstance.hasErrors() && ejecucionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), ejecucionInstance.id])}"
                redirect(action: "show", id: ejecucionInstance.id)
            }
            else {
                render(view: "edit", model: [ejecucionInstance: ejecucionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def ejecucionInstance = Ejecucion.get(params.id)
        if (!ejecucionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"ejecucion.show", default:"Show Ejecucion")

            [ejecucionInstance: ejecucionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def ejecucionInstance = Ejecucion.get(params.id)
        if (ejecucionInstance) {
            try {
                ejecucionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ejecucion.label', default: 'Ejecucion'), params.id])}"
            redirect(action: "list")
        }
    }
}
