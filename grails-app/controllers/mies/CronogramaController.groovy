package mies

class CronogramaController extends mies.seguridad.Shield{

    def kerberosService
    def dbConnectionService

    def nuevoCronograma = {
        println "nuevo cronograma "+params
        def colores= ["#DD7B42","#FFAB48","#FFE7AD","#A7C9AE","#888A63"]
        def proyecto = Proyecto.get(params.id)
        def componentes = MarcoLogico.findAll("from MarcoLogico where proyecto=${proyecto.id} and tipoElemento=2 and estado=0 order by id")
        def anio
        if(!params.anio)
            anio = Anio.findByAnio(new Date().format("yyyy").toString())
        else
            anio = Anio.get(params.anio)
        if(!anio)
            anio = Anio.findAll("from Anio order by anio").pop()
        def finan = Financiamiento.findAllByProyectoAndAnio(proyecto,anio)
        def fuentes = []
        def totAnios = [:]
        finan.each {
            fuentes.add(it.fuente)
            totAnios.put(it.fuente.id,it.monto)
        }
        println "anio "+anio+" total anios "+totAnios
        [proyecto:proyecto,componentes:componentes,anio:anio,fuentes:fuentes,colores:colores,totAnios:totAnios]

    }

    def guardarDatosCronograma = {
        println "guardar "+params
        def crg
        if(params.id && params.id!="" && params.id!=" " && params.id!="0"){
            crg = Cronograma.get(params.id)
            crg.valor = params.valor.toDouble()

            crg.fuente = Fuente.get(params.fuente)
            crg.presupuesto=Presupuesto.get(params.prsp)
            if (params.prsp2 && params.prsp2!=""){
                crg.valor2=params.valor2.toDouble()
                crg.presupuesto2=Presupuesto.get(params.prsp2)
            }else{
                crg.presupuesto2=null
                crg.valor2=0
            }
        }else{
            crg = new Cronograma()
            crg.marcoLogico = MarcoLogico.get(params.act)
            crg.valor = params.valor.toDouble()
            crg.valor2=params.valor2.toDouble()
            crg.fuente = Fuente.get(params.fuente)
            crg.anio=Anio.get(params.anio)
            crg.mes=Mes.get(params.mes)
            crg.presupuesto=Presupuesto.get(params.prsp)
            if (params.prsp2  && params.prsp2!="" && params.valor2.toDouble()>0){

                crg.valor2=params.valor2.toDouble()
                crg.presupuesto2=Presupuesto.get(params.prsp2)
            }
        }
        def marco = MarcoLogico.get(params.act)
        def valor  = 0
        Cronograma.findAllByMarcoLogicoAndCronogramaIsNull(marco).each{

            if(it.id!=crg.id)
                valor+=(it.valor+it.valor2)
        }
//        println "valor!!! "+valor+" "+params.valor
        if(marco.monto>=valor+params.valor.toDouble()+params.valor2.toDouble()){
            crg = kerberosService.saveObject(crg, Cronograma, session.perfil, session.usuario, "guardarDatosCronograma", "cronograma", session)
            println " crg "+ crg.errors.getErrorCount()
            if(crg.errors.getErrorCount()!=0){

                render "no"
            } else {
                render crg.id
            }
        }else{
            render("no")
        }
    }

    boolean verificarHijas(asgn){
        def hijas = Asignacion.findAllByPadre(asgn)
        def res = true
        println "verificando "+asgn.id
        hijas.each {
            println "verificando hija "+it.id
            res = verificarHijas(it)
            if (!res)
                return false
            if( DistribucionAsignacion.findAllByAsignacion(it).size()>0){
                return false
            }
            if(ModificacionAsignacion.findAllByDesdeOrRecibe(it,it).size()>0){
                return false
            }
            if(Certificacion.findAllByAsignacion(it).size()>0)
                return false
        }


        if( DistribucionAsignacion.findAllByAsignacion(asgn).size()>0){
            return false
        }
        if(ModificacionAsignacion.findAllByDesdeOrRecibe(asgn,asgn).size()>0){
            return false
        }
        if(Certificacion.findAllByAsignacion(asgn).size()>0)
            return false

        println "paso... true"
        return true
    }


    def eliminaHijas(asgn){
        def hijas = Asignacion.findAllByPadre(asgn)
        def masHijas = []
        def res = true

        hijas.each {
            if (res){
                res = eliminaHijas(it)

                println " ---------------- borra programaciones"

                ProgramacionAsignacion.findAllByAsignacion(it).each { prg->
                    prg.delete(flush:true)
                }
                Obra.findAllByAsignacion(it).each { ob->
                    ob.delete(flush:true)
                }


//            Certificacion.findAllByAsignacion(it).each {cr->
//                cr.delete(flush: true)
//            }



                println "borradas PAC----------------"
                try{
                    println "Asignacion a borrar: ${it.id}"
                    it.delete(flush: true)
                }catch (e){
                    res = false
                }
            }
        }

        if (res){
            try {
                ProgramacionAsignacion.findAllByAsignacion(asgn).each { prg->
                    prg.delete(flush:true)
                }
                Obra.findAllByAsignacion(asgn).each { ob->
                    ob.delete(flush:true)
                }

            }catch (e){
                println "no pudo  borrar 2 "
                res = false

            }
        }

        return res

    }

    def calcularAsignaciones = {
        println "calc asg "+params
        def proyecto = Proyecto.get(params.proyecto)
        def anio=Anio.get(params.anio)
        def cn = dbConnectionService.getConnection()
        def res = true
        def asignaciones = []
        MarcoLogico.findAll("from MarcoLogico where tipoElemento=3 and proyecto=${proyecto.id} and estado=0 ").each{ comp->
            def asgs= Asignacion.findAll("from Asignacion where marcoLogico=${comp.id} and anio=${anio.id} and padre is null ")
            asgs.each {aa->
                if (res){
                    res = verificarHijas(aa)
                    asignaciones.add(aa)
                }
            }

        }
        if(res){
            asignaciones.each {asg->

                res = eliminaHijas(asg)
                if (res){
                    try{
                        params.id=asg.id
                        kerberosService.delete(params,Asignacion,session.perfil,session.usuario)
                    }catch (e){
                        println "no pudo borrar  "+params.id+"  e "+e
                        res = false
                    }
                }


            }
        }

        /*Inicio del cambio!!! usando views*/

        if(!res){
            render "no"
        }else{
            //creo la vista
            def nombreVista = "vista_asg_${session.usuario.id}"
            def sqlView="CREATE or replace  VIEW ${nombreVista} as (SELECT c.crng__id as crono,c.mrlg__id as mrlg,c.fnte__id as fuente,c.anio__id as anio,c.prsp__id as prsp,c.messvlor as valor from crng c,mrlg m where c.mrlg__id=m.mrlg__id and m.proy__id=${proyecto.id} and m.tpel__id=3 and m.mrlgetdo=0 and c.anio__id = ${anio.id})union(SELECT c.crng__id as crono,c.mrlg__id as mrlg,c.fnte__id as fuente,c.anio__id as anio,c.prsp2_id as prsp,c.mesvlor2 as valor from crng c,mrlg m where c.mrlg__id=m.mrlg__id and m.proy__id=${proyecto.id} and m.tpel__id=3 and m.mrlgetdo=0 and c.anio__id = ${anio.id} and prsp2_id is not null);"
            //println "sql "+sqlView
            cn.execute(sqlView.toString())
            /*fin del cambio*/

            def sql = "select c.mrlg, c.fuente,c.prsp,sum(c.valor) from ${nombreVista} c,mrlg m where c.mrlg=m.mrlg__id and m.proy__id=${proyecto.id} and m.tpel__id=3 and m.mrlgetdo=0 and c.anio = ${anio.id} group by c.mrlg,c.fuente,c.prsp order by 1"
            //println "sql "+sql
            cn.eachRow(sql.toString()){row->
                //println "row "+row
                def asg = new Asignacion()
                asg.marcoLogico=MarcoLogico.get(row.mrlg)
                asg.anio=anio
                asg.presupuesto=Presupuesto.get(row.prsp)
                asg.fuente=Fuente.get(row.fuente)
                asg.planificado=row.sum
                asg.unidad=proyecto.unidadEjecutora
                asg = kerberosService.saveObject(asg,Asignacion,session.perfil,session.usuario,"calcularAsignaciones","cronograma",session)
                def maxNum = 1
                def band =true
                def prsp1 = false
                Cronograma.findAll("from Cronograma where marcoLogico=${row.mrlg} and fuente=${row.fuente} and anio=${anio.id} and presupuesto=${row.prsp}").each{ crg->
                    // println crg.valor+"  mes "+crg.mes.descripcion+" mrlg "+crg.marcoLogico.id

                    maxNum=crg.mes.numero
                    def progra=new ProgramacionAsignacion()
                    progra.mes=crg.mes
                    progra.asignacion=asg
                    progra.cronograma=crg
                    progra.valor=crg.valor
                    progra.cronograma=crg
                    progra=kerberosService.saveObject(progra,ProgramacionAsignacion,session.perfil,session.usuario,"calcularAsignaciones","cronograma",session)
                }

                Cronograma.findAll("from Cronograma where marcoLogico=${row.mrlg} and fuente=${row.fuente} and anio=${anio.id} and presupuesto2=${row.prsp}").each{ crg->
                    //println crg.valor+"  mes "+crg.mes.descripcion+" mrlg "+crg.marcoLogico.id
                    maxNum=crg.mes.numero
                    def progra=new ProgramacionAsignacion()
                    progra.mes=crg.mes
                    progra.asignacion=asg
                    progra.cronograma=crg
                    progra.valor=crg.valor2
                    progra=kerberosService.saveObject(progra,ProgramacionAsignacion,session.perfil,session.usuario,"calcularAsignaciones","cronograma",session)
                }




            }

            sqlView="drop VIEW vista_asg_${session.usuario.id};"
            //println "sql "+sqlView
            cn.execute(sqlView.toString())
            cn.close()

            render "ok"
        }




    }

    def verCronograma = {
        println "nuevo cronograma "+params
        def colores= ["#DD7B42","#FFAB48","#FFE7AD","#A7C9AE","#888A63"]
        def proyecto = Proyecto.get(params.id)
        def componentes = MarcoLogico.findAll("from MarcoLogico where proyecto=${proyecto.id} and tipoElemento=2 and estado=0 order by id")
        def fuentes = Financiamiento.findAllByProyecto(proyecto).fuente
        def anio
        if(!params.anio)
            anio = Anio.findByAnio(new Date().format("yyyy").toString())
        else
            anio = Anio.get(params.anio)
        if(!anio)
            anio = Anio.findAll("from Anio order by anio").pop()
        println "anio "+anio
        [proyecto:proyecto,componentes:componentes,anio:anio,fuentes:fuentes,colores:colores]
    }


}
