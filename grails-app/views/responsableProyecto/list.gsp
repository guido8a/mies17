
<%@ page import="mies.ResponsableProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'responsableProyecto.label', default: 'ResponsableProyecto')}" />
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
                                                  title="${message(code: 'responsableProyecto.id.label', default: 'Id')}" />
                                
                                <th class="ui-state-default"><g:message code="responsableProyecto.responsable.label"
                                               default="Responsable" /></th>
                                
                                <th class="ui-state-default"><g:message code="responsableProyecto.proyecto.label"
                                               default="Proyecto" /></th>
                                
                                <tdn:sortableColumn property="desde" class="ui-state-default"
                                                  title="${message(code: 'responsableProyecto.desde.label', default: 'Desde')}" />
                                
                                <tdn:sortableColumn property="hasta" class="ui-state-default"
                                                  title="${message(code: 'responsableProyecto.hasta.label', default: 'Hasta')}" />
                                
                                <tdn:sortableColumn property="observaciones" class="ui-state-default"
                                                  title="${message(code: 'responsableProyecto.observaciones.label', default: 'Observaciones')}" />
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${responsableProyectoInstanceList}" status="i" var="responsableProyectoInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <td><g:link action="show"
                                                id="${responsableProyectoInstance.id}">${fieldValue(bean: responsableProyectoInstance, field: "id")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: responsableProyectoInstance, field: "responsable")}</td>
                                    
                                    <td>${fieldValue(bean: responsableProyectoInstance, field: "proyecto")}</td>
                                    
                                    <td><g:formatDate date="${responsableProyectoInstance.desde}" /></td>
                                    
                                    <td><g:formatDate date="${responsableProyectoInstance.hasta}" /></td>
                                    
                                    <td>${fieldValue(bean: responsableProyectoInstance, field: "observaciones")}</td>
                                    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${responsableProyectoInstanceTotal}" />
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
