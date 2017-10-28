package mies

class PoliticaAplicaProyectoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["PoliticaAplicaProyecto"], default: "PoliticaAplicaProyecto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [politicaAplicaProyectoInstanceList: PoliticaAplicaProyecto.list(params), politicaAplicaProyectoInstanceTotal: PoliticaAplicaProyecto.count(), title: title, params: params]
    }

    def form = {
        def title
        def politicaAplicaProyectoInstance

        if (params.source == "create") {
            politicaAplicaProyectoInstance = new PoliticaAplicaProyecto()
            politicaAplicaProyectoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["PoliticaAplicaProyecto"], default: "crearPoliticaAplicaProyecto")
        } else if (params.source == "edit") {
            politicaAplicaProyectoInstance = PoliticaAplicaProyecto.get(params.id)
            if (!politicaAplicaProyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["PoliticaAplicaProyecto"], default: "editarPoliticaAplicaProyecto")
        }

        return [politicaAplicaProyectoInstance: politicaAplicaProyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["PoliticaAplicaProyecto"], default: "Edit PoliticaAplicaProyecto")
            def politicaAplicaProyectoInstance = PoliticaAplicaProyecto.get(params.id)
            if (politicaAplicaProyectoInstance) {
                politicaAplicaProyectoInstance.properties = params
                if (!politicaAplicaProyectoInstance.hasErrors() && politicaAplicaProyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), politicaAplicaProyectoInstance.id])}"
                    redirect(action: "show", id: politicaAplicaProyectoInstance.id)
                }
                else {
                    render(view: "form", model: [politicaAplicaProyectoInstance: politicaAplicaProyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["PoliticaAplicaProyecto"], default: "Create PoliticaAplicaProyecto")
            def politicaAplicaProyectoInstance = new PoliticaAplicaProyecto(params)
            if (politicaAplicaProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), politicaAplicaProyectoInstance.id])}"
                redirect(action: "show", id: politicaAplicaProyectoInstance.id)
            }
            else {
                render(view: "form", model: [politicaAplicaProyectoInstance: politicaAplicaProyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def politicaAplicaProyectoInstance = PoliticaAplicaProyecto.get(params.id)
        if (politicaAplicaProyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (politicaAplicaProyectoInstance.version > version) {

                    politicaAplicaProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto')] as Object[], "Another user has updated this PoliticaAplicaProyecto while you were editing")
                    render(view: "edit", model: [politicaAplicaProyectoInstance: politicaAplicaProyectoInstance])
                    return
                }
            }
            politicaAplicaProyectoInstance.properties = params
            if (!politicaAplicaProyectoInstance.hasErrors() && politicaAplicaProyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), politicaAplicaProyectoInstance.id])}"
                redirect(action: "show", id: politicaAplicaProyectoInstance.id)
            }
            else {
                render(view: "edit", model: [politicaAplicaProyectoInstance: politicaAplicaProyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def politicaAplicaProyectoInstance = PoliticaAplicaProyecto.get(params.id)
        if (!politicaAplicaProyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["PoliticaAplicaProyecto"], default: "Show PoliticaAplicaProyecto")

            [politicaAplicaProyectoInstance: politicaAplicaProyectoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def politicaAplicaProyectoInstance = PoliticaAplicaProyecto.get(params.id)
        if (politicaAplicaProyectoInstance) {
            try {
                politicaAplicaProyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto'), params.id])}"
            redirect(action: "list")
        }
    }
}
