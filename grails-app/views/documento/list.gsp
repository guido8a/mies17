<%@ page import="mies.Documento" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}"/>
        <title>Biblioteca de Documentos</title>
    </head>

    <body>

        <div class="dialog" title="${title}">

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <div class="list" style="width: 1040px;">
                    <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                        <div id="example_length" class="dataTables_length">
                            <div class="botones">
                                <div class="botones left" style="margin-left: 15px; font-weight: normal;">
                                    Mostrando 1 a ${documentoInstanceList?.size()} de ${documentoInstanceTotal}
                                </div>

                                <div class="botones right">
                                    <g:form action="list" class="frm_busca">
                                        <input name="busca" value="${params.busca}"
                                               class="ui-widget-content ui-corner-all"/>
                                        <a href="#" class="button search">Buscar</a>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table style="width: 1040px;">
                        <thead>
                            <tr>


                                <th class="ui-state-default">CUP</th>

                                <tdn:sortableColumn property="proyecto" class="ui-state-default"
                                                    title="${message(code: 'documento.proyecto.label', default: 'Proyecto')}"/>

                                <th class="ui-state-default"><g:message code="documento.grupoProcesos.label"
                                                                        default="Grupo Procesos"/></th>

                                <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                    title="${message(code: 'documento.descripcion.label', default: 'Descripcion')}"/>

                                <tdn:sortableColumn property="clave" class="ui-state-default"
                                                    title="${message(code: 'documento.clave.label', default: 'Clave')}"/>

                                <tdn:sortableColumn property="resumen" class="ui-state-default"
                                                    title="${message(code: 'documento.resumen.label', default: 'Resumen')}"/>

                                <th class="ui-state-default">Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    <td>${documentoInstance?.proyecto?.codigoProyecto}</td>
                                    
                                    <td>${documentoInstance?.proyecto}</td>

                                    <td>${fieldValue(bean: documentoInstance, field: "grupoProcesos")}</td>

                                    <td>${fieldValue(bean: documentoInstance, field: "descripcion")}</td>

                                    <td>${fieldValue(bean: documentoInstance, field: "clave")}</td>

                                    <td>${fieldValue(bean: documentoInstance, field: "resumen")}</td>

                                    <td>
                                        <g:link action="downloadDoc" id="${documentoInstance.id}"
                                                class="button download">Descargar</g:link>
                                        <a href="#" class="button ver" id="${documentoInstance.id}">Ver</a>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${documentoInstanceTotal}"/>
                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <div title="Documento" id="dlg_doc"></div>

        <script type="text/javascript">
            $(function() {

                $("#dlg_doc").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 800,
                    buttons: {
                        "Cerrar": function() {
                            $(this).dialog("close");
                        }
                    }
                });


                $(".button").button();
                $(".download").button("option", "icons", {primary:'ui-icon-arrowrefresh-1-s'});
                $(".download").button("option", "text", false);
                $(".ver").button("option", "icons", {primary:'ui-icon-zoomin'});
                $(".ver").button("option", "text", false).click(function() {
                    var id = $(this).attr("id");
                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'ver')}",
                        data: {
                            id: id
                        },
                        success: function(msg) {
                            $("#dlg_doc").html(msg);
                        }
                    });
                    $("#dlg_doc").dialog("open");
                    return false;
                });

                $(".search").button("option", "icons", {primary:'ui-icon-search'}).click(function() {
                    $(".frm_busca").submit();
                    return false;
                });
            });
        </script>

    </body>
</html>
