<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

        <title>Documentos de ${unidad.nombre}</title>
        <style type="text/css">
        .field {
            width : 350px;
        }

        select.field {
            width : 353px;
        }
        </style>

    </head>

    <body>

        <div class="dialog">

            <g:link action="arbol" class="button arbol">Unidades ejecutoras</g:link>

            <g:if test="${flash.message}">
                <div style="padding: 0.7em; margin-top: 10px;" class="mensaje ui-state-${flash.estado} ui-corner-all">
                    <p>
                        <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-${flash.icon}"></span>
                        ${flash.message}
                    </p>
                </div>
            </g:if>

            <div class="body">
                <div class="list" style="width: 1050px;">
                    <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                        <div id="example_length" class="dataTables_length">
                            <div class="botones">
                                <div class="botones left">
                                    <a href="#" id="add" class="button add">Agregar</a>

                                    <a href="#" id="del" class="button del">Eliminar</a>
                                </div>

                                <div class="botones left" style="margin-left: 15px; font-weight: normal;">
                                    Mostrando 1 a ${documentoInstanceList.size()} de ${documentoInstanceTotal}
                                </div>

                                <div class="botones right">
                                    <g:form action="docsFromTree" class="frm_busca">
                                        <g:hiddenField name="id" value="${unidad.id}"/>
                                        <input name="busca" value="${params.busca}"
                                               class="ui-widget-content ui-corner-all"/>

                                        <a href="#" class="button search">Buscar</a>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <g:form action="docsFromTreeDelete" method="post" class="frm_docs">
                        <g:hiddenField name="unidad" value="${unidad.id}"/>
                        <table style="width: 1050px;">
                            <thead>
                                <tr>
                                    <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                        title="${message(code: 'documento.descripcion.label', default: 'Descripción')}"/>
                                    <tdn:sortableColumn property="clave" class="ui-state-default"
                                                        title="${message(code: 'documento.clave.label', default: 'Clave')}"/>
                                    <tdn:sortableColumn property="resumen" class="ui-state-default"
                                                        title="${message(code: 'documento.resumen.label', default: 'Resumen')}"/>

                                    <th class="ui-state-default" style="width: 86px;">
                                        Acciones
                                    </th>

                                    <th class="ui-state-default">
                                        <input type="checkbox" id="chk_all"/>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
                                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                        <td>${fieldValue(bean: documentoInstance, field: "descripcion")}</td>

                                        <td>${fieldValue(bean: documentoInstance, field: "clave")}</td>

                                        <td>${fieldValue(bean: documentoInstance, field: "resumen")}</td>

                                        <td style="text-align: center;">
                                            <g:link action="docsFromTreeDownload" id="${documentoInstance.id}"
                                                    params="${[unidad:unidad.id]}"
                                                    class="button download">Descargar</g:link>
                                            <a href="#" id="${documentoInstance.id}" class="button ver">Ver</a>

                                            <a href="#" id="${documentoInstance.id}" class="button edit">Editar</a>
                                        </td>

                                        <td style="text-align: center;">
                                            <input type="checkbox" value="${documentoInstance.id}" name="id"
                                                   class="chk">
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>

                        <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                            <tdn:paginate total="${documentoInstanceTotal}" id="${unidad.id}"/>
                        </div>
                    </g:form>

                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <div id="dlg_doc" title="Agregar documento"></div>

        <div id="dlg_editar" title="Editar información del documento"></div>

        <div title="Documento" id="dlg_ver"></div>

        <script type="text/javascript">

            function esconder() {
                $(".mensaje").hide("slow");
            }

            $(function () {

                if ($(".mensaje").is(":visible")) {
                    setTimeout("esconder()", 3000);
                }

                var clase = "ui-state-highlight";

                $("#chk_all").click(function () {
                    $(".chk").attr("checked", $(this).is(":checked"));
                    if ($(this).is(":checked")) {
                        $(".chk").parent().parent().addClass(clase);
                    } else {
                        $(".chk").parent().parent().removeClass(clase);
                    }
                });

                $(".chk").click(function () {
                    var sel = true;
                    $(".chk").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).parent().parent().addClass(clase);
                            sel = sel & true;
                        } else {
                            $(this).parent().parent().removeClass(clase);
                            sel = sel & false;
                        }
                    });
                    if (sel) {
                        $("#chk_all").attr("checked", true);
                    } else {
                        $("#chk_all").attr("checked", false);
                    }
                });

                $("#dlg_ver").dialog({
                    autoOpen:false,
                    modal:true,
                    width:800,
                    buttons:{
                        "Cerrar":function () {
                            $(this).dialog("close");
                        }
                    }
                });

                $("#dlg_doc").dialog({
                    autoOpen:false,
                    modal:true,
                    width:500,
                    buttons:{
                        "Cancelar":function () {
                            $(this).dialog("close");
                        },
                        "Guardar":function () {
                            $(".frm_doc").submit();
                        }
                    }
                });

                $("#dlg_editar").dialog({
                    autoOpen:false,
                    modal:true,
                    width:500,
                    buttons:{
                        "Cancelar":function () {
                            $(this).dialog("close");
                        },
                        "Guardar":function () {
                            $(".frm_doc").submit();
                        }
                    }
                });

                $(".button").button();

                $(".arbol").button("option", "icons", {primary:'ui-icon-bullet'});

                $(".download").button("option", "icons", {primary:'ui-icon-arrowrefresh-1-s'});
                $(".download").button("option", "text", false);

                $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
                $(".edit").button("option", "text", false).click(function () {
                    var id = $(this).attr("id");
                    $.ajax({
                        type:"POST",
                        url:"${createLink(action:'docsFromTreeEdit')}",
                        data:{
                            unidad:${unidad.id},
                            id:id
                        },
                        success:function (msg) {
                            $("#dlg_editar").html(msg);
                        }
                    });
                    $("#dlg_editar").dialog("open");
                    return false;
                });

                $(".ver").button("option", "icons", {primary:'ui-icon-zoomin'});
                $(".ver").button("option", "text", false).click(function () {
                    var id = $(this).attr("id");
                    $.ajax({
                        type:"POST",
                        url:"${createLink(action:'docsFromTreeVer')}",
                        data:{
                            id:id
                        },
                        success:function (msg) {
                            $("#dlg_ver").html(msg);
                        }
                    });
                    $("#dlg_ver").dialog("open");
                    return false;
                });

                $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});
                $(".add").button("option", "icons", {primary:'ui-icon-plusthick'}).click(function () {
                    $.ajax({
                        type:"POST",
                        url:"${createLink(action:'docsFromTreeEdit')}",
                        data:{
                            unidad:${unidad.id}
                        },
                        success:function (msg) {
                            $("#dlg_doc").html(msg);
                        }
                    });
                    $("#dlg_doc").dialog("open");
                    return false;
                });
                $(".search").button("option", "icons", {primary:'ui-icon-search'}).click(function () {
                    $(".frm_busca").submit();
                    return false;
                });
                $(".del").button("option", "icons", {primary:'ui-icon-trash'}).click(function () {
                    var sel = $(".chk:checked").length
                    if (sel > 0) {
                        if (confirm("Eliminar los documentos seleccionados?")) {
                            $(".frm_docs").submit();
                        } else {
                            return false;
                        }
                    } else {
                        alert("Seleccione al menos un archivo para eliminar");
                        return false;
                    }
                });
            });
        </script>

    </body>
</html>
