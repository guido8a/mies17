<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Inicio</title>
    <meta name="layout" content="main"/>
    <style type="text/css">
    @page {
        size: 8.5in 11in;  /* width height */
        margin: 0.25in;
    }
    .item{
        width: 170px;height: 180px;float: left;margin: 8px;
        /*border:1px solid #A6C9E2;*/
        /*background-color: white;*/

    }
    .imagen{
        width: 80px;
        height: 80px;
        margin: auto;
        margin-top: 15px;
    }
    .texto{
        width: 90%;
        height: 50px;
        padding-top: 20px;
        /*border: solid 1px black;*/
        margin: auto;
        margin-top: 5px;
        /*font-family: fantasy; */
        font-size: 12px;
        font-weight: bolder;
        font-style: oblique;
        text-align: center;

    }
    .fuera{
        margin-left: 15px;
        margin-top: 10px;
        background-color: #A6C9E2;
    }
    </style>
</head>
<body>
%{-- TODO: Cambiar a: proyectos, biblioteca, entidades, asiganaciones, alertas, informes, --}%
<div class="dialog">
    <div class="body" style="width: 1000px;height: 680px;position: relative;">
        <div style="width: 50%;height: 90%;float: left">
            <div style="width: 300px;border: 1px solid white;margin: auto;margin-top: 130px" class="ui-corner-all">
                <img src="${resource(dir: 'images', file: 'mies_logo.png')}" alt="mies" width="100%" />
            </div>
            <div style="width: 400px; font-size: 1.5em; margin-top: 15px; padding-left: 50px">
                    Sistema de Seguimiento y Control de Programas y Proyectos del Plan Anual de la Política Pública
            </div>
        </div>
        <div style="width: 45%;height: 90%;float: left;padding-left: 40px;">
            <g:link  controller="proyecto" action="list" title="Gestion de proyectos">
                <div  class="ui-corner-all ui-widget-content item fuera">
                    <div  class="ui-corner-all ui-widget-content item">
                        <div class="imagen">
                            <img src="${resource(dir: 'images', file: 'proyecto.jpg')}" width="100%" height="100%"/>
                        </div>
                        <div class="texto">Proyectos</div>
                    </div>
                </div>
            </g:link>
            <g:link  controller="documento" action="list" title="Biblioteca de Proyectos">
                <div  class="ui-corner-all ui-widget-content item fuera">
                    <div  class="ui-corner-all ui-widget-content item">
                        <div class="imagen">
                            <img src="${resource(dir: 'images', file: 'libros2.jpg')}" width="100%" height="100%"/>
                        </div>
                        <div class="texto">Biblioteca de Proyectos</div>
                    </div>
                </div>
            </g:link>
            <g:link  controller="entidad" action="arbol_asg"  id="${session.unidad.id}" title="Asignaciones de Inversión - Proyectos ">
                <div  class="ui-corner-all ui-widget-content item fuera">
                    <div  class="ui-corner-all ui-widget-content item">
                        <div class="imagen">
                            <img src="${resource(dir: 'images', file: 'dinero2.jpg')}" width="100%" height="100%"/>
                        </div>
                        <div class="texto">Asignaciones Inversión</div>
                    </div>
                </div>
            </g:link>
            <g:link  controller="asignacion" action="asignacionesCorrientes"  id="${session.unidad.id}" title="Asignaciones del Gasto Corriente">
                <div  class="ui-corner-all ui-widget-content item fuera">
                    <div  class="ui-corner-all ui-widget-content item">
                        <div class="imagen">
                            <img src="${resource(dir: 'images', file: 'dinero.jpg')}" width="100%" height="100%"/>
                        </div>
                        <div class="texto">Asignaciones Gasto Corriente</div>
                    </div>
                </div>
            </g:link>
            <g:link  controller="informe" action="create" title="Informes del estado del proyecto ">
                <div  class="ui-corner-all ui-widget-content item fuera">
                    <div  class="ui-corner-all ui-widget-content item">
                        <div class="imagen">
                            <img src="${resource(dir: 'images', file: 'informe.jpg')}" width="100%" height="100%"/>
                        </div>
                        <div class="texto">Informe del Proyecto</div>
                    </div>
                </div>
            </g:link>
            <g:link  controller="inicio" action="mostrarAlertas" title="Ver alertas pendientes ">
                <div  class="ui-corner-all ui-widget-content item fuera">
                    <div  class="ui-corner-all ui-widget-content item">
                        <div class="imagen">
                            <img src="${resource(dir: 'images', file: 'alerta.jpg')}" width="100%" height="100%"/>
                        </div>
                        <div class="texto">Alertas</div>
                    </div>
                </div>
            </g:link>

        </div>
        <div style="height: 25px;width: 200px;position:absolute;bottom: 1px;right: 5px;text-align: right">Versión 1.1.30a</div>
    </div>
</div>
<script type="text/javascript">
    $(".fuera").hover(function(){
        var d =  $(this).find(".imagen")
        d.width(d.width()+10)
        d.height(d.height()+10)
//        $.each($(this).children(),function(){
//            $(this).width( $(this).width()+10)
//        });
    },function(){
        var d =  $(this).find(".imagen")
        d.width(d.width()-10)
        d.height(d.height()-10)
    })
</script>
</body>
</html>