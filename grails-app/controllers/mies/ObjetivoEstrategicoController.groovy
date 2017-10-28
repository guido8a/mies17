package mies

class ObjetivoEstrategicoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"objetivoestrategico.list", default:"ObjetivoEstrategico List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [objetivoEstrategicoInstanceList: ObjetivoEstrategico.list(params), objetivoEstrategicoInstanceTotal: ObjetivoEstrategico.count(), title: title, params:params]
    }

    def form = {
        def title
        def objetivoEstrategicoInstance

        if(params.source == "create") {
            objetivoEstrategicoInstance = new ObjetivoEstrategico()
            objetivoEstrategicoInstance.properties = params
            title = g.message(code:"objetivoestrategico.create", default:"Create ObjetivoEstrategico")
        } else if(params.source == "edit") {
            objetivoEstrategicoInstance = ObjetivoEstrategico.get(params.id)
            if (!objetivoEstrategicoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code:"objetivoestrategico.edit", default:"Edit ObjetivoEstrategico")
        }

        return [objetivoEstrategicoInstance: objetivoEstrategicoInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"objetivoestrategico.edit", default:"Edit ObjetivoEstrategico")
            def objetivoEstrategicoInstance = ObjetivoEstrategico.get(params.id)
            if (objetivoEstrategicoInstance) {
                objetivoEstrategicoInstance.properties = params
                if (!objetivoEstrategicoInstance.hasErrors() && objetivoEstrategicoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), objetivoEstrategicoInstance.id])}"
                    redirect(action: "show", id: objetivoEstrategicoInstance.id)
                }
                else {
                    render(view: "form", model: [objetivoEstrategicoInstance: objetivoEstrategicoInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"objetivoestrategico.create", default:"Create ObjetivoEstrategico")
            def objetivoEstrategicoInstance = new ObjetivoEstrategico(params)
            if (objetivoEstrategicoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), objetivoEstrategicoInstance.id])}"
                redirect(action: "show", id: objetivoEstrategicoInstance.id)
            }
            else {
                render(view: "form", model: [objetivoEstrategicoInstance: objetivoEstrategicoInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def objetivoEstrategicoInstance = ObjetivoEstrategico.get(params.id)
        if (objetivoEstrategicoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (objetivoEstrategicoInstance.version > version) {
                    
                    objetivoEstrategicoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico')] as Object[], "Another user has updated this ObjetivoEstrategico while you were editing")
                    render(view: "edit", model: [objetivoEstrategicoInstance: objetivoEstrategicoInstance])
                    return
                }
            }
            objetivoEstrategicoInstance.properties = params
            if (!objetivoEstrategicoInstance.hasErrors() && objetivoEstrategicoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), objetivoEstrategicoInstance.id])}"
                redirect(action: "show", id: objetivoEstrategicoInstance.id)
            }
            else {
                render(view: "edit", model: [objetivoEstrategicoInstance: objetivoEstrategicoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def objetivoEstrategicoInstance = ObjetivoEstrategico.get(params.id)
        if (!objetivoEstrategicoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"objetivoestrategico.show", default:"Show ObjetivoEstrategico")

            [objetivoEstrategicoInstance: objetivoEstrategicoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def objetivoEstrategicoInstance = ObjetivoEstrategico.get(params.id)
        if (objetivoEstrategicoInstance) {
            try {
                objetivoEstrategicoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico'), params.id])}"
            redirect(action: "list")
        }
    }
}
