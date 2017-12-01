package mies

class SubSectorController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["SubSector"], default: "SubSector List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [subSectorInstanceList: SubSector.list(params), subSectorInstanceTotal: SubSector.count(), title: title, params: params]
    }

    def form = {
        def title
        def subSectorInstance

        if (params.source == "create") {
            subSectorInstance = new SubSector()
            subSectorInstance.properties = params
            title = "Crear Subsector"
        } else if (params.source == "edit") {
            subSectorInstance = SubSector.get(params.id)
            if (!subSectorInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Subsector"
        }

        return [subSectorInstance: subSectorInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["SubSector"], default: "Edit SubSector")
            def subSectorInstance = SubSector.get(params.id)
            if (subSectorInstance) {
                subSectorInstance.properties = params
                if (!subSectorInstance.hasErrors() && subSectorInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'subSector.label', default: 'SubSector'), subSectorInstance.id])}"
                    redirect(action: "show", id: subSectorInstance.id)
                }
                else {
                    render(view: "form", model: [subSectorInstance: subSectorInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["SubSector"], default: "Create SubSector")
            def subSectorInstance = new SubSector(params)
            if (subSectorInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'subSector.label', default: 'SubSector'), subSectorInstance.id])}"
                redirect(action: "show", id: subSectorInstance.id)
            }
            else {
                render(view: "form", model: [subSectorInstance: subSectorInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def subSectorInstance = SubSector.get(params.id)
        if (subSectorInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (subSectorInstance.version > version) {

                    subSectorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'subSector.label', default: 'SubSector')] as Object[], "Another user has updated this SubSector while you were editing")
                    render(view: "edit", model: [subSectorInstance: subSectorInstance])
                    return
                }
            }
            subSectorInstance.properties = params
            if (!subSectorInstance.hasErrors() && subSectorInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'subSector.label', default: 'SubSector'), subSectorInstance.id])}"
                redirect(action: "show", id: subSectorInstance.id)
            }
            else {
                render(view: "edit", model: [subSectorInstance: subSectorInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def subSectorInstance = SubSector.get(params.id)
        if (!subSectorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["SubSector"], default: "Show SubSector")

            [subSectorInstance: subSectorInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def subSectorInstance = SubSector.get(params.id)
        if (subSectorInstance) {
            try {
                subSectorInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subSector.label', default: 'SubSector'), params.id])}"
            redirect(action: "list")
        }
    }
}
