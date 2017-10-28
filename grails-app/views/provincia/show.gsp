<%@ page import="mies.Provincia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'provincia.label', default: 'Provincia')}"/>
        <title><g:message code="default.show.label" args="[entityName]"/></title>
    </head>

    <body>

        <div class="dialog" title="${title}">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
            %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
            %{--<g:message code="home" default="Home" />--}%
            %{--</a>--}%
            %{--<g:link class="button list" action="list">--}%
            %{--<g:message code="provincia.list" default="Provincia List" />--}%
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
                                    <g:message code="default.show.legend" args="${['Provincia']}"
                                               default="Show Provincia details"/>
                                </td>
                            </tr>
                        </thead>
                        <tbody>

                            <tr class="prop ${hasErrors(bean: provinciaInstance, field: 'id', 'error')}">

                                <td class="label">
                                    <g:message code="provincia.id.label"
                                               default="Id"/>
                                </td>

                                <td class="campo">

                                    ${fieldValue(bean: provinciaInstance, field: "id")}

                                </td> <!-- campo -->




                                <td class="label">
                                    <g:message code="provincia.zona.label"
                                               default="Zona"/>
                                </td>

                                <td class="campo">

                                    <g:link controller="zona" action="show"
                                            id="${provinciaInstance?.zona?.id}">
                                        ${provinciaInstance?.zona?.encodeAsHTML()}
                                    </g:link>

                                </td> <!-- campo -->

                            </tr>




                            <tr class="prop ${hasErrors(bean: provinciaInstance, field: 'region', 'error')}">

                                <td class="label">
                                    <g:message code="provincia.region.label"
                                               default="Region"/>
                                </td>

                                <td class="campo">

                                    <g:link controller="region" action="show"
                                            id="${provinciaInstance?.region?.id}">
                                        ${provinciaInstance?.region?.encodeAsHTML()}
                                    </g:link>

                                </td> <!-- campo -->




                                <td class="label">
                                    <g:message code="provincia.numero.label"
                                               default="Numero"/>
                                </td>

                                <td class="campo">

                                    ${fieldValue(bean: provinciaInstance, field: "numero")}

                                </td> <!-- campo -->

                            </tr>




                            <tr class="prop ${hasErrors(bean: provinciaInstance, field: 'nombre', 'error')}">

                                <td class="label">
                                    <g:message code="provincia.nombre.label"
                                               default="Nombre"/>
                                </td>

                                <td class="campo">

                                    ${fieldValue(bean: provinciaInstance, field: "nombre")}

                                </td> <!-- campo -->

                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="buttons" style="text-align: right;">
                                    <g:link class="button edit" action="edit" id="${provinciaInstance?.id}">
                                        <g:message code="default.button.update.label" default="Edit"/>
                                    </g:link>
                                    <g:link class="button delete" action="delete" id="${provinciaInstance?.id}">
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
