package mies

class SectorController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Sector"], default: "Sector List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [sectorInstanceList: Sector.list(params), sectorInstanceTotal: Sector.count(), title: title, params: params]
    }

    def form = {
        def title
        def sectorInstance

        if (params.source == "create") {
            sectorInstance = new Sector()
            sectorInstance.properties = params
            title = "Crear Sector"
        } else if (params.source == "edit") {
            sectorInstance = Sector.get(params.id)
            if (!sectorInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Sector"
        }

        return [sectorInstance: sectorInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Sector"], default: "Edit Sector")
            def sectorInstance = Sector.get(params.id)
            if (sectorInstance) {
                sectorInstance.properties = params
                if (!sectorInstance.hasErrors() && sectorInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sector.label', default: 'Sector'), sectorInstance.id])}"
                    redirect(action: "show", id: sectorInstance.id)
                }
                else {
                    render(view: "form", model: [sectorInstance: sectorInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Sector"], default: "Create Sector")
            def sectorInstance = new Sector(params)
            if (sectorInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'sector.label', default: 'Sector'), sectorInstance.id])}"
                redirect(action: "show", id: sectorInstance.id)
            }
            else {
                render(view: "form", model: [sectorInstance: sectorInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def sectorInstance = Sector.get(params.id)
        if (sectorInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sectorInstance.version > version) {

                    sectorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sector.label', default: 'Sector')] as Object[], "Another user has updated this Sector while you were editing")
                    render(view: "edit", model: [sectorInstance: sectorInstance])
                    return
                }
            }
            sectorInstance.properties = params
            if (!sectorInstance.hasErrors() && sectorInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sector.label', default: 'Sector'), sectorInstance.id])}"
                redirect(action: "show", id: sectorInstance.id)
            }
            else {
                render(view: "edit", model: [sectorInstance: sectorInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def sectorInstance = Sector.get(params.id)
        if (!sectorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Sector"], default: "Show Sector")

            [sectorInstance: sectorInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def sectorInstance = Sector.get(params.id)
        if (sectorInstance) {
            try {
                sectorInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sector.label', default: 'Sector'), params.id])}"
            redirect(action: "list")
        }
    }
}
