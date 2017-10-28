package mies

class InicioController extends mies.seguridad.Shield{


    def getValorReal(aa){
        if(aa.reubicada=="S"){
            if (aa.planificado==0)
                return aa.planificado
//            println "ASIGNACION aa --> "+aa.id+" val "+aa.planificado
            def dist = DistribucionAsignacion.findAllByAsignacion(aa)

//            def valor = getValorSinModificacion(aa)
            def valor = aa.planificado
//            println "valor inicial "+valor
            Asignacion.findAllByPadreAndUnidadNotEqual(aa,aa.marcoLogico.proyecto.unidadEjecutora,[sort: "id"]).each { hd->
//                println "hijo directo ------------------>  "+hd.id+" sumando "+hd.planificado
                valor+=getValorHijo(hd)
            }
//            println "valor hijos "+valor
//            def vs = getValorSinModificacion(aa)
            def vs=0
            def mas = ModificacionAsignacion.findAllByDesde(aa)
            def menos = ModificacionAsignacion.findAllByRecibe(aa)

            mas.each {
//                println "asignacion ${aa.id} tienen modificaciones 1 ${it.id}"


                if(it.recibe?.padre?.id==it.desde.id){
//                    println "sumo"
                    vs+=it.valor
                }
//                else
//                    println "no sumo"


            }
//            menos.each {
//                println "asignacion ${aa.id} tienen modificaciones 2 ${it.id}"
//
//                    vs-=it.valor
//                    println "resto"
//
//
//            }
//            println "valor de la original sin mods "+vs
//
//            println "valor total "+(valor+vs)
            valor+=vs
            dist.each {
                println "restando distribucion "+it.id+" -->  "+it.valor
                valor=valor-it.valor
            }
//            println "valor "+valor
//            println "-------------------------------"

            if (valor>aa.planificado)
                valor=aa.planificado
            if (valor<0)
                valor=0

            return valor
        }else{
            return aa.planificado
        }

    }

    def getValorHijo(asg){
        // println "get valor hijo "+asg.id
        def hijos = Asignacion.findAllByPadre(asg)
        //println "hijos "+hijos
        def val=0
        hijos.each {
            val += getValorHijo(it)
        }
        // println "return "+(val+asg.planificado)
        val = val+getValorSinModificacion(asg)
//        println "valor hijo "+asg.id+"  --> "+val
//        println ""
        return val
    }

    def getValorSinModificacion(asg){

        def valor = asg.planificado
        def mas = ModificacionAsignacion.findAllByDesde(asg)
        def menos = ModificacionAsignacion.findAllByRecibe(asg)

        mas.each {
//            println "asignacion ${asg.id} tienen modificaciones 1 ${it.id}"


            if(it.recibe?.padre?.id!=it.desde.id){
                println "sumo"
                valor+=it.valor
            }
//
//            }else
//                println "no sumo"


        }
        menos.each {
//            println "asignacion ${asg.id} tienen modificaciones 2 ${it.id}"

            if(it.recibe?.padre?.id!=it.desde.id && it.desde?.padre?.id!=it.recibe.id){
                valor-=it.valor
            }
//                println "resto"
//            }else
//                println "no sumo"



        }

//        println "valor mods  "+asg.id+"  --> "+valor

        return valor


    }


    def index = {

//        def asi = Asignacion.get(2631)
//        def val = 450000
//        def hijos = Asignacion.findAllByPadre(asi)
//        println "hijos "+hijos
//        def mods= ModificacionAsignacion.findAllByDesdeOrRecibe(asi,asi,[sort: "id"])
//        mods.each {
//
//            if (it.desde.id==2631){
//                println "+  "+it.id+"  "+it.fecha+"  "+it.valor+"  "+it.desde.id
//                val=val-it.valor
//            }else{
//                println "-  "+it.id+"  "+it.fecha+"  "+it.valor +"  "+it.recibe.id
//                val=val+it.valor
//            }
//        }
//        println "valor final "+val

        if(!session.unidad){
            redirect(controller:"login",action: "logout")
        }
//
//        def aa = Asignacion.get(4469)
//        println "get valor real "+getValorReal(aa)






    }

    def mostrarAlertas = {
        //ejemplo de como mandar alertas
        //kerberosService.generarAlerta(session.usuario,finix.seguridad.Usro.get(48),"que eres pal burro","proceso","show",8)
        //        println "alertas "+alertas
        def alertas = mies.alertas.Alerta.findAllByUsroAndFec_recibido(session.usuario,null,[sort:"fec_envio"])
        return [alertas:alertas]
    }

    def showAlerta = {
        def alerta = mies.alertas.Alerta.get(params.id)
        alerta.fec_recibido=new Date()
        alerta.save(flush:true)
        params.id=alerta.id_remoto
        redirect(controller:alerta.controlador,action:alerta.accion,params:params)
    }

    def parametros = {

    }

    def verificarSession = {
        println "verificando session "
        if(session.usuario && session.perfil)
            render "ok"
        else
            render "no"
    }


}
