
<%@ page import="mies.Obra" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'obra.label', default: 'Obra')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

        <g:set var="width" value="600" />

    </head>

    <body>

        <div class="dialog">

            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button list" action="list">
                    <g:message code="obra.list" default="Obra List" />
                </g:link>
                <g:link class="button create" action="create">
                    <g:message code="default.new.label" args="[entityName]" />
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
                                
                                <tdn:sortableColumn property="undd__id" class="ui-state-default"
                                                  title="${message(code: 'obra.undd__id.label', default: 'Unddid')}" />
                                
                                <th class="ui-state-default"><g:message code="obra.codigoComprasPublicas.label"
                                               default="Codigo Compras Publicas" /></th>
                                
                                <th class="ui-state-default"><g:message code="obra.tipoCompra.label"
                                               default="Tipo Compra" /></th>
                                
                                <th class="ui-state-default"><g:message code="obra.asignacion.label"
                                               default="Asignacion" /></th>
                                
                                <th class="ui-state-default"><g:message code="obra.obra.label"
                                               default="Obra" /></th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${obraInstanceList}" status="i" var="obraInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    
                                    <td><g:link action="show"
                                                id="${obraInstance.id}">${fieldValue(bean: obraInstance, field: "undd__id")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: obraInstance, field: "codigoComprasPublicas")}</td>
                                    
                                    <td>${fieldValue(bean: obraInstance, field: "tipoCompra")}</td>
                                    
                                    <td>${fieldValue(bean: obraInstance, field: "asignacion")}</td>
                                    
                                    <td>${fieldValue(bean: obraInstance, field: "obra")}</td>
                                    



                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${obraInstanceTotal}" />
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
                    if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
