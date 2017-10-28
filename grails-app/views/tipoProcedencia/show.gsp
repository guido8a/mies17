<%@ page import="mies.TipoProcedencia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'tipoProcedencia.label', default: 'TipoProcedencia')}"/>
        <title>Ver Tipo de Procedencia</title>
    </head>

    <body>

        <div class="dialog">
            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button list" action="list">
                    Lista de Tipos de procedencia
                </g:link>
                <g:link class="button create" action="create">
                    Nuevo Tipo de procedencia
                </g:link>
            </div> <!-- toolbar -->

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                    <table style="width: 800px;" class="show ui-widget-content ui-corner-all">

                        <thead>
                            <tr>
                                <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                    Ver detalles del Tipo de procedencia
                                </td>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td colspan="2" class="blanco">&nbsp;</td>
                            </tr>

                            <tr class="prop ${hasErrors(bean: tipoProcedenciaInstance, field: 'descripcion', 'error')}">

                                <td class="label" style="width: 10em;">
                                    <g:message code="tipoProcedencia.descripcion.label"
                                               default="Descripción"/>:
                                </td>

                                <td class="">

                                    ${fieldValue(bean: tipoProcedenciaInstance, field: "descripcion")}

                                </td> <!-- campo -->


                            <tr>
                                <td colspan="2" class="label">&nbsp;</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="buttons" style="text-align: right;">
                                    <g:link class="button edit" action="edit" id="${tipoProcedenciaInstance?.id}">
                                        <g:message code="default.button.update.label" default="Edit"/>
                                    </g:link>
                                    <g:link class="button delete" action="delete" id="${tipoProcedenciaInstance?.id}">
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
