
<%@ page import="mies.UnidadEjecutora" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora')}" />
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
                                                  title="${message(code: 'unidadEjecutora.id.label', default: 'Id')}" />
                                
                                <th class="ui-state-default"><g:message code="unidadEjecutora.tipoInstitucion.label"
                                               default="Tipo Institucion" /></th>

                                <th class="ui-state-default"><g:message code="unidadEjecutora.provincia.label"
                                               default="Provincia" /></th>
                                
                                <tdn:sortableColumn property="codigo" class="ui-state-default"
                                                  title="${message(code: 'unidadEjecutora.codigo.label', default: 'Codigo')}" />
                                
                                <tdn:sortableColumn property="fechaInicio" class="ui-state-default"
                                                  title="${message(code: 'unidadEjecutora.fechaInicio.label', default: 'Fecha Inicio')}" />
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${unidadEjecutoraInstanceList}" status="i" var="unidadEjecutoraInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <td><g:link action="show"
                                                id="${unidadEjecutoraInstance.id}">${fieldValue(bean: unidadEjecutoraInstance, field: "id")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: unidadEjecutoraInstance, field: "tipoInstitucion")}</td>
                                                                        
                                    <td>${fieldValue(bean: unidadEjecutoraInstance, field: "provincia")}</td>
                                    
                                    <td>${fieldValue(bean: unidadEjecutoraInstance, field: "codigo")}</td>
                                    
                                    <td><g:formatDate date="${unidadEjecutoraInstance.fechaInicio}" /></td>
                                    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${unidadEjecutoraInstanceTotal}" />
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
