package mies

class GrupoProcesosController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"default.list.label", args:["GrupoProcesos"], default:"GrupoProcesos List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [grupoProcesosInstanceList: GrupoProcesos.list(params), grupoProcesosInstanceTotal: GrupoProcesos.count(), title: title, params:params]
    }

    def form = {
        def title
        def grupoProcesosInstance

        if(params.source == "create") {
            grupoProcesosInstance = new GrupoProcesos()
            grupoProcesosInstance.properties = params
            title = "Crear Grupo de procesos"
        } else if(params.source == "edit") {
            grupoProcesosInstance = GrupoProcesos.get(params.id)
            if (!grupoProcesosInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Grupo de procesos"
        }

        return [grupoProcesosInstance: grupoProcesosInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"default.edit.label", args:["GrupoProcesos"], default:"Edit GrupoProcesos")
            def grupoProcesosInstance = GrupoProcesos.get(params.id)
            if (grupoProcesosInstance) {
                grupoProcesosInstance.properties = params
                if (!grupoProcesosInstance.hasErrors() && grupoProcesosInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), grupoProcesosInstance.id])}"
                    redirect(action: "show", id: grupoProcesosInstance.id)
                }
                else {
                    render(view: "form", model: [grupoProcesosInstance: grupoProcesosInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"default.create.label", args:["GrupoProcesos"], default:"Create GrupoProcesos")
            def grupoProcesosInstance = new GrupoProcesos(params)
            if (grupoProcesosInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), grupoProcesosInstance.id])}"
                redirect(action: "show", id: grupoProcesosInstance.id)
            }
            else {
                render(view: "form", model: [grupoProcesosInstance: grupoProcesosInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def grupoProcesosInstance = GrupoProcesos.get(params.id)
        if (grupoProcesosInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (grupoProcesosInstance.version > version) {
                    
                    grupoProcesosInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'grupoProcesos.label', default: 'GrupoProcesos')] as Object[], "Another user has updated this GrupoProcesos while you were editing")
                    render(view: "edit", model: [grupoProcesosInstance: grupoProcesosInstance])
                    return
                }
            }
            grupoProcesosInstance.properties = params
            if (!grupoProcesosInstance.hasErrors() && grupoProcesosInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), grupoProcesosInstance.id])}"
                redirect(action: "show", id: grupoProcesosInstance.id)
            }
            else {
                render(view: "edit", model: [grupoProcesosInstance: grupoProcesosInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def grupoProcesosInstance = GrupoProcesos.get(params.id)
        if (!grupoProcesosInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"default.show.label", args:["GrupoProcesos"], default:"Show GrupoProcesos")

            [grupoProcesosInstance: grupoProcesosInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def grupoProcesosInstance = GrupoProcesos.get(params.id)
        if (grupoProcesosInstance) {
            try {
                grupoProcesosInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'grupoProcesos.label', default: 'GrupoProcesos'), params.id])}"
            redirect(action: "list")
        }
    }
}
