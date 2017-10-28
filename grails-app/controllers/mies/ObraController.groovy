package mies

class ObraController extends mies.seguridad.Shield {

    def kerberosService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    /*TODO cambiar esto para que valga con obras - asignacion*/
    def pacProyecto = {
        def proyecto = Proyecto.get(params.id)
        def componentes = MarcoLogico.findAll("from MarcoLogico where proyecto = ${proyecto.id} and tipoElemento = 2 and estado = 0")
        def unidades = Unidad.list([sort: 'descripcion', order: 'asc'])
        def tipoCompra = TipoCompra.list([sort: 'descripcion'])
        def acts = []
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        componentes.each {comp ->
            def temp = MarcoLogico.findAllByMarcoLogicoAndEstado(comp, 0)
            if (temp)
                acts += temp
        }
        //def fuentes = Financiamiento.findAllByProyecto(proyecto).fuente

        //println "acts " + acts

        [proyecto: proyecto, acts: acts, actual: actual, unidades: unidades, tipoCompra: tipoCompra]


    }

    def pacCorrientes = {
        def band = true
        if (params.id.toLong() != session.unidad.id.toLong()) {
            band = false
        }
        if (session.perfil.id.toLong() == 1.toLong()) {
            band = true
        }
        if (!band) {
            response.sendError(404)
        } else {

            def unidad = UnidadEjecutora.get(params.id)
            def unidades = Unidad.list([sort: 'descripcion', order: 'asc'])
            def tipoCompra = TipoCompra.list([sort: 'descripcion'])
            def actual
            if (params.anio)
                actual = Anio.get(params.anio)
            else
                actual = Anio.findByAnio(new Date().format("yyyy"))
            if (!actual)
                actual = Anio.list([sort: 'anio', order: 'desc']).pop()
            def max = PresupuestoUnidad.findByUnidadAndAnio(unidad,actual)
            def asgs = Asignacion.findAll("from Asignacion where unidad = ${unidad.id} and anio=${actual.id} and actividad is not null order by actividad")

            //def fuentes = Financiamiento.findAllByProyecto(proyecto).fuente

            return [actual: actual, asgs: asgs, unidad: unidad, unidades: unidades, tipoCompra: tipoCompra,max:max]
        }
    }

    def   pacCorrientesMod = {
        def band = false
        def unidad = UnidadEjecutora.get(params.id)
        def unej = unidad
        def usuario = session.usuario
        def ahora =  new Date()
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        if (!actual)
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()

        while(unej!=null){
           // println "unej "+unej
            def resp=ResponsableProyecto.findAllByUnidadAndTipo(unej,TipoResponsable.findByCodigo("A"))
           // println "responsables "+resp
            resp.each {r->
                if(r.desde.before(ahora) && r.hasta.after(ahora)){
                  //  println "si es ahora "+r.desde+"  "+r.hasta
                    if (r.responsable.id.toInteger()==usuario.id.toInteger()){
                       // println "si es responsable"
                        band=true
                    }
                }
            }
            unej=unej.padre

        }

        if (!band) {
            [msn:"Usted no es el responsable administrativo de esta unidad.",unidad: unidad,actual: actual]
        } else {


            def unidades = Unidad.list([sort: 'descripcion', order: 'asc'])
            def tipoCompra = TipoCompra.list([sort: 'descripcion'])

            def max = PresupuestoUnidad.findByUnidadAndAnio(unidad,actual)
            def asgs = Asignacion.findAll("from Asignacion where unidad = ${unidad.id} and anio=${actual.id} and actividad is not null order by actividad")

            //def fuentes = Financiamiento.findAllByProyecto(proyecto).fuente

            return [actual: actual, asgs: asgs, unidad: unidad, unidades: unidades, tipoCompra: tipoCompra,max:max]
        }
    }

    def agregarFila = {
//        println "params copiar obra!! "+params
//        render params
        def obra = kerberosService.save(params, Obra, session.perfil, session.usuario)
//        println " errores "+obra.errors
        render obra.id
    }

    def eliminarFila = {
        params.controllerName = "Obra"
        params.actionName = "eliminarFila"
        if (kerberosService.delete(params, Obra, session.perfil, session.usuario)) {
            render("OK")
        } else {
            render("NO")
        }
    }


    def obrasAsignacion = {
        def asignacion = Asignacion.get(params.id)
        def obras = Obra.findAllByAsignacionAndObraIsNull(asignacion)
        [obras: obras, asignacion: asignacion]
    }

    def guardarObra = {
        //println "params guardar obra!! " + params
        def obra = kerberosService.save(params, Obra, session.perfil, session.usuario)
        //println " errores " + obra.errors
        render obra.id

    }

    def guardarObraMod = {
        println "guardar obra mod  "+params
        def obra = Obra.get(params.id)
        obra.properties=params
        obra = kerberosService.saveModificacion(obra, Obra, session.usuario,session)
        if (obra.errors.getErrorCount()!=0){
            println "error "+obra.errors
            render "no"
        }else{
            render obra.id
        }
    }
    def guardarObraGC = {

        params.cuatrimestre1 = "0"
        params.cuatrimestre2 = "0"
        params.cuatrimestre3 = "0"
        switch (params.cant) {
            case "0":

                break;
            case "1":
                if (params.cuatri == "1")
                    params.cuatrimestre1 = "1"
                if (params.cuatri == "2")
                    params.cuatrimestre2 = "1"
                if (params.cuatri == "3")
                    params.cuatrimestre3 = "1"
                break;
            default:
                params.cuatri.each {
                    if (it.toInteger() == 1)
                        params.cuatrimestre1 = "1"
                    if (it.toInteger() == 2)
                        params.cuatrimestre2 = "1"
                    if (it.toInteger() == 3)
                        params.cuatrimestre3 = "1"
                }
                break;
        }
        //println "params " + params
        def obra = kerberosService.save(params, Obra, session.perfil, session.usuario)
        //println " errores " + obra.errors
        render "ok"

    }
    def guardarObraGCform = {
        params.fechaFin = params.fechaFin_day + "/" + params.fechaFin_month + "/" + params.fechaFin_year
        params.fechaInicio = params.fechaInicio_day + "/" + params.fechaInicio_month + "/" + params.fechaInicio_year
        params.cuatrimestre1 = "0"
        params.cuatrimestre2 = "0"
        params.cuatrimestre3 = "0"
        switch (params.cant) {
            case "0":

                break;
            case "1":
                if (params.cuatri == "1")
                    params.cuatrimestre1 = "1"
                if (params.cuatri == "2")
                    params.cuatrimestre2 = "1"
                if (params.cuatri == "3")
                    params.cuatrimestre3 = "1"
                break;
            default:
                params.cuatri.each {
                    if (it.toInteger() == 1)
                        params.cuatrimestre1 = "1"
                    if (it.toInteger() == 2)
                        params.cuatrimestre2 = "1"
                    if (it.toInteger() == 3)
                        params.cuatrimestre3 = "1"
                }
                break;
        }
        //println "params " + params
        def obra = kerberosService.save(params, Obra, session.perfil, session.usuario)
        //println " errores " + obra.errors
        redirect(controller: "asignacion", action: "pacAsignacion", id: obra.asignacion.id)
    }

    def list = {
        def title = g.message(code: "obra.list", default: "Obra List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [obraInstanceList: Obra.list(params), obraInstanceTotal: Obra.count(), title: title, params: params]
    }

    def form = {
        def title
        def obraInstance

        if (params.source == "create") {
            obraInstance = new Obra()
            obraInstance.properties = params
            title = g.message(code: "obra.create", default: "Create Obra")
        } else if (params.source == "edit") {
            obraInstance = Obra.get(params.id)
            if (!obraInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "obra.edit", default: "Edit Obra")
        }

        return [obraInstance: obraInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "obra.edit", default: "Edit Obra")
            def obraInstance = Obra.get(params.id)
            if (obraInstance) {
                obraInstance.properties = params
                if (!obraInstance.hasErrors() && obraInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'obra.label', default: 'Obra'), obraInstance.id])}"
                    redirect(action: "show", id: obraInstance.id)
                }
                else {
                    render(view: "form", model: [obraInstance: obraInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "obra.create", default: "Create Obra")
            def obraInstance = new Obra(params)
            if (obraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'obra.label', default: 'Obra'), obraInstance.id])}"
                redirect(action: "show", id: obraInstance.id)
            }
            else {
                render(view: "form", model: [obraInstance: obraInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def obraInstance = Obra.get(params.id)
        if (obraInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (obraInstance.version > version) {

                    obraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'obra.label', default: 'Obra')] as Object[], "Another user has updated this Obra while you were editing")
                    render(view: "edit", model: [obraInstance: obraInstance])
                    return
                }
            }
            obraInstance.properties = params
            if (!obraInstance.hasErrors() && obraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'obra.label', default: 'Obra'), obraInstance.id])}"
                redirect(action: "show", id: obraInstance.id)
            }
            else {
                render(view: "edit", model: [obraInstance: obraInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def obraInstance = Obra.get(params.id)
        if (!obraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "obra.show", default: "Show Obra")

            [obraInstance: obraInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def obraInstance = Obra.get(params.id)
        if (obraInstance) {
            try {
                obraInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'obra.label', default: 'Obra'), params.id])}"
            redirect(action: "list")
        }
    }
}