package mies

import mies.seguridad.Prfl
import mies.seguridad.Sesn
import mies.seguridad.Usro

class EntidadController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def kerberosService
    def dbConnectionService

    def index = {
        redirect(action: "list", params: params)
    }

    String makeTree() {
        def entidades = Entidad.list(sort: "nombre", order: "asc")
        def tree = ""
        def clase

        tree += "<ul>" // <ul padre
        clase = (entidades.size() > 0) ? "jstree-open" : ""
        tree += "<li id='padre_' class='padre " + clase + "' rel='padre'>" // <li pais
        tree += "<a href='#' class='label_arbol'>Entidades</a>" // </> a href pais

        tree += "<ul>" // <ul entidades
        entidades.each { ent ->
            def subs = SubSecretaria.findAllByEntidad(ent, [sort: "nombre", order: "asc"])
            clase = (subs.size() > 0) ? "jstree-open" : ""
            tree += "<li id='ent_" + ent.id + "' class='entidad " + clase + "' rel='entidad'>" // <li entidad
            tree += "<a href='#' id='link_entidad_" + ent.id + "' class='label_arbol'>" + ent.nombre + "</a>" // </> a href entidad
            if (subs.size() > 0) {
                tree += "<ul>" // <ul subsecretarias
                subs.each { sub ->
                    def unidades = UnidadEjecutora.findAllBySubSecretaria(sub, [sort: "nombre", order: "asc"])
                    clase = (unidades.size() > 0) ? "jstree-open" : ""
                    tree += "<li id='sub_" + sub.id + "' class='subsecretaria " + clase + "' rel='subsecretaria'>" // <li subsecretaria
                    tree += "<a href='#' id='link_subsecretaria_" + sub.id + "' class='label_arbol'>" + sub.nombre + "</a>" // </> a href subsecretaria
                    if (unidades.size() > 0) {
                        tree += "<ul>" // <ul unidades
                        unidades.each { uni ->
                            def responsables = Usro.findAllByUnidad(uni)
                            responsables.sort { a, b -> a.persona.apellido <=> b.persona.apellido }
                            clase = (responsables.size() > 0) ? "jstree-open" : ""
                            tree += "<li id='uni_" + uni.id + "' class='unidad " + clase + "' rel='unidad'>" // <li unidad
                            tree += "<a href='#' id='link_unidad_" + uni.id + "' class='label_arbol'>" + uni.nombre + "</a>" // </>a href unidad
                            if (responsables.size() > 0) {
                                tree += "<ul>" // <ul responsables
                                responsables.each { resp ->
                                    tree += "<li id='res_" + resp.id + "' class='responsable ' rel='responsable'>" // <li responsable
                                    tree += "<a href='#' id='link_responsable_" + resp.id + "' class='label_arbol'>" + resp.persona.apellido + " " + resp.persona.nombre + "</a>" // </> a href responsable
                                    tree += "</li>" // /> li responsable
                                } //responsables.each
                                tree += "</ul>" // /> ul responsables
                            } //if responsables.size > 0
                            tree += "</li>" // /> li unidad
                        } //unidades.each
                        tree += "</ul>" // /> ul unidades
                    } // if unidades.size > 0
                    tree += "</li>" // /> li subsecretaria
                } //subsecretarias.each
                tree += "</ul>" // /> ul subsecretarias
            } //subsecretarias.each
            tree += "</li>" // /> li entidad
        } //entidades.each
        tree += "</ul>" // /> ul entidades

        tree += "</ul>" //padre de todos
        return tree
    }

    String makeBasicTree(tipo, id) {
        String tree = "", clase = "", rel, clUs = ""
        def unej1, usros = [], proys = []
        switch (tipo) {
            case "padre": //cargo las unidades ejecutoras de codigo 1
            case "padre_nu":
//                unej1 = UnidadEjecutora.findAllByTipoInstitucion(TipoInstitucion.findByCodigo(1))
                unej1 = UnidadEjecutora.findAllByPadreIsNull([sort: 'orden'])
                break;
            case "unej": //cargo las unidades ejecutoras a partir de un padre
                def padre = UnidadEjecutora.get(id)
                unej1 = UnidadEjecutora.findAllByPadre(padre, [sort: 'orden'])
                usros = Usro.findAllByUnidad(padre)
                break;
            case "unej_nu": //cargo las unidades ejecutoras a partir de un padre
                def padre = UnidadEjecutora.get(id)
                unej1 = UnidadEjecutora.findAllByPadre(padre, [sort: 'orden'])
                proys = Proyecto.findAllByUnidadEjecutora(padre)
                break;
        }

        tree += "<ul type='unej'>"
        unej1.each { unej ->
            def hijos = UnidadEjecutora.findAllByPadre(unej)
            def uss = []
            if (!tipo.contains("_nu")) {
                uss = Usro.findAllByUnidad(unej)
            } else {
                uss = Proyecto.findAllByUnidadEjecutora(unej)
            }
            clase = (hijos.size() > 0 || uss.size() > 0) ? "jstree-closed" : ""
            rel = (hijos.size() > 0) ? "folder" : "file"

            if (uss.size() > 0) {
                clUs += " hasUsers "
            }

            tree += "<li id='unej_" + unej.id + "' class='unej " + clase + " " + clUs + "' rel='" + rel + "'>"
            tree += "<a href='#' id='link_unej_" + unej.id + "' class='label_arbol'>" + unej.nombre + "</a>"
            tree += "</li>"
        }

        usros.each { usro ->
            clase = ""
            rel = "usro"

            tree += "<li id='usro_" + usro.id + "' class='usro " + clase + "' rel='" + rel + "'>"
            tree += "<a href='#' id='link_usro_" + usro.id + "' class='label_arbol'>" + usro.persona.nombre + " " + usro.persona.apellido + "</a>"
            tree += "</li>"
        }
        proys.each { proy ->
            clase = ""
            rel = "proy"

            tree += "<li id='usro_" + proy.id + "' class='proy " + clase + "' rel='" + rel + "'>"
            tree += "<a href='#' id='link_proy_" + proy.id + "' class='label_arbol'>" + proy.nombre + "</a>"
            tree += "</li>"
        }


        tree += "</ul>"

        return tree
    }

    def loadTreePart = {
        render(makeBasicTree(params.tipo, params.id))
    }

    def getResponsables = {
        /*
        'E' 'Ejecución'
        'I' 'Planificación'
        'S' 'Seguimiento'
        'A' 'Administrativo'
        'F' 'Financiero'

        administrativo
        si esigef = 9999 -> solo de la direccion administrativa // id=93
        else -> de la unidad

        ejecucion
        de la unidad

        financiero
        si esigef = 9999 -> solo de la direccion financiera // id=94
        else -> de la unidad

        planificacion
        si esigef = 9999 -> solo de la direccion de planificacion // id=85
        else -> de la unidad

        seguimiento
        si esigef = 9999 -> solo de la direccion de planificacion // id=85
        else -> de la unidad
        */

        def unidad = UnidadEjecutora.get(params.unidad)
        def tipo = TipoResponsable.get(params.tipo)

        def dirAdmin = UnidadEjecutora.get(93)
        def dirFinan = UnidadEjecutora.get(94)
        def dirPlan = UnidadEjecutora.get(85)


        def usuarios = []
        if (tipo) {
            switch (tipo.codigo) {
                case 'A':
                    if (unidad.codigo == "9999") {
                        usuarios = Usro.findAllByUnidad(dirAdmin)
                    } else {
                        if (unidad) {
                            usuarios = Usro.findAllByUnidad(unidad)
                        }
                    }
                    break;
                case 'E':
                    usuarios = Usro.findAllByUnidad(unidad)
                    break;
                case 'F':
                    if (unidad.codigo == "9999") {
                        usuarios = Usro.findAllByUnidad(dirFinan)
                    } else {
                        if (unidad) {
                            usuarios = Usro.findAllByUnidad(unidad)
                        }
                    }
                    break;
                case 'I':
/*
                    if (unidad.codigo == "9999") {
                        usuarios = Usro.findAllByUnidad(dirPlan)
                    } else {
*/
                    if (unidad) {
                        usuarios = Usro.findAllByUnidad(unidad)
                    }
/*
                    }
*/
                    break;
                case 'S':
                    if (unidad.codigo == "9999") {
                        usuarios = Usro.findAllByUnidad(dirPlan)
                    } else {
                        if (unidad) {
                            usuarios = Usro.findAllByUnidad(unidad)
                        }
                    }
                    break;
            }
        }
        usuarios.sort { it.persona.nombre }

        def ls = []
        usuarios.each { u ->
            def m = [:]
            m.key = u.id
            m.value = u.persona.nombre.toLowerCase().split(' ').collect { it.capitalize() }.join(' ') + " " + u.persona.apellido.toLowerCase().split(' ').collect { it.capitalize() }.join(' ')
            ls.add(m)
        }

        render g.select(from: ls, optionKey: 'key', optionValue: 'value', name: "responsable", "class": "field required ui-widget-content ui-corner-all")
    }


    def responsables = {
        def unidad = UnidadEjecutora.get(params.id)
        return [unidad: unidad]
    }

    def responsable = {
        def unidad = UnidadEjecutora.get(params.id)
        def usuarios = Usro.findAllByUnidad(unidad)

//        def results = ResponsableProyecto.findAllByTipoAndUnidad(TipoResponsable.findByCodigo("A"), unidad, [sort: "hasta", order: "desc"])
//        def results2 = ResponsableProyecto.findAllByTipoAndUnidad(TipoResponsable.findByCodigo("F"), unidad, [sort: "hasta", order: "desc"])
//        def results3 = ResponsableProyecto.findAllByTipoAndUnidad(TipoResponsable.findByCodigo("I"), unidad, [sort: "hasta", order: "desc"])
//        def responsables = ResponsableProyecto.findAllByUnidad(unidad, [sort: "hasta", order: "desc"])

        def now = new Date()

        def c = ResponsableProyecto.createCriteria()
        def responsables = c.list {
            eq("unidad", unidad)
            le("desde", now)
            ge("hasta", now)
            and {
                order("tipo", "asc")
                order("desde", "asc")
            }
        }
//        println ResponsableProyecto.findAllByUnidad(unidad)
//        println "RESPONSABLES: " + responsables
//        println "aa " + results3
//        return [responsableAdministrativo: results[0], responsableFinanciero: results2[0], responsablePlanificacion: results3[0], usuarios: usuarios, unidad: unidad]
        return [usuarios: usuarios, unidad: unidad, responsables: responsables]
    } //responsable


    def bajaResponsable = {
        def responsable = ResponsableProyecto.get(params.id)

        responsable.hasta = new Date()

        responsable = kerberosService.saveObject(responsable, ResponsableProyecto, session.perfil, session.usuario, actionName, controllerName, session)

        if (responsable.errors.getErrorCount() != 0) {
            println responsable.errors
            render("NO")
        } else {
            redirect(action: "reloadResponsables", id: params.unidad)
        }
    }

    def saveResponsable = {
//        println "SAVE RESP: " + params
        /*
        [
        "id":"",
        "responsable":"106",
        "observaciones":"",
         "hasta":"29-02-2012",
         "tipo":"1",
         "desde":"24-02-2012",
         "unidad":"7"
         ]
         */

        def unidad = UnidadEjecutora.get(params.unidad)
        def usuario = Usro.get(params.responsable)
        def tipo = TipoResponsable.get(params.tipo)

        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)

        def responsable = new ResponsableProyecto()

        if (params.id) {
            responsable = ResponsableProyecto.get(params.id)
        }

        responsable.responsable = usuario
        responsable.unidad = unidad
        responsable.desde = desde
        responsable.hasta = hasta
        responsable.tipo = tipo
        responsable.observaciones = params.observaciones

        responsable = kerberosService.saveObject(responsable, ResponsableProyecto, session.perfil, session.usuario, actionName, controllerName, session)

        if (responsable.errors.getErrorCount() != 0) {
            println responsable.errors
            render("NO")
        } else {
            redirect(action: "reloadResponsables", id: unidad.id)
        }
    }

    def reloadResponsables = {
        def unidad = UnidadEjecutora.get(params.id)
        def responsables = []

        if (unidad) {
            def now = new Date()
            def c = ResponsableProyecto.createCriteria()
            responsables = c.list {
                eq("unidad", unidad)
                le("desde", now)
                ge("hasta", now)
                and {
                    order("tipo", "asc")
                    order("desde", "asc")
                }
            }
        }
        return [responsables: responsables]
    }


    def saveResponsable_ = {
        println "SAVE RESPONSABLE " + params

//        params.each {
        //            println it
        //        }
        def err = false
        if (params.administrativo) {
            def unidad = UnidadEjecutora.get(params.administrativo.unidad.id)
            def desde = params.administrativo.desde
            def hasta = params.administrativo.hasta

            def c = ResponsableProyecto.createCriteria()
            def results = ResponsableProyecto.findAllByTipoAndUnidad(TipoResponsable.findByCodigo("A"), unidad, [sort: "hasta", order: "desc"])

            if (results.size() > 0) {

                def ahora = new Date()
                results.each {
                    if (it.hasta.after(ahora)) {
                        it.hasta = ahora
                        if (it.desde.after(ahora))
                            it.desde = null
                        it.save(flush: true)
                    }
                }
                params.planificacion.id = null
                params.planificacion.tipo = TipoResponsable.findByCodigo("A")
                def obj = kerberosService.save(params.planificacion, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            } else {
                if (params.administrativo.tipo == "update") {
                    def ant = ResponsableProyecto.get(params.administrativo.id)
                    ant.hasta = Date.parse("dd-MM-yyyy", desde)
                    ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsableAdministrativo", "proyecto", session)
                    err = ant.errors.getErrorCount() != 0
                }
                params.administrativo.id = null
                params.administrativo.tipo = TipoResponsable.findByCodigo("A")
                def obj = kerberosService.save(params.administrativo, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            }
        }
        if (params.financiero) {
            def desde = params.financiero.desde
            def hasta = params.financiero.hasta
            def unidad = UnidadEjecutora.get(params.financiero.unidad.id)

            def results = ResponsableProyecto.findAllByTipoAndUnidad(TipoResponsable.findByCodigo("F"), unidad, [sort: "hasta", order: "desc"])

            if (results.size() > 0) {

                def ahora = new Date()
                results.each {
                    if (it.hasta.after(ahora)) {
                        it.hasta = ahora
                        if (it.desde.after(ahora))
                            it.desde = null
                        it.save(flush: true)
                    }
                }

                params.planificacion.id = null
                params.planificacion.tipo = TipoResponsable.findByCodigo("F")
                def obj = kerberosService.save(params.planificacion, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            } else {
                if (params.financiero.tipo == "update") {
                    def ant = ResponsableProyecto.get(params.financiero.id)

                    ant.hasta = Date.parse("dd-MM-yyyy", desde)
                    ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsableFinanciero", "proyecto", session)
                    err = ant.errors.getErrorCount() != 0
                }
                params.financiero.id = null
                params.financiero.tipo = TipoResponsable.findByCodigo("F")
                def obj = kerberosService.save(params.financiero, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            }
        }
        if (params.planificacion) {
            def desde = params.planificacion.desde
            def hasta = params.planificacion.hasta
            def unidad = UnidadEjecutora.get(params.planificacion.unidad.id)

            def results = ResponsableProyecto.findAllByTipoAndUnidad(TipoResponsable.findByCodigo("I"), unidad, [sort: "hasta", order: "desc"])

            if (results.size() > 0) {
                def ahora = new Date()
                results.each {
                    if (it.hasta.after(ahora)) {
                        it.hasta = ahora
                        if (it.desde.after(ahora))
                            it.desde = null
                        it.save(flush: true)

                    }
                }
                params.planificacion.id = null
                params.planificacion.tipo = TipoResponsable.findByCodigo("I")
                def obj = kerberosService.save(params.planificacion, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }

            } else {
                if (params.planificacion.tipo == "update") {
                    def ant = ResponsableProyecto.get(params.planificacion.id)
                    ant.hasta = Date.parse("dd-MM-yyyy", desde)
                    ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsablePlanificacion", "proyecto", session)
                    err = ant.errors.getErrorCount() != 0
                }
                params.planificacion.id = null
                params.planificacion.tipo = TipoResponsable.findByCodigo("I")
                def obj = kerberosService.save(params.planificacion, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            }
        }
    }

    def historialResponsables = {
        def unidad = UnidadEjecutora.get(params.id)
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def responsableProyectoInstanceList = []

        def ls = ResponsableProyecto.findAllByUnidad(unidad, [sort: "desde"])
//            c.list {
////            maxResults(params.max)
//            tipo {
//                or {
//                    eq("codigo", "A")
//                    eq("codigo", "F")
//                    eq("codigo", "I")
//                }
//            }
//            and {
//                isNull("proyecto")
//                order("desde", "asc")
//                order("hasta", "asc")
//                order("tipo", "asc")
//            }
//        }
        def cont = 0
        def ahora = new Date()
        ls.each {
            if (it.unidad.id == unidad.id) {
                def m = [:]
                m.obj = it
                if (it) {
                    if (it?.desde <= ahora && it?.hasta >= ahora) {
                        m.clase = "activo"
                    } else {
                        if (it?.desde < ahora) {
                            m.clase = "pasado"
                        } else {
                            if (it?.hasta > ahora) {
                                m.clase = "futuro"
                            }
                        }
                    }
                    m.estado = m.clase
                    m.clase += " " + (it?.tipo.descripcion).toLowerCase()
                    responsableProyectoInstanceList.add(m)
                    cont++
                }
            }
        }

        responsableProyectoInstanceList.sort { it.activo }

        def responsableProyectoInstanceTotal = cont

        return [unidad: unidad, responsableProyectoInstanceList: responsableProyectoInstanceList, responsableProyectoInstanceTotal: responsableProyectoInstanceTotal]
    }

    def arbol = { }

    def arbol_asg = { }

    def arbol_ = {
        return [tree: makeTree()]
    }

    def renderArbol = {
        render(makeTree())
    }

    def infoForTree = {

        if (params.tipo == "usro") {
            redirect(action: "infoResponsable", id: params.id)
        } else if (params.tipo == "proy") {
            redirect(action: "infoProyecto", id: params.id)
        } else {
            def unidad = UnidadEjecutora.get(params.id)

            def c = PresupuestoUnidad.createCriteria()
            def presupuestos = c.list {
                eq("unidad", unidad)
                anio {
                    order("anio", "asc")
                }
            }

            return [unidad: unidad, presupuestos: presupuestos]
        }
//        redirect(action: 'info' + (params.tipo).capitalize(), params: params)
    }

    def getPresupuestoAnio = {
        def anio = Anio.get(params.anio)
        def unidad = UnidadEjecutora.get(params.unidad)

        def presupuesto = PresupuestoUnidad.findByAnioAndUnidad(anio, unidad)

        def str = (presupuesto ? presupuesto.id : '')
        str += "_"
        str += (presupuesto ? g.formatNumber(number: presupuesto.maxCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : '0,00')
        str += "_"
        str += (presupuesto ? g.formatNumber(number: presupuesto.maxInversion, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2) : '0,00')
        str += "_"
        str += (presupuesto ? presupuesto?.ejeProgramatico?.id : '')
        str += "_"
        str += (presupuesto ? presupuesto?.objetivoEstrategico?.id : '')
        str += "_"
        str += (presupuesto ? presupuesto?.objetivoGobiernoResultado?.id : '')
        str += "_"
        str += (presupuesto ? presupuesto?.politica?.id : '')
        str += "_"
        str += (presupuesto ? g.formatNumber(number: presupuesto?.originalCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : '0,00')
        str += "_"
        str += (presupuesto ? g.formatNumber(number: presupuesto?.originalInversion, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : '0,00')

        render(str)
    }

    def presupuestoFromTree = {
        def unidad = UnidadEjecutora.get(params.id)

        return [unidad: unidad]
    }

    def docsFromTreeVer = {
        def documentoInstance = Documento.get(params.id)
        if (!documentoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "documento.show", default: "Show Documento")

            [documentoInstance: documentoInstance, unidad: documentoInstance.unidadEjecutora]
        }
    }
    def docsFromTreeEdit = {
        def unidad = UnidadEjecutora.get(params.unidad)

        def documentoInstance

        if (params.id) {
            documentoInstance = Documento.get(params.id)
        }

        return [unidad: unidad, documentoInstance: documentoInstance]
    }

    def docsFromTreeUpload = {

//        println "UPLOADING"
//        println params
//        println "\n\n\n"

        def unidad = UnidadEjecutora.get(params.id)

        def entidad = "MIES"

        def path = servletContext.getRealPath("/") + "archivos/" + entidad
        new File(path).mkdirs()

        def f = request.getFile('fileUpload')
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename()
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }
            def reps = [
                    "a": "[àáâãäåæ]",
                    "e": "[èéêë]",
                    "i": "[ìíîï]",
                    "o": "[òóôõöø]",
                    "u": "[ùúûü]",

                    "A": "[ÀÁÂÃÄÅÆ]",
                    "E": "[ÈÉÊË]",
                    "I": "[ÌÍÎÏ]",
                    "O": "[ÒÓÔÕÖØ]",
                    "U": "[ÙÚÛÜ]",

                    "n": "[ñ]",
                    "c": "[ç]",

                    "N": "[Ñ]",
                    "C": "[Ç]",

                    "": "[\\!@#\\\$%\\^&*()-='\"\\/<>:;\\.,\\?]",

                    "_": "[\\s]"
            ]

            reps.each { k, v ->
                fileName = (fileName.trim()).replaceAll(v, k)
            }

            fileName = fileName + "_unidad_" + unidad.id + "." + ext

            def pathFile = path + File.separatorChar + fileName
            def src = new File(pathFile)

            if (src.exists()) {
                flash.message = 'Ya existe un archivo con ese nombre. Por favor cámbielo o elimine el otro archivo primero.'
                flash.estado = "error"
                flash.icon = "alert"
            } else {
                def doc = new Documento()
                doc.unidadEjecutora = unidad
                doc.descripcion = params.descripcion
                doc.clave = params.clave
                doc.resumen = params.resumen
                doc.documento = fileName
                doc = kerberosService.saveObject(doc, Documento, session.perfil, session.usuario, actionName, controllerName, session)
                if (doc.errors.getErrorCount() != 0) {
                    flash.message = 'Ha ocurrido un error al guardar su archivo.'
                    flash.estado = "error"
                    flash.icon = "alert"
                } else {
                    f.transferTo(new File(pathFile))
                    flash.message = 'Se ha agregado su archivo exitosamente.'
                    flash.estado = "highlight"
                    flash.icon = "info"
                }
            }
        } else {
            if (params.doc) {
                def doc = Documento.get(params.doc)
                doc.unidadEjecutora = unidad
                doc.descripcion = params.descripcion
                doc.clave = params.clave
                doc.resumen = params.resumen
                doc = kerberosService.saveObject(doc, Documento, session.perfil, session.usuario, actionName, controllerName, session)
                if (doc.errors.getErrorCount() != 0) {
                    flash.message = 'Ha ocurrido un error al guardar su archivo.'
                    flash.estado = "error"
                    flash.icon = "alert"
                } else {
                    flash.message = 'Se ha actualizado su archivo exitosamente.'
                    flash.estado = "highlight"
                    flash.icon = "info"
                }
            } else {
                flash.message = 'Seleccione un archivo.'
                flash.estado = "error"
                flash.icon = "alert"
            }
        }
        redirect(action: "docsFromTree", params: [id: unidad.id])
    }
    def docsFromTreeDelete = {
        println "DELETE DOC"
        println params
        def unidad = UnidadEjecutora.get(params.unidad)
        def entidad = "MIES"
        def path = servletContext.getRealPath("/") + "archivos/" + entidad

        if (params.id.class == java.lang.String) {
            params.id = [params.id]
        }

        (params.id).each { id ->
            def doc = Documento.get(id)
            def archivo = doc.documento
            def pathFile = path + File.separatorChar + archivo
            def src = new File(pathFile)
            if (src.exists()) {
                src.delete()
            }

            def p = [:]
            p.id = id
            p.controllerName = controllerName
            p.actionName = actionName
            kerberosService.delete(p, Documento, session.perfil, session.usuario)
        }

        redirect(action: "docsFromTree", params: [id: unidad.id])
    }
    def docsFromTreeDownload = {
        def doc = Documento.get(params.id)
        def archivo = doc.documento
        def unidad = UnidadEjecutora.get(params.unidad)
        def entidad = "MIES"
        def path = servletContext.getRealPath("/") + "archivos/" + entidad

        def pathFile = path + File.separatorChar + archivo
        def src = new File(pathFile)
        if (src.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${src.getName()}")

            response.outputStream << src.newInputStream()
        } else {
            redirect(action: "fileNotFound", params: ['archivo': archivo, 'id': unidad.id])
        }
    }
    def docsFromTreeFileNotFound = {
        return [archivo: params.archivo, id: params.id]
    }
    def docsFromTree = {
        def unidad = UnidadEjecutora.get(params.id)

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.sort) {
            params.sort = "id"
        }
        if (!params.order) {
            params.order = "asc"
        }
        def offset = params.offset?.toInteger() ?: 0
        def busca = params.busca?.trim()
        def c = Documento.createCriteria()
        def documentoInstanceList = c.list {
            eq("unidadEjecutora", unidad)
            if (params.busca && busca != "") {
                or {
                    ilike("descripcion", "%" + busca + "%")
                    ilike("clave", "%" + busca + "%")
                    ilike("resumen", "%" + busca + "%")
                    ilike("documento", "%" + busca + "%")
                }
            }
            maxResults(params.max)
            firstResult offset
            order(params.sort, params.order)
        }

        c = Documento.createCriteria()
        def lista = c.list {
            eq("unidadEjecutora", unidad)
            if (params.busca && busca != "") {
                or {
                    ilike("descripcion", "%" + busca + "%")
                    ilike("clave", "%" + busca + "%")
                    ilike("resumen", "%" + busca + "%")
                    ilike("documento", "%" + busca + "%")
                }
            }
        }

        def documentoInstanceTotal = lista.size()

        return [unidad: unidad, documentoInstanceList: documentoInstanceList, documentoInstanceTotal: documentoInstanceTotal, params: params]
    }

    def editFromTree = {
        def unidad, padre
        if (params.tipo == "edit") {
            unidad = UnidadEjecutora.get(params.id)
            padre = unidad.padre
        } else {
            unidad = new UnidadEjecutora()
            padre = UnidadEjecutora.get(params.id)
        }
        return [unidad: unidad, padre: padre]
    }

    def saveFromTree = {
        if (params.esUsuario == "1") {
//            println "save usro " + params
            def err
            def paramsPersona = params.persona
            def paramsUsuario = params.usuario

            def tx_fcha
            def fcha
            if(paramsPersona.fechaNacimiento){
                tx_fcha = "${paramsPersona.fechaNacimiento_day}-${paramsPersona.fechaNacimiento_month}-${paramsPersona.fechaNacimiento_year}"
                fcha = new Date().parse("dd-MM-yyyy", tx_fcha)
                paramsPersona.fechaNacimiento = fcha
            }

            def tx_fcha2
            def fcha2
            if(paramsUsuario.fechaPass){
                tx_fcha2 = "${paramsUsuario.fechaPass_day}-${paramsUsuario.fechaPass_month}-${paramsUsuario.fechaPass_year}"
                fcha2 = new Date().parse("dd-MM-yyyy", tx_fcha2)
                paramsUsuario.fechaPass = fcha2
            }

            if (paramsUsuario.usroPassword.trim() != "" && paramsUsuario.usroPassword.trim() != "****") {
                paramsUsuario.usroPassword = paramsUsuario.usroPassword.trim().encodeAsMD5()
            } else {
                paramsUsuario.remove("usroPassword")
            }
            if (paramsUsuario.autorizacion.trim() != "" && paramsUsuario.autorizacion.trim() != "****") {
                paramsUsuario.autorizacion = paramsUsuario.autorizacion.trim().encodeAsMD5()
            } else {
                paramsUsuario.remove("autorizacion")
            }


            def persona

            if(paramsPersona.id){
                persona = Persona.get(paramsPersona.id)
            }else{
                persona = new Persona ()
            }

            persona.properties = paramsPersona

            try{
                persona.save(flush: true)
            }catch (e){
                println("error al guardar la persona " + e)
                err = true
            }


            def usro
            if (paramsUsuario.id) {
                usro = Usro.get(paramsUsuario.id)
            } else {
                usro = new Usro()

            }
            usro.properties = paramsUsuario
            usro.persona = persona


            try{
                usro.save(flush:true)
            }catch (e){
                println("error al guardar el usuario " + e)
                err = true
            }


            def sesns = Sesn.findAllByUsuario(usro)
            def perfilesId = sesns.perfil.id

            def perfiles_add = params.perfiles_add.split(",")
            def perfiles_remove = params.perfiles_remove.split(",")

            perfiles_add.each { id ->
                if (id != "" && !perfilesId.contains(id)) {
                    def perfil = Prfl.get(id.toLong())
                    def sesn = new Sesn()
                    sesn.perfil = perfil
                    sesn.usuario = usro

                    sesn = kerberosService.saveObject(sesn, Sesn, session.perfil, session.usuario, actionName, controllerName, session)
                }
            }

            perfiles_remove.each { perfId ->
                sesns.each { sesn ->
                    if (perfId != "") {
                        if (sesn.id.toLong() == perfId.toLong()) {

                            def prm = [:]
                            prm.id = sesn.id
                            prm.actionName = actionName
                            prm.controllerName = controllerName
                            kerberosService.delete(prm, Sesn, session.perfil, session.usuario)
                        }
                    }
                }
            }


            if (err) {
                render("NO")
            } else {
                render("OK")
            }
        } //save usuario
        else if (params.esUsuario == "2") {
            println "GUARDA PRESUPUESTO ENTIDAD "
            println params
            println ""
            def unidad = UnidadEjecutora.get(params.unidad)
            def anio = Anio.get(params.anio.id)

            def padre
            def inversionPadre
            def unidades
            def inversionesTodas
            def valorActualInversion = PresupuestoUnidad.findByUnidadAndAnio(unidad, anio)?.maxInversion

//            println("valor actual inversion " + valorActualInversion)

            if(unidad.padre){
                padre = UnidadEjecutora.get(unidad.padre.id)
                inversionPadre = PresupuestoUnidad.findByUnidadAndAnio(padre, anio).maxInversion
                unidades = UnidadEjecutora.findAllByPadre(padre)
                inversionesTodas = (PresupuestoUnidad.findAllByUnidadInListAndAnio(unidades, anio).maxInversion.sum() ?: 0)
            }

            def presupuestoUnidad = new PresupuestoUnidad()

            def inversion = params.maxInversion
            def corriente = params.maxCorrientes
            def orgInversion = params.originalInversion
            def orgCorriente = params.originalCorrientes

            if (!inversion) {
                inversion = "0"
            }
            if (!corriente) {
                corriente = "0"
            }

            if (params.presId) {
                presupuestoUnidad = PresupuestoUnidad.get(params.presId)
            } else {
                presupuestoUnidad.anio = anio
                presupuestoUnidad.unidad = unidad
            }

            inversion = inversion.replaceAll("\\.", "")
            inversion = inversion.replaceAll(",", "\\.")

            presupuestoUnidad.maxInversion = inversion.toDouble()


            corriente = corriente.replaceAll("\\.", "")
            corriente = corriente.replaceAll(",", "\\.")
            presupuestoUnidad.maxCorrientes = corriente.toDouble()

            orgInversion = orgInversion.replaceAll("\\.", "")
            orgInversion = orgInversion.replaceAll(",", "\\.")
            presupuestoUnidad.originalInversion = orgInversion.toDouble()

            orgCorriente = orgCorriente.replaceAll("\\.", "")
            orgCorriente = orgCorriente.replaceAll(",", "\\.")
            presupuestoUnidad.originalCorrientes = orgCorriente.toDouble()

            presupuestoUnidad.objetivoGobiernoResultado = ObjetivoGobiernoResultado.get(params.objetivoGobiernoResultado.id)
            presupuestoUnidad.politica = Politica.get(params.politica.id)
            presupuestoUnidad.ejeProgramatico = EjeProgramatico.get(params.ejeProgramatico.id)
            presupuestoUnidad.objetivoEstrategico = ObjetivoEstrategicoProyecto.get(params.objetivoEstrategico.id)

            println "\n\nGPR"
            println presupuestoUnidad.objetivoGobiernoResultado
            println "\n\n"


            if(unidad.padre){
//                def padre = UnidadEjecutora.get(unidad.padre.id)
//                def inversionPadre = PresupuestoUnidad.findByUnidad(padre).maxInversion
//                def unidades = UnidadEjecutora.findAllByPadre(padre)
//                println("unidades " + unidades.id)
//                def inversionesTodas = (PresupuestoUnidad.findAllByUnidadInList(unidades).maxInversion.sum() ?: 0)
                def subtotalInv = inversionPadre - inversionesTodas
                def inversionDisponible = Math.round(subtotalInv*100)/100

//                println("inv padre " + inversionPadre)
//                println("inv todas " + inversionesTodas)
//                println("inv disponible " + inversionDisponible)

                params.maxInversion = params.maxInversion.replaceAll('\\.','')
                params.maxInversion = params.maxInversion.replaceAll(',','\\.')

//                println("--> " + params.maxInversion.toDouble())

                if(valorActualInversion){

                    if(params.maxInversion.toDouble() <= valorActualInversion){
                        presupuestoUnidad = kerberosService.saveObject(presupuestoUnidad, PresupuestoUnidad, session.perfil, session.usuario, actionName, controllerName, session)
                        if ((presupuestoUnidad.errors.getErrorCount() == 0)) {
                            render("OK")
                        } else {
                            render("NO")
                        }
                    }else{
                        def diferenciaInversion = params.maxInversion.toDouble() - valorActualInversion

                        def totalDisponible = valorActualInversion + inversionDisponible

//                        println("inversion actual " + valorActualInversion)
//                        println("disponible para esta inversion " + totalDisponible)

//                        if(diferenciaInversion < inversionDisponible){
                        if(params.maxInversion.toDouble() <= totalDisponible){
                            presupuestoUnidad = kerberosService.saveObject(presupuestoUnidad, PresupuestoUnidad, session.perfil, session.usuario, actionName, controllerName, session)
                            if ((presupuestoUnidad.errors.getErrorCount() == 0)) {
                                render("OK")
                            } else {
                                render("NO")
                            }
                        }else{
                            render "NO"
                        }
                    }
                }else{

                    if(inversionPadre < params.maxInversion.toDouble()){
                        render "NO"
                    }else{

                        if(inversionDisponible < params.maxInversion.toDouble()){
                            render "NO"
                        }else{
                            presupuestoUnidad = kerberosService.saveObject(presupuestoUnidad, PresupuestoUnidad, session.perfil, session.usuario, actionName, controllerName, session)
                            if ((presupuestoUnidad.errors.getErrorCount() == 0)) {
                                render("OK")
                            } else {
                                render("NO")
                            }
                        }
                    }
                }
            }else{
                presupuestoUnidad = kerberosService.saveObject(presupuestoUnidad, PresupuestoUnidad, session.perfil, session.usuario, actionName, controllerName, session)
                if ((presupuestoUnidad.errors.getErrorCount() == 0)) {
                    render("OK")
                } else {
                    render("NO")
                }
            }

        } //guardar presupuesto entidad
        else {

            def pUnidad = params.unidad
            def unidad
            if (pUnidad.id) {
                unidad = UnidadEjecutora.get(pUnidad.id)
            } else {
                unidad = new UnidadEjecutora()
            }
            unidad.properties = pUnidad
            unidad = kerberosService.saveObject(unidad, Unidad, session.perfil, session.usuario, actionName, controllerName, session)
            if ((unidad.errors.getErrorCount() == 0)) {
                render("OK")
            } else {
                render("NO")
            }
//            } else {
            //                render("NO")
            //            }
        } //save entidad


    }

    def deleteFromTree = {
        def unidad = UnidadEjecutora.get(params.id)

        def pUnidad = [id: unidad.id, actionName: actionName, controllerName: controllerName]

        if (kerberosService.delete(pUnidad, UnidadEjecutora, session.perfil, session.usuario)) {
            render("OK")
        } else {
            render("NO")
        }
    }

    def editUserFromTree = {
        def usuario, unidad, perfiles = []
        if (params.tipo == "edit") {
            usuario = Usro.get(params.id)
            unidad = usuario.unidad
            perfiles = Sesn.findAllByUsuario(usuario)
        } else {
            usuario = new Usro()
            unidad = UnidadEjecutora.get(params.id)
        }
        return [usuario: usuario, unidad: unidad, perfiles: perfiles]
    }
    def deleteUserFromTree = {
        def usuario = Usro.get(params.id)
        def sesion = Sesn.findAllByUsuario(usuario)
        def err = false
        sesion.each {
            def p = params.clone()
            p.id = it.id
            if (!kerberosService.delete(p, Sesn, session.perfil, session.usuario)) {
                err = true
            }
        }
        if (!err) {
            if (kerberosService.delete(params, Usro, session.perfil, session.usuario)) {
                render("OK")
            } else {
                render("NO")
            }
        } else {
            render("NO")
        }
    }

    def infoEntidad = {
        def obj = Entidad.get(params.id)
        return [entidadInstance: obj]
    }
    def infoSubsecretaria = {
        def obj = SubSecretaria.get(params.id)
        return [subSecretariaInstance: obj]
    }
    def infoUnidad = {
        def obj = UnidadEjecutora.get(params.id)
        return [unidadEjecutoraInstance: obj]
    }
    def infoResponsable = {
        def obj = Usro.get(params.id)
        def perfiles = Sesn.findAllByUsuario(obj)
        return [usuario: obj, perfiles: perfiles]
    }
    def infoProyecto = {

        def obj = Proyecto.get(params.id)
        return [proyecto: obj]
    }

    def editar = {
        redirect(action: 'editar' + (params.tipo).capitalize(), params: params)
    }
    def editarEntidad = {
        def obj
        if (params.id) {
            obj = Entidad.get(params.id)
        } else {
            obj = new Entidad()
        }
        return [entidadInstance: obj, tipo: params.tipo]
    }
    def editarSubsecretaria = {
        def obj, crear
        if (params.id) {
            obj = SubSecretaria.get(params.id)
            crear = false
        } else {
            obj = new SubSecretaria()
            obj.entidad = Entidad.get(params.padre)
            crear = true
        }
        return [subSecretariaInstance: obj, tipo: params.tipo, crear: crear]
    }
    def editarUnidad = {
        def obj, crear
        if (params.id) {
            obj = UnidadEjecutora.get(params.id)
            crear = false
        } else {
            obj = new UnidadEjecutora()
            obj.subSecretaria = SubSecretaria.get(params.padre)
            crear = true
        }
        return [unidadEjecutoraInstance: obj, tipo: params.tipo, crear: crear]
    }
    def editarResponsable = {
        def obj, crear
        def perfiles = []
        if (params.id) {
            obj = Usro.get(params.id)
            perfiles = Sesn.findAllByUsuario(obj)
            crear = false
        } else {
            obj = new Usro()
            obj.unidad = UnidadEjecutora.get(params.padre)
            crear = true
        }
        return [usuario: obj, tipo: params.tipo, crear: crear, perfiles: perfiles]
    }

    def saveFromTree_ = {
        def obj
        def err
        switch (params.tipo) {
            case "entidad":
                obj = kerberosService.save(params, Entidad, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
            case "subsecretaria":
                obj = kerberosService.save(params, SubSecretaria, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
            case "unidad":
                obj = kerberosService.save(params, UnidadEjecutora, session.perfil, session.usuario)
                err = (obj.errors.getErrorCount() != 0)
                break;
            case "responsable":
                def paramsPersona = params.persona
                def paramsUsuario = params.usuario

                if (paramsUsuario.usroPassword.trim() != "") {
                    paramsUsuario.usroPassword = paramsUsuario.usroPassword.trim().encodeAsMD5()
                } else {
                    paramsUsuario.remove("usroPassword")
                }
                if (paramsUsuario.autorizacion.trim() != "") {
                    paramsUsuario.autorizacion = paramsUsuario.autorizacion.trim().encodeAsMD5()
                } else {
                    paramsUsuario.remove("autorizacion")
                }

                def persona = kerberosService.save(paramsPersona, Persona, session.perfil, session.usuario)

                paramsPersona.id = persona.id

                if (persona.errors.getErrorCount() != 0) {
                    err = true
                    println "errores persona"
                } else {
                    def usro
                    if (paramsUsuario.id) {
                        usro = Usro.get(paramsUsuario.id)
                    } else {
                        usro = new Usro()
                    }
                    usro.properties = paramsUsuario
                    usro.persona = persona
                    usro = kerberosService.saveObject(usro, Usro, session.perfil, session.usuario, actionName, controllerName, session)
                    if (usro.errors.getErrorCount() != 0) {
                        kerberosService.delete(paramsPersona, Persona, session.perfil, session.usuario)
                        err = true
                        println "ERRORES USRO"
                    } else {
                        def sesns = Sesn.findAllByUsuario(usro)
                        def perfilesId = sesns.perfil.id

                        def perfiles_add = params.perfiles_add.split(",")
                        def perfiles_remove = params.perfiles_remove.split(",")

                        perfiles_add.each { id ->
                            if (id != "" && !perfilesId.contains(id)) {
                                def perfil = Prfl.get(id.toLong())
                                def sesn = new Sesn()
                                sesn.perfil = perfil
                                sesn.usuario = usro

                                sesn = kerberosService.saveObject(sesn, Sesn, session.perfil, session.usuario, actionName, controllerName, session)
                            }
                        }

                        perfiles_remove.each { perfId ->
                            sesns.each { sesn ->
                                if (perfId != "") {
                                    if (sesn.id.toLong() == perfId.toLong()) {

                                        def prm = [:]
                                        prm.id = sesn.id
                                        prm.actionName = actionName
                                        prm.controllerName = controllerName
                                        kerberosService.delete(prm, Sesn, session.perfil, session.usuario)
                                    }
                                }
                            }
                        }

                    }
                }
                break;
        }
        if (err) {
            render("NO")
        } else {
            render("OK")
        }
    }

    def deleteFromTree_ = {
        switch (params.tipo) {
            case "entidad":
                if (kerberosService.delete(params, Entidad, session.perfil, session.usuario)) {
                    render("OK")
                } else {
                    render("NO")
                }
                break;
            case "subsecretaria":
                if (kerberosService.delete(params, SubSecretaria, session.perfil, session.usuario)) {
                    render("OK")
                } else {
                    render("NO")
                }
                break;
            case "unidad":
                if (kerberosService.delete(params, UnidadEjecutora, session.perfil, session.usuario)) {
                    render("OK")
                } else {
                    render("NO")
                }
                break;
        }
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Entidad"], default: "Entidad List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [entidadInstanceList: Entidad.list(params), entidadInstanceTotal: Entidad.count(), title: title, params: params]
    }

    def form = {
        def title
        def entidadInstance

        if (params.source == "create") {
            entidadInstance = new Entidad()
            entidadInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Entidad"], default: "crearEntidad")
        } else if (params.source == "edit") {
            entidadInstance = Entidad.get(params.id)
            if (!entidadInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Entidad"], default: "editarEntidad")
        }

        return [entidadInstance: entidadInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Entidad"], default: "Edit Entidad")
            def entidadInstance = Entidad.get(params.id)
            if (entidadInstance) {
                entidadInstance.properties = params
                if (!entidadInstance.hasErrors() && entidadInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'entidad.label', default: 'Entidad'), entidadInstance.id])}"
                    redirect(action: "show", id: entidadInstance.id)
                }
                else {
                    render(view: "form", model: [entidadInstance: entidadInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Entidad"], default: "Create Entidad")
            def entidadInstance = new Entidad(params)
            if (entidadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'entidad.label', default: 'Entidad'), entidadInstance.id])}"
                redirect(action: "show", id: entidadInstance.id)
            }
            else {
                render(view: "form", model: [entidadInstance: entidadInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def entidadInstance = Entidad.get(params.id)
        if (entidadInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (entidadInstance.version > version) {

                    entidadInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'entidad.label', default: 'Entidad')] as Object[], "Another user has updated this Entidad while you were editing")
                    render(view: "edit", model: [entidadInstance: entidadInstance])
                    return
                }
            }
            entidadInstance.properties = params
            if (!entidadInstance.hasErrors() && entidadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'entidad.label', default: 'Entidad'), entidadInstance.id])}"
                redirect(action: "show", id: entidadInstance.id)
            }
            else {
                render(view: "edit", model: [entidadInstance: entidadInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def entidadInstance = Entidad.get(params.id)
        if (!entidadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "default.show.label", args: ["Entidad"], default: "Show Entidad")

            [entidadInstance: entidadInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def entidadInstance = Entidad.get(params.id)
        if (entidadInstance) {
            try {
                entidadInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'entidad.label', default: 'Entidad'), params.id])}"
            redirect(action: "list")
        }
    }

    def validarAsignaciones = {
        def res = []
        def cn = dbConnectionService.getConnection()
        def sql = "select \n" +
                "        asgn.asgn__id  id, \n" +
                "        mrlg__id       mrlg, \n" +
                "        unej__id       unej, \n" +
                "        asgnplan       plan, \n" +
                "        prsp__id       prsp, \n" +
                "        asgn.anio__id  anio,\n" +
                "        sum(messvlor)  valor,\n" +
                "        asgnplan - sum(messvlor) resta\n" +
                "  from asgn, pras\n" +
                "  where pras.asgn__id = asgn.asgn__id\n" +
                "  group by asgn.asgn__id, mrlg__id, unej__id, asgnplan, prsp__id, asgn.anio__id\n" +
                "  having asgnplan - sum(messvlor) <> 0\n" +
                "  order by resta"

        cn.eachRow(sql) { row ->
            def m = [:]
            m.id = row.id
            m.mrlg = row.mrlg
            m.unej = row.unej
            m.plan = row.plan
            m.prsp = row.prsp
            m.valor = row.valor
            m.resta = row.resta
            m.anio = row.anio
            res.add(m)
        }
        cn.close()
        return [res: res]
    }

}
