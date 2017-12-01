package mies

class PoliticaController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Politica"], default: "Politica List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [politicaInstanceList: Politica.list(params), politicaInstanceTotal: Politica.count(), title: title, params: params]
    }

    def form = {
        def title
        def politicaInstance

        if (params.source == "create") {
            politicaInstance = new Politica()
            politicaInstance.properties = params
            title = "Crear política"
        } else if (params.source == "edit") {
            politicaInstance = Politica.get(params.id)
            if (!politicaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar política"
        }

        return [politicaInstance: politicaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Politica"], default: "Edit Politica")
            def politicaInstance = Politica.get(params.id)
            if (politicaInstance) {
                politicaInstance.properties = params
                if (!politicaInstance.hasErrors() && politicaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politica.label', default: 'Politica'), politicaInstance.id])}"
                    redirect(action: "show", id: politicaInstance.id)
                }
                else {
                    render(view: "form", model: [politicaInstance: politicaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Politica"], default: "Create Politica")
            def politicaInstance = new Politica(params)
            if (politicaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'politica.label', default: 'Politica'), politicaInstance.id])}"
                redirect(action: "show", id: politicaInstance.id)
            }
            else {
                render(view: "form", model: [politicaInstance: politicaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def politicaInstance = Politica.get(params.id)
        if (politicaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (politicaInstance.version > version) {

                    politicaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'politica.label', default: 'Politica')] as Object[], "Another user has updated this Politica while you were editing")
                    render(view: "edit", model: [politicaInstance: politicaInstance])
                    return
                }
            }
            politicaInstance.properties = params
            if (!politicaInstance.hasErrors() && politicaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'politica.label', default: 'Politica'), politicaInstance.id])}"
                redirect(action: "show", id: politicaInstance.id)
            }
            else {
                render(view: "edit", model: [politicaInstance: politicaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def politicaInstance = Politica.get(params.id)
        if (!politicaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Politica"], default: "Show Politica")

            [politicaInstance: politicaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def politicaInstance = Politica.get(params.id)
        if (politicaInstance) {
            try {
                politicaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'politica.label', default: 'Politica'), params.id])}"
            redirect(action: "list")
        }
    }
}
