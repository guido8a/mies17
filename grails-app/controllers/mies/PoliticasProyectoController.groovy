package mies

class PoliticasProyectoController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["PoliticasProyecto"], default: "PoliticasProyecto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [politicasProyectoInstanceList: PoliticasProyecto.list(params), politicasProyectoInstanceTotal: PoliticasProyecto.count(), title: title, params: params]
    }

    def form = {
        def title
        def politicasProyectoInstance

        if (params.source == "create") {
            politicasProyectoInstance = new PoliticasProyecto()
            politicasProyectoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["PoliticasProyecto"], default: "crearPoliticasProyecto")
        } else if (params.source == "edit") {
            politicasProyectoInstance = PoliticasProyecto.get(params.id)
            if (!politicasProyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["PoliticasProyecto"], default: "editarPoliticasProyecto")
        }

        return [politicasProyectoInstance: politicasProyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["PoliticasProyecto"], default: "Edit PoliticasProyecto")
            def politicasProyectoInstance = PoliticasProyecto.get(params.id)
            if (politicasProyectoInstance) {
                politicasProyectoInstance.properties = params
                if (!politicasProyectoInstance.hasErrors() && politicasProyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), politicasProyectoInstance.id])}"
                    redirect(action: "show", id: politicasProyectoInstance.id)
                }
                else {
                    render(view: "form", model: [politicasProyectoInstance: politicasProyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["PoliticasProyecto"], default: "Create PoliticasProyecto")
            def politicasProyectoInstance = new PoliticasProyecto(params)
            if (politicasProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), politicasProyectoInstance.id])}"
                redirect(action: "show", id: politicasProyectoInstance.id)
            }
            else {
                render(view: "form", model: [politicasProyectoInstance: politicasProyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def politicasProyectoInstance = PoliticasProyecto.get(params.id)
        if (politicasProyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (politicasProyectoInstance.version > version) {

                    politicasProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto')] as Object[], "Another user has updated this PoliticasProyecto while you were editing")
                    render(view: "edit", model: [politicasProyectoInstance: politicasProyectoInstance])
                    return
                }
            }
            politicasProyectoInstance.properties = params
            if (!politicasProyectoInstance.hasErrors() && politicasProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), politicasProyectoInstance.id])}"
                redirect(action: "show", id: politicasProyectoInstance.id)
            }
            else {
                render(view: "edit", model: [politicasProyectoInstance: politicasProyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def politicasProyectoInstance = PoliticasProyecto.get(params.id)
        if (!politicasProyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["PoliticasProyecto"], default: "Show PoliticasProyecto")

            [politicasProyectoInstance: politicasProyectoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def politicasProyectoInstance = PoliticasProyecto.get(params.id)
        if (politicasProyectoInstance) {
            try {
                politicasProyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicasProyecto.label', default: 'PoliticasProyecto'), params.id])}"
            redirect(action: "list")
        }
    }
}
