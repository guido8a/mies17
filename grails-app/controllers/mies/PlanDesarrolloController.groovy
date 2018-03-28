package mies

import mies.seguridad.Shield

class PlanDesarrolloController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "planDesarrollo.list", default: "Planes de Desarrollo")

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [planDesarrolloInstanceList: PlanDesarrollo.list(params), planDesarrolloInstanceTotal: PlanDesarrollo.count(), title: title, params: params]
    }

    def form = {
        def title
        def planDesarrolloInstance

        if (params.source == "create") {
            planDesarrolloInstance = new PlanDesarrollo()
            planDesarrolloInstance.properties = params
            title = g.message(code: "planDesarrollo.create", default: "Nuevo Plan de Desarrollo")
        } else if (params.source == "edit") {
            planDesarrolloInstance = PlanDesarrollo.get(params.id)
            if (!planDesarrolloInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "planDesarrollo.edit", default: "Editar Plan de Desarrollo")
        }

        return [planDesarrolloInstance: planDesarrolloInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "planDesarrollo.edit", default: "Editar Plan de desarrollo")
            def planDesarrolloInstance = PlanDesarrollo.get(params.id)
            if (planDesarrolloInstance) {
                planDesarrolloInstance.properties = params
                if (!planDesarrolloInstance.hasErrors() && planDesarrolloInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), planDesarrolloInstance.id])}"
                    redirect(action: "show", id: planDesarrolloInstance.id)
                }
                else {
                    render(view: "form", model: [planDesarrolloInstance: planDesarrolloInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "planDesarrollo.create", default: "Crear Plan de Desarrollo")
            def planDesarrolloInstance = new PlanDesarrollo(params)
            if (planDesarrolloInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), planDesarrolloInstance.id])}"
                redirect(action: "show", id: planDesarrolloInstance.id)
            }
            else {
                render(view: "form", model: [planDesarrolloInstance: planDesarrolloInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def planDesarrolloInstance = PlanDesarrollo.get(params.id)
        if (planDesarrolloInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (planDesarrolloInstance.version > version) {

                    planDesarrolloInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo')] as Object[], "Another user has updated this ProgramaPresupuestario while you were editing")
                    render(view: "edit", model: [planDesarrolloInstance: planDesarrolloInstance])
                    return
                }
            }
            planDesarrolloInstance.properties = params
            if (!planDesarrolloInstance.hasErrors() && planDesarrolloInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), planDesarrolloInstance.id])}"
                redirect(action: "show", id: planDesarrolloInstance.id)
            }
            else {
                render(view: "edit", model: [planDesarrolloInstance: planDesarrolloInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def planDesarrolloInstance = PlanDesarrollo.get(params.id)
        if (!planDesarrolloInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
            redirect(action: "list")
        }
        else {
            def title = g.message(code: "planDesarrollo.show", default: "Ver Plan de Desarrollo")
            [planDesarrolloInstance: planDesarrolloInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
//        println("params " + params)
        def planDesarrolloInstance = PlanDesarrollo.get(params.id)
        if (planDesarrolloInstance) {
            try {
                planDesarrolloInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
//                redirect(action: "list")
                render "ok"
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
//                redirect(action: "show", id: params.id)
                render "no"
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'planDesarrollo.label', default: 'Plan de Desarrollo'), params.id])}"
//            redirect(action: "list")
            render "no"
        }
    }
}
