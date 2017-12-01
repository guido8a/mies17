package mies

class PoliticaAgendaSocialController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "politicaagendasocial.list", default: "PoliticaAgendaSocial List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [politicaAgendaSocialInstanceList: PoliticaAgendaSocial.list(params), politicaAgendaSocialInstanceTotal: PoliticaAgendaSocial.count(), title: title, params: params]
    }

    def form = {
        def title
        def politicaAgendaSocialInstance

        if (params.source == "create") {
            politicaAgendaSocialInstance = new PoliticaAgendaSocial()
            politicaAgendaSocialInstance.properties = params
            title = g.message(code: "politicaagendasocial.create", default: "Create PoliticaAgendaSocial")
        } else if (params.source == "edit") {
            politicaAgendaSocialInstance = PoliticaAgendaSocial.get(params.id)
            if (!politicaAgendaSocialInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "politicaagendasocial.edit", default: "Edit PoliticaAgendaSocial")
        }

        return [politicaAgendaSocialInstance: politicaAgendaSocialInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "politicaagendasocial.edit", default: "Edit PoliticaAgendaSocial")
            def politicaAgendaSocialInstance = PoliticaAgendaSocial.get(params.id)
            if (politicaAgendaSocialInstance) {
                politicaAgendaSocialInstance.properties = params
                if (!politicaAgendaSocialInstance.hasErrors() && politicaAgendaSocialInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), politicaAgendaSocialInstance.id])}"
                    redirect(action: "show", id: politicaAgendaSocialInstance.id)
                }
                else {
                    render(view: "form", model: [politicaAgendaSocialInstance: politicaAgendaSocialInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "politicaagendasocial.create", default: "Create PoliticaAgendaSocial")
            def politicaAgendaSocialInstance = new PoliticaAgendaSocial(params)
            if (politicaAgendaSocialInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), politicaAgendaSocialInstance.id])}"
                redirect(action: "show", id: politicaAgendaSocialInstance.id)
            }
            else {
                render(view: "form", model: [politicaAgendaSocialInstance: politicaAgendaSocialInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def politicaAgendaSocialInstance = PoliticaAgendaSocial.get(params.id)
        if (politicaAgendaSocialInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (politicaAgendaSocialInstance.version > version) {

                    politicaAgendaSocialInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial')] as Object[], "Another user has updated this PoliticaAgendaSocial while you were editing")
                    render(view: "edit", model: [politicaAgendaSocialInstance: politicaAgendaSocialInstance])
                    return
                }
            }
            politicaAgendaSocialInstance.properties = params
            if (!politicaAgendaSocialInstance.hasErrors() && politicaAgendaSocialInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), politicaAgendaSocialInstance.id])}"
                redirect(action: "show", id: politicaAgendaSocialInstance.id)
            }
            else {
                render(view: "edit", model: [politicaAgendaSocialInstance: politicaAgendaSocialInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def politicaAgendaSocialInstance = PoliticaAgendaSocial.get(params.id)
        if (!politicaAgendaSocialInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "politicaagendasocial.show", default: "Show PoliticaAgendaSocial")

            [politicaAgendaSocialInstance: politicaAgendaSocialInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def politicaAgendaSocialInstance = PoliticaAgendaSocial.get(params.id)
        if (politicaAgendaSocialInstance) {
            try {
                politicaAgendaSocialInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politicaAgendaSocial.label', default: 'PoliticaAgendaSocial'), params.id])}"
            redirect(action: "list")
        }
    }
}
