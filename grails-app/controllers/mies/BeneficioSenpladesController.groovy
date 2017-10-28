package mies

class BeneficioSenpladesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["BeneficioSenplades"], default: "BeneficioSenplades List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [beneficioSenpladesInstanceList: BeneficioSenplades.list(params), beneficioSenpladesInstanceTotal: BeneficioSenplades.count(), title: title, params: params]
    }

    def form = {
        def title
        def beneficioSenpladesInstance

        if (params.source == "create") {
            beneficioSenpladesInstance = new BeneficioSenplades()
            beneficioSenpladesInstance.properties = params
            title = g.message(code: "default.create.label", args: ["BeneficioSenplades"], default: "crearBeneficioSenplades")
        } else if (params.source == "edit") {
            beneficioSenpladesInstance = BeneficioSenplades.get(params.id)
            if (!beneficioSenpladesInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["BeneficioSenplades"], default: "editarBeneficioSenplades")
        }

        return [beneficioSenpladesInstance: beneficioSenpladesInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["BeneficioSenplades"], default: "Edit BeneficioSenplades")
            def beneficioSenpladesInstance = BeneficioSenplades.get(params.id)
            if (beneficioSenpladesInstance) {
                beneficioSenpladesInstance.properties = params
                if (!beneficioSenpladesInstance.hasErrors() && beneficioSenpladesInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), beneficioSenpladesInstance.id])}"
                    redirect(action: "show", id: beneficioSenpladesInstance.id)
                }
                else {
                    render(view: "form", model: [beneficioSenpladesInstance: beneficioSenpladesInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["BeneficioSenplades"], default: "Create BeneficioSenplades")
            def beneficioSenpladesInstance = new BeneficioSenplades(params)
            if (beneficioSenpladesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), beneficioSenpladesInstance.id])}"
                redirect(action: "show", id: beneficioSenpladesInstance.id)
            }
            else {
                render(view: "form", model: [beneficioSenpladesInstance: beneficioSenpladesInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def beneficioSenpladesInstance = BeneficioSenplades.get(params.id)
        if (beneficioSenpladesInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (beneficioSenpladesInstance.version > version) {

                    beneficioSenpladesInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades')] as Object[], "Another user has updated this BeneficioSenplades while you were editing")
                    render(view: "edit", model: [beneficioSenpladesInstance: beneficioSenpladesInstance])
                    return
                }
            }
            beneficioSenpladesInstance.properties = params
            if (!beneficioSenpladesInstance.hasErrors() && beneficioSenpladesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), beneficioSenpladesInstance.id])}"
                redirect(action: "show", id: beneficioSenpladesInstance.id)
            }
            else {
                render(view: "edit", model: [beneficioSenpladesInstance: beneficioSenpladesInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def beneficioSenpladesInstance = BeneficioSenplades.get(params.id)
        if (!beneficioSenpladesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["BeneficioSenplades"], default: "Show BeneficioSenplades")

            [beneficioSenpladesInstance: beneficioSenpladesInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def beneficioSenpladesInstance = BeneficioSenplades.get(params.id)
        if (beneficioSenpladesInstance) {
            try {
                beneficioSenpladesInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades'), params.id])}"
            redirect(action: "list")
        }
    }
}
