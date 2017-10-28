
<%@ page import="mies.Asignacion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'asignacion.label', default: 'Asignacion')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

        <g:set var="width" value="600" />

    </head>

    <body>

        <div class="dialog">

            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button list" action="list">
                    <g:message code="asignacion.list" default="Asignacion List" />
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
                                
                                <th class="ui-state-default"><g:message code="asignacion.anio.label"
                                               default="Anio" /></th>
                                
                                <th class="ui-state-default"><g:message code="asignacion.fuente.label"
                                               default="Fuente" /></th>
                                
                                <th class="ui-state-default"><g:message code="asignacion.marcoLogico.label"
                                               default="Marco Logico" /></th>
                                
                                <th class="ui-state-default"><g:message code="asignacion.actividad.label"
                                               default="Actividad" /></th>
                                
                                <th class="ui-state-default"><g:message code="asignacion.presupuesto.label"
                                               default="Presupuesto" /></th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${asignacionInstanceList}" status="i" var="asignacionInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    
                                    <td><g:link action="show"
                                                id="${asignacionInstance.id}">${fieldValue(bean: asignacionInstance, field: "anio")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: asignacionInstance, field: "fuente")}</td>
                                    
                                    <td>${fieldValue(bean: asignacionInstance, field: "marcoLogico")}</td>
                                    
                                    <td>${fieldValue(bean: asignacionInstance, field: "actividad")}</td>
                                    
                                    <td>${fieldValue(bean: asignacionInstance, field: "presupuesto")}</td>
                                    



                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${asignacionInstanceTotal}" />
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
