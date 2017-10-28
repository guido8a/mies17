package mies

class ProgramaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Programa"], default: "Lista de Programas")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 18, 100)

        [programaInstanceList: Programa.list(params), programaInstanceTotal: Programa.count(), title: title, params: params]
    }

    def form = {
        def title
        def programaInstance

        if (params.source == "create") {
            programaInstance = new Programa()
            programaInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Programa"], default: "crearPrograma")
        } else if (params.source == "edit") {
            programaInstance = Programa.get(params.id)
            if (!programaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Programa"], default: "editarPrograma")
        }

        return [programaInstance: programaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Programa"], default: "Edit Programa")
            def programaInstance = Programa.get(params.id)
            if (programaInstance) {
                programaInstance.properties = params
                if (!programaInstance.hasErrors() && programaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'programa.label', default: 'Programa'), programaInstance.id])}"
                    redirect(action: "show", id: programaInstance.id)
                }
                else {
                    render(view: "form", model: [programaInstance: programaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Programa"], default: "Create Programa")
            def programaInstance = new Programa(params)
            if (programaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'programa.label', default: 'Programa'), programaInstance.id])}"
                redirect(action: "show", id: programaInstance.id)
            }
            else {
                render(view: "form", model: [programaInstance: programaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def programaInstance = Programa.get(params.id)
        if (programaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (programaInstance.version > version) {

                    programaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'programa.label', default: 'Programa')] as Object[], "Another user has updated this Programa while you were editing")
                    render(view: "edit", model: [programaInstance: programaInstance])
                    return
                }
            }
            programaInstance.properties = params
            if (!programaInstance.hasErrors() && programaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'programa.label', default: 'Programa'), programaInstance.id])}"
                redirect(action: "show", id: programaInstance.id)
            }
            else {
                render(view: "edit", model: [programaInstance: programaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def programaInstance = Programa.get(params.id)
        if (!programaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Programa"], default: "Show Programa")

            [programaInstance: programaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def programaInstance = Programa.get(params.id)
        if (programaInstance) {
            try {
                programaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programa.label', default: 'Programa'), params.id])}"
            redirect(action: "list")
        }
    }
}
