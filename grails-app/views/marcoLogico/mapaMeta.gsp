<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/28/11
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>
            Mapa de la provincia
        </title>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
              type="text/css"/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
              type="text/css"/>

        <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
                language="JavaScript"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
                type="text/javascript" language="JavaScript"></script>

        <style type="text/css">
        .pin {
            cursor   : pointer;
            z-index  : 50;
            position : absolute;
        }

        .remove {
            background : #deb887;
            border     : solid 2px #8b4513;
            padding    : 6px;
            width      : 24px;
            height     : 40px;
        }

        .area {
            width    : 755px;
            position : relative;
        }

        .provincia {
            /*z-index : 1;*/
        }
        </style>

    </head>

    <body>

        <div class="breadCrumbHolder module">
            <div id="breadCrumb" class="breadCrumb module">
                <ul>
                    <li>
                        <g:link class="bc" controller="proyecto" action="show"
                                id="${componente.proyecto.id}">
                            Proyecto
                        </g:link>
                    </li>
                    <li>
                        <g:link class="bc" controller="marcoLogico" action="showMarco"
                                id="${componente.proyecto.id}">
                            Marco L&oacute;gico
                        </g:link>
                    </li>
                    <li>
                        <g:link class="bc" controller="marcoLogico" action="componentes"
                                id="${componente.proyecto.id}">
                            Componentes
                        </g:link>
                    </li>
                    <li>
                        <g:link class="bc" action="ingresoMetas" id="${meta.marcoLogico.id}">
                            Metas
                        </g:link>
                    </li>
                    <li>
                        Mapa
                    </li>
                </ul>
            </div>
        </div>

        <div id="" class="toolbar ui-widget-header ui-corner-all" style="margin-bottom: 5px;">
            <g:link class="button save">
                Guardar
            </g:link>
        </div> <!-- toolbar -->


        <div style="margin-bottom: 15px; margin-top: 15px;">
            Posicione el ícono en el lugar que desee ubicar la meta <strong>${meta.descripcion}</strong> (${meta.parroquia} - ${meta.parroquia?.canton})
            <g:form action="guardarMapaMeta" name="frmMapaMeta">
                <input type="hidden" id="coordX" name="coordX"/>
                <input type="hidden" id="coordY" name="coordY"/>
            </g:form>
        </div>

        <div class="area" style="min-height: 600px;overflow: auto;float: left">
            <div class="remove left ui-corner-all" style="margin-right: 15px;">
                <img src="${resource(dir: 'images', file: 'red_pin.png')}" class="pin" alt="Pin" data-text="${ttip}"
                     data-title="${ttitle}"
                     style="${(meta.cord_y > 0 && meta.cord_x > 0) ? 'top: ' + meta.cord_y + 'px; left: ' + meta.cord_x + 'px;' : ''}">
            </div>

            <div class="provincia left" style="min-height: 550px">
                <img src="${resource(dir: 'images/mapas/provincias', file: provincia.imagen)}"
                     alt="${provincia.nombreMostrar}" width="680"/>
            </div>
        </div>

        <script type="text/javascript">
            $(function() {
                $(".button").button();
                $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});
                $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
                    var datos = $("#frmMapaMeta").serialize();
                    datos += "&id=${meta.id}&c=${componente.id}";
                    var url = $("#frmMapaMeta").attr("action");
                    url += "?" + datos
                    location.href = url;
                    return false
                });

                $("#breadCrumb").jBreadCrumb({
                    beginingElementsToLeaveOpen: 10
                });

                $("#coordX").val("${meta.cord_x}");
                $("#coordY").val("${meta.cord_y}");

                $('.pin').qtip({
                    content: {
                        text: function(api) {
                            return $(this).attr('data-text');
                        },
                        title: {
                            text: function(api) {
                                return $(this).attr('data-title');
                            }
                        }
                    },
                    hide: {
                        delay : 0,
                        leave: false
                    },
                    position: {
                        my: 'top left',  // Position my top left...
                        at: 'bottom right' // at the bottom right of...
                    },
                    style: {
                        classes:'ui-tooltip-rounded ui-tooltip-tipped'
                    }
                });


                $(".pin").draggable({
                    revert: "invalid",
                    scroll: false,
                    containment: ".area",
                    stop: function(event, ui) {
                        var top = ui.position.top;
                        var left = ui.position.left;
                        $("#coordX").val(number_format(left, 0, ".", ""));
                        $("#coordY").val(number_format(top, 0, ".", ""));
                    }
                });

                $(".provincia, .remove").droppable({
                });
            });
        </script>

    </body>
</html>