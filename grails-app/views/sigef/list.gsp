<%@ page import="mies.Sigef" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'sigef.label', default: 'Sigef')}"/>
    <title>Datos cargados desde el eSIGEF</title>
</head>

<body>

<div class="dialog" title="${title}">

    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <g:link class="button list" action="list">
            <g:message code="sigef.list" default="Lista de Carga de Datos desde el eSIGEF"/>
        </g:link>
        <g:link class="button create" action="create">Nueva Carga de Datos
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
                                        title="${message(code: 'sigef.id.label', default: 'Id')}"/>

                    <th class="ui-state-default"><g:message code="sigef.anio.label"
                                                            default="Año"/></th>

                    <th class="ui-state-default"><g:message code="sigef.mes.label"
                                                            default="Mes"/></th>

                    <tdn:sortableColumn property="fecha" class="ui-state-default"
                                        title="${message(code: 'sigef.fecha.label', default: 'Fecha de Carga')}"/>

                </tr>
                </thead>
                <tbody>
                <g:each in="${sigefInstanceList}" status="i" var="sigefInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td><g:link action="show"
                                    id="${sigefInstance.id}">${fieldValue(bean: sigefInstance, field: "id")}</g:link></td>

                        <td>${fieldValue(bean: sigefInstance, field: "anio")}</td>

                        <td>${fieldValue(bean: sigefInstance, field: "mes")}</td>

                        <td><g:formatDate date="${sigefInstance.fecha}"/></td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
            <tdn:paginate total="${sigefInstanceTotal}"/>
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
