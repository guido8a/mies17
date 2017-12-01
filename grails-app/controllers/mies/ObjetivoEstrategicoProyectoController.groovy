package mies

class ObjetivoEstrategicoProyectoController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "objetivoestrategicoproyecto.list", default: "ObjetivoEstrategicoProyecto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [objetivoEstrategicoProyectoInstanceList: ObjetivoEstrategicoProyecto.list(params), objetivoEstrategicoProyectoInstanceTotal: ObjetivoEstrategicoProyecto.count(), title: title, params: params]
    }

    def form = {
        def title
        def objetivoEstrategicoProyectoInstance

        if (params.source == "create") {
            objetivoEstrategicoProyectoInstance = new ObjetivoEstrategicoProyecto()
            objetivoEstrategicoProyectoInstance.properties = params
            title = g.message(code: "objetivoestrategicoproyecto.create", default: "Crear Objetivo Estratégico")
        } else if (params.source == "edit") {
            objetivoEstrategicoProyectoInstance = ObjetivoEstrategicoProyecto.get(params.id)
            if (!objetivoEstrategicoProyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "objetivoestrategicoproyecto.edit", default: "Editando Objetivo Estratégico")
        }

        return [objetivoEstrategicoProyectoInstance: objetivoEstrategicoProyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "objetivoestrategicoproyecto.edit", default: "Edit ObjetivoEstrategicoProyecto")
            def objetivoEstrategicoProyectoInstance = ObjetivoEstrategicoProyecto.get(params.id)
            if (objetivoEstrategicoProyectoInstance) {
                objetivoEstrategicoProyectoInstance.properties = params
                if (!objetivoEstrategicoProyectoInstance.hasErrors() && objetivoEstrategicoProyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), objetivoEstrategicoProyectoInstance.id])}"
                    redirect(action: "show", id: objetivoEstrategicoProyectoInstance.id)
                }
                else {
                    render(view: "form", model: [objetivoEstrategicoProyectoInstance: objetivoEstrategicoProyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "objetivoestrategicoproyecto.create", default: "Create ObjetivoEstrategicoProyecto")
            def objetivoEstrategicoProyectoInstance = new ObjetivoEstrategicoProyecto(params)
            if (objetivoEstrategicoProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), objetivoEstrategicoProyectoInstance.id])}"
                redirect(action: "show", id: objetivoEstrategicoProyectoInstance.id)
            }
            else {
                render(view: "form", model: [objetivoEstrategicoProyectoInstance: objetivoEstrategicoProyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def objetivoEstrategicoProyectoInstance = ObjetivoEstrategicoProyecto.get(params.id)
        if (objetivoEstrategicoProyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (objetivoEstrategicoProyectoInstance.version > version) {

                    objetivoEstrategicoProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto')] as Object[], "Another user has updated this ObjetivoEstrategicoProyecto while you were editing")
                    render(view: "edit", model: [objetivoEstrategicoProyectoInstance: objetivoEstrategicoProyectoInstance])
                    return
                }
            }
            objetivoEstrategicoProyectoInstance.properties = params
            if (!objetivoEstrategicoProyectoInstance.hasErrors() && objetivoEstrategicoProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), objetivoEstrategicoProyectoInstance.id])}"
                redirect(action: "show", id: objetivoEstrategicoProyectoInstance.id)
            }
            else {
                render(view: "edit", model: [objetivoEstrategicoProyectoInstance: objetivoEstrategicoProyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def objetivoEstrategicoProyectoInstance = ObjetivoEstrategicoProyecto.get(params.id)
        if (!objetivoEstrategicoProyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "objetivoestrategicoproyecto.show", default: "Show ObjetivoEstrategicoProyecto")

            [objetivoEstrategicoProyectoInstance: objetivoEstrategicoProyectoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def objetivoEstrategicoProyectoInstance = ObjetivoEstrategicoProyecto.get(params.id)
        if (objetivoEstrategicoProyectoInstance) {
            try {
                objetivoEstrategicoProyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategicoProyecto.label', default: 'ObjetivoEstrategicoProyecto'), params.id])}"
            redirect(action: "list")
        }
    }
}
