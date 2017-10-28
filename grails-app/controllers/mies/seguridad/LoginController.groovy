package mies.seguridad


class LoginController {

    def loginService

    def index = {
        println "index login"
    }


    def pagina = {

    }


    def login = {
        println "login "+params
        def user   = params.usuario
        def pass   = params.password
        def perfil = params.perfil

        if(params.usuario && params.password) {
            println "usuario: ${user} password: ${pass.encodeAsMD5().size()}"
            def usuario = loginService.login(user, pass)
            println "---> usuario: ${usuario}"
            if(usuario){
                flash.message = null
                session.usuario = usuario
                session.unidad = usuario.unidad
                def perfiles = loginService.perfiles(usuario)
                render(view:'index', model:[perfiles:perfiles])
            }else{
                flash.message = "Usuario o contraseña inválidos"
                render(view:'index')
            }
        }
        else{
            if(session.usuario && params.perfil){
                session.perfil=Prfl.get(params.perfil)
                def permisos=mies.seguridad.Prms.findAllByPerfil(session.perfil)
                def hp=[:]
                permisos.each{
                    hp.put(it.accion.accnNombre,it.accion.control.ctrlNombre)
                }
                session.permisos=hp

                //session.menu = loginService.menu(session.perfil.id, session.usuario.id)

//        def c = request.cookies.find {it.name == 'colores'}
                //        println "c "+c
                //        if(!c){
                //          println "no "
                //          session.color1="FF8010"
                //          session.color2=null
                //          session.colorMenu="FF9020"
                //          session.colorFuente="222"
                //          session.colorFuenteMenu="ffffff"
                //          session.colorFuenteTitulos="222222"
                //        }else{
                //          def colores = c.value.split("!")
                //          println "colores "+colores+" "+c.value
                //          session.color1=colores[0]
                //          session.color2=colores[1]
                //          session.colorMenu=colores[2]
                //          session.colorFuente=colores[3]
                //          session.colorFuenteMenu=colores[4]
                //          session.colorFuenteTitulos=colores[5]
                //        }
                if(session.an && session.cn){
                    redirect(controller:session.cn, action:session.an,params: session.pr)
                }else{
                    redirect(controller:"inicio", action:"index")
                }
            }
            else{
                session.usuario=null
                redirect(action:"index")
            }
        }
    }
    def logout = {
        if(session.usuario) {
            session.usuario = null
            session.perfil=null
            session.permisos=null
            session.menu=null
            session.invalidate()
            redirect(action:index)
        } else {
            redirect(action:'index')
        }
    }



}
