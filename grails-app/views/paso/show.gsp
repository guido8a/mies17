<%@ page import="mies.Paso" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'paso.label', default: 'Paso')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

    <div class="dialog" title="${title}">
        %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
        %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
        %{--<g:message code="home" default="Home" />--}%
        %{--</a>--}%
        %{--<g:link class="button list" action="list">--}%
        %{--<g:message code="paso.list" default="Paso List" />--}%
        %{--</g:link>--}%
        %{--<g:link class="button create" action="create">--}%
        %{--<g:message code="default.new.label" args="[entityName]" />--}%
        %{--</g:link>--}%
        %{--</div> <!-- toolbar -->--}%

        <div class="body">
            <g:if test="${flash.message}">
                <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
            </g:if>
            <div>

                <table width="100%" class="ui-widget-content ui-corner-all">

                    <thead>
                        <tr>
                            <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                <g:message code="default.show.legend" args="${['Paso']}" default="Show Paso details"/>
                            </td>
                        </tr>
                    </thead>
                    <tbody>

                        <tr class="prop ${hasErrors(bean: pasoInstance, field: 'id', 'error')}">

                            <td class="label">
                                <g:message code="paso.id.label"
                                           default="Id"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "id")}

                            </td> <!-- campo -->




                            <td class="label">
                                <g:message code="paso.proceso.label"
                                           default="Proceso"/>
                            </td>

                            <td class="campo">

                                <g:link controller="proceso" action="show"
                                        id="${pasoInstance?.proceso?.id}">
                                    ${pasoInstance?.proceso?.encodeAsHTML()}
                                </g:link>

                            </td> <!-- campo -->

                        </tr>




                        <tr class="prop ${hasErrors(bean: pasoInstance, field: 'orden', 'error')}">

                            <td class="label">
                                <g:message code="paso.orden.label"
                                           default="Orden"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "orden")}

                            </td> <!-- campo -->




                            <td class="label">
                                <g:message code="paso.nombre.label"
                                           default="Nombre"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "nombre")}

                            </td> <!-- campo -->

                        </tr>




                        <tr class="prop ${hasErrors(bean: pasoInstance, field: 'descripcion', 'error')}">

                            <td class="label">
                                <g:message code="paso.descripcion.label"
                                           default="Descripcion"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "descripcion")}

                            </td> <!-- campo -->




                            <td class="label">
                                <g:message code="paso.obligacion.label"
                                           default="Obligacion"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "obligacion")}

                            </td> <!-- campo -->

                        </tr>




                        <tr class="prop ${hasErrors(bean: pasoInstance, field: 'tabla', 'error')}">

                            <td class="label">
                                <g:message code="paso.tabla.label"
                                           default="Tabla"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "tabla")}

                            </td> <!-- campo -->




                            <td class="label">
                                <g:message code="paso.estado.label"
                                           default="Estado"/>
                            </td>

                            <td class="campo">

                                ${fieldValue(bean: pasoInstance, field: "estado")}

                            </td> <!-- campo -->

                        </tr>

                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="buttons" style="text-align: right;">
                                <g:link class="button edit" action="edit" id="${pasoInstance?.id}">
                                    <g:message code="default.button.update.label" default="Edit"/>
                                </g:link>
                                <g:link class="button delete" action="delete" id="${pasoInstance?.id}">
                                    <g:message code="default.button.delete.label" default="Delete"/>
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
