
<%@ page import="mies.Ejecucion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'ejecucion.label', default: 'Ejecucion')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">


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
                                                  title="${message(code: 'ejecucion.id.label', default: 'Id')}" />
                                
                                <th class="ui-state-default"><g:message code="ejecucion.asignacion.label"
                                               default="Asignacion" /></th>
                                
                                <tdn:sortableColumn property="compromiso" class="ui-state-default"
                                                  title="${message(code: 'ejecucion.compromiso.label', default: 'Compromiso')}" />
                                
                                <tdn:sortableColumn property="devengado" class="ui-state-default"
                                                  title="${message(code: 'ejecucion.devengado.label', default: 'Devengado')}" />
                                
                                <tdn:sortableColumn property="pagado" class="ui-state-default"
                                                  title="${message(code: 'ejecucion.pagado.label', default: 'Pagado')}" />
                                
                                <tdn:sortableColumn property="saldoDisponible" class="ui-state-default"
                                                  title="${message(code: 'ejecucion.saldoDisponible.label', default: 'Saldo Disponible')}" />
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${ejecucionInstanceList}" status="i" var="ejecucionInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <td><g:link action="show"
                                                id="${ejecucionInstance.id}">${fieldValue(bean: ejecucionInstance, field: "id")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: ejecucionInstance, field: "asignacion")}</td>
                                    
                                    <td>${fieldValue(bean: ejecucionInstance, field: "compromiso")}</td>
                                    
                                    <td>${fieldValue(bean: ejecucionInstance, field: "devengado")}</td>
                                    
                                    <td>${fieldValue(bean: ejecucionInstance, field: "pagado")}</td>
                                    
                                    <td>${fieldValue(bean: ejecucionInstance, field: "saldoDisponible")}</td>
                                    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${ejecucionInstanceTotal}" />
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
