
<%@ page import="mies.TipoResponsable" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'tipoResponsable.label', default: 'TipoResponsable')}" />
        <title>Lista de Tipos de responsable</title>
    </head>

    <body>

        <div class="dialog" title="${title}">

            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button create" action="create">
                    Nuevo Tipo de responsable
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
                                                  title="${message(code: 'tipoResponsable.id.label', default: 'Id')}" />
                                
                                <tdn:sortableColumn property="codigo" class="ui-state-default"
                                                  title="${message(code: 'tipoResponsable.codigo.label', default: 'Codigo')}" />
                                
                                <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                                  title="${message(code: 'tipoResponsable.descripcion.label', default: 'Descripcion')}" />
                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${tipoResponsableInstanceList}" status="i" var="tipoResponsableInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <td><g:link action="show"
                                                id="${tipoResponsableInstance.id}">${fieldValue(bean: tipoResponsableInstance, field: "id")}</g:link></td>
                                    
                                    <td>${fieldValue(bean: tipoResponsableInstance, field: "codigo")}</td>
                                    
                                    <td>${fieldValue(bean: tipoResponsableInstance, field: "descripcion")}</td>
                                    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${tipoResponsableInstanceTotal}" />
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
