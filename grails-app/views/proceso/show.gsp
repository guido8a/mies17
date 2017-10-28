<%@ page import="mies.Paso; mies.Proceso" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'proceso.label', default: 'Proceso')}"/>
        <title><g:message code="default.show.label" args="[entityName]"/></title>

        <style type="text/css">
        .tr_click {
            cursor: pointer;
        }
        </style>

    </head>

    <body>

        <div class="dialog" title="${title}">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
            %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
            %{--<g:message code="home" default="Home" />--}%
            %{--</a>--}%
            %{--<g:link class="button list" action="list">--}%
            %{--<g:message code="proceso.list" default="Proceso List" />--}%
            %{--</g:link>--}%
            %{--<g:link class="button create" action="create">--}%
            %{--<g:message code="default.new.label" args="[entityName]" />--}%
            %{--</g:link>--}%
            %{--</div> <!-- toolbar -->--}%

            <div class="body" style="width: 800px;">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                    <table width="100%" class="ui-widget-content ui-corner-all">

                        <thead>
                            <tr>
                                <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                    ${fieldValue(bean: procesoInstance, field: "nombre")}
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="label">
                                    <g:message code="proceso.descripcion.label"
                                               default="Descripcion"/>
                                </td>
                                <td>
                                    ${fieldValue(bean: procesoInstance, field: "descripcion")}
                                </td> <!-- campo -->
                            </tr>

                            <tr>
                                <td class="label">
                                    <g:message code="proceso.fecha.label"
                                               default="Fecha"/>
                                </td>
                                <td>
                                    <g:formatDate date="${procesoInstance?.fecha}" format="dd-MM-yyyy"/>
                                </td> <!-- campo -->
                            </tr>

                            <tr>
                                <td class="label">
                                    <g:message code="proceso.fechaFin.label"
                                               default="Fecha Fin"/>
                                </td>
                                <td>
                                    <g:formatDate date="${procesoInstance?.fechaFin}" format="dd-MM-yyyy"/>
                                </td> <!-- campo -->
                            </tr>

                            <tr>
                                <td class="label">
                                    <g:message code="proceso.estado.label"
                                               default="Estado"/>
                                </td>
                                <td>
                                    ${fieldValue(bean: procesoInstance, field: "estado")}
                                </td> <!-- campo -->
                            </tr>

                            <tr>
                                <td class="label">
                                    <g:message code="proceso.observaciones.label"
                                               default="Observaciones"/>
                                </td>
                                <td>
                                    ${fieldValue(bean: procesoInstance, field: "observaciones")}
                                </td> <!-- campo -->
                            </tr>

                            <tr>
                                <td class="label">
                                    Pasos:
                                </td>
                                <td colspan="3">
                                    <g:each in="${pasos}" var="pasoInstance" status="i">
                                        <table id="tbl_${pasoInstance.id}"
                                               style="width: 700px; border: solid 3px #6495ed;"
                                               class="ui-corner-all">
                                            <thead>
                                                <tr id="tr_${pasoInstance.id}" class="tr_click"
                                                    paso="${pasoInstance.id}">
                                                    <th colspan="4" class="${(i % 2) == 0 ? 'odd' : 'even'}"
                                                        style="text-align: left;">
                                                        ${pasoInstance.orden}.- ${pasoInstance.nombre}
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbd_${pasoInstance.id}" class="ui-helper-hidden">

                                                <tr>
                                                    <td class="label" width="85">
                                                        <g:message code="paso.descripcion.label"
                                                                   default="Descripcion"/>
                                                    </td>
                                                    <td>
                                                        ${fieldValue(bean: pasoInstance, field: "descripcion")}
                                                    </td> <!-- campo -->
                                                </tr>

                                                <tr>
                                                    <td class="label">
                                                        <g:message code="paso.obligacion.label"
                                                                   default="Obligatorio"/>
                                                    </td>
                                                    <td>
                                                        ${(pasoInstance.obligacion == 1 || pasoInstance.obligacion == "1") ? "Sí" : "No"}
                                                    </td> <!-- campo -->
                                                </tr>

                                                <tr>
                                                    <td class="label">
                                                        <g:message code="paso.estado.label"
                                                                   default="Estado"/>
                                                    </td>
                                                    <td>
                                                        ${pasoInstance.estado == "A" ? "Activo" : "Inactivo"}
                                                    </td> <!-- campo -->
                                                </tr>

                                                <tr>
                                                    <td class="label">
                                                        <g:message code="paso.tabla.label"
                                                                   default="Tabla(s)"/>
                                                    </td>
                                                    <td>
                                                        ${fieldValue(bean: pasoInstance, field: "tabla")}
                                                    </td> <!-- campo -->
                                                </tr>
                                            </tbody>

                                        </table>
                                    </g:each>
                                </td>
                            </tr>

                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="buttons" style="text-align: right;">
                                    <g:link class="button edit" action="edit" id="${procesoInstance?.id}">
                                        Editar
                                    </g:link>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <script type="text/javascript">
            $(function() {

                $(".tr_click").click(function() {
                    var paso = $(this).attr("paso");
                    $("#tbd_" + paso).toggle();
                });

                $(".button").button();
                $(".home").button("option", "icons", {primary:'ui-icon-home'});
                $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
                $(".create").button("option", "icons", {primary:'ui-icon-document'});

                $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
                $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
                    if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
