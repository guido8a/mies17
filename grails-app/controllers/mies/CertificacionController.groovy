package mies

import mies.seguridad.Usro

class CertificacionController  extends mies.seguridad.Shield{

    def kerberosService

    def solicitarCertificacion = {
        println "params soollciitar "+params
        def usuario = session.usuario
        def band =false
        def unidad



        if(params.tipo!="arbol"){
            unidad=usuario.unidad
        }else{

            unidad=UnidadEjecutora.get(params.id)
            if (usuario.id.toInteger() == 3 || usuario.unidad.id == 85) {
                band = true
            } else {

                def resp = ResponsableProyecto.findAllByUnidadAndTipo(unidad, TipoResponsable.findByCodigo("I"))
                // println "resp "+resp
                def r = []
                def ahora = new Date()
                resp.each {
                    if (it.desde.before(ahora) && it.hasta.after(ahora))
                        r.add(it)
                }
                r.each {rp ->
                    //println "r -> "+rp
                    if (rp.responsable.id.toInteger() == session.usuario.id.toInteger())
                        band = true

                }
            }
            if (!band) {
                response.sendError(403)
            }
        }

        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        def corrientes = Asignacion.findAll("from Asignacion  where marcoLogico is null and anio=${actual.id} and unidad=${unidad.id} order by id")
        def inversion = Asignacion.findAll("from Asignacion  where marcoLogico is not null and anio=${actual.id} and unidad=${unidad.id} order by id")
        [unidad:unidad,actual:actual,corrientes:corrientes,inversion:inversion]
    }

    def listaCertificados = {
        def usuario = Usro.get(session.usuario.id)
        def band = false
        if(usuario.id.toInteger() == 3 || usuario.unidad.id==85)
            band = true
        if (band){
            def unidad=UnidadEjecutora.get(params.id)
            def actual
            if (params.anio)
                actual = Anio.get(params.anio)
            else
                actual = Anio.findByAnio(new Date().format("yyyy"))
            def corrientes = Asignacion.findAll("from Asignacion  where marcoLogico is null and anio=${actual.id} and unidad=${unidad.id} order by id")
            def inversion = Asignacion.findAll("from Asignacion  where marcoLogico is not null and anio=${actual.id} and unidad=${unidad.id} order by id")
            [unidad:unidad,actual:actual,corrientes:corrientes,inversion:inversion]
        }else{
            response.sendError(403)
        }
    }

    def certificarPac = {
        def unidad=UnidadEjecutora.get(params.id)
        def actual
        if (params.anio)
            actual = Anio.get(params.anio)
        else
            actual = Anio.findByAnio(new Date().format("yyyy"))
        def asgs = Asignacion.findAll("from Asignacion  where anio=${actual.id} and unidad=${unidad.id} order by id")
        def pac = []
        asgs.each {
            def temp = Obra.findAllByAsignacion(it,[sort:"certificado"])
            if(temp)
                pac+=temp
        }
        [unidad:unidad,actual: actual,pac:pac]
    }


    def cargarCertificados = {
        def asgn = Asignacion.get(params.id)
        def aprobados = Certificacion.findAllByAsignacionAndEstado(asgn,1)
        def solicitados =Certificacion.findAllByAsignacionAndEstado(asgn,0)
        def negados = Certificacion.findAllByAsignacionAndEstado(asgn,2)
        [aprobados:aprobados,solicitados:solicitados,negados:negados]

    }

    def guardarSolicitud = {
        println "solicitud "+params
        /*TODO enviar alertas*/
        def asg=Asignacion.get(params.asgn)
        def monto = params.monto
        monto = monto.toDouble()
        def concepto = params.concepto
        def cer = new Certificacion()
        cer.usuario=session.usuario
        cer.concepto=concepto
        cer.monto=monto
        cer.asignacion=asg
        cer.memorandoSolicitud=params.memorando
        cer = kerberosService.saveObject(cer,Certificacion,session.perfil,session.usuario,"guardarSolicitud","certificacion",session)
        render "Solicitud enviada"

    }

    def editarCertificacion = {
        def usuario = Usro.get(session.usuario.id)
        def band = false
        if(usuario.id.toInteger() == 3 || usuario.unidad.id==85)
            band = true
        if (band){
            def cer = Certificacion.get(params.id)
            def msn = null
            if (params.msn)
                msn=params.msn
            params.msn=null
            [cer:cer,msn: msn]
        }else{
            response.sendError(403)
        }
    }

    def listaSolicitudes = {

        def band = false
        def usuario = Usro.get(session.usuario.id)

        if(usuario.id.toInteger() == 3 || usuario.unidad.id==85)
            band = true
        else{

            def resp = ResponsableProyecto.findAllByUnidadAndTipo(usuario.unidad,TipoResponsable.findByCodigo("I"))
            // println "resp "+resp
            def r =[]
            def ahora = new Date()
            resp.each {
                if(it.desde.before(ahora) && it.hasta.after(ahora))
                    r.add(it)
            }
            r.each {rp->
                //println "r -> "+rp
                if(rp.responsable.id.toInteger()==session.usuario.id.toInteger())
                    band=true

            }
        }

        if(!band){
            response.sendError(403)
        }else{
            def actual
            if (params.anio)
                actual = Anio.get(params.anio)
            else
                actual = Anio.findByAnio(new Date().format("yyyy"))

            def msn = params.msn
            params.msn=""
            def mapa = [:]
            def certificaciones = Certificacion.findAllByEstado(0)

            certificaciones.each {
                def unidad = it.asignacion.unidad.nombre
                if(mapa[unidad]){
                    mapa[unidad].add(it)
                }else{
                    mapa.put(unidad,[it])
                }
            }
            def mapa2 = [:]
            certificaciones = Certificacion.findAllByEstadoGreaterThanAndFechaGreaterThan(0,new Date().parse("dd/MM/yyyy","01/01/"+actual.anio),[sort:"estado"])
            certificaciones.each {
                def unidad = it.asignacion.unidad.nombre
                if(mapa2[unidad]){

                    mapa2[unidad].add(it)
                }else{
                    mapa2.put(unidad,[it])

                }
            }
            [mapa:mapa, msn: msn,mapa2:mapa2,actual: actual]
        }
    }


    def aprobarCertificacion = {

        /*TODO enviar alertas*/
        //println "aprobar "+params
        def path = servletContext.getRealPath("/") + "certificaciones/"
        new File(path).mkdirs()

        def f = request.getFile('archivo')
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

                    "": "[\\!@\\\$%\\^&*()='\"\\/<>:;\\.,\\?]",

                    "_": "[\\s]"
            ]

            reps.each { k, v ->
                fileName = (fileName.trim()).replaceAll(v, k)
            }

            fileName = fileName+"_"+new Date().format("mm_ss")+"." + "pdf"

            def pathFile = path + File.separatorChar + fileName
            def src = new File(pathFile)
            def msn

            if (src.exists()) {
                def cer = Certificacion.get(params.id)
                msn="Ya existe un archivo con ese nombre. Por favor cámbielo."
                if (params.tipo)
                    redirect(action: 'editarCertificacion',params: [id:cer.id,unidad: cer.asignacion.unidad,msn: msn])
                else
                    redirect(action: 'listaSolicitudes',params: [msn:msn])


            } else {
                def band = false
                def usuario = Usro.get(session.usuario.id)
                def cer = Certificacion.get(params.id)
                if(usuario.id.toInteger() == 3 || usuario.unidad.id==85)
                    band = true
                else{

                    def resp = ResponsableProyecto.findAllByUnidadAndTipo(cer.asignacion.unidad,TipoResponsable.findByCodigo("I"))
                    // println "resp "+resp
                    def r =[]
                    def ahora = new Date()
                    resp.each {
                        if(it.desde.before(ahora) && it.hasta.after(ahora))
                            r.add(it)
                    }
                    r.each {rp->
                        //println "r -> "+rp
                        if(rp.responsable.id.toInteger()==session.usuario.id.toInteger())
                            band=true

                    }
                }
                if(band){

                    f.transferTo(new File(pathFile))
                    cer.archivo=fileName
                    cer.estado=1
                    if (!params.tipo)
                        cer.fechaRevision=new Date()
                    cer=kerberosService.saveObject(cer,Certificacion,session.perfil,session.usuario,"aprobarCertificacion","certificacion",session)
                    msn="Solciitud aprobada"
                    if (params.tipo)
                        redirect(action: "listaCertificados",params: [cer:cer,id: cer.asignacion.unidad.id])
                    else
                        redirect(action: 'listaSolicitudes',params: [msn:msn])
                }else{
                    msn="Usted no tiene permisos para aprobar esta solicitud"
                    if (params.tipo)
                        redirect(action: "listaCertificados",params: [cer:cer,id: cer.asignacion.unidad.id])
                    else
                        redirect(action: 'listaSolicitudes',params: [msn:msn])
                }
            }
        }
    }

    def negarCertificacion = {
        /*TODO enviar alertas*/
        def band = false
        def usuario = Usro.get(session.usuario.id)
        def cer = Certificacion.get(params.id)
        if(usuario.id.toInteger() == 3 || usuario.unidad.id==85)
            band = true
        else{

            def resp = ResponsableProyecto.findAllByUnidadAndTipo(cer.asignacion.unidad,TipoResponsable.findByCodigo("I"))
            // println "resp "+resp
            def r =[]
            def ahora = new Date()
            resp.each {
                if(it.desde.before(ahora) && it.hasta.after(ahora))
                    r.add(it)
            }
            r.each {rp->
                //println "r -> "+rp
                if(rp.responsable.id.toInteger()==session.usuario.id.toInteger())
                    band=true

            }
        }
        if(band){

            cer.estado=2
            cer.fechaRevision=new Date()
            cer=kerberosService.saveObject(cer,Certificacion,session.perfil,session.usuario,"negarCertificacion","certificacion",session)
            def msn="Solciitud negada"
            render "ok"

        }else{
            render("no")

        }


    }

    def descargaDocumento = {
        def cer = Certificacion.get(params.id)
        def path = servletContext.getRealPath("/") + "certificaciones/" + cer.archivo

        def src = new File(path)
        if (src.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${src.getName()}")

            response.outputStream << src.newInputStream()
        } else {
            render "archivo no encontrado"
        }
    }

    def certificarObra = {
        def obra = Obra.get(params.id)
        obra.certificado="S"
        obra.fechaCertificado=new Date()
        kerberosService.saveObject(obra,Obra,session.perfil,session.usuario,"certficarObra","certificacion",session)
        render "ok"
    }

}
