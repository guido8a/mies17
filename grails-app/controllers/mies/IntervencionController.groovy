package mies

class IntervencionController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"default.list.label", args:["Intervencion"], default:"Intervencion List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [intervencionInstanceList: Intervencion.list(params), intervencionInstanceTotal: Intervencion.count(), title: title, params:params]
    }

    def form = {
        def title
        def intervencionInstance

        if(params.source == "create") {
            intervencionInstance = new Intervencion()
            intervencionInstance.properties = params
            title = g.message(code:"default.create.label", args:["Intervencion"], default:"crearIntervencion")
        } else if(params.source == "edit") {
            intervencionInstance = Intervencion.get(params.id)
            if (!intervencionInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code:"default.edit.label", args:["Intervencion"], default:"editarIntervencion")
        }

        return [intervencionInstance: intervencionInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"default.edit.label", args:["Intervencion"], default:"Edit Intervencion")
            def intervencionInstance = Intervencion.get(params.id)
            if (intervencionInstance) {
                intervencionInstance.properties = params
                if (!intervencionInstance.hasErrors() && intervencionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), intervencionInstance.id])}"
                    redirect(action: "show", id: intervencionInstance.id)
                }
                else {
                    render(view: "form", model: [intervencionInstance: intervencionInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"default.create.label", args:["Intervencion"], default:"Create Intervencion")
            def intervencionInstance = new Intervencion(params)
            if (intervencionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), intervencionInstance.id])}"
                redirect(action: "show", id: intervencionInstance.id)
            }
            else {
                render(view: "form", model: [intervencionInstance: intervencionInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def intervencionInstance = Intervencion.get(params.id)
        if (intervencionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (intervencionInstance.version > version) {
                    
                    intervencionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'intervencion.label', default: 'Intervencion')] as Object[], "Another user has updated this Intervencion while you were editing")
                    render(view: "edit", model: [intervencionInstance: intervencionInstance])
                    return
                }
            }
            intervencionInstance.properties = params
            if (!intervencionInstance.hasErrors() && intervencionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), intervencionInstance.id])}"
                redirect(action: "show", id: intervencionInstance.id)
            }
            else {
                render(view: "edit", model: [intervencionInstance: intervencionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def intervencionInstance = Intervencion.get(params.id)
        if (!intervencionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"default.show.label", args:["Intervencion"], default:"Show Intervencion")

            [intervencionInstance: intervencionInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def intervencionInstance = Intervencion.get(params.id)
        if (intervencionInstance) {
            try {
                intervencionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'intervencion.label', default: 'Intervencion'), params.id])}"
            redirect(action: "list")
        }
    }
}
