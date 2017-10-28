<%@ page import="mies.TipoInforme" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'tipoInforme.label', default: 'TipoInforme')}"/>
        <title>Lista de Tipos de informe</title>
    </head>

    <body>

        <div class="dialog">

%{--
            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button create" action="create">Nuevo Tipo de informe</g:link>
            </div> <!-- toolbar -->
--}%

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <div class="list" style="width: 800px;">
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
                    <table style="width: 800px;">
                        <thead>
                            <tr>

                                <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                    title="${message(code: 'tipoInforme.descripcion.label', default: 'Descripción')}"/>

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${tipoInformeInstanceList}" status="i" var="tipoInformeInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
%{--
                                    <td><g:link action="show" id="${tipoInformeInstance.id}">
                                        ${fieldValue(bean: tipoInformeInstance, field: "descripcion")}
                                    </g:link></td>
--}%
                                    <td>${tipoInformeInstance.descripcion}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${tipoInformeInstanceTotal}"/>
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
