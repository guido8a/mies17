<%@ page import="mies.Proceso" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'proceso.label', default: 'Proceso')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>

    <body>

        <div class="dialog" title="${title}">

            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button create" action="create">
                    <g:message code="default.new.label" args="[entityName]"/>
                </g:link>
            </div> <!-- toolbar -->

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <div class="list" style="width: 600px;">
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
                    <table style="width: 600px;">
                        <thead>
                            <tr>

                                <tdn:sortableColumn property="id" class="ui-state-default"
                                                    title="${message(code: 'proceso.id.label', default: 'Id')}"/>

                                <tdn:sortableColumn property="nombre" class="ui-state-default"
                                                    title="${message(code: 'proceso.nombre.label', default: 'Nombre')}"/>

                                <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                    title="${message(code: 'proceso.descripcion.label', default: 'Descripcion')}"/>

                                <tdn:sortableColumn property="fecha" class="ui-state-default"
                                                    title="${message(code: 'proceso.fecha.label', default: 'Fecha')}"/>

                                <tdn:sortableColumn property="fechaFin" class="ui-state-default"
                                                    title="${message(code: 'proceso.fechaFin.label', default: 'Fecha Fin')}"/>

                                <tdn:sortableColumn property="estado" class="ui-state-default"
                                                    title="${message(code: 'proceso.estado.label', default: 'Estado')}"/>

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${procesoInstanceList}" status="i" var="procesoInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    <td><g:link action="show"
                                                id="${procesoInstance.id}">${fieldValue(bean: procesoInstance, field: "id")}</g:link></td>

                                    <td>${fieldValue(bean: procesoInstance, field: "nombre")}</td>

                                    <td>${fieldValue(bean: procesoInstance, field: "descripcion")}</td>

                                    <td><g:formatDate date="${procesoInstance.fecha}"/></td>

                                    <td><g:formatDate date="${procesoInstance.fechaFin}"/></td>

                                    <td>${fieldValue(bean: procesoInstance, field: "estado")}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${procesoInstanceTotal}"/>
                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <script type="text/javascript">
            $(function() {
                $(".button").button();
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
