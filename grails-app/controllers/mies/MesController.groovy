package mies

class MesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"default.list.label", args:["Mes"], default:"Mes List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [mesInstanceList: Mes.list(params), mesInstanceTotal: Mes.count(), title: title, params:params]
    }

    def form = {
        def title
        def mesInstance

        if(params.source == "create") {
            mesInstance = new Mes()
            mesInstance.properties = params
            title = g.message(code:"default.create.label", args:["Mes"], default:"crearMes")
        } else if(params.source == "edit") {
            mesInstance = Mes.get(params.id)
            if (!mesInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code:"default.edit.label", args:["Mes"], default:"editarMes")
        }

        return [mesInstance: mesInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"default.edit.label", args:["Mes"], default:"Edit Mes")
            def mesInstance = Mes.get(params.id)
            if (mesInstance) {
                mesInstance.properties = params
                if (!mesInstance.hasErrors() && mesInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'mes.label', default: 'Mes'), mesInstance.id])}"
                    redirect(action: "show", id: mesInstance.id)
                }
                else {
                    render(view: "form", model: [mesInstance: mesInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"default.create.label", args:["Mes"], default:"Create Mes")
            def mesInstance = new Mes(params)
            if (mesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'mes.label', default: 'Mes'), mesInstance.id])}"
                redirect(action: "show", id: mesInstance.id)
            }
            else {
                render(view: "form", model: [mesInstance: mesInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def mesInstance = Mes.get(params.id)
        if (mesInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (mesInstance.version > version) {
                    
                    mesInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'mes.label', default: 'Mes')] as Object[], "Another user has updated this Mes while you were editing")
                    render(view: "edit", model: [mesInstance: mesInstance])
                    return
                }
            }
            mesInstance.properties = params
            if (!mesInstance.hasErrors() && mesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'mes.label', default: 'Mes'), mesInstance.id])}"
                redirect(action: "show", id: mesInstance.id)
            }
            else {
                render(view: "edit", model: [mesInstance: mesInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def mesInstance = Mes.get(params.id)
        if (!mesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"default.show.label", args:["Mes"], default:"Show Mes")

            [mesInstance: mesInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def mesInstance = Mes.get(params.id)
        if (mesInstance) {
            try {
                mesInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mes.label', default: 'Mes'), params.id])}"
            redirect(action: "list")
        }
    }
}
