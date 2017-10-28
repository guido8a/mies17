package mies

class PresupuestoController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def kerberosService

    def editPresupuesto = {
        def id = params.id
        def lvl = params.level.toInteger()
        def tipo = params.type

        def presupuestoInstance
        def presupuestoPadre
        def hijos = 0

        if (tipo == "create") {
            presupuestoInstance = new Presupuesto()
            presupuestoPadre = Presupuesto.get(id)
            lvl = lvl + 1
        } else {
            presupuestoInstance = Presupuesto.get(id)
            presupuestoPadre = presupuestoInstance.presupuesto
            hijos = Presupuesto.findAllByPresupuesto(presupuestoInstance).size()
        }

        return [presupuestoInstance: presupuestoInstance, presupuestoPadre: presupuestoPadre, lvl: lvl, hijos: hijos]
    }

    def saveFromTree = {
        def presupuesto
        if (params.id) {
            presupuesto = Presupuesto.get(params.id)
        } else {
            presupuesto = new Presupuesto()
        }

        presupuesto.properties = params

        presupuesto = kerberosService.saveObject(presupuesto, Presupuesto, session.perfil, session.usuario, actionName, controllerName, session)

        Presupuesto padre = presupuesto.presupuesto
        padre.movimiento = 0

        padre = kerberosService.saveObject(padre, Presupuesto, session.perfil, session.usuario, actionName, controllerName, session)

        if (presupuesto.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }

    def deleteFromTree = {
        def presupuesto = Presupuesto.get(params.id)
        def hijos = Presupuesto.findAllByPresupuesto(presupuesto)
        if (hijos.size() == 0) {
            if (kerberosService.delete(params, Presupuesto, session.perfil, session.usuario)) {
                render("OK")
            } else {
                render("NO")
            }
        } else {
            render("NO")
        }
    }

    def makeTree() {
        def lista = Presupuesto.findAllByNivel(1, [sort: "numero"]).id//Presupuesto.list(sort: "codigo")
        def res = ""
        res += "<ul>"
        res += "<li id='li_00' level='0' class='init jstree-open' ' rel='init'>"
        res += "<a href='#' class='label_arbol'>Presupuesto</a>"
        res += "<ul>"
        lista.each {
            res += imprimeHijos(it)
        }
        res += "</ul>"
        res += "</ul>"
    }

    def imprimeHijos(padre) {
        def band = true
        def t = ""
        def txt = ""

        def presupuesto = Presupuesto.get(padre)

        def l = Presupuesto.findAllByPresupuesto(presupuesto);

        l.each {
            band = false;
            t += imprimeHijos(it.id)
        }

        if (!band) {
            def clase = "jstree-open"
            if (presupuesto.nivel >= 2) {
                clase = "jstree-closed"
            }
            txt += "<li id='li_" + presupuesto.id + "' level='" + presupuesto.nivel + "' class='padre " + clase + "' rel='padre'>"
            txt += "<a href='#' class='label_arbol'>" + presupuesto + "</a>"
            txt += "<ul>"
            txt += t
            txt += "</ul>"
        }
        else {
            txt += "<li id='li_" + presupuesto.id + "' level='" + presupuesto.nivel + "' class='hijo jstree-leaf' rel='hijo'>"
            txt += "<a href='#' class='label_arbol'>" + presupuesto + "</a>"
        }
        txt += "</li>"
        return txt
    }

    def tree = {
        return [res: makeTree()]
    }

    def renderArbol = {
        render(makeTree())
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Presupuesto"], default: "Presupuesto List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        [presupuestoInstanceList: Presupuesto.list(params), presupuestoInstanceTotal: Presupuesto.count(), title: title, params: params]
    }

    def form = {
        def title
        def presupuestoInstance

        if (params.source == "create") {
            presupuestoInstance = new Presupuesto()
            presupuestoInstance.properties = params
            title = "Crear Presupuesto"
        } else if (params.source == "edit") {
            presupuestoInstance = Presupuesto.get(params.id)
            if (!presupuestoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Presupuesto"
        }

        return [presupuestoInstance: presupuestoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Presupuesto"], default: "Edit Presupuesto")
            def presupuestoInstance = Presupuesto.get(params.id)
            if (presupuestoInstance) {
                presupuestoInstance.properties = params
                if (!presupuestoInstance.hasErrors() && presupuestoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), presupuestoInstance.id])}"
                    redirect(action: "show", id: presupuestoInstance.id)
                }
                else {
                    render(view: "form", model: [presupuestoInstance: presupuestoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Presupuesto"], default: "Create Presupuesto")
            def presupuestoInstance = new Presupuesto(params)
            if (presupuestoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), presupuestoInstance.id])}"
                redirect(action: "show", id: presupuestoInstance.id)
            }
            else {
                render(view: "form", model: [presupuestoInstance: presupuestoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def presupuestoInstance = Presupuesto.get(params.id)
        if (presupuestoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (presupuestoInstance.version > version) {

                    presupuestoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'presupuesto.label', default: 'Presupuesto')] as Object[], "Another user has updated this Presupuesto while you were editing")
                    render(view: "edit", model: [presupuestoInstance: presupuestoInstance])
                    return
                }
            }
            presupuestoInstance.properties = params
            if (!presupuestoInstance.hasErrors() && presupuestoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), presupuestoInstance.id])}"
                redirect(action: "show", id: presupuestoInstance.id)
            }
            else {
                render(view: "edit", model: [presupuestoInstance: presupuestoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def presupuestoInstance = Presupuesto.get(params.id)
        if (!presupuestoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Presupuesto"], default: "Show Presupuesto")

            [presupuestoInstance: presupuestoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def presupuestoInstance = Presupuesto.get(params.id)
        if (presupuestoInstance) {
            try {
                presupuestoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'presupuesto.label', default: 'Presupuesto'), params.id])}"
            redirect(action: "list")
        }
    }

    def cargarCuentasCvs = {
        def archivo = new File("/home/svt/Downloads/presupuesto4.csv")
        def contador = 0
        def errores = 0
        archivo.eachLine {
            def partes = it.split("&")
            def prsp = new Presupuesto()
            prsp.numero = partes[0].trim()
            prsp.descripcion = partes[1].trim().toUpperCase()
            prsp.movimiento = partes[2].trim().toInteger()
            if (partes[3].trim() != "0")
                prsp.presupuesto = Presupuesto.findByNumero(partes[3].trim())
            prsp.nivel = partes[4].trim().toInteger()
            if (prsp.save(flush: true))
                contador++
            else
                errores++
        }
        render "se insertaron ${contador} cuentas. Hubo ${errores} errores"
    }

    def cargarCuentasCvsActividad = {
        def archivo = new File("/home/svt/Downloads/presupuesto4.csv")
        def contador = 0
        def errores = 0
        archivo.eachLine {
            def partes = it.split("&")
            if (partes[2].trim() == "1") {
                def actv = new Actividad()
                actv.codigo = partes[0].trim()
                actv.descripcion = partes[1].trim().toUpperCase()
                if (actv.save(flush: true))
                    contador++
                else
                    errores++
            }
        }
        render "se insertaron ${contador} cuentas. Hubo ${errores} errores"
    }
}
