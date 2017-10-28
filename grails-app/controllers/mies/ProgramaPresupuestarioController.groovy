package mies

import mies.seguridad.Shield

class ProgramaPresupuestarioController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "programapresupuestario.list", default: "ProgramaPresupuestario List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [programaPresupuestarioInstanceList: ProgramaPresupuestario.list(params), programaPresupuestarioInstanceTotal: ProgramaPresupuestario.count(), title: title, params: params]
    }

    def form = {
        def title
        def programaPresupuestarioInstance

        if (params.source == "create") {
            programaPresupuestarioInstance = new ProgramaPresupuestario()
            programaPresupuestarioInstance.properties = params
            title = g.message(code: "programapresupuestario.create", default: "Create ProgramaPresupuestario")
        } else if (params.source == "edit") {
            programaPresupuestarioInstance = ProgramaPresupuestario.get(params.id)
            if (!programaPresupuestarioInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "programapresupuestario.edit", default: "Edit ProgramaPresupuestario")
        }

        return [programaPresupuestarioInstance: programaPresupuestarioInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "programapresupuestario.edit", default: "Edit ProgramaPresupuestario")
            def programaPresupuestarioInstance = ProgramaPresupuestario.get(params.id)
            if (programaPresupuestarioInstance) {
                programaPresupuestarioInstance.properties = params
                if (!programaPresupuestarioInstance.hasErrors() && programaPresupuestarioInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), programaPresupuestarioInstance.id])}"
                    redirect(action: "show", id: programaPresupuestarioInstance.id)
                }
                else {
                    render(view: "form", model: [programaPresupuestarioInstance: programaPresupuestarioInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "programapresupuestario.create", default: "Create ProgramaPresupuestario")
            def programaPresupuestarioInstance = new ProgramaPresupuestario(params)
            if (programaPresupuestarioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), programaPresupuestarioInstance.id])}"
                redirect(action: "show", id: programaPresupuestarioInstance.id)
            }
            else {
                render(view: "form", model: [programaPresupuestarioInstance: programaPresupuestarioInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def programaPresupuestarioInstance = ProgramaPresupuestario.get(params.id)
        if (programaPresupuestarioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (programaPresupuestarioInstance.version > version) {

                    programaPresupuestarioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario')] as Object[], "Another user has updated this ProgramaPresupuestario while you were editing")
                    render(view: "edit", model: [programaPresupuestarioInstance: programaPresupuestarioInstance])
                    return
                }
            }
            programaPresupuestarioInstance.properties = params
            if (!programaPresupuestarioInstance.hasErrors() && programaPresupuestarioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), programaPresupuestarioInstance.id])}"
                redirect(action: "show", id: programaPresupuestarioInstance.id)
            }
            else {
                render(view: "edit", model: [programaPresupuestarioInstance: programaPresupuestarioInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def programaPresupuestarioInstance = ProgramaPresupuestario.get(params.id)
        if (!programaPresupuestarioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "programapresupuestario.show", default: "Show ProgramaPresupuestario")

            [programaPresupuestarioInstance: programaPresupuestarioInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def programaPresupuestarioInstance = ProgramaPresupuestario.get(params.id)
        if (programaPresupuestarioInstance) {
            try {
                programaPresupuestarioInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'programaPresupuestario.label', default: 'ProgramaPresupuestario'), params.id])}"
            redirect(action: "list")
        }
    }
}
