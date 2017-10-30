package mies

import mies.seguridad.Usro

import java.text.SimpleDateFormat

class ProyectoController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def kerberosService
    def dbConnectionService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "default.list.label", args: ["Proyecto"], default: "Proyecto List")
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        if (!params.sort) {
            params.sort = "id"
        }
        if (!params.order) {
            params.order = "asc"
        }

        def offset = params.offset?.toInteger() ?: 0
        def busca = params.busca?.trim()
        def desde = params.desde?.trim()
        def hasta = params.hasta?.trim()

        try {
            desde = desde.toDouble()
        } catch (e) {
            desde = ""
        }
        try {
            hasta = hasta.toDouble()
        } catch (e) {
            hasta = ""
        }

        def ifBusca = params.busca && busca != ""
        def ifNotBusca = !params.busca || busca == ""

        def ifDesde = params.desde && desde != ""
        def ifNotDesde = !params.desde || desde == ""

        def ifHasta = params.hasta && hasta != ""
        def ifNotHasta = !params.hasta || hasta == ""

        def c = Proyecto.createCriteria()
        def proyectoInstanceList = c.list {
            if (ifBusca && ifDesde && ifHasta) {
                and {
                    ilike("nombre", "%" + busca + "%")
                    between("monto", desde, hasta)
                }
            } else if (ifBusca && ifDesde && ifNotHasta) {
                and {
                    ilike("nombre", "%" + busca + "%")
                    ge("monto", desde)
                }
            } else if (ifBusca && ifNotDesde && ifHasta) {
                and {
                    ilike("nombre", "%" + busca + "%")
                    le("monto", hasta)
                }
            } else if (ifNotBusca && ifDesde && ifHasta) {
                between("monto", desde, hasta)
            } else if (ifNotBusca && ifNotDesde && ifHasta) {
                le("monto", hasta)
            } else if (ifNotBusca && ifDesde && ifNotHasta) {
                ge("monto", desde)
            } else if (ifBusca && ifNotDesde && ifNotHasta) {
                ilike("nombre", "%" + busca + "%")
            }

            maxResults(params.max)
            firstResult offset
            order(params.sort, params.order)
        }

        c = Proyecto.createCriteria()
        def lista = c.list {
            if (ifBusca && ifDesde && ifHasta) {
                and {
                    ilike("nombre", "%" + busca + "%")
                    between("monto", desde, hasta)
                }
            } else if (ifBusca && ifDesde && ifNotHasta) {
                and {
                    ilike("nombre", "%" + busca + "%")
                    ge("monto", desde)
                }
            } else if (ifBusca && ifNotDesde && ifHasta) {
                and {
                    ilike("nombre", "%" + busca + "%")
                    le("monto", hasta)
                }
            } else if (ifNotBusca && ifDesde && ifHasta) {
                between("monto", desde, hasta)
            } else if (ifNotBusca && ifNotDesde && ifHasta) {
                le("monto", hasta)
            } else if (ifNotBusca && ifDesde && ifNotHasta) {
                ge("monto", desde)
            } else if (ifBusca && ifNotDesde && ifNotHasta) {
                ilike("nombre", "%" + busca + "%")
            }
        }

        def proyectoInstanceTotal = lista.size()

        [proyectoInstanceList: proyectoInstanceList, proyectoInstanceTotal: proyectoInstanceTotal, title: title, params: params]
    }

    def form = {
        def title
        def proyectoInstance

        if (params.source == "create") {
            proyectoInstance = new Proyecto()
            proyectoInstance.properties = params
            title = g.message(code: "default.create.label", args: ["Proyecto"], default: "crearProyecto")
        } else if (params.source == "edit") {
            proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Proyecto"], default: "editarProyecto")
        }

        return [proyectoInstance: proyectoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title

        params.mes = (params.mes).toInteger()

        if (params.id) {
            title = g.message(code: "default.edit.label", args: ["Proyecto"], default: "Edit Proyecto")
            def proyectoInstance = Proyecto.get(params.id)
            if (proyectoInstance) {
                proyectoInstance.properties = params
                if (!proyectoInstance.hasErrors() && proyectoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyectoInstance.id])}"
                    redirect(action: "show", id: proyectoInstance.id)
                }
                else {
                    render(view: "form", model: [proyectoInstance: proyectoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "default.create.label", args: ["Proyecto"], default: "Create Proyecto")
            def proyectoInstance = new Proyecto(params)
            if (proyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyectoInstance.id])}"
                redirect(action: "show", id: proyectoInstance.id)
            }
            else {
                render(view: "form", model: [proyectoInstance: proyectoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def proyectoInstance = Proyecto.get(params.id)
        if (proyectoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (proyectoInstance.version > version) {

                    proyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'proyecto.label', default: 'Proyecto')] as Object[], "Another user has updated this Proyecto while you were editing")
                    render(view: "edit", model: [proyectoInstance: proyectoInstance])
                    return
                }
            }
            proyectoInstance.properties = params
            if (!proyectoInstance.hasErrors() && proyectoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyectoInstance.id])}"
                redirect(action: "show", id: proyectoInstance.id)
            }
            else {
                render(view: "edit", model: [proyectoInstance: proyectoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
            redirect(action: "list")
        }
    }


    def listaAprobarProyecto = {
        println "lista " + params
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        def proyectos = []


        if (params.parametro && params.parametro.trim().size() > 0) {

            proyectos += Proyecto.findAllByNombreIlike("%${params.parametro}%")
            proyectos += Proyecto.findAllByCodigoProyectoIlike("%${params.parametro}%")
        } else {
            proyectos = Proyecto.list(params)
        }


        [proyectos: proyectos, total: proyectos.count(), parametro: params.parametro]
    }


    def aprobarProyecto = {
        if (request.method == 'POST') {
            println "params " + params
            if (session.usuario.autorizacion == params.ssap.encodeAsMD5()) {
                def proy = Proyecto.get(params.proy)
                proy.aprobado = "a"
                kerberosService.saveObject(proy, Proyecto, session.perfil, session.usuario, "aprobarProyecto", "proyecto", session)
                render "ok"
            } else {
                render "no"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }


    def estadoProyecto = {
        def proyectoInstance = Proyecto.get(params.id)

        /*
        TODO: ESTA UTILIZANDO EL PROCESO 1 SIEMPRE!!!!
        */
        def proceso = Proceso.get(1)
        def pasos = Paso.findAllByProceso(proceso, [sort: "orden"])

        def c2 = ResponsableProyecto.createCriteria()
        def resp = c2.list {
            eq("proyecto", proyectoInstance)
            tipo {
                eq("codigo", "I")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }
        def responsable = "No se ha asignado"
        if (resp.size() > 0) {
            responsable = resp[0].responsable.persona.nombre + " " + resp[0].responsable.persona.apellido
        }

        def tabla = "<table class='ui-widget-content ui-corner-all' style='margin-top:15px;' cellpadding='10'>"
        tabla += "<thead class='ui-widget-header ui-corner-top'>"

        tabla += "<tr>"
        tabla += "<th colspan='3'>"
        tabla += "Estado del proyecto<br/>"
        tabla += "Responsable: " + responsable
        tabla += "</th>"
        tabla += "</tr>"

        tabla += "<tr>"

        tabla += "<th>"
        tabla += "Paso"
        tabla += "</th>"

        tabla += "<th colspan='2'>"
        tabla += "Estado (por tabla)"
        tabla += "</th>"

        tabla += "</tr>"

        tabla += "</thead>"
        tabla += "<tbody>"

        pasos.eachWithIndex { paso, j ->
            def tablas = (paso.tabla).split(",")
            def tablasEsp = (paso.tablaEsp).split(",")
            tabla += "<tr class='even'>"

            tabla += "<td class='" + (j % 2 == 0 ? "even" : "odd") + "' rowspan='" + (tablas.size()) + "'>"
            tabla += paso.orden + ".- " + paso.nombre
            tabla += "</td>"

            tablas.eachWithIndex { tbl, i ->
                if (i > 0) {
                    tabla += "<tr class='" + (i % 2 == 0 ? 'even' : 'odd') + "'>"
                }
                tabla += "<td>"
                tabla += tablasEsp[i]
                tabla += "</td>"

                def domain = grailsApplication.domainClasses.find {it.name == tbl}
                def clazz = domain.clazz
                def loader = clazz.getClassLoader()
                def nomb = clazz.getName()
                def sname = clazz.getSimpleName()
                def clase = loader.loadClass(nomb)
                def lista

                if (sname != "Proyecto") {
                    lista = clase.findAllByProyecto(proyectoInstance)
                } else {
                    lista = clase.findAllById(proyectoInstance.id)
                }

                def n = "5"

                tabla += "<td>"
                if (lista.size() > 0) {
                    tabla += "<img src='" + resource(dir: 'images', file: "ok" + n + ".png") + "' alt='OK' />"
                } else {
                    tabla += "<img src='" + resource(dir: 'images', file: "cancel" + n + ".png") + "' alt='NO' />"
                }
                tabla += "</td>"
                if (i == 0) {
                    tabla += "</tr>"
                }
            }
        }
        tabla += "</tbody>"
        tabla += "</table>"

        return [tabla: tabla]
    }

    def eliminarTodo(elems, clase) {
//        println "eliminando " + clase.name
        def cont = 0
        def b = true
        elems.each {
            def p = [:]
            p.id = it.id.toLong()
            p.controllerName = controllerName
            p.actionName = "deleteProyecto>" + clase.name
            if (!kerberosService.delete(p, clase, session.perfil, session.usuario)) {
                b = false
            } else {
                cont++
            }
        }
//        println "eliminados " + cont + " de " + elems.size() + " " + clase
        return b
    }

    def eliminarTodoProyecto(proyecto, clase) {
        def elems = clase.findAllByProyecto(proyecto)
        return eliminarTodo(elems, clase)
    }

    def deleteProyecto = {
        def proyecto = Proyecto.get(params.id)
        def b = true

        try {
            MarcoLogico.findAllByProyecto(proyecto).each { ml ->
//                println ml.id
                def metas = Meta.findAllByMarcoLogico(ml)
                def asignaciones = Asignacion.findAllByMarcoLogico(ml)
                def cronograma = Cronograma.findAllByMarcoLogico(ml)
//                println cronograma
                def indicadores = Indicador.findAllByMarcoLogico(ml)
                def supuestos = Supuesto.findAllByMarcoLogico(ml)
                asignaciones.each { asg ->
                    def programacionAsignacion = ProgramacionAsignacion.findAllByAsignacion(asg)
                    b = eliminarTodo(programacionAsignacion, ProgramacionAsignacion)
//                    def ejecuciones = Ejecucion.findAllByAsignacion(asg)
//                    b = eliminarTodo(ejecuciones, "Ejecucion")
                    def obras = Obra.findAllByAsignacion(asg)
                    b = eliminarTodo(obras, Obra)
                }
                metas.each { mt ->
                    def avances = Avance.findAllByMeta(mt)
                    b = eliminarTodo(avances, Avance)
                }
                indicadores.each { id ->
                    def medioVerificacion = MedioVerificacion.findAllByIndicador(id)
                    b = eliminarTodo(medioVerificacion, MedioVerificacion)
                }
                b = eliminarTodo(metas, Meta)
                b = eliminarTodo(asignaciones, Asignacion)
                b = eliminarTodo(cronograma, Cronograma)
                b = eliminarTodo(indicadores, Indicador)
                b = eliminarTodo(supuestos, Supuesto)
            }
            ModificacionProyecto.findAllByProyecto(proyecto).each { mp ->
                def modificables = Modificables.findAllByModificacion(mp)
                def modificacionAsignacion = ModificacionAsignacion.findAllByModificacionProyecto(mp)
                b = eliminarTodo(modificables, Modificables)
                b = eliminarTodo(modificacionAsignacion, ModificacionAsignacion)

                b = eliminarTodo([mp], ModificacionProyecto)
            }
            ResponsableProyecto.findAllByProyecto(proyecto).each { rp ->
                def informes = Informe.findAllByResponsableProyecto(rp)
                b = eliminarTodo(informes, Informe)

                b = eliminarTodo([rp], ResponsableProyecto)
            }

//            def ml2 = MarcoLogico.findAllByProyectoAndPadreModIsNotNull(proyecto)
//            b = eliminarTodo(ml2, MarcoLogico)
//            def ml1 = MarcoLogico.findAllByProyectoAndMarcoLogicoIsNotNull(proyecto)
//            b = eliminarTodo(ml1, MarcoLogico)
//            def ml3 = MarcoLogico.findAllByProyecto(proyecto)
//            b = eliminarTodo(ml3, MarcoLogico)

//            println "eliminando marco logico"
            def cn = dbConnectionService.getConnection()
            def sql = "update mrlg set mrlgpdre = null where proy__id =" + proyecto.id
            cn.execute(sql)
            sql = "update mrlg set mrlgpdmd = null where proy__id =" + proyecto.id
            cn.execute(sql)
            sql = "update mrlg set mrlghijo = null where proy__id =" + proyecto.id
            cn.execute(sql)
            sql = "delete from mrlg where proy__id =" + proyecto.id
            cn.execute(sql)
            cn.close()
//            println "eliminados marcos logicos (?)"

            b = eliminarTodoProyecto(proyecto, Adquisiciones)
//            b = eliminarTodoProyecto(proyecto, BeneficioSenplades)
            b = eliminarTodoProyecto(proyecto, Documento)
            b = eliminarTodoProyecto(proyecto, EntidadesProyecto)
//            b = eliminarTodoProyecto(proyecto, EstudiosTecnicos)
            b = eliminarTodoProyecto(proyecto, Financiamiento)
//            b = eliminarTodoProyecto(proyecto, GrupoDeAtencion)
            b = eliminarTodoProyecto(proyecto, IndicadoresSenplades)
//            b = eliminarTodoProyecto(proyecto, Intervencion)
//        b = eliminarTodoProyecto(proyecto, MarcoLogico)
            b = eliminarTodoProyecto(proyecto, MetaBuenVivirProyecto)
//        b = eliminarTodoProyecto(proyecto, ModificacionProyecto)
//            b = eliminarTodoProyecto(proyecto, ObjetivoEstrategico)
            b = eliminarTodoProyecto(proyecto, PoliticasAgendaProyecto)
            b = eliminarTodoProyecto(proyecto, PoliticasProyecto)
//        b = eliminarTodoProyecto(proyecto, ResponsableProyecto)

            b = eliminarTodo([proyecto], Proyecto)

            if (b) {
                flash.message = "Proyecto y datos asociados eliminados exitosamente"
                redirect(action: 'list')
            } else {
//                render "ERROR EN ALGUN LADO!!!"
                flash.message = "Ha ocurrido un error grave"
                redirect(action: 'show', id: proyecto.id)
            }
        } catch (Exception e) {
//            println "ERROR!!!! " + e.printStackTrace()
//            render("ERROR!!!!!" + e.printStackTrace())
            flash.message = "Ha ocurrido un error grave"
            redirect(action: 'show', id: proyecto.id)
        }
//        render "????"
        flash.message = "Ha ocurrido un error grave"
        redirect(action: 'show', id: proyecto.id)
    }

    def validarAutorizacion = {
        if (session.usuario.id.toLong() == Usro.findByUsroLogin("ruth").id.toLong()) {
            if (session.usuario.autorizacion == params.auth.encodeAsMD5()) {
                render "OK"
            } else {
                render "NO_2"
            }
        } else {
            render "NO_1"
        }
    }

    def show = {
        def proyectoInstance = Proyecto.get(params.id)
        if (!proyectoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
            redirect(action: "list")
        }
        else {
            def title = g.message(code: "default.show.label", args: ["Proyecto"], default: "Show Proyecto")

            def metasProyecto = MetaBuenVivirProyecto.findAllByProyecto(proyectoInstance)
            def politicas = PoliticasProyecto.findAllByProyecto(proyectoInstance)
            def financiamientos = Financiamiento.findAllByProyecto(proyectoInstance)
            def plas = PoliticasAgendaProyecto.findAllByProyecto(proyectoInstance)

            def entidades = EntidadesProyecto.findAllByProyecto(proyectoInstance)

            if (financiamientos.size() > 0) {
                financiamientos = financiamientos.sort { it?.anio?.anio }
            }
            [proyectoInstance: proyectoInstance, title: title, metas: metasProyecto, politicas: politicas, financiamientos: financiamientos, plas: plas, entidades: entidades]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def proyectoInstance = Proyecto.get(params.id)
        if (proyectoInstance) {
            try {
                proyectoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.id])}"
            redirect(action: "list")
        }
    }

    def loadCombo = {
        println "aaa "+params
        def str = ""
        switch (params.tipo) {
            case "politica":

                if (params.padre != null && params.padre != "null") {
                    def objetivo = ObjetivoBuenVivir.get(params.padre)
                    def politicas = PoliticaBuenVivir.findAllByObjetivo(objetivo)

                    str += "<strong>Pol&iacute;tica:</strong>"
                    str += g.select(from: politicas, name: "politica", id: "politica", optionKey: "id", style: "width: 250px;", noSelection: ['null': '..-- Seleccione una política --..'])

                    str += '<script type="text/javascript">'
                    str += '$("#politica").selectmenu({'
                    str += 'width: 250'
                    str += '}).change(function() {'
                    str += 'var pol = $(this).val();'

                    str += '$.ajax({'
                    str += 'type: "POST",'
                    str += 'url: "' + g.createLink(action: ' loadCombo ') + '",'
                    str += 'data: {'
                    str += 'tipo: "meta",'
                    str += 'padre: pol'
                    str += '},'
                    str += 'success: function(msg) {'
                    str += '$("#mets").html(msg).show();'
                    str += '$("#btnAdd").show();'
                    str += '}'
                    str += '});'

                    str += '});'
                    str += '</script>'
                }
                break;
            case "meta":
                if (params.padre != null && params.padre != "null") {
                    def politica = PoliticaBuenVivir.get(params.padre)
                    def metas = MetaBuenVivir.findAllByPolitica(politica)

                    str += "<strong>Meta:</strong>"
                    str += g.select(from: metas, name: "meta", id: "meta", optionKey: "id", style: "width: 250px;", noSelection: ['null': '..-- Seleccione una meta --..'])

                    str += '<script type="text/javascript">'
                    str += '$("#meta").selectmenu({'
                    str += 'width: 250'
                    str += '});'
                    str += '</script>'
                }
                break;
        }

        render(str)
    }

    def formProyecto = {
        println "params: $params"
        def proyecto = Proyecto.get(params.id)
        [proyecto: proyecto]
    }

    def validarProyecto()  {
        println "params validarProyecto: $params"
        def proyecto = Proyecto.get(params.id)

        if (params.mes) {
            params.mes = (params.mes).toInteger()
        }
        if (!params.id) {
            println "CREA"
            proyecto = new Proyecto(params)
        } else {
            println "edita proyecto"
            proyecto = Proyecto.get(params.id)
        }

        def tx_fcha
        def fcha
        if(params.fechaInicioPlanificada.size() > 20){
            tx_fcha = "${params.fechaInicioPlanificada_day}-${params.fechaInicioPlanificada_month}-${params.fechaInicioPlanificada_year}"
            fcha = new Date().parse("dd-MM-yyyy", tx_fcha)
            proyecto.fechaInicioPlanificada = fcha
        }
        if(params.fechaFinPlanificada.size() > 20){
            tx_fcha = "${params.fechaFinPlanificada_day}-${params.fechaFinPlanificada_month}-${params.fechaFinPlanificada_year}"
            fcha = new Date().parse("dd-MM-yyyy", tx_fcha)
            proyecto.fechaFinPlanificada = fcha
        }
        if(params.fechaInicio.size() > 20){
            tx_fcha = "${params.fechaInicio_day}-${params.fechaInicio_month}-${params.fechaInicio_year}"
            fcha = new Date().parse("dd-MM-yyyy", tx_fcha)
            proyecto.fechaInicio = fcha
        }
        if(params.fechaFin.size() > 20){
            tx_fcha = "${params.fechaFin_day}-${params.fechaFin_month}-${params.fechaFin_year}"
            fcha = new Date().parse("dd-MM-yyyy", tx_fcha)
            proyecto.fechaFin = fcha
        }

        params.remove('fechaInicioPlanificada')
        params.remove('fechaFinPlanificada')
        params.remove('fechaInicio')
        params.remove('fechaFin')
        proyecto.properties = params

        if (!proyecto.hasErrors() && proyecto.save(flush: true)) {
            flash.message = "Proyecto actualizado correctamente"
            redirect(action: "formProyecto", id: proyecto.id)
        }
        else {
            render(proyecto.errors)
        }
    }

    def nuevoProyectoFlow = {
        inicio {
            action {

                session.proyecto = null
                session.unidad = null

                flow.politicasProyecto = []
                flow.financiamiento = []
                flow.politicasAgenda = []

                flow.type = "create"

                def items = []
                items[0] = [:]
                items[0].link = ["controller": "proyecto", "action": "nuevoProyecto", "event": "click", "params": ["evento": "proyecto"]]
                items[0].text = "Proyecto"
                items[0].evento = "proyecto"

                items[1] = [:]
                items[1].link = ["controller": "proyecto", "action": "nuevoProyecto", "event": "click", "params": ["evento": "buenVivir"]]
                items[1].text = "Objetivos del Buen Vivir"
                items[1].evento = "buenVivir"

                items[2] = [:]
                items[2].link = ["controller": "proyecto", "action": "nuevoProyecto", "event": "click", "params": ["evento": "politicasAgenda"]]
                items[2].text = "Políticas Agenda Social"
                items[2].evento = "politicasAgenda"

                items[3] = [:]
                items[3].link = ["controller": "proyecto", "action": "nuevoProyecto", "event": "click", "params": ["evento": "politicasProyecto"]]
                items[3].text = "Políticas MIES"
                items[3].evento = "politicasProyecto"

                flow.items = items
                flow.links = false
                flow.metasProyecto = []

                if (params.id) {
                    flow.type = "edit"
                    flow.proyecto = Proyecto.get(params.id)
                    flow.politicasProyecto = []
                    (PoliticasProyecto.findAllByProyecto(flow.proyecto).politica.id).each {
                        flow.politicasProyecto.add(it.toLong())
                    }
                    flow.financiamientos = Financiamiento.findAllByProyecto(flow.proyecto)
                    flow.metasProyecto = MetaBuenVivirProyecto.findAllByProyecto(flow.proyecto)
                    (PoliticasAgendaProyecto.findAllByProyecto(flow.proyecto).politicaAgendaSocial.id).each {
                        flow.politicasAgenda.add(it.toLong())
                    }
//                    NumberFormat nf = NumberFormat.getInstance(Locale.ENGLISH)
//                    def m = nf.format(flow.proyecto.monto)
//                    println m
                    flow.links = true
                }//if params.id
                yes()
            } //inicio > action
            on("yes") { println "yes " + flow.proyecto }.to("proyecto")
        } //inicio

        proyecto {
            on("validarProyecto") {
                flow.evento = params.goto
//                println params
                if (params.mes) {
                    params.mes = (params.mes).toInteger()
                }
                if (flow.type == "create") {
                    println "CREA"
                    flow.proyecto = new Proyecto(params)
                    flow.type = "edit"
                } else {
                    println "EDITA"
                    println "PARAMS"
                    println params
                    flow.proyecto.properties = params
                }
//                println flow.proyecto.objetivoGobiernoResultado
                println "WTF"
            }.to("validarProyecto")
//            on("lista").to("lista")
            on("salir").to("salir")
            on("click") {flow.evento = params.evento}.to "redirect"
        } //proyecto

        validarProyecto {
            action {
                if (!flow.proyecto.validate()) {
                    if (flow.proyecto.errors.getErrorCount() != 0) {
                        flow.proyecto.errors.getAllErrors().each {
                            println "erroresDeInsercion !!! " + it.field + " " + it.defaultMessage
                        }
                        no()
                    } else {
                        println "WTF 1"
                        kerberosService.saveObject(flow.proyecto, /*MetaBuenVivir*/ Proyecto, session.perfil, session.usuario, "nuevoProyectoFlow>validarProyecto", controllerName, session)
                        yes()
                    }
                } else {
                    println "WTF 2"
                    println flow.proyecto.monto
                    println session

                    flow.proyecto.save(flush: true)

//                    flow.proyecto = kerberosService.saveObject(flow.proyecto, /*MetaBuenVivir*/ Proyecto, session.perfil, session.usuario, "nuevoProyectoFlow>validarProyecto", controllerName, session)
                    yes()
                }
            } //save proyecto > action
            on("yes").to("redirect")
            on("no").to("proyecto")
        } //save proyecto

        buenVivir {
            on("saveMetas") {

                flow.evento = params.goto
//                println ".....Save metas....."
//                println params
                if (params.meta?.class == java.lang.String) {
                    params.meta = [params.meta]
                }

                params.meta.each { meta ->
                    def mtp = new MetaBuenVivirProyecto()
                    mtp.metaBuenVivir = MetaBuenVivir.get(meta)
                    mtp.proyecto = flow.proyecto

//                    println "\n"
//                    println mtp.metaBuenVivir
//                    println mtp.proyecto
//                    println "\n"

                    mtp = kerberosService.saveObject(mtp, MetaBuenVivirProyecto, session.perfil, session.usuario, actionName, controllerName, session)
                    flow.metasProyecto.add(mtp)
                }

                def parts = params.deleted.split(",")
                def mets = []
                if (parts.size() > 0) {
                    parts.each { pa ->
                        mets.add(MetaBuenVivirProyecto.get(pa))
                    }
                }

//                println "METS"
//                println mets
//                println "FLOW"
//                println flow.metasProyecto

                flow.metasProyecto = flow.metasProyecto - mets
                flow.metasProyectoDelete = mets

                println "DELEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEETE!!!"
                println flow.metasProyectoDelete
                if (flow.metasProyectoDelete?.size() > 0) {
                    flow.metasProyectoDelete.each {
                        if (it && it != null && it != "null") {
                            def par = ["id": it.id, "actionName": actionName, "controllerName": controllerName]
                            kerberosService.delete(par, MetaBuenVivirProyecto, session.perfil, session.usuario)
                        }
                    }
                }
            }.to("redirect")//.to("politicasAgenda")
            on("salir").to("salir")
//            on("datos").to("proyecto")
            on("click") {flow.evento = params.evento}.to "redirect"
        }//buen vivir

        politicasAgenda {
            on("savePoliticasAgenda") {
                println ".....Save politicas agenda....."
                flow.evento = params.goto

                flow.politicasAgendaInsert = []
                flow.politicasAgendaDelete = []
                if (params.politica) {
                    params.politica.each {
                        def cont = false
                        flow.politicasAgenda.each { pa ->
                            if (pa == it.toLong()) {
                                cont = true
                            }
                        }
                        if (!cont) {
                            flow.politicasAgenda.add(it.toInteger())
                            flow.politicasAgendaInsert.add(it.toInteger())
                        }
                    }
                    def rem = []
                    if (flow.politicasAgenda.size > 0) {
                        flow.politicasAgenda.eachWithIndex { obj, i ->
                            if (!params.politica.toList().contains(obj.toString())) {
                                println "1"
                                rem.add(i)
                                println "2"
                                flow.politicasAgendaDelete.add(obj)
                                println "3"
                            }
                        }
                    }
                    def q = 0
                    if (rem.size() > 0) {
                        rem.each {
                            flow.politicasAgenda.remove(it - q)
                            q++
                        }
                    }

                }
            }.to("checkpoint0")
//            on("buenVivir").to("buenVivir")
            on("salir").to("salir")
            on("click") {flow.evento = params.evento}.to "redirect"
        }

        checkpoint0 {
            action {
                flow.politicasAgendaInsert.each {
                    def pp = new PoliticasAgendaProyecto()
                    pp.proyecto = flow.proyecto
                    pp.politicaAgendaSocial = PoliticaAgendaSocial.get(it)
                    kerberosService.saveObject(pp, PoliticasAgendaProyecto, session.perfil, session.usuario, actionName, controllerName, session)
                }
                flow.politicasAgendaInsert = []
                flow.politicasAgendaDelete.each {
//                    println it
                    def pp = PoliticasAgendaProyecto.findByProyectoAndPoliticaAgendaSocial(flow.proyecto, PoliticaAgendaSocial.get(it))
                    def par = ["id": pp.id, "actionName": actionName, "controllerName": controllerName]
//                    def pp = ["id": it]
                    kerberosService.delete(par, PoliticasAgendaProyecto, session.perfil, session.usuario)
                }
                flow.politicasAgendaDelete = []
                yes()
            } //checkpoint0 > action
            on("yes").to("redirect")
        } //checkpoint0

//        cargarPoliticas {
//            action {
//                yes()
//            }//cargar politicas > action
//            on("yes").to "politicasProyecto"
//        } //cargar politicas

        politicasProyecto {
            on("savePoliticas") {
                flow.evento = params.goto

                flow.politicasInsert = []
                flow.politicasDelete = []
                if (params.politica) {
                    params.politica.each {

                        def cont = false
                        flow.politicasProyecto.each { pa ->
                            if (pa == it.toLong()) {
                                cont = true
                            }
                        }
                        if (!cont) {
                            flow.politicasProyecto.add(it.toInteger())
                            flow.politicasInsert.add(it.toInteger())
                        }
                    }
                    def rem = []
                    if (flow.politicasProyecto.size > 0) {
                        flow.politicasProyecto.eachWithIndex { obj, i ->
                            if (!params.politica.toList().contains(obj.toString())) {
                                println "1"
                                rem.add(i)
                                println "2"
                                flow.politicasDelete.add(obj)
                                println "3"
                            }
                        }
                    }
                    def q = 0
                    if (rem.size() > 0) {
                        rem.each {
                            flow.politicasProyecto.remove(it - q)
                            q++
                        }
                    }

                }
            }.to("checkpoint1")
//            on("lista").to("lista")
            on("salir").to("salir")
            on("plas").to("politicasAgenda")
            on("click") {flow.evento = params.evento}.to "redirect"
        } //politicas proyecto

        checkpoint1 {
            action {
//                flow.proyecto = kerberosService.saveObject(flow.proyecto, Proyecto, session.perfil, session.usuario, actionName, controllerName, session)

                flow.financiamientos.each {
                    kerberosService.saveObject(it, Financiamiento, session.perfil, session.usuario, actionName, controllerName, session)
                }
                flow.politicasInsert.each {
                    def pp = new PoliticasProyecto()
                    pp.proyecto = flow.proyecto
                    pp.politica = Politica.get(it)
                    kerberosService.saveObject(pp, PoliticasProyecto, session.perfil, session.usuario, actionName, controllerName, session)
                }
                flow.politicasInsert = []
                println "politicas Delete " + flow.politicasDelete
                flow.politicasDelete.each {
//                    println it
                    def pp = PoliticasProyecto.findByProyectoAndPolitica(flow.proyecto, Politica.get(it))
                    def par = ["id": pp.id, "actionName": actionName, "controllerName": controllerName]
//                    def pp = ["id": it]
                    kerberosService.delete(par, PoliticasProyecto, session.perfil, session.usuario)
                }
                flow.politicasDelete = []
                println "financiamientos Delete " + flow.financiamientosDelete
                flow.financiamientosDelete.each { pol ->
                    if (pol && pol.id) {
                        def par = ["id": pol.id, "actionName": actionName, "controllerName": controllerName]
                        kerberosService.delete(par, Financiamiento, session.perfil, session.usuario)
                    }
                }

                yes()
            } //checkpoint1 > action
            on("yes").to("redirect")
        } //checkpoint1

        redirect {
            action {
                yes()
            }
            on('yes').to { flow.evento }
        }

        salir {
//            redirect(controller: "proyecto", action: "semplades", id: flow.proyecto.id)
            redirect(controller: "proyecto", action: "show", id: flow.proyecto.id)
        }

        lista {
            redirect(controller: "proyecto", action: "list")
        }

    } //nuevo proyecto flow

    def editar = {

        def proyecto = Proyecto.get(params.proyecto)

        def documentoInstance

        if (params.id) {
            documentoInstance = Documento.get(params.id)
        }

        return [proyecto: proyecto, documentoInstance: documentoInstance]
    }

    def verDoc = {
        def documentoInstance = Documento.get(params.id)
        if (!documentoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "documento.show", default: "Show Documento")

            [documentoInstance: documentoInstance, title: title, proyecto: documentoInstance.proyecto]
        }
    }

    def documentos = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.sort) {
            params.sort = "id"
        }
        if (!params.order) {
            params.order = "asc"
        }
        def offset = params.offset?.toInteger() ?: 0
        def proyecto = Proyecto.get(params.id)
        def busca = params.busca?.trim()
        def c = Documento.createCriteria()
        def documentoInstanceList = c.list {
            eq("proyecto", proyecto)
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
            eq("proyecto", proyecto)
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

        return [proyecto: proyecto, documentoInstanceList: documentoInstanceList, documentoInstanceTotal: documentoInstanceTotal, params: params]
    }

    def uploadDoc = {

//        println "UPLOADING"
//        println params
//        println "\n\n\n"

        def proyecto = Proyecto.get(params.id)

        def entidad
        if (proyecto.unidadEjecutora) {
            entidad = proyecto.unidadEjecutora.nombre
        } else {
            entidad = "ND"
        }

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

            fileName = fileName + "_proyecto_" + proyecto.id + "." + ext

            def pathFile = path + File.separatorChar + fileName
            def src = new File(pathFile)

            if (src.exists()) {
                flash.message = 'Ya existe un archivo con ese nombre. Por favor cambielo o elimine el otro archivo primero.'
                flash.estado = "error"
                flash.icon = "alert"
            } else {
                def doc = new Documento()
                doc.proyecto = proyecto
                doc.grupoProcesos = GrupoProcesos.get(params.grupoProcesos.id)
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
                doc.proyecto = proyecto
                doc.grupoProcesos = GrupoProcesos.get(params.grupoProcesos.id)
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
        redirect(action: "documentos", params: [id: proyecto.id])
    }
    def deleteDoc = {
        println "DELETE DOC"
        println params
        def proyecto = Proyecto.get(params.proyecto)

        def entidad
        if (proyecto.unidadEjecutora) {
            entidad = proyecto.unidadEjecutora.nombre
        } else {
            entidad = "ND"
        }
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

        redirect(action: "documentos", params: [id: proyecto.id])
    }
    def downloadDoc = {
        def doc = Documento.get(params.id)
        def archivo = doc.documento
        def proyecto = Proyecto.get(params.proyecto)
        def entidad
        if (proyecto.unidadEjecutora) {
            entidad = proyecto.unidadEjecutora.nombre
        } else {
            entidad = "ND"
        }
        def path = servletContext.getRealPath("/") + "archivos/" + entidad

        def pathFile = path + File.separatorChar + archivo
        def src = new File(pathFile)
        if (src.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${src.getName()}")

            response.outputStream << src.newInputStream()
        } else {
            redirect(action: "fileNotFound", params: ['archivo': archivo, 'id': proyecto.id])
        }
/*
def file = new File(params.fileDir)
response.setContentType("application/octet-stream")
response.setHeader("Content-disposition", "attachment;filename=${file.getName()}")

response.outputStream << file.newInputStream()
 */
    }

    def fileNotFound = {
        return [archivo: params.archivo, id: params.id]
    }

    def responsable = {
        def proyecto = Proyecto.get(params.id)

        def unidadProyecto = proyecto.unidadEjecutora
        def plantaCentral = UnidadEjecutora.findByCodigo("9999")

        def responsablesEjecucion = Usro.findAllByUnidad(unidadProyecto)
        def responsablesIngreso = Usro.findAllByUnidad(unidadProyecto)
        def responsablesSeguimiento = Usro.findAllByUnidad(plantaCentral)

        def c = ResponsableProyecto.createCriteria()
        def results = c.list {
            eq("proyecto", proyecto)
            tipo {
                eq("codigo", "E")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        def c2 = ResponsableProyecto.createCriteria()
        def results2 = c2.list {
            eq("proyecto", proyecto)
            tipo {
                eq("codigo", "I")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        def c3 = ResponsableProyecto.createCriteria()
        def results3 = c3.list {
            eq("proyecto", proyecto)
            tipo {
                eq("codigo", "S")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        return [proyecto: proyecto, responsableEjecucion: results[0], responsableIngreso: results2[0], responsableSeguimiento: results3[0], responsablesEjecucion: responsablesEjecucion, responsablesIngreso: responsablesIngreso, responsablesSeguimiento: responsablesSeguimiento]
    } //responsable

    def responsables = {
        def proyecto = Proyecto.get(params.id)

        def c = ResponsableProyecto.createCriteria()
        def results = c.list {
            eq("proyecto", proyecto)
            tipo {
                eq("codigo", "E")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        def c2 = ResponsableProyecto.createCriteria()
        def results2 = c2.list {
            eq("proyecto", proyecto)
            tipo {
                eq("codigo", "I")
            }
            and {
                le("desde", new Date())
                ge("hasta", new Date())
            }
        }

        return [proyecto: proyecto, responsableEjecucion: results[0], responsableIngreso: results2[0]]
    } //responsable

    def saveResponsable = {
        println "SAVE RESPONSABLE"
        params.each {
            println it
        }
        def err = false
        if (params.ingreso) {
            def proyecto = Proyecto.get(params.ingreso.proyecto.id)

            def desde = params.ingreso.desde
            def hasta = params.ingreso.hasta

            def c = ResponsableProyecto.createCriteria()
            def results = c.list {
                eq("proyecto", proyecto)
                tipo {
                    eq("codigo", "I")
                }
                and {
                    ge("desde", Date.parse("dd-MM-yyyy", desde))
                    le("hasta", Date.parse("dd-MM-yyyy", hasta))
                }
            }

            if (results.size() > 0) {
                println results
                render("!!")
            } else {
                if (params.ingreso.tipo == "update") {
                    def ant = ResponsableProyecto.get(params.ingreso.id)
                    ant.hasta = Date.parse("dd-MM-yyyy", desde)
                    ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsableIngreso", "proyecto", session)
                    err = ant.errors.getErrorCount() != 0
                }
                params.ingreso.id = null
                params.ingreso.tipo = TipoResponsable.findByCodigo("I")
                def obj = kerberosService.save(params.ingreso, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            }
        }
        if (params.ejecucion) {
            def proyecto = Proyecto.get(params.ejecucion.proyecto.id)

            def desde = params.ejecucion.desde
            def hasta = params.ejecucion.hasta

            def c = ResponsableProyecto.createCriteria()
            def results = c.list {
                eq("proyecto", proyecto)
                tipo {
                    eq("codigo", "E")
                }
                and {
                    ge("desde", Date.parse("dd-MM-yyyy", desde))
                    le("hasta", Date.parse("dd-MM-yyyy", hasta))
                }
            }

            if (results.size() > 0) {
                println results
                render("!!")
            } else {
                if (params.ejecucion.tipo == "update") {
                    def ant = ResponsableProyecto.get(params.ejecucion.id)
                    ant.hasta = Date.parse("dd-MM-yyyy", desde)
                    ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsableEjecucion", "proyecto", session)
                    err = ant.errors.getErrorCount() != 0
                }
                params.ejecucion.id = null
                params.ejecucion.tipo = TipoResponsable.findByCodigo("E")
                def obj = kerberosService.save(params.ejecucion, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            }
        }
        if (params.seguimiento) {
            def proyecto = Proyecto.get(params.seguimiento.proyecto.id)

            def desde = params.seguimiento.desde
            def hasta = params.seguimiento.hasta

            def c = ResponsableProyecto.createCriteria()
            def results = c.list {
                eq("proyecto", proyecto)
                tipo {
                    eq("codigo", "S")
                }
                and {
                    ge("desde", Date.parse("dd-MM-yyyy", desde))
                    le("hasta", Date.parse("dd-MM-yyyy", hasta))
                }
            }

            if (results.size() > 0) {
                println results
                render("!!")
            } else {
                if (params.seguimiento.tipo == "update") {
                    def ant = ResponsableProyecto.get(params.seguimiento.id)
                    ant.hasta = Date.parse("dd-MM-yyyy", desde)
                    ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsableSeguimiento", "proyecto", session)
                    err = ant.errors.getErrorCount() != 0
                }
                params.seguimiento.id = null
                params.seguimiento.tipo = TipoResponsable.findByCodigo("S")
                def obj = kerberosService.save(params.seguimiento, ResponsableProyecto, session.perfil, session.usuario)
                if (obj.errors.getErrorCount() != 0 || err) {
                    render("NO")
                } else {
                    render("OK")
                }
            }
        }
//        if (params.ejecucion) {
        //            if (params.ejecucion.tipo == "update") {
        //                def fecha = params.ejecucion.desde[1]
        //                def ant = ResponsableProyecto.get(params.ejecucion.id)
        //                ant.hasta = Date.parse("dd-MM-yyyy", fecha)
        //                ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsable", "proyecto", session)
        //                err = ant.errors.getErrorCount() != 0
        //            }
        //            params.ejecucion.id = null
        //            params.ejecucion.tipo = TipoResponsable.findByCodigo("E")
        //            def obj2 = kerberosService.save(params.ejecucion, ResponsableProyecto, session.perfil, session.usuario)
        //            if (obj2.errors.getErrorCount() != 0 || err) {
        //                render("NO")
        //            } else {
        //                render("OK")
        //            }
        //        }
        //        if (params.seguimiento) {
        //            if (params.seguimiento.tipo == "update") {
        //                def fecha = params.seguimiento.desde[1]
        //                def ant = ResponsableProyecto.get(params.seguimiento.id)
        //                ant.hasta = Date.parse("dd-MM-yyyy", fecha)
        //                ant = kerberosService.saveObject(ant, ResponsableProyecto, session.perfil, session.usuario, "saveResponsable", "proyecto", session)
        //                err = ant.errors.getErrorCount() != 0
        //            }
        //            params.seguimiento.id = null
        //            params.seguimiento.tipo = TipoResponsable.findByCodigo("S")
        //            def obj2 = kerberosService.save(params.seguimiento, ResponsableProyecto, session.perfil, session.usuario)
        //            if (obj2.errors.getErrorCount() != 0 || err) {
        //                render("NO")
        //            } else {
        //                render("OK")
        //            }
        //        }
    }

    def historialResponsables = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def proyecto = Proyecto.get(params.id)
        def c = ResponsableProyecto.createCriteria()
        def responsableProyectoInstanceList = []

        def ls = c.list {
            eq("proyecto", proyecto)
//            maxResults(params.max)
            and {
                order("desde", "asc")
                order("hasta", "asc")
                order("tipo", "asc")
            }
        }

        ls.each {
            def m = [:]
            m.obj = it
            if (it) {
                if (it?.desde <= new Date() && it?.hasta >= new Date()) {
                    m.clase = "activo"
                } else {
                    if (it?.desde < new Date()) {
                        m.clase = "pasado"
                    } else {
                        if (it?.hasta > new Date()) {
                            m.clase = "futuro"
                        }
                    }
                }
                m.clase += " " + (it?.tipo.descripcion).toLowerCase()
                responsableProyectoInstanceList.add(m)
            }
        }

//        responsableProyectoInstanceList.sort { it.activo }

        c = ResponsableProyecto.createCriteria()
        def lista = c.list {
            eq("proyecto", proyecto)
        }

        def responsableProyectoInstanceTotal = lista.size()

        return [proyecto: proyecto, responsableProyectoInstanceList: responsableProyectoInstanceList, responsableProyectoInstanceTotal: responsableProyectoInstanceTotal]
    }

    def getDatos = {
        def proyecto = Proyecto.get(params.id)
        def headers, lista, tipo

        switch (params.tipo) {
            case "estudiosTecnicos":
                tipo = "Estudios t&eacute;cnicos"
                lista = EstudiosTecnicos.findAllByProyecto(proyecto)
                headers = [
                        [text: "Documento", name: "documento", align: "left"],
                        [text: "Fecha", name: "fecha", align: "center"],
                        [text: "Resumen", name: "resumen", align: "left"]
                ]
                break;
            case "objetivosEstrategicos":
                tipo = "Objetivos Estrat&eacute;gicos"
                lista = ObjetivoEstrategico.findAllByProyecto(proyecto)
                headers = [
                        [text: "Instituci&oacute;n", name: "institucion", align: "left"],
                        [text: "Objetivo", name: "objetivo", align: "left"],
                        [text: "Pol&iacute;tica", name: "politica", align: "left"],
                        [text: "Meta", name: "meta", align: "left"]
                ]
                break;
            case "gruposDeAtencion":
                tipo = "Grupos de Atención"
                lista = GrupoDeAtencion.findAllByProyecto(proyecto)
                headers = [
                        [text: "Tipo de grupo", name: "tipoGrupo", align: "left", property: "descripcion"],
                        [text: "Hombre", name: "hombre", align: "left"],
                        [text: "Mujer", name: "mujer", align: "left"]
                ]
                break;
            case "entidadesProyecto":
                tipo = "Entidades del Proyecto"
                lista = EntidadesProyecto.findAllByProyecto(proyecto)
                headers = [
                        [text: "Unidad Ejecutora", name: "unidad", align: "left", property: "nombre"],
                        [text: "Tipo Participación", name: "tipoPartisipacion", align: "left"],
                        [text: "Monto", name: "monto", align: "right"],
                        [text: "Rol", name: "rol", align: "left"],
                ]
                break;
            case "intervencion":
                tipo = "Intervenciones"
                lista = Intervencion.findAllByProyecto(proyecto)
                headers = [
                        [text: "Subsector", name: "subSector", align: "left"]
                ]
                break;
            case "adquisicion":
                tipo = "Adquisiciones"
                lista = Adquisiciones.findAllByProyecto(proyecto)
                headers = [
                        [text: "Tipo adquisición", name: "tipoAdquisicion", align: "left", property: "descripcion"],
                        [text: "Tipo procedencia", name: "tipoProcedencia", align: "left", property: "descripcion"],
                        [text: "Descripción", name: "descripcion", align: "left"],
                        [text: "Valor", name: "valor", align: "right"],
                        [text: "Porcentaje", name: "porcentaje", align: "right"]
                ]
                break;
        }

        return [lista: lista, headers: headers, tipo: tipo]
    }

    def saveEstudiosTecnicos = {
        def obj = new EstudiosTecnicos(params)

        obj = kerberosService.saveObject(obj, EstudiosTecnicos, session.perfil, session.usuario, actionName, controllerName, session)
        if (obj.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }
    def deleteEstudiosTecnicos = {
        if (params.id.class != java.lang.String) {
            (params.id).each { id ->
                def p = [:]
                p.id = id
                p.controllerName = controllerName
                p.actionName = actionName
                kerberosService.delete(p, EstudiosTecnicos, session.perfil, session.usuario)
            }
        } else {
            params.controllerName = controllerName
            params.actionName = actionName
            kerberosService.delete(params, EstudiosTecnicos, session.perfil, session.usuario)
        }
        render("OK")
    }

    def saveObjetivosEstrategicos = {
        def obj = new ObjetivoEstrategico(params)

        obj = kerberosService.saveObject(obj, ObjetivoEstrategico, session.perfil, session.usuario, actionName, controllerName, session)
        if (obj.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }
    def deleteObjetivosEstrategicos = {
        if (params.id.class != java.lang.String) {
            (params.id).each { id ->
                def p = [:]
                p.id = id
                p.controllerName = controllerName
                p.actionName = actionName
                kerberosService.delete(p, ObjetivoEstrategico, session.perfil, session.usuario)
            }
        } else {
            params.controllerName = controllerName
            params.actionName = actionName
            kerberosService.delete(params, ObjetivoEstrategico, session.perfil, session.usuario)
        }
        render("OK")
    }

    def saveGruposDeAtencion = {
        def obj = new GrupoDeAtencion(params)

        obj = kerberosService.saveObject(obj, GrupoDeAtencion, session.perfil, session.usuario, actionName, controllerName, session)
        if (obj.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }
    def deleteGruposDeAtencion = {
        if (params.id.class != java.lang.String) {
            (params.id).each { id ->
                def p = [:]
                p.id = id
                p.controllerName = controllerName
                p.actionName = actionName
                kerberosService.delete(p, GrupoDeAtencion, session.perfil, session.usuario)
            }
        } else {
            params.controllerName = controllerName
            params.actionName = actionName
            kerberosService.delete(params, GrupoDeAtencion, session.perfil, session.usuario)
        }
        render("OK")
    }

    def saveEntidadesProyecto = {

        println actionName
        println params
        println "\n\n\n"

        def obj = new EntidadesProyecto(params)

        obj = kerberosService.saveObject(obj, EntidadesProyecto, session.perfil, session.usuario, actionName, controllerName, session)
        if (obj.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }
    def deleteEntidadesProyecto = {
        if (params.id.class != java.lang.String) {
            (params.id).each { id ->
                def p = [:]
                p.id = id
                p.controllerName = controllerName
                p.actionName = actionName
                kerberosService.delete(p, EntidadesProyecto, session.perfil, session.usuario)
            }
        } else {
            params.controllerName = controllerName
            params.actionName = actionName
            kerberosService.delete(params, EntidadesProyecto, session.perfil, session.usuario)
        }
        render("OK")
    }

    def saveIntervencion = {
        def obj = new Intervencion(params)

        obj = kerberosService.saveObject(obj, Intervencion, session.perfil, session.usuario, actionName, controllerName, session)
        if (obj.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }
    def deleteIntervencion = {
        if (params.id.class != java.lang.String) {
            (params.id).each { id ->
                def p = [:]
                p.id = id
                p.controllerName = controllerName
                p.actionName = actionName
                kerberosService.delete(p, Intervencion, session.perfil, session.usuario)
            }
        } else {
            params.controllerName = controllerName
            params.actionName = actionName
            kerberosService.delete(params, Intervencion, session.perfil, session.usuario)
        }
        render("OK")
    }

    def saveAdquisicion = {
        def obj = new Adquisiciones(params)

        obj = kerberosService.saveObject(obj, Adquisiciones, session.perfil, session.usuario, actionName, controllerName, session)
        if (obj.errors.getErrorCount() != 0) {
            render("NO")
        } else {
            render("OK")
        }
    }
    def deleteAdquisicion = {
        if (params.id.class != java.lang.String) {
            (params.id).each { id ->
                def p = [:]
                p.id = id
                p.controllerName = controllerName
                p.actionName = actionName
                kerberosService.delete(p, Adquisiciones, session.perfil, session.usuario)
            }
        } else {
            params.controllerName = controllerName
            params.actionName = actionName
            kerberosService.delete(params, Adquisiciones, session.perfil, session.usuario)
        }
        render("OK")
    }

    def verIndicadoresSenplades = {
        def proyecto = Proyecto.get(params.id)
        def indicadores = [:]
        indicadores.indicadoresSempladesInstance = IndicadoresSenplades.findByProyecto(proyecto)
        return [proyecto: proyecto, indicadores: indicadores]
    }

    def editarIndicadoresSenplades = {
        def proyecto = Proyecto.get(params.id)
        def indicadores = [:]
        indicadores.indicadoresSempladesInstance = IndicadoresSenplades.findByProyecto(proyecto)
        return [proyecto: proyecto, indicadores: indicadores]
    }

    def saveIndicadoresSenplades = {
        println params
        def proyecto = Proyecto.get(params.id)

        def indicador = IndicadoresSenplades.findByProyecto(proyecto)

        if (!indicador) {
            indicador = new IndicadoresSenplades()
            indicador.proyecto = proyecto
        }

        indicador.tasaAnalisisFinanciero = params.tan.toDouble()
        indicador.tasaInternaDeRetorno = params.tir.toDouble()
        indicador.costoBeneficio = params.cob.toDouble()
        indicador.valorActualNeto = params.van.toDouble()
        indicador.metodologia = params.met
        indicador.impactos = params.imp

        indicador = kerberosService.saveObject(indicador, IndicadoresSenplades, session.perfil, session.usuario, actionName, controllerName, session)
        println indicador

        if (indicador.errors.getErrorCount() != 0) {
            redirect(action: "editarIndicadoresSenplades", id: params.id)
        } else {
            redirect(action: "verIndicadoresSenplades", id: params.id)
        }
    }

    def verEntidades = {
        def proyecto = Proyecto.get(params.id)
        def indicadores = [:]
        def headers = [:]
        indicadores.entidadesProyectoInstance = EntidadesProyecto.findAllByProyecto(proyecto)
        headers.entidadesProyecto = [
                [text: "Unidad Ejecutora", name: "unidad", align: "left", property: "nombre"],
                [text: "Tipo Participación", name: "tipoPartisipacion", align: "left"],
                [text: "Monto", name: "monto", align: "right"],
                [text: "Rol", name: "rol", align: "left"],
        ]
        return [proyecto: proyecto, indicadores: indicadores, headers: headers]
    }

    def editarEntidades = {
        def proyecto = Proyecto.get(params.id)
        def entidadesProyectoInstance = EntidadesProyecto.findAllByProyecto(proyecto)

        return [entidadesProyectoInstance: entidadesProyectoInstance, proyecto: proyecto]
    }

    def verFinanciamiento = {
        def proyecto = Proyecto.get(params.id)
        def financiamientos = Financiamiento.findAllByProyecto(proyecto)
        [proyecto: proyecto, financiamientos: financiamientos]
    }

    def editarFinanciamiento = {
        def proyecto = Proyecto.get(params.id)
        def financiamientos = Financiamiento.findAllByProyecto(proyecto)
        [proyecto: proyecto, financiamientos: financiamientos]
    }

    def saveFinanciamiento = {

        println params

        def proyecto = Proyecto.get(params.id)

        def financiamientos = Financiamiento.findAllByProyecto(proyecto)

        def ok = true

        params.each {
            if (it.key.contains("mnt")) {
                def parts = (it.key).split("_")
                def id = parts[1]
                def anio = parts[2]
                def monto = it.value

                def financiamiento

                if ((!financiamientos || financiamientos.size() == 0) || (financiamientos.size() > 0 && !financiamientos.fuente.id.contains(id))) {
                    financiamiento = new Financiamiento()
                    financiamiento.proyecto = proyecto
                    financiamiento.fuente = Fuente.get(id)
                    financiamiento.monto = monto.toDouble()
                    financiamiento.anio = Anio.get(anio)

                    financiamiento = kerberosService.saveObject(financiamiento, Financiamiento, session.perfil, session.usuario, actionName, controllerName, session)

                    if (financiamiento.errors.getErrorCount() != 0) {
                        ok = false
                    }
                }
            } else {
                if (it.key == "deleted" && it.value) {
                    def parts = it.value.split(",")
                    if (parts.size() > 0) {
                        parts.each { pa ->
                            def p = [:]
                            println "\npa"
                            println pa
                            println "\n"
                            p.id = pa
                            p.controllerName = controllerName
                            p.actionName = actionName
                            if (!kerberosService.delete(p, Financiamiento, session.perfil, session.usuario)) {
                                ok = false
                            }
                        }
                    }
                } //deleted
            }
        }

        if (ok) {
            flash.message = "Financiamientos guardados exitosamente"
            redirect(action: 'show', id: params.id)
        } else {
            flash.message = "Ha ocurrido un error, por favor comuníquese con el administrador del sistema<br/>[controller:proyecto, action:saveFinanciamiento]"
            redirect(action: 'editarFinanciamiento', id: params.id)
        }
    }

    def verDatosSenplades = {
        def proyecto = Proyecto.get(params.id)

        def indicadores = [:]
        def headers = [:]

        indicadores.indicadoresSempladesInstance = IndicadoresSenplades.findByProyecto(proyecto)
        indicadores.estudioTecnicoInstance = EstudiosTecnicos.findAllByProyecto(proyecto)
        indicadores.objetivoEstrategicoInstance = ObjetivoEstrategico.findAllByProyecto(proyecto)
        indicadores.grupoDeAtencionInstance = GrupoDeAtencion.findAllByProyecto(proyecto)
        indicadores.beneficioSempladesInstance = BeneficioSenplades.findByProyecto(proyecto)
        indicadores.entidadesProyectoInstance = EntidadesProyecto.findAllByProyecto(proyecto)
        indicadores.intervenciones = Intervencion.findAllByProyecto(proyecto)
        indicadores.adquisiciones = Adquisiciones.findAllByProyecto(proyecto)

        headers.estudiosTecnicos = [
                [text: "Documento", name: "documento", align: "left"],
                [text: "Fecha", name: "fecha", align: "center"],
                [text: "Resumen", name: "resumen", align: "left"]
        ]

        headers.objetivosEstrategicos = [
                [text: "Instituci&oacute;n", name: "institucion", align: "left"],
                [text: "Objetivo", name: "objetivo", align: "left"],
                [text: "Pol&iacute;tica", name: "politica", align: "left"],
                [text: "Meta", name: "meta", align: "left"]
        ]

        headers.gruposDeAtencion = [
                [text: "Tipo de grupo", name: "tipoGrupo", align: "left", property: "descripcion"],
                [text: "Hombre", name: "hombre", align: "left"],
                [text: "Mujer", name: "mujer", align: "left"]
        ]

        headers.entidadesProyecto = [
                [text: "Entidad", name: "entidad", align: "left", property: "nombre"],
                [text: "Tipo Participación", name: "tipoPartisipacion", align: "left"],
                [text: "Monto", name: "monto", align: "right"],
                [text: "Rol", name: "rol", align: "left"],
        ]

        headers.intervenciones = [
                [text: "Subsector", name: "subSector", align: "left"]
        ]

        headers.adquisiciones = [
                [text: "Tipo adquisición", name: "tipoAdquisicion", align: "left", property: "descripcion"],
                [text: "Tipo procedencia", name: "tipoProcedencia", align: "left", property: "descripcion"],
                [text: "Descripción", name: "descripcion", align: "left"],
                [text: "Valor", name: "valor", align: "right"],
                [text: "Porcentaje", name: "porcentaje", align: "right"]
        ]
        return [proyecto: proyecto, indicadores: indicadores, headers: headers]
    }

    def sempladesFlow = {
        inicio {
            action {

                def items = []
                items[0] = [:]
                items[0].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "indicadoresSemplades"]]
                items[0].text = "Indicadores Senplades"
                items[0].evento = "indicadoresSemplades"

                items[1] = [:]
                items[1].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "beneficiosSemplades"]]
                items[1].text = "Beneficios Senplades"
                items[1].evento = "beneficiosSemplades"

                items[2] = [:]
                items[2].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "estudiosTecnicos"]]
                items[2].text = "Estudios T&eacute;cnicos"
                items[2].evento = "estudiosTecnicos"

                items[3] = [:]
                items[3].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "objetivosEstrategicos"]]
                items[3].text = "Objetivos Estrat&eacute;gicos"
                items[3].evento = "objetivosEstrategicos"

                items[4] = [:]
                items[4].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "gruposDeAtencion"]]
                items[4].text = "Grupos de atenci&oacute;n"
                items[4].evento = "gruposDeAtencion"

                items[5] = [:]
                items[5].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "entidadesProyecto"]]
                items[5].text = "Entidades Proyecto"
                items[5].evento = "entidadesProyecto"

                items[6] = [:]
                items[6].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "adquisiciones"]]
                items[6].text = "Adquisiciones"
                items[6].evento = "adquisiciones"

                items[7] = [:]
                items[7].link = [controller: "proyecto", action: "semplades", event: "click", params: [evento: "intervenciones"]]
                items[7].text = "Intervenciones"
                items[7].evento = "intervenciones"

                flow.items = items

                flow.saved = false
                flow.error = false
                flow.message = ""

                flow.proyecto = Proyecto.get(params.id)
                if (flow.proyecto) {
                    flow.indicadoresSempladesInstance = IndicadoresSenplades.findByProyecto(flow.proyecto)
                    flow.estudioTecnicoInstance = EstudiosTecnicos.findAllByProyecto(flow.proyecto)
                    flow.objetivoEstrategicoInstance = ObjetivoEstrategico.findAllByProyecto(flow.proyecto)
                    flow.grupoDeAtencionInstance = GrupoDeAtencion.findAllByProyecto(flow.proyecto)
                    flow.beneficioSempladesInstance = BeneficioSenplades.findByProyecto(flow.proyecto)
                    flow.entidadesProyectoInstance = EntidadesProyecto.findAllByProyecto(flow.proyecto)
                    flow.intervenciones = Intervencion.findAllByProyecto(flow.proyecto)
                    flow.adquisiciones = Adquisiciones.findAllByProyecto(flow.proyecto)
                    yes()
                } else {
                    no()
                }
            } //inicio > action
            on("yes").to("indicadoresSemplades")
            on("no").to("error")
        } //inicio

        error {} //error

        indice {
            on("click") {flow.evento = params.evento}.to "redirect"
        } //indice

        redirect {
            action {
                flow.saved = false
                flow.error = false
                yes()
            }
            on('yes').to { flow.evento }
        }

        indicadoresSemplades {
            on("click") {flow.evento = params.evento}.to "redirect"
            on("guardarIndicadores").to("guardarIndicadores")
        } //indicadores semplades
        guardarIndicadores {
            action {
                if (!flow.indicadoresSempladesInstance) {
                    flow.indicadoresSempladesInstance = new IndicadoresSenplades()
                }
                flow.indicadoresSempladesInstance.properties = params
                flow.indicadoresSempladesInstance.proyecto = flow.proyecto

                flow.indicadoresSempladesInstance = kerberosService.saveObject(flow.indicadoresSempladesInstance, IndicadoresSenplades, session.perfil, session.usuario, actionName, controllerName, session)
                if (flow.indicadoresSempladesInstance.errors.getErrorCount() != 0) {
                    flow.saved = false
                    flow.error = true
                    flow.message = "Ha ocurrido un error al guardar el indicador"
                    no()
                } else {
                    flow.saved = true
                    flow.error = false
                    flow.message = "Indicador guardado exitosamente"
                    yes()
                }
            }
            on("yes").to("indicadoresSemplades")
            on("no").to("indicadoresSemplades")
        }

        beneficiosSemplades {
            on("click") {flow.evento = params.evento}.to "redirect"
            on("guardarBeneficios") { println "???? " + params }.to "guardarBeneficios"
        } //beneficios semplades
        guardarBeneficios {
            action {
                if (!flow.beneficioSempladesInstance) {
                    flow.beneficioSempladesInstance = new BeneficioSenplades()
                }
                flow.beneficioSempladesInstance.properties = params
                flow.beneficioSempladesInstance.proyecto = flow.proyecto

                flow.benficioSempladesInstance = kerberosService.saveObject(flow.beneficioSempladesInstance, BeneficioSenplades, session.perfil, session.usuario, actionName, controllerName, session)
                if (flow.beneficioSempladesInstance.errors.getErrorCount() != 0) {
                    flow.saved = false
                    flow.error = true
                    flow.message = "Ha ocurrido un error al guardar el beneficio"
                    no()
                } else {
                    flow.saved = true
                    flow.error = false
                    flow.message = "Beneficio guardado exitosamente"
                    yes()
                }

            }
            on("yes").to("beneficiosSemplades")
            on("no").to("beneficiosSemplades")
        }

        estudiosTecnicos {
            on("click") {flow.evento = params.evento}.to "redirect"
        } //estudios tecnicos

        objetivosEstrategicos {
            on("click") {flow.evento = params.evento}.to "redirect"
        } //objetivos estrategicos

        gruposDeAtencion {
            on("click") {flow.evento = params.evento}.to "redirect"
        } //grupos de atencion

        entidadesProyecto {
            on("click") {flow.evento = params.evento}.to "redirect"
        } //entidades proyecto

        intervenciones {
            on("click") {flow.evento = params.evento}.to "redirect"

        } //intervenciones

        adquisiciones {
            on("click") {flow.evento = params.evento}.to "redirect"
        } //adquisiciones

        salir {
            redirect(controller: "proyecto", action: "show", id: flow.proyecto.id)
        } //show
    }

    def formBuenVivir = {
        def proyecto = Proyecto.get(params.id)
        def metasProyecto = MetaBuenVivirProyecto.findAllByProyecto(proyecto)
        return[metasProyecto:metasProyecto,proyecto: proyecto]
    }

    def saveBuenVivir = {
//        println("params " + params)
        def proyecto = Proyecto.get(params.proyecto)
        def meta
        def metas
        def metaProyecto
        def errores = ''

        if(params.deleted){
            def c = params.deleted.split(",")
            c.each{
                def borrar = MetaBuenVivirProyecto.get(it.toString())
                try {
                    borrar.delete(flush: true)
                }catch (e){
                    println("error al borrar la meta buen vivir del proyecto " + e)
                    errores += e
                }
            }
        }

        if(params.meta){
            if(params.meta.class == java.lang.String ){
                meta = MetaBuenVivir.get(params.meta)
                metaProyecto = new MetaBuenVivirProyecto()
                metaProyecto.metaBuenVivir = meta
                metaProyecto.proyecto = proyecto

                try{
                    metaProyecto.save(flush: true)
                }catch (e){
                    println("error al agregar meta buen vivir " + e)
                    errores += e
                }

            }else{
                params.meta.each{
                    meta = MetaBuenVivir.get(it)
                    metaProyecto = new MetaBuenVivirProyecto()
                    metaProyecto.metaBuenVivir = meta
                    metaProyecto.proyecto = proyecto

                    try{
                        metaProyecto.save(flush: true)

                    }catch (e){
                        println("error al agregar meta buen vivir " + e)
                        errores += e
                    }
                }
            }
        }


        if(errores == ''){
            redirect(controller: 'proyecto', action: 'formBuenVivir',id: proyecto.id)
        }else{
            flash.message = "Error al guardar las metas"
        }
    }

    def formPoliticas () {
        def proyecto = Proyecto.get(params.id)
        def politicasAgenda = PoliticasAgendaProyecto.findAllByProyecto(proyecto).politicaAgendaSocial.id
        return[proyecto: proyecto, politicasAgenda: politicasAgenda]
    }

    def savePoliticas = {
        println("params " + params)
        def proyecto = Proyecto.get(params.proyecto)
        def politica
        def errores = ''
        def politicaProyecto

        def politicasAgenda = PoliticasAgendaProyecto.findAllByProyecto(proyecto)

        if(params.politica){

            politicasAgenda.politicaAgendaSocial.id.each { p->
                if(params.politica.contains(p.toString())){
                    params.politica = params.politica - p.toString()
                }else{
                    politica = PoliticaAgendaSocial.get(p)
                    politicaProyecto = PoliticasAgendaProyecto.findByPoliticaAgendaSocialAndProyecto(politica,proyecto)
                    try{
                        politicaProyecto.delete(flush: true)
                    }catch (e){
                        println("error al borrar una politica especifica " + e)
                        errores += e
                    }
                }
            }

            if(params.politica.class == java.lang.String ){
                politica = PoliticaAgendaSocial.get(params.politica)
                politicaProyecto = new PoliticasAgendaProyecto()
                politicaProyecto.proyecto = proyecto
                politicaProyecto.politicaAgendaSocial = politica

                try{
                   politicaProyecto.save(flush: true)
                }catch (e){
                   println("error al guardar la politica " + e)
                    errores += e
                }
            }else{
                params.politica.each{
                    politica = PoliticaAgendaSocial.get(it)
                    politicaProyecto = new PoliticasAgendaProyecto()
                    politicaProyecto.proyecto = proyecto
                    politicaProyecto.politicaAgendaSocial = politica

                    try{
                        politicaProyecto.save(flush: true)
                    }catch (e){
                        println("error al guardar la politica " + e)
                        errores += e
                    }
                }
            }
        }else{
            politicasAgenda.each{b->

                try{
                    b.delete(flush: true)
                }catch (e){
                    println("error al borrar todas las politicas")
                    errores += e
                }

            }
        }

        if(errores == ''){
            redirect(controller: 'proyecto', action: 'formPoliticas',id: proyecto.id)
        }else{
            flash.message = "Error al guardar las politicas"
        }
    }

    def formPoliticasMies () {
        def proyecto = Proyecto.get(params.id)
        def politicasProyecto = PoliticasProyecto.findAllByProyecto(proyecto).politica.id
        return[proyecto: proyecto, politicasProyecto: politicasProyecto]
    }

    def savePoliticasMies = {
//        println("params " + params)
        def proyecto = Proyecto.get(params.proyecto)
        def politica
        def errores = ''
        def politicaProyecto

        def politicasMies = PoliticasProyecto.findAllByProyecto(proyecto)

        if(params.politica){

            politicasMies.politica.id.each { p->
                if(params.politica.contains(p.toString())){
                    params.politica = params.politica - p.toString()
                }else{
                    politica = Politica.get(p)
                    politicaProyecto = PoliticasProyecto.findByPoliticaAndProyecto(politica,proyecto)
                    try{
                        politicaProyecto.delete(flush: true)
                    }catch (e){
                        println("error al borrar una politica especifica " + e)
                        errores += e
                    }
                }
            }

            if(params.politica.class == java.lang.String ){
                politica = Politica.get(params.politica)
                politicaProyecto = new PoliticasProyecto()
                politicaProyecto.proyecto = proyecto
                politicaProyecto.politica = politica

                try{
                    politicaProyecto.save(flush: true)
                }catch (e){
                    println("error al guardar la politica " + e)
                    errores += e
                }
            }else{
                params.politica.each{
                    politica = Politica.get(it)
                    politicaProyecto = new PoliticasProyecto()
                    politicaProyecto.proyecto = proyecto
                    politicaProyecto.politica = politica

                    try{
                        politicaProyecto.save(flush: true)
                    }catch (e){
                        println("error al guardar la politica MIES " + e)
                        errores += e
                    }
                }
            }
        }else{
            politicasMies.each{b->

                try{
                    b.delete(flush: true)
                }catch (e){
                    println("error al borrar todas las politicas MIES")
                    errores += e
                }

            }
        }

        if(errores == ''){
            redirect(controller: 'proyecto', action: 'formPoliticasMies',id: proyecto.id)
        }else{
            flash.message = "Error al guardar las politicas MIES"
        }
    }
}
