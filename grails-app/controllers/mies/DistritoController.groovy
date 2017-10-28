package mies

class DistritoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"default.list.label", args:["Distrito"], default:"Distrito List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [distritoInstanceList: Distrito.list(params), distritoInstanceTotal: Distrito.count(), title: title, params:params]
    }

    def form = {
        def title
        def distritoInstance

        if(params.source == "create") {
            distritoInstance = new Distrito()
            distritoInstance.properties = params
            title = "Crear Distrito"
        } else if(params.source == "edit") {
            distritoInstance = Distrito.get(params.id)
            if (!distritoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Distrito"
        }

        return [distritoInstance: distritoInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"default.edit.label", args:["Distrito"], default:"Edit Distrito")
            def distritoInstance = Distrito.get(params.id)
            if (distritoInstance) {
                distritoInstance.properties = params
                if (!distritoInstance.hasErrors() && distritoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'distrito.label', default: 'Distrito'), distritoInstance.id])}"
                    redirect(action: "show", id: distritoInstance.id)
                }
                else {
                    render(view: "form", model: [distritoInstance: distritoInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"default.create.label", args:["Distrito"], default:"Create Distrito")
            def distritoInstance = new Distrito(params)
            if (distritoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'distrito.label', default: 'Distrito'), distritoInstance.id])}"
                redirect(action: "show", id: distritoInstance.id)
            }
            else {
                render(view: "form", model: [distritoInstance: distritoInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def distritoInstance = Distrito.get(params.id)
        if (distritoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (distritoInstance.version > version) {
                    
                    distritoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'distrito.label', default: 'Distrito')] as Object[], "Another user has updated this Distrito while you were editing")
                    render(view: "edit", model: [distritoInstance: distritoInstance])
                    return
                }
            }
            distritoInstance.properties = params
            if (!distritoInstance.hasErrors() && distritoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'distrito.label', default: 'Distrito'), distritoInstance.id])}"
                redirect(action: "show", id: distritoInstance.id)
            }
            else {
                render(view: "edit", model: [distritoInstance: distritoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def distritoInstance = Distrito.get(params.id)
        if (!distritoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"default.show.label", args:["Distrito"], default:"Show Distrito")

            [distritoInstance: distritoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def distritoInstance = Distrito.get(params.id)
        if (distritoInstance) {
            try {
                distritoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'distrito.label', default: 'Distrito'), params.id])}"
            redirect(action: "list")
        }
    }
}
