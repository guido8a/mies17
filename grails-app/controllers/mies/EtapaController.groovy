package mies

class EtapaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Etapa"], default: "Etapa List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [etapaInstanceList: Etapa.list(params), etapaInstanceTotal: Etapa.count(), title: title, params: params]
    }

    def form = {
        def title
        def etapaInstance

        if (params.source == "create") {
            etapaInstance = new Etapa()
            etapaInstance.properties = params
            title = "Crear Etapa de proyecto"
        } else if (params.source == "edit") {
            etapaInstance = Etapa.get(params.id)
            if (!etapaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Etapa de proyecto"
        }

        return [etapaInstance: etapaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Etapa"], default: "Edit Etapa")
            def etapaInstance = Etapa.get(params.id)
            if (etapaInstance) {
                etapaInstance.properties = params
                if (!etapaInstance.hasErrors() && etapaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'etapa.label', default: 'Etapa'), etapaInstance.id])}"
                    redirect(action: "show", id: etapaInstance.id)
                }
                else {
                    render(view: "form", model: [etapaInstance: etapaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Etapa"], default: "Create Etapa")
            def etapaInstance = new Etapa(params)
            if (etapaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'etapa.label', default: 'Etapa'), etapaInstance.id])}"
                redirect(action: "show", id: etapaInstance.id)
            }
            else {
                render(view: "form", model: [etapaInstance: etapaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def etapaInstance = Etapa.get(params.id)
        if (etapaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (etapaInstance.version > version) {

                    etapaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'etapa.label', default: 'Etapa')] as Object[], "Another user has updated this Etapa while you were editing")
                    render(view: "edit", model: [etapaInstance: etapaInstance])
                    return
                }
            }
            etapaInstance.properties = params
            if (!etapaInstance.hasErrors() && etapaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'etapa.label', default: 'Etapa'), etapaInstance.id])}"
                redirect(action: "show", id: etapaInstance.id)
            }
            else {
                render(view: "edit", model: [etapaInstance: etapaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def etapaInstance = Etapa.get(params.id)
        if (!etapaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Etapa"], default: "Show Etapa")

            [etapaInstance: etapaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def etapaInstance = Etapa.get(params.id)
        if (etapaInstance) {
            try {
                etapaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'etapa.label', default: 'Etapa'), params.id])}"
            redirect(action: "list")
        }
    }
}
