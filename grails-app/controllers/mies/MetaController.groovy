package mies

class MetaController {

    def kerberosService

    def index = { }

    def guardarMeta = {
        println "params guardar " + params
        if(params.id){
            def mta = Meta.get(params.id)
            def total = 0
            Cronograma.findAllByMarcoLogicoAndCronogramaIsNull(mta.marcoLogico).each{
                println "cronograma "+it +" total "+total
                total+=it.valor+it.valor2
            }
            def inversion =params.inversion
            inversion = inversion.replaceAll("\\.","")

            inversion = inversion.replaceAll(",",".")

            inversion = inversion.toDouble()
            //println " inversion "+inversion.toFloat().round(2)+" total "+ total.toFloat().round(2)
            if (inversion.toFloat().round(2) < total.toFloat().round(2)){
                render "Error: El nuevo valor de inversión de la meta (\$ ${params.inversion}) es inferior a lo registrado en el cronograma (\$ ${g.formatNumber(number:total,format:"###,##0",minFractionDigits:"2", maxFractionDigits:"2")})"
            }else{
                def meta = kerberosService.save(params, Meta, session.perfil, session.usuario)
                if (meta.errors.getErrorCount() == 0) {
                    render "ok"
                } else {
                    render "Error en los datos ingresados "+meta.errors
                }

            }
        }else{
            def meta = kerberosService.save(params, Meta, session.perfil, session.usuario)
            if (meta.errors.getErrorCount() == 0) {
                render "ok"
            } else {
                render "Error en los datos ingresados "+meta.errors
            }
        }




    }

    def eliminarMeta = {
        def meta = Meta.get(params.id)
        def avances = Avance.findAllByMeta(meta)
        if (avances.size() > 0) {
            render("NO_Esta meta tiene avances, no puede ser eliminada.")
        } else {
            if (kerberosService.delete(params, Meta, session.perfil, session.usuario)) {
                render("OK_Meta eliminada correctamente.")
            } else {
                render("NO_Ha ocurrido un error al eliminar la meta.")
            }
        }
    }

    def buscadorMetas = {
        def signos = [[1: "Igual"], [2: "Mayor"], [3: "Menor"]]
        [signos: signos]
    }


    def buscarMeta = {
        //println "buscar meta "+params
        def metas = []
        def hql = "from Meta where "
        if (!params.hql) {
            def meta = 0
            def inversion = 0
            try {
                inversion = params.inversion.toDouble()

            } catch (e) {
                println "no hay o mal dato inv "

                inversion = -1
            }
            try {
                meta = params.meta.toDouble()

            } catch (e) {
                println "no hay o mal dato meta"
                meta = -1
            }

            def band = false
            if (params.indicador.trim().size() > 0) {
                if (params.indicador!="-1"){
                hql += "tipoMeta=" + params.indicador + " "
                band = true
                }else{
                    hql += "tipoMeta is not null "
                    band = true
                }
            }
            if (params.parroquia.trim().size() > 0) {
                if (band)
                    hql += " and "
                hql += "parroquia=" + params.parroquia + " "
                band = true
            }
            if (meta != -1) {
                if (band)
                    hql += " and "
                hql += " indicador "
                switch (params.tipoMeta) {
                    case "1":
                        hql += " = "
                        break;
                    case "2":
                        hql += " > "
                        break;
                    case "3":
                        hql += " < "
                        break;
                }

                hql += meta + " "
                band = true
            }
            if (inversion != -1) {
                if (band)
                    hql += " and "
                hql += " inversion "
                switch (params.tipoInversion) {
                    case "1":
                        hql += " = "
                        break;
                    case "2":
                        hql += " > "
                        break;
                    case "3":
                        hql += " < "
                        break;
                }

                hql += inversion + " "
                band = true
            }

            //println " hql " + hql

            try {
                metas = Meta.findAll(hql)
                //println "metas "+metas
            } catch (e) {
                println "error " + e
            }
        } else {
            hql = params.hql
            switch (params.order) {
                case "tipoMeta":
                    metas = Meta.findAll(params.hql)
                    metas = metas.sort {it.tipoMeta.descripcion}
                    break;
                case "provincia":
                    metas = Meta.findAll(params.hql)
                    metas = metas.sort {it.parroquia.canton.provincia.nombre}
                    break;
                case "canton":
                    metas = Meta.findAll(params.hql)
                    metas = metas.sort {it.parroquia.canton.nombre}
                    break;
                case "parroquia":
                    metas = Meta.findAll(params.hql)
                    metas = metas.sort {it.parroquia.nombre}
                    break;
                case "indicador":
                    metas = Meta.findAll(params.hql + " order by indicador")
                    break;
                case "inversion":
                    metas = Meta.findAll(params.hql + " order by inversion")
                    break;
            }

            /*TODO ordenar aqui*/
        }

        [metas: metas, hql: hql]


    }

    def form = {
        def title
        def meta
        println "meta " + params
        if (params.source == "create") {
            meta = new Canton()
            meta.properties = params
            title = g.message(code: "default.create.label", args: ["Canton"], default: "crearCanton")
        } else if (params.source == "edit") {
            meta = Meta.get(params.id)
            if (!meta) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'canton.label', default: 'Canton'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "default.edit.label", args: ["Meta"], default: "Editar meta")
        }

        return [meta: meta, title: title, source: params.source]
    }


    def buscarParroquias = {
        def parroquias = []
        if (params.parametro.trim().size() > 0) {
            parroquias = Parroquia.findAll("from Parroquia where nombre like '%${params.parametro.toUpperCase()}%' order by nombre")
            def provs = Provincia.findAll("from Provincia where nombre like '%${params.parametro.toUpperCase()}%' order by nombre")
            def cntns = Canton.findAll("from Canton where nombre like '%${params.parametro.toUpperCase()}%' order by nombre")
            provs.each {
                Canton.findAllByProvincia(it).each { c ->
                    Parroquia.findAllByCanton(c).each { pr ->
                        if (!parroquias.contains(pr)) {
                            parroquias.add(pr)
                        }
                    }
                }
            }
            cntns.each {c ->
                Parroquia.findAllByCanton(c).each { pr ->
                    if (!parroquias.contains(pr)) {
                        parroquias.add(pr)
                    }
                }
            }
        } else {
            parroquias = Parroquia.list([sort: "nombre", max: 20])
        }
        [parroquias: parroquias]
    }

    def buscarParroquiasEditar = {
        def parroquias = []
        if (params.parametro.trim().size() > 0) {
            parroquias = Parroquia.findAll("from Parroquia where nombre like '%${params.parametro.toUpperCase()}%' order by nombre")
            def provs = Provincia.findAll("from Provincia where nombre like '%${params.parametro.toUpperCase()}%' order by nombre")
            def cntns = Canton.findAll("from Canton where nombre like '%${params.parametro.toUpperCase()}%' order by nombre")
            provs.each {
                Canton.findAllByProvincia(it).each { c ->
                    Parroquia.findAllByCanton(c).each { pr ->
                        if (!parroquias.contains(pr)) {
                            parroquias.add(pr)
                        }
                    }
                }
            }
            cntns.each {c ->
                Parroquia.findAllByCanton(c).each { pr ->
                    if (!parroquias.contains(pr)) {
                        parroquias.add(pr)
                    }
                }
            }
        } else {
            parroquias = Parroquia.list([sort: "nombre", max: 20])
        }
        [parroquias: parroquias]
    }

    def verAvances = {
        def meta = Meta.get(params.id)
        def avances = Avance.findAllByMeta(meta, [sort: "id"])
        [meta: meta, avances: avances]
    }

    def registrarAvanceFlow = {
        inicio {
            action {
                println "inicio " + params
                def meta = Meta.get(params.meta)
                def rps = ResponsableProyecto.findAll("from ResponsableProyecto where responsable = ${session.usuario.id} and proyecto=${meta.marcoLogico.proyecto.id} and tipo=1")
                def rp
                def fecha = new Date()
                rps.each {
                    if (it.desde.before(fecha) && it.hasta.after(fecha))
                        rp = it


                }

                if (!rp) {
                    response.sendError(403)
                } else {
                    flow.responsable = rp
                }
                println "paso"
                flow.avance = new Avance()
                flow.informe = new Informe()
                if (params.id) {
                    flow.avance = Avance.get(params.id)
                    flow.informe = flow.avance.informe
                }
                flow.avance.meta = meta
                yes()
            }
            on("yes") {println "yes" }.to "informe"

        }

        informe {
            on("siguiente") {
                println "informe 2 " + flow.informe
                println "siguiente " + params
                flow.informe.fecha = new Date()
                flow.informe.avance = params.avance
                flow.informe.dificultades = params.dificultades
                flow.informe.link = params.link
                flow.informe.tipo = TipoInforme.get(3)
                flow.informe.responsableProyecto = flow.responsable
                //flow.informe.properties=params
            }.to "validarInforme"
        }

        validarInforme {
            action {
                if (!flow.informe.validate()) {
                    if (flow.informe.errors.getErrorCount() != 0) {
                        flow.informe.errors.getAllErrors().each {
                            println "erroresDeInsercion !!! " + it.field + " " + it.defaultMessage
                        }
                        no()
                    } else {
                        yes()
                    }
                } else {
                    yes()
                }
            }
            on("yes").to "avance"
            on("no").to "informe"
        }

        avance {
            on("siguiente") {
                println "siguiente " + params
                flow.avance.properties = params
            }.to "validarAvance"
            on("atras").to "informe"
        }
        validarAvance {
            action {
                if (!flow.avance.validate()) {
                    if (flow.avance.errors.getErrorCount() != 0) {
                        flow.avance.errors.getAllErrors().each {
                            println "erroresDeInsercion !!! " + it.field + " " + it.defaultMessage
                        }
                        no()
                    } else {
                        yes()
                    }
                } else {
                    yes()
                }
            }
            on("yes").to "guardar"
            on("no").to "avance"
        }

        guardar {
            action {
                flow.informe = kerberosService.saveObject(flow.informe, Informe, session.perfil, session.usuario, "registrarAvanceFlow", "meta", session)
                flow.avance.informe = flow.informe
                flow.avance = kerberosService.saveObject(flow.avance, Avance, session.perfil, session.usuario, "registrarAvanceFlow", "meta", session)
                yes()
            }
            on("yes").to "salir"
        }

        salir {
//            redirect(controller: "proyecto", action: "semplades", id: flow.proyecto.id)
            redirect(controller: "proyecto", action: "show", id: flow.avance?.meta?.marcoLogico?.proyecto?.id)
        }


    }

}
