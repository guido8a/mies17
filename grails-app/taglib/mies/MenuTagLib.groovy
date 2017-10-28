package mies

class MenuTagLib {

    def dbConnectionService

    String createMenu(perfil, bordeAlertas, divs) {

        def borde = bordeAlertas ? "style='border:2px red solid'" : ""

        def clase = !divs ? 'class="ui-helper-hidden"' : ''

        def menu = "<ul id='menuGlobal' " + clase + ">"
        def cn = dbConnectionService.getConnection()
        def cnd = dbConnectionService.getConnection()
        cn.eachRow(" select distinct mdlo.mdlo__id as id ,mdlo. mdlonmbr as nombre,mdlo.mdloordn " +
                "from mdlo , accn , prms " +
                "where prms.accn__id = accn.accn__id and mdlo.mdlo__id=accn.mdlo__id and " +
                "prms.prfl__id =${perfil.id} order by mdlo.mdloordn ") {
            menu += "<li>"
            menu += '<a href="#" class="parent">'
            menu += it.nombre
            menu += '</a>'
            if (divs) {
                menu += '<span></span>'
                menu += '<div>'
            }
            menu += '<ul>'
            cnd.eachRow("select accn.accnnmbr as nombre, accn.accndscr as dscr, accn.tpac__id as tipo, " +
                    "ctrl.ctrlnmbr as controlador from ctrl, accn , prms " +
                    "where prms.accn__id = accn.accn__id and accn.ctrl__id=ctrl.ctrl__id and " +
                    "prms.prfl__id = ${perfil.id} and accn.mdlo__id = ${it.id} order by accndscr") {rs ->
                if (rs.tipo == 1) {
                    menu += '<li>'
                    if (divs) {
                        menu += '<span></span>'
                    }
                    menu += '<a href="' + g.createLink(controller: "${rs.controlador.substring(0,1).toLowerCase()+rs.controlador.substring(1,rs.controlador.size())}", action: "${rs.nombre}") + '" class="parent" title="' + rs.dscr + '">'
                    menu += rs.dscr
                    menu += '</a>'
                    menu += '</li>'
                }
            }
            menu += "</ul>"
            if (divs) {
                menu += "</div>"
            }
            menu += "</li>"

        }

        /** ***************************Alertas                                         ********************************************************/
        menu += "<li " + borde + ">"
        menu += '<a href="#" class="parent" >'
        menu += 'Alertas'
        menu += '</a>'
        if (divs) {
            menu += '<span></span>'
            menu += '<div>'
        }
        menu += '<ul>'
        menu += '<li>'
        if (divs) {
            menu += '<span></span>'
        }
        menu += '<a href="' + g.createLink(controller: "inicio", action: "mostrarAlertas") + '" class="parent" title="Ver alertas">'
        menu += 'Ver alertas'
        menu += '</a>'
        menu += '</li>'
        menu += "</ul>"
        if (divs) {
            menu += "</div>"
        }
        menu += "</li>"

        /** ***************************Logout                                         *********************************************************/
        menu += "<li>"
        menu += '<a href="#" class="parent" >'
        menu += 'Salir'
        menu += '</a>'
        if (divs) {
            menu += '<span></span>'
        }
        if (divs) {
            menu += '<div>'
        }
        menu += '<ul>'
        menu += '<li>'
        if (divs) {
            menu += '<span></span>'
        }
        menu += '<a href="' + g.createLink(controller: "login", action: "logout") + '" class="parent" title="Salir del sistema">'
        menu += 'Cerrar Sesión'
        menu += '</a>'
        menu += '</li>'
        menu += "</ul>"
        if (divs) {
            menu += "</div>"
        }
        menu += "</li>"

        menu += "</ul>"

        cn.close()
        cnd.close()

        return menu
    }

    def generarMenuVertical = {attrs ->
        def usuario = session.usuario
        def perfil = session.perfil
        if (usuario && perfil) {
            def modulos
            def menu = '<link rel="stylesheet" href="' + g.resource(dir: 'css', file: 'menuVertical.css') + '"/>'
            menu += createMenu(perfil, true, true)
            menu += '<script type="text/javascript">'
            menu += '$(function() {'
            menu += '$(\'#treeMenu ul li:has("div")\').find("span:first").addClass("closed");'
            menu += '$(\'#treeMenu ul li:has("div")\').find("div").hide();'
            menu += '$(\'#treeMenu li:has("div")\').find("span:first").click(function () {'
            menu += '$(this).parent("li").find("span:first").toggleClass("opened");'
            menu += '$(this).parent("li").find("div:first").slideToggle();'
            menu += '});'
            menu += '$(\'#treeMenu li:has("div")\').find("a:first").click(function () {'
            menu += '$(this).parent("li").find("span:first").toggleClass("opened");'
            menu += '$(this).parent("li").find("div:first").slideToggle();'
            menu += 'return false;'
            menu += '});'
            menu += '});'
            menu += '</script>'
            out << menu
        }
    }

    def generarMenuHorizontal = {attrs ->
        def usuario = session.usuario
        def perfil = session.perfil
        if (usuario && perfil) {
            def modulos
            def menu = ""

            menu += '<link rel="stylesheet" href="' + g.resource(dir: 'js/jquery/kendo/styles', file: 'kendo.common.min.css') + '"/>'

            menu += '<link rel="stylesheet/less" type="text/css" href="' + g.resource(dir: 'js/jquery/kendo/styles', file: 'kendo.css.less') + '">'
            menu += '<script src="' + g.resource(dir: 'js', file: 'less-1.1.3.min.js') + '" type="text/javascript"></script>'

//            menu += '<link rel="stylesheet" href="' + g.resource(dir: 'js/jquery/kendo/styles', file: 'kendo.blue.css') + '"/>'
            menu += '<script type="text/javascript" src="' + g.resource(dir: 'js/jquery/kendo/js', file: 'kendo.all.min.js') + '"></script>'
            menu += '<link rel="stylesheet" href="' + g.resource(dir: 'css', file: 'menuHorizontal.css') + '"/>'
            menu += createMenu(perfil, true, false)
            menu += '<script type="text/javascript">'
            menu += '$(function() {'
            menu += '$("#menuGlobal").kendoMenu({'
            menu += 'openOnClick: true'
            menu += '}).show();'
            menu += '});'
            menu += '</script>'
            out << menu
        }
    }

    def generarMenuPreview = {attrs ->
        def perfil = mies.seguridad.Prfl.get(attrs.perfil)
        def modulos
        def menu = createMenu(perfil, false, true)
        out << menu
    }


}
