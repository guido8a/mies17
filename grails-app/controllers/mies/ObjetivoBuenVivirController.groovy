package mies


import static org.springframework.http.HttpStatus.*
//import grails.transaction.Transactional
//
//@Transactional(readOnly = true)
class ObjetivoBuenVivirController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

//    def index(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond ObjetivoBuenVivir.list(params), model:[objetivoBuenVivirInstanceCount: ObjetivoBuenVivir.count()]
//    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Objetivos"], default: "Lista de Objetivos")
        params.max = Math.min(params.max ? params.int('max') : 15, 100)
        [objetivoInstanceList: ObjetivoBuenVivir.list(params).sort{it.codigo}, objetivoInstanceTotal: ObjetivoBuenVivir.count(), title: title, params: params]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def show = {
        def objetivo = ObjetivoBuenVivir.get(params.id)
        if (!objetivo) {
            flash.message = "Objetivo Buen Vivir"
            redirect(action: "list")
        }
        else {
            def title = "Detalles Objertivo Buen Vivir"

            [objetivoBuenVivirInstance: objetivo, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def form = {
        def title
        def objetivoBuenVivirInstance

        if (params.source == "create") {
            objetivoBuenVivirInstance = new ObjetivoBuenVivir()
            objetivoBuenVivirInstance.properties = params
            title = "Nuevo Objetivo del Buen Vivir"
        } else if (params.source == "edit") {
            objetivoBuenVivirInstance = ObjetivoBuenVivir.get(params.id)
            if (!objetivoBuenVivirInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: ['Objetivo Buen Vivir', params.id])}"
                redirect(action: "list")
            }
            title = "Editar Objetivo Buen Vivir"
        }

        return [objetivoBuenVivirInstance: objetivoBuenVivirInstance, title: title, source: params.source]
    }

    def save = {
//        println("params " + params)

        def title
        if (params.id) {
            title = "Editar Objetivo Buen Vivir"
            def objetivoBuenVivirInstance = ObjetivoBuenVivir.get(params.id)
            if (objetivoBuenVivirInstance) {
                objetivoBuenVivirInstance.properties = params
                if (!objetivoBuenVivirInstance.hasErrors() && objetivoBuenVivirInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: ['Objetivo Buen Vivir', objetivoBuenVivirInstance.id])}"
                    redirect(action: "show", id: objetivoBuenVivirInstance.id)
                }
                else {
                    render(view: "form", model: [objetivoBuenVivirInstance: objetivoBuenVivirInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: ['Objetivo Buen Vivir', params.id])}"
                redirect(action: "list")
            }
        } else {
            title = "Nuevo Objetivo Buen Vivir"
            def objetivoBuenVivirInstance = new ObjetivoBuenVivir()
            objetivoBuenVivirInstance.properties = params
            if (objetivoBuenVivirInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: ['Objetivo Buen Vivir', objetivoBuenVivirInstance.id])}"
                redirect(action: "show", id: objetivoBuenVivirInstance.id)
            }
            else {
                render(view: "form", model: [objetivoBuenVivirInstance: objetivoBuenVivirInstance, title: title, source: "create"])
            }
        }
    }

    def delete_ajax = {
        def objetivoBuenVivirInstance = ObjetivoBuenVivir.get(params.id)
        if (objetivoBuenVivirInstance) {
            try {
                objetivoBuenVivirInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: ['Objetivo buen vivir', params.id])}"
                redirect(action: "list")
            }
            catch (e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: ['Objetivo buen vivir', params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: ['Objetivo buen vivir', params.id])}"
            redirect(action: "list")
        }
    }

}
