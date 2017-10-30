<%@ page import="mies.Proyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'proyecto.label', default: 'Proyecto')}"/>
        <title>Lista de Proyectos Nuevos</title>

        <style type="text/css">
        .clean {
            background : none;
            width      : 50px;
        }
        </style>

    </head>

    <body>

        <g:set var="w" value="1050"/>

        <div id="" class="toolbar ui-widget-header ui-corner-all">
            <span class="menuButton"><g:link class="create btn"
                                             action="formProyecto">Nuevo Proyecto</g:link></span>
        </div>

        <div class="body">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list" style="width: ${w}px;">
                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                    <div id="example_length" class="dataTables_length">
                        <div class="botones">
                            <div class="botones left" style="margin-left: 15px; font-weight: normal;">
                                Mostrando 1 a ${proyectoInstanceList.size()} de ${proyectoInstanceTotal}
                            </div>

                            <div class="botones right">
                                <g:form action="list" class="frm_busca">
                                    <label class="clean" for="desde">Desde</label>
                                    <input name="desde" id="desde" value="${params.desde}"
                                           class="ui-widget-content ui-corner-all busca" style="width: 80px;"/>
                                    <label class="clean" for="hasta">Hasta</label>
                                    <input name="hasta" id="hasta" value="${params.hasta}"
                                           class="ui-widget-content ui-corner-all busca" style="width: 80px;"/>
                                    <label class="clean" for="busca">Nombre</label>
                                    <input name="busca" id="busca" value="${params.busca}"
                                           class="ui-widget-content ui-corner-all busca" style="width: 90px;"/>
                                    <a href="#" class="button search">Buscar</a>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
                <table style="width: ${w}px;">
                    <thead>
                        <tr>

                            <g:sortableColumn property="codigoProyecto"
                                              title="${message(code: 'proyecto.codigoProyecto.label', default: 'CUP')}"
                                              class="ui-state-default"/>
                            <g:sortableColumn property="nombre"
                                              title="${message(code: 'proyecto.nombre.label', default: 'Nombre')}"
                                              class="ui-state-default"/>
                            <th class="ui-state-default" style="width: 90px;">Unidad Ejecutora</th>
                            <th class="ui-state-default">Cobertura</th>
                            <th class="ui-state-default">Monto</th>
                            <g:sortableColumn property="fechaRegistro"
                                              title="${message(code: 'proyecto.fechaRegistro.label', default: 'Fecha')}"
                                              class="ui-state-default"/>
                            <g:sortableColumn property="aprobado"
                                              title="${message(code: 'proyecto.aprobado.label', default: 'Aprobado')}"
                                              class="ui-state-default"/>
                            <g:sortableColumn property="descripcion"
                                              title="${message(code: 'proyecto.aprobado.label', default: 'Descripcion')}"
                                              class="ui-state-default" colspan="2"/>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${proyectoInstanceList}" status="i" var="proyectoInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><div
                                        style="width: 90px; word-wrap: break-word;">${proyectoInstance.codigoProyecto}</div>
                                </td>
                                <td><div style="width: 300px;">
                                    <g:link action="show"
                                            id="${proyectoInstance.id}">${proyectoInstance.nombre}</g:link></div></td>
                                <td>${proyectoInstance.unidadEjecutora}</td>
                                <td>${proyectoInstance.cobertura}</td>
                                <td align="right"><g:formatNumber number="${proyectoInstance.monto?.toDouble()}"
                                                                  format="###,##0"
                                                                  minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td>${proyectoInstance.fechaRegistro?.format("dd/MM/yyyy")}</td>
                                <td>${proyectoInstance.aprobado?.trim() == "a" ? "Sí" : "No"}</td>
                                %{--<td>${proyectoInstance.descripcion}</td>--}%
                                <td><div style="width: 160px;">
                                    ${(proyectoInstance.descripcion?.length() > 70) ? proyectoInstance.descripcion?.substring(0, 70) + "..." : proyectoInstance.descripcion}</div>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="paginateButtons">
                <g:paginate total="${proyectoInstanceTotal}"/>
            </div>
        </div>
        <script type="text/javascript">
            $(function() {

                /*$("[name=desde]").focus();*/

                $(".busca").keypress(function(e) {
                    if (e.keyCode == 13) {
                        $(".frm_busca").submit();
                    }
                });

                $(".btn").button()
                $(".button").button();
                $(".create").button("option", "icons", {primary:'ui-icon-document'});

                $(".search").button("option", "icons", {primary:'ui-icon-search'}).click(function() {
                    $(".frm_busca").submit();
                    return false;
                });
            });
        </script>
    </body>

</html>
