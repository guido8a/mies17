
<%@ page import="mies.ResponsableProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'responsableProyecto.label', default: 'ResponsableProyecto')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                    %{--<g:message code="home" default="Home" />--}%
                %{--</a>--}%
                %{--<g:link class="button list" action="list">--}%
                    %{--<g:message code="responsableProyecto.list" default="ResponsableProyecto List" />--}%
                %{--</g:link>--}%
                %{--<g:link class="button create" action="create">--}%
                    %{--<g:message code="default.new.label" args="[entityName]" />--}%
                %{--</g:link>--}%
            %{--</div> <!-- toolbar -->--}%

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                        <table width="100%" class="ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                         <g:message code="default.show.legend" args="${['ResponsableProyecto']}" default="Show ResponsableProyecto details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>


                        

                            
                                <tr class="prop ${hasErrors(bean: responsableProyectoInstance, field: 'id', 'error')}">
                            


                                <td class="label">
                                    <g:message code="responsableProyecto.id.label"
                                               default="Id" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: responsableProyectoInstance, field: "id")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="responsableProyecto.responsable.label"
                                               default="Responsable" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="usro" action="show"
                                                         id="${responsableProyectoInstance?.responsable?.id}">
                                        ${responsableProyectoInstance?.responsable?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: responsableProyectoInstance, field: 'proyecto', 'error')}">
                            


                                <td class="label">
                                    <g:message code="responsableProyecto.proyecto.label"
                                               default="Proyecto" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="proyecto" action="show"
                                                         id="${responsableProyectoInstance?.proyecto?.id}">
                                        ${responsableProyectoInstance?.proyecto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="responsableProyecto.desde.label"
                                               default="Desde" />
                                </td>

                                <td class="campo">
                                    
                                    <g:formatDate date="${responsableProyectoInstance?.desde}" format="dd-MM-yyyy HH:mm" />
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: responsableProyectoInstance, field: 'hasta', 'error')}">
                            


                                <td class="label">
                                    <g:message code="responsableProyecto.hasta.label"
                                               default="Hasta" />
                                </td>

                                <td class="campo">
                                    
                                    <g:formatDate date="${responsableProyectoInstance?.hasta}" format="dd-MM-yyyy HH:mm" />
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="responsableProyecto.observaciones.label"
                                               default="Observaciones" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: responsableProyectoInstance, field: "observaciones")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="edit" id="${responsableProyectoInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button delete" action="delete" id="${responsableProyectoInstance?.id}">
                                            <g:message code="default.button.delete.label" default="Delete" />
                                        </g:link>
                                    </td>
                                </tr>
                            </tfoot>
                    </table>
                </div>
            </div> <!-- body -->
            </div> <!-- dialog -->

         <script type="text/javascript">
            $(function() {
                $(".button").button();
                $(".home").button("option", "icons", {primary:'ui-icon-home'});
                $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
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
