<%@ page import="mies.Presupuesto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'presupuesto.label', default: 'Presupuesto')}"/>
        <title>Lista de Presupuestos</title>

        <g:set var="width" value="1040"/>

    </head>

    <body>

        <div class="dialog">

            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button create" action="create">
                    Nuevo Presupuesto
                </g:link>
                <g:link class="button tree" action="tree">
                    Arbol
                </g:link>
            </div> <!-- toolbar -->


            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <div class="list" style="width: ${width}px;">
                    <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                        %{--<div id="example_length" class="dataTables_length">--}%
                        %{--<g:message code="show" default="Show" />&nbsp;--}%
                        %{--<g:select from="${[10,20,30,40,50,60,70,80,90,100]}" name="max" value="${params.max}" />&nbsp;--}%
                        %{--<g:message code="entries" default="entries" />--}%


                        %{--<g:select--}%
                        %{--from="['asc':message(code:'asc', default:'Ascendente'), 'desc':message(code:'desc', default:'Descendente')]"--}%
                        %{--name="order"--}%
                        %{--optionKey="key"--}%
                        %{--optionValue="value"--}%
                        %{--value="${params.order}"--}%
                        %{--class="ui-widget-content ui-corner-all"/>--}%
                        %{--</div>--}%
                    </div>
                    <table style="width: ${width}px;">
                        <thead>
                            <tr>

                                <tdn:sortableColumn property="numero" class="ui-state-default"
                                                    title="${message(code: 'presupuesto.numero.label', default: 'Número')}"/>

                                <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                    title="${message(code: 'presupuesto.descripcion.label', default: 'Descripción')}"/>

                                <tdn:sortableColumn property="nivel" class="ui-state-default"
                                                    title="${message(code: 'presupuesto.nivel.label', default: 'Nivel')}"/>

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${presupuestoInstanceList}" status="i" var="presupuestoInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    <td><g:link action="show" id="${presupuestoInstance.id}">
                                        ${fieldValue(bean: presupuestoInstance, field: "numero")}
                                    </g:link></td>

                                    <td>${fieldValue(bean: presupuestoInstance, field: "descripcion")}</td>

                                    <td>${fieldValue(bean: presupuestoInstance, field: "nivel")}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${presupuestoInstanceTotal}"/>
                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <script type="text/javascript">
            $(function() {
                $(".button").button();
                $(".tree").button("option", "icons", {primary:'ui-icon-bullet'});
                $(".home").button("option", "icons", {primary:'ui-icon-home'});
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
