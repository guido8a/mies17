package mies

class ProcesoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Proceso"], default: "Proceso List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [procesoInstanceList: Proceso.list(params), procesoInstanceTotal: Proceso.count(), title: title, params: params]
    }

    def form = {
        def title
        def procesoInstance
        def pasos

        if (params.source == "create") {
            procesoInstance = new Proceso()
            procesoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Proceso"], default: "crearProceso")
        } else if (params.source == "edit") {
            procesoInstance = Proceso.get(params.id)
            if (!procesoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
                redirect(action: "list")
            }
            pasos = Paso.findAllByProceso(procesoInstance, [sort: "orden"])
            title = g.message(code: "default.edit.label", args: ["Proceso"], default: "editarProceso")
        }

        return [procesoInstance: procesoInstance, title: title, source: params.source, pasos: pasos]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Proceso"], default: "Edit Proceso")
            def procesoInstance = Proceso.get(params.id)
            if (procesoInstance) {
                procesoInstance.properties = params
                if (!procesoInstance.hasErrors() && procesoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'proceso.label', default: 'Proceso'), procesoInstance.id])}"
//                    redirect(action: "show", id: procesoInstance.id)
                    redirect(controller: 'paso', action: "create", params: [proceso: procesoInstance.id])
                }
                else {
                    render(view: "form", model: [procesoInstance: procesoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Proceso"], default: "Create Proceso")
            def procesoInstance = new Proceso(params)
            if (procesoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'proceso.label', default: 'Proceso'), procesoInstance.id])}"
//                redirect(action: "show", id: procesoInstance.id)
                redirect(controller: 'paso', action: "create", params: [proceso: procesoInstance.id])
            }
            else {
                render(view: "form", model: [procesoInstance: procesoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def procesoInstance = Proceso.get(params.id)
        if (procesoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (procesoInstance.version > version) {

                    procesoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'proceso.label', default: 'Proceso')] as Object[], "Another user has updated this Proceso while you were editing")
                    render(view: "edit", model: [procesoInstance: procesoInstance])
                    return
                }
            }
            procesoInstance.properties = params
            if (!procesoInstance.hasErrors() && procesoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'proceso.label', default: 'Proceso'), procesoInstance.id])}"
                redirect(action: "show", id: procesoInstance.id)
            }
            else {
                render(view: "edit", model: [procesoInstance: procesoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def procesoInstance = Proceso.get(params.id)
        if (!procesoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Proceso"], default: "Show Proceso")
            def pasos = Paso.findAllByProceso(procesoInstance, [sort: "orden"])
            [procesoInstance: procesoInstance, title: title, pasos: pasos]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def procesoInstance = Proceso.get(params.id)
        if (procesoInstance) {
            try {
                procesoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proceso.label', default: 'Proceso'), params.id])}"
            redirect(action: "list")
        }
    }
}
