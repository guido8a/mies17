package mies

class ZonaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def kerberosService

    def index = {
        redirect(action: "list", params: params)
    }

    def editar = {
        redirect(action: 'editar' + (params.tipo).capitalize(), params: params)
    }
    def editarZona = {
        def obj, crear
        if (params.id) {
            obj = Zona.get(params.id)
            crear = false
        } else {
            obj = new Zona()
            crear = true
        }
        return [zonaInstance: obj, tipo: params.tipo, crear: crear]
    }
    def editarProvincia = {
        def obj, crear
        if (params.id) {
            obj = Provincia.get(params.id)
            crear = false
        } else {
            obj = new Provincia()
            obj.zona = Zona.get(params.padre)
            crear = true
        }
        return [provinciaInstance: obj, tipo: params.tipo, crear: crear]
    }
    def editarCanton = {
        def obj, crear
        if (params.id) {
            obj = Canton.get(params.id)
            crear = false
        } else {
            obj = new Canton()
            obj.provincia = Provincia.get(params.padre)
            crear = true
        }
        return [cantonInstance: obj, tipo: params.tipo, crear: crear]
    }
    def editarParroquia = {
        def obj, crear
        if (params.id) {
            obj = Parroquia.get(params.id)
            crear = false
        } else {
            obj = new Parroquia()
            obj.canton = Canton.get(params.padre)
            crear = true
        }
        return [parroquiaInstance: obj, tipo: params.tipo, crear: crear]
    }

    def infoForTree = {
        redirect(action: 'info' + (params.tipo).capitalize(), params: params)
    }
    def infoZona = {
        def obj = Zona.get(params.id)
        return [zonaInstance: obj]
    }
    def infoProvincia = {
        def obj = Provincia.get(params.id)
        return [provinciaInstance: obj]
    }
    def infoCanton = {
        def obj = Canton.get(params.id)
        return [cantonInstance: obj]
    }
    def infoParroquia = {
        def obj = Parroquia.get(params.id)
        return [parroquiaInstance: obj]
    }

    def saveFromTree = {
        def obj
        def err
        switch (params.tipo) {
            case "zona":
                obj = kerberosService.save(params, Zona, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
            case "provincia":
                obj = kerberosService.save(params, Provincia, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
            case "canton":
                obj = kerberosService.save(params, Canton, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
            case "parroquia":
                obj = kerberosService.save(params, Parroquia, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
        }
        if (err) {
            render("NO")
        } else {
            render("OK")
        }
    }

    def deleteFromTree = {
        switch (params.tipo) {
            case "zona":
                def zona = Zona.get(params.id)
                def provincias = Provincia.findAllByZona(zona)
                def band = true
                def p = [:]
                p.actionName = "deleteFromTree: Zona"
                p.controllerName = "Zona"
                provincias.each { provincia ->
                    def cantones = Canton.findAllByProvincia(provincia)
                    cantones.each { canton ->
                        def parroquias = Parroquia.findAllByCanton(canton)
                        parroquias.each { parroquia ->
                            p.id = parroquia.id
                            band = band && kerberosService.delete(p, Parroquia, session.perfil, session.usuario)
                        }
                        if (band) {
                            p.id = canton.id
                            band = band && kerberosService.delete(p, Canton, session.perfil, session.usuario)
                        }
                    }
                    if (band) {
                        p.id = provincia.id
                        band = band && kerberosService.delete(p, Provincia, session.perfil, session.usuario)
                    }
                }
                if (band) {
                    if (kerberosService.delete(params, Zona, session.perfil, session.usuario)) {
                        render("OK")
                    } else {
                        render("NO")
                    }
                }
                break;
            case "provincia":
                def provincia = Provincia.get(params.id)
                def cantones = Canton.findAllByProvincia(provincia)
                def band = true
                def p = [:]
                p.actionName = "deleteFromTree: Provincia"
                p.controllerName = "Zona"
                cantones.each { canton ->
                    def parroquias = Parroquia.findAllByCanton(canton)
                    parroquias.each { parroquia ->
                        p.id = parroquia.id
                        band = band && kerberosService.delete(p, Parroquia, session.perfil, session.usuario)
                    }
                    if (band) {
                        p.id = canton.id
                        band = band && kerberosService.delete(p, Canton, session.perfil, session.usuario)
                    }
                }
                if (band) {
                    if (kerberosService.delete(params, Provincia, session.perfil, session.usuario)) {
                        render("OK")
                    } else {
                        render("NO")
                    }
                }
                break;
            case "canton":
                def canton = Canton.get(params.id)
                def parroquias = Parroquia.findAllByCanton(canton)
                def band = true
                def p = [:]
                p.actionName = "deleteFromTree: Canton"
                p.controllerName = "Zona"
                parroquias.each { parroquia ->
                    p.id = parroquia.id
                    band = band && kerberosService.delete(p, Parroquia, session.perfil, session.usuario)
                }
                if (band) {
                    if (kerberosService.delete(params, Canton, session.perfil, session.usuario)) {
                        render("OK")
                    } else {
                        render("NO")
                    }
                }
                break;
            case "parroquia":
                params.actionName = "deleteFromTree: Parroquia"
                if (kerberosService.delete(params, Parroquia, session.perfil, session.usuario)) {
                    render("OK")
                } else {
                    render("NO")
                }
                break;
        }
    }

    String makeTree() {
        def zonas = Zona.list(sort: "nombre", order: "asc")
        def tree = ""
        def clase

        tree += "<ul type='pais'>" // <ul pais
        clase = (zonas.size() > 0) ? "jstree-open" : ""
        tree += "<li id='pais_' class='pais " + clase + "' rel='pais'>" // <li pais
        tree += "<a href='#' class='label_arbol'>División política</a>" // </> a href pais

        tree += "<ul type='zona'>" // <ul zonas
        zonas.each { zona ->
            def provincias = Provincia.findAllByZona(zona)
            clase = (provincias.size() > 0) ? "jstree-open" : ""
            tree += "<li id='zona_" + zona.id + "' class='zona " + clase + "' rel='zona'>" // <li zona
            tree += "<a href='#' id='link_zona_" + zona.id + "' class='label_arbol'>" + zona.nombre + "</a>" // </> a href zona
            if (provincias.size() > 0) {
                tree += "<ul type='provincia'>" // < ul provincias
                provincias.each { provincia ->
                    def cantones = Canton.findAllByProvincia(provincia)
                    clase = (cantones.size() > 0) ? "jstree-open" : ""
                    tree += "<li id='provincia_" + provincia.id + "' class='provincia " + clase + "' rel='provincia'>" // <li provincia
                    tree += "<a href='#' id='link_provincia_" + provincia.id + "' class='label_arbol'>" + provincia.nombre + "</a>" // </> a href provincia
                    if (cantones.size() > 0) {
                        tree += "<ul type='canton'>" // < ul cantones
                        cantones.each { canton ->
                            def parroquias = Parroquia.findAllByCanton(canton)
                            clase = (parroquias.size() > 0) ? "jstree-open" : ""
                            tree += "<li id='canton_" + canton.id + "' class='canton " + clase + "' rel='canton'>" // <li canton
                            tree += "<a href='#' id='link_canton_" + canton.id + "' class='label_arbol'>" + canton.nombre + "</a>" // </> a href canton
                            if (parroquias.size() > 0) {
                                tree += "<ul type='parroquia'>" // < ul parroquias
                                parroquias.each { parroquia ->
                                    clase = ""
                                    tree += "<li id='parroquia_" + parroquia.id + "' class='parroquia " + clase + "' rel='parroquia'>" // <li parroquia
                                    tree += "<a href='#' id='link_parroquia_" + parroquia.id + "' class='label_arbol'>" + parroquia.nombre + "</a>" // </> a href parroquia
                                    tree += "</li>" // /> li parroquia
                                } // parroquias.each (provincia > canton > parroquia)
                                tree += "</ul>" // /> ul parroquias
                            } //parroquias.size > 0 ( en provincia > canton)
                        } //cantones.each (en provincia)
                        tree += "</ul>" // /> cantones
                    } //cantones.size > 0 (en provincia)
                    tree += "</li>" // /> li provincia
                } //provincias.each
                tree += "</ul>" // /> provincias
            } //provincias.size > 0
            tree += "</li>" // /> li zona
        } // zonas.each

        tree += "</ul>" // /> ul zonas

        tree += "</li>" // /> li pais
        tree += "</ul>" // /> ul pais

        println tree

        return tree
    }

    String makeBasicTree(tipo, id) {
        String tree = "", clase = ""
        switch (tipo) {
            case "init": //cargo "Division politica"
                tree += "<ul type='pais'>" // <ul pais
                clase = ""
                tree += "<li id='pais_' class='pais jstree-closed' rel='pais'>" // <li pais
                tree += "<a href='#' class='label_arbol'>División política</a>" // </> a href pais
                tree += "</ul>"
                break;
            case "pais": //cargo las zonas
                def zonas = Zona.list(sort: "nombre", order: "asc")
                tree += "<ul type='zona'>" // <ul zonas
                zonas.each { zona ->
                    def provincias = Provincia.findAllByZona(zona, [sort: 'nombre'])
                    def cantonesZ = Canton.findAllByZona(zona, [sort: 'nombre'])
                    clase = (provincias.size() > 0 || cantonesZ.size() > 0) ? "jstree-closed" : ""

                    tree += "<li id='zona_" + zona.id + "' class='zona " + clase + "' rel='zona'>" // <li zona
                    tree += "<a href='#' id='link_zona_" + zona.id + "' class='label_arbol'>" + zona.nombre + "</a>" // </> a href zona
                    tree += "</li>"
                }

                tree += "</ul>"
                break;
            case "zona": //cargo las provincias de la zona especificada
                def zona = Zona.get(params.id)
                def provincias = Provincia.findAllByZona(zona, [sort: 'nombre'])
                def cantonesZ = Canton.findAllByZona(zona, [sort: 'nombre'])

                if (provincias.size() > 0) {
                    tree += "<ul type='provincia'>" // < ul provincias
                    provincias.each { provincia ->
                        def cantones = Canton.findAllByProvincia(provincia, [sort: 'nombre'])
                        clase = (cantones.size() > 0) ? "jstree-closed" : ""
                        tree += "<li id='provincia_" + provincia.id + "' class='provincia " + clase + "' rel='provincia'>" // <li provincia
                        tree += "<a href='#' id='link_provincia_" + provincia.id + "' class='label_arbol'>" + provincia.nombre + "</a>" // </> a href provincia
                        tree += "</li>" // </> li provincia
                    }
                    tree += "</ul>" // </> ul provincias
                }
                if (cantonesZ.size() > 0) {
                    tree += "<ul type='canton'>" // < ul cantones
                    cantonesZ.each { canton ->
                        def parroquias = Parroquia.findAllByCanton(canton, [sort: 'nombre'])
                        def gads = Gad.findAllByCanton(canton, [sort: 'nombre'])

                        clase = (parroquias.size() > 0 || gads.size() > 0) ? "jstree-closed" : ""
                        tree += "<li id='canton_" + canton.id + "' class='canton " + clase + "' rel='canton'>" // <li canton
                        tree += "<a href='#' id='link_canton_" + canton.id + "' class='label_arbol'>" + canton.nombre + "</a>" // </> a href canton
                        tree += "</li>" // </> li canton
                    }
                    tree += "</ul>" // </> ul cantones
                }
                break;
            case "provincia": // cargo los cantones de la provincia
                def provincia = Provincia.get(params.id)

                def cantones = Canton.findAllByProvincia(provincia, [sort: 'nombre'])
                clase = (cantones.size() > 0) ? "jstree-closed" : ""

                if (cantones.size() > 0) {
                    tree += "<ul type='canton'>" // < ul cantones
                    cantones.each { canton ->
                        def parroquias = Parroquia.findAllByCanton(canton, [sort: 'nombre'])

                        clase = (parroquias.size() > 0) ? "jstree-closed" : ""
                        tree += "<li id='canton_" + canton.id + "' class='canton " + clase + "' rel='canton'>" // <li canton
                        tree += "<a href='#' id='link_canton_" + canton.id + "' class='label_arbol'>" + canton.nombre + "</a>" // </> a href canton
                        tree += "</li>" // </> li canton
                    }
                    tree += "</ul>" // </> ul cantones
                }
                break;
            case "canton":
                def canton = Canton.get(params.id)

                def parroquias = Parroquia.findAllByCanton(canton, [sort: 'nombre'])

                clase = ""

                if (parroquias.size() > 0) {
                    tree += "<ul type='parroquia'>" // < ul parroquias
                    parroquias.each { parroquia ->
                        tree += "<li id='parroquia_" + parroquia.id + "' class='parroquia " + clase + "' rel='parroquia'>" // <li parroquia
                        tree += "<a href='#' id='link_parroquia_" + parroquia.id + "' class='label_arbol'>" + parroquia.nombre + "</a>" // </> a href parroquia
                        tree += "</li>" // </> li parroquia
                    }
                    tree += "</ul>" // </> ul parroquias
                }
                break;
        }
        return tree
    }

     def loadTreePart = {
        render(makeBasicTree(params.tipo, params.id))
    }

    def arbol = {
        return [tree: makeTree()]
    }

    def renderArbol = {
        render(makeTree())
    }


    def list = {
        def title = g.message(code: "default.list.label", args: ["Zona"], default: "Zona List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [zonaInstanceList: Zona.list(params), zonaInstanceTotal: Zona.count(), title: title, params: params]
    }

    def form = {
        def title
        def zonaInstance

        if (params.source == "create") {
            zonaInstance = new Zona()
            zonaInstance.properties = params
            title = "Crear Zona de planificación"
        } else if (params.source == "edit") {
            zonaInstance = Zona.get(params.id)
            if (!zonaInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar Zona de planificación"
        }

        return [zonaInstance: zonaInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Zona"], default: "Edit Zona")
            def zonaInstance = Zona.get(params.id)
            if (zonaInstance) {
                zonaInstance.properties = params
                if (!zonaInstance.hasErrors() && zonaInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'zona.label', default: 'Zona'), zonaInstance.id])}"
                    redirect(action: "show", id: zonaInstance.id)
                }
                else {
                    render(view: "form", model: [zonaInstance: zonaInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Zona"], default: "Create Zona")
            def zonaInstance = new Zona(params)
            if (zonaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'zona.label', default: 'Zona'), zonaInstance.id])}"
                redirect(action: "show", id: zonaInstance.id)
            }
            else {
                render(view: "form", model: [zonaInstance: zonaInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def zonaInstance = Zona.get(params.id)
        if (zonaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (zonaInstance.version > version) {

                    zonaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'zona.label', default: 'Zona')] as Object[], "Another user has updated this Zona while you were editing")
                    render(view: "edit", model: [zonaInstance: zonaInstance])
                    return
                }
            }
            zonaInstance.properties = params
            if (!zonaInstance.hasErrors() && zonaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'zona.label', default: 'Zona'), zonaInstance.id])}"
                redirect(action: "show", id: zonaInstance.id)
            }
            else {
                render(view: "edit", model: [zonaInstance: zonaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def zonaInstance = Zona.get(params.id)
        if (!zonaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Zona"], default: "Show Zona")

            [zonaInstance: zonaInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def zonaInstance = Zona.get(params.id)
        if (zonaInstance) {
            try {
                zonaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'zona.label', default: 'Zona'), params.id])}"
            redirect(action: "list")
        }
    }
}
