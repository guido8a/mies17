package mies

class IndicadoresSenpladesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["IndicadoresSenplades"], default: "IndicadoresSenplades List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [indicadoresSenpladesInstanceList: IndicadoresSenplades.list(params), indicadoresSenpladesInstanceTotal: IndicadoresSenplades.count(), title: title, params: params]
    }

    def form = {
        def title
        def indicadoresSenpladesInstance

        if (params.source == "create") {
            indicadoresSenpladesInstance = new IndicadoresSenplades()
            indicadoresSenpladesInstance.properties = params
            title = g.message(code: "default.create.label", args: ["IndicadoresSenplades"], default: "crearIndicadoresSenplades")
        } else if (params.source == "edit") {
            indicadoresSenpladesInstance = IndicadoresSenplades.get(params.id)
            if (!indicadoresSenpladesInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["IndicadoresSenplades"], default: "editarIndicadoresSenplades")
        }

        return [indicadoresSenpladesInstance: indicadoresSenpladesInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["IndicadoresSenplades"], default: "Edit IndicadoresSenplades")
            def indicadoresSenpladesInstance = IndicadoresSenplades.get(params.id)
            if (indicadoresSenpladesInstance) {
                indicadoresSenpladesInstance.properties = params
                if (!indicadoresSenpladesInstance.hasErrors() && indicadoresSenpladesInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), indicadoresSenpladesInstance.id])}"
                    redirect(action: "show", id: indicadoresSenpladesInstance.id)
                }
                else {
                    render(view: "form", model: [indicadoresSenpladesInstance: indicadoresSenpladesInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["IndicadoresSenplades"], default: "Create IndicadoresSenplades")
            def indicadoresSenpladesInstance = new IndicadoresSenplades(params)
            if (indicadoresSenpladesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), indicadoresSenpladesInstance.id])}"
                redirect(action: "show", id: indicadoresSenpladesInstance.id)
            }
            else {
                render(view: "form", model: [indicadoresSenpladesInstance: indicadoresSenpladesInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def indicadoresSenpladesInstance = IndicadoresSenplades.get(params.id)
        if (indicadoresSenpladesInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (indicadoresSenpladesInstance.version > version) {

                    indicadoresSenpladesInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades')] as Object[], "Another user has updated this IndicadoresSenplades while you were editing")
                    render(view: "edit", model: [indicadoresSenpladesInstance: indicadoresSenpladesInstance])
                    return
                }
            }
            indicadoresSenpladesInstance.properties = params
            if (!indicadoresSenpladesInstance.hasErrors() && indicadoresSenpladesInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), indicadoresSenpladesInstance.id])}"
                redirect(action: "show", id: indicadoresSenpladesInstance.id)
            }
            else {
                render(view: "edit", model: [indicadoresSenpladesInstance: indicadoresSenpladesInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def indicadoresSenpladesInstance = IndicadoresSenplades.get(params.id)
        if (!indicadoresSenpladesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["IndicadoresSenplades"], default: "Show IndicadoresSenplades")

            [indicadoresSenpladesInstance: indicadoresSenpladesInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def indicadoresSenpladesInstance = IndicadoresSenplades.get(params.id)
        if (indicadoresSenpladesInstance) {
            try {
                indicadoresSenpladesInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'indicadoresSenplades.label', default: 'IndicadoresSenplades'), params.id])}"
            redirect(action: "list")
        }
    }
}
