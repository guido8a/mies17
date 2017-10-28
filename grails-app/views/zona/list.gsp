<%@ page import="mies.Zona" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'zona.label', default: 'Zona')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>

    <body>

        <div class="dialog" title="${title}">
            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button create" action="create">
                    Nueva Zona de planificaci&oacute;n
                </g:link>
                <g:link class="button tree" action="arbol">
                    &Aacute;rbol de Zonas de planificaci&oacute;n
                </g:link>
            </div> <!-- toolbar -->

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <div class="list" style="width: 600px;">
                    <table style="width: 600px;">
                        <thead>
                            <tr>

                                <tdn:sortableColumn property="numero" class="ui-state-default"
                                                    title="${message(code: 'zona.numero.label', default: 'Número')}"/>

                                <tdn:sortableColumn property="nombre" class="ui-state-default"
                                                    title="${message(code: 'zona.nombre.label', default: 'Nombre')}"/>

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${zonaInstanceList}" status="i" var="zonaInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    <td><g:link action="show" id="${zonaInstance.id}">
                                        ${fieldValue(bean: zonaInstance, field: "numero")}
                                    </g:link></td>

                                    <td>${fieldValue(bean: zonaInstance, field: "nombre")}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${zonaInstanceTotal}"/>
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
