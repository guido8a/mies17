package mies

class CargoPersonalController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "cargopersonal.list", default: "CargoPersonal List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [cargoPersonalInstanceList: CargoPersonal.list(params), cargoPersonalInstanceTotal: CargoPersonal.count(), title: title, params: params]
    }

    def form = {
        def title
        def cargoPersonalInstance

        if (params.source == "create") {
            cargoPersonalInstance = new CargoPersonal()
            cargoPersonalInstance.properties = params
            title = g.message(code: "cargopersonal.create", default: "Create CargoPersonal")
        } else if (params.source == "edit") {
            cargoPersonalInstance = CargoPersonal.get(params.id)
            if (!cargoPersonalInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "cargopersonal.edit", default: "Edit CargoPersonal")
        }

        return [cargoPersonalInstance: cargoPersonalInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "cargopersonal.edit", default: "Edit CargoPersonal")
            def cargoPersonalInstance = CargoPersonal.get(params.id)
            if (cargoPersonalInstance) {
                cargoPersonalInstance.properties = params
                if (!cargoPersonalInstance.hasErrors() && cargoPersonalInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), cargoPersonalInstance.id])}"
                    redirect(action: "show", id: cargoPersonalInstance.id)
                }
                else {
                    render(view: "form", model: [cargoPersonalInstance: cargoPersonalInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "cargopersonal.create", default: "Create CargoPersonal")
            def cargoPersonalInstance = new CargoPersonal(params)
            if (cargoPersonalInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), cargoPersonalInstance.id])}"
                redirect(action: "show", id: cargoPersonalInstance.id)
            }
            else {
                render(view: "form", model: [cargoPersonalInstance: cargoPersonalInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def cargoPersonalInstance = CargoPersonal.get(params.id)
        if (cargoPersonalInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (cargoPersonalInstance.version > version) {

                    cargoPersonalInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cargoPersonal.label', default: 'CargoPersonal')] as Object[], "Another user has updated this CargoPersonal while you were editing")
                    render(view: "edit", model: [cargoPersonalInstance: cargoPersonalInstance])
                    return
                }
            }
            cargoPersonalInstance.properties = params
            if (!cargoPersonalInstance.hasErrors() && cargoPersonalInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), cargoPersonalInstance.id])}"
                redirect(action: "show", id: cargoPersonalInstance.id)
            }
            else {
                render(view: "edit", model: [cargoPersonalInstance: cargoPersonalInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def cargoPersonalInstance = CargoPersonal.get(params.id)
        if (!cargoPersonalInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "cargopersonal.show", default: "Show CargoPersonal")

            [cargoPersonalInstance: cargoPersonalInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def cargoPersonalInstance = CargoPersonal.get(params.id)
        if (cargoPersonalInstance) {
            try {
                cargoPersonalInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargoPersonal.label', default: 'CargoPersonal'), params.id])}"
            redirect(action: "list")
        }
    }
}
