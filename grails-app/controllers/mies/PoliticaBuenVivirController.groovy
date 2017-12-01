package mies



import static org.springframework.http.HttpStatus.*
//import grails.transaction.Transactional
//
//@Transactional(readOnly = true)
class PoliticaBuenVivirController extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

//    def index(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond PoliticaBuenVivir.list(params), model:[politicaBuenVivirInstanceCount: PoliticaBuenVivir.count()]
//    }


    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Politica"], default: "Politica List")
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [politicaInstanceList: PoliticaBuenVivir.list(params), politicaInstanceTotal: PoliticaBuenVivir.count(), title: title, params: params]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def show = {
        def politica = PoliticaBuenVivir.get(params.id)
        if (!politica) {
            flash.message = "Política Buen Vivir"
            redirect(action: "list")
        }
        else {
            def title = "Detalles Política Buen Vivir"

            [politicaBuenVivirInstance: politica, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def form = {
        def title
        def politicaBuenVivirInstance

        if (params.source == "create") {
            politicaBuenVivirInstance = new PoliticaBuenVivir()
            politicaBuenVivirInstance.properties = params
            title = "Nueva Política del Buen Vivir"
        } else if (params.source == "edit") {
            politicaBuenVivirInstance = PoliticaBuenVivir.get(params.id)
            if (!politicaBuenVivirInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: ['Política Buen Vivir', params.id])}"
                redirect(action: "list")
            }
            title = "Editar Política Buen Vivir"
        }

        return [politicaBuenVivirInstance: politicaBuenVivirInstance, title: title, source: params.source]
    }

    def save = {
//        println("params " + params)

        def title
        if (params.id) {
            title = "Editar Política Buen Vivir"
            def politicaBuenVivirInstance = PoliticaBuenVivir.get(params.id)
            if (politicaBuenVivirInstance) {
                politicaBuenVivirInstance.properties = params
                if (!politicaBuenVivirInstance.hasErrors() && politicaBuenVivirInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: ['Política Buen Vivir', politicaBuenVivirInstance.id])}"
                    redirect(action: "show", id: politicaBuenVivirInstance.id)
                }
                else {
                    render(view: "form", model: [politicaBuenVivirInstance: politicaBuenVivirInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: ['Política Buen Vivir', params.id])}"
                redirect(action: "list")
            }
        } else {
            title = "Nueva Política Buen Vivir"
            def politicaBuenVivirInstance = new PoliticaBuenVivir()
            politicaBuenVivirInstance.properties = params
            if (politicaBuenVivirInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: ['Política Buen Vivir', politicaBuenVivirInstance.id])}"
                redirect(action: "show", id: politicaBuenVivirInstance.id)
            }
            else {
                render(view: "form", model: [politicaBuenVivirInstance: politicaBuenVivirInstance, title: title, source: "create"])
            }
        }
    }


    def delete_ajax = {
//        println("params " + params)
        def politicaBuenVivirInstance = PoliticaBuenVivir.get(params.id)
        if (politicaBuenVivirInstance) {
            try {
                politicaBuenVivirInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: ['Política buen vivir', params.id])}"
                redirect(action: "list")
            }
            catch (e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: ['Política buen vivir', params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: ['Política buen vivir', params.id])}"
            redirect(action: "list")
        }
    }

}
