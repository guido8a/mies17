
<%@ page import="mies.ModificacionProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'modificacionProyecto.label', default: 'ModificacionProyecto')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog">


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
                                                  title="${message(code: 'modificacionProyecto.id.label', default: 'Id')}" />
                                
                                <th class="ui-state-default"><g:message code="modificacionProyecto.informe.label"
                                               default="Informe" /></th>
                                
                                <th class="ui-state-default"><g:message code="modificacionProyecto.tipoModificacion.label"
                                               default="Tipo Modificacion" /></th>
                                
                                <tdn:sortableColumn property="valor" class="ui-state-default"
                                                  title="${message(code: 'modificacionProyecto.valor.label', default: 'Valor')}" />
                                
                                <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                  title="${message(code: 'modificacionProyecto.descripcion.label', default: 'Descripcion')}" />
                                
                                <tdn:sortableColumn property="fecha" class="ui-state-default"
                                                  title="${message(code: 'modificacionProyecto.fecha.label', default: 'Fecha')}" />
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${modificacionProyectoInstanceList}" status="i" var="modificacionProyectoInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <td><g:link action="show"
                                                id="${modificacionProyectoInstance.id}">${fieldValue(bean: modificacionProyectoInstance, field: "id")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: modificacionProyectoInstance, field: "informe")}</td>
                                    
                                    <td>${fieldValue(bean: modificacionProyectoInstance, field: "tipoModificacion")}</td>
                                    
                                    <td>${fieldValue(bean: modificacionProyectoInstance, field: "valor")}</td>
                                    
                                    <td>${fieldValue(bean: modificacionProyectoInstance, field: "descripcion")}</td>
                                    
                                    <td><g:formatDate date="${modificacionProyectoInstance.fecha}" /></td>
                                    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${modificacionProyectoInstanceTotal}" />
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
