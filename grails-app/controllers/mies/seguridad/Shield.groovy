package mies.seguridad

class Shield{
    def beforeInterceptor = [action:this.&auth,except:'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {
        println "an "+actionName+" cn "+ controllerName+"  "
        if(!session.usuario || !session.perfil){

            if(controllerName != "inicio" && actionName != "index") {
                flash.message = "Usted ha superado el tiempo de inactividad máximo de la sesión"
            }
            render "<script type='text/javascript'> window.location.href = '${createLink(controller:'login', action:'login')}'; </script>"
            session.finalize()
            return false

/*
            if(actionName=~"verificarSession"){
                session.an="inicio"
                session.cn="inicio"

            }else{
                session.an=actionName
                session.cn=controllerName
                session.pr=params
            }
*/
            //println "session .pr "+session.pr
/*
            redirect(controller:'login',action:'login')
            session.finalize()
            return false
*/

        } else {

            //verificacion de permisos
            if(!session.unidad){
                if(controllerName=="proyecto"){
                    if(this.isAllowed() )
                        return true

                    response.sendError(403)
                    return false
                }else{
                    try{
                        def usuario = session.usuario
                        session.unidad = usuario.unidad
                        if(this.isAllowed() )
                            return true

                        response.sendError(403)
                        return false
                    } catch (e){

                        redirect(controller:'login',action:'login')
                        session.finalize()
                        return false
                    }

                }
            }else{
                if(this.isAllowed() )
                    return true

                response.sendError(403)
                return false
            }
        }
    }

    boolean isAllowed(){

        try{
            if(session.permisos[actionName]==controllerName)
                return true
        }catch(e){
            println "execption e"+e
            return true
        }
        return true
    }
}

