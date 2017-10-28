
<%@ page import="mies.ModificacionProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'modificacionProyecto.label', default: 'ModificacionProyecto')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                    %{--<g:message code="home" default="Home" />--}%
                %{--</a>--}%
                %{--<g:link class="button list" action="list">--}%
                    %{--<g:message code="modificacionProyecto.list" default="ModificacionProyecto List" />--}%
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
                                         <g:message code="default.show.legend" args="${['ModificacionProyecto']}" default="Show ModificacionProyecto details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                        

                            
                                <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'id', 'error')}">
                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.id.label"
                                               default="Id" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: modificacionProyectoInstance, field: "id")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.informe.label"
                                               default="Informe" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="informe" action="show"
                                                         id="${modificacionProyectoInstance?.informe?.id}">
                                        ${modificacionProyectoInstance?.informe?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'tipoModificacion', 'error')}">
                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.tipoModificacion.label"
                                               default="Tipo Modificacion" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="tipoModificacion" action="show"
                                                         id="${modificacionProyectoInstance?.tipoModificacion?.id}">
                                        ${modificacionProyectoInstance?.tipoModificacion?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.valor.label"
                                               default="Valor" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: modificacionProyectoInstance, field: "valor")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'descripcion', 'error')}">
                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.descripcion.label"
                                               default="Descripcion" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: modificacionProyectoInstance, field: "descripcion")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.fecha.label"
                                               default="Fecha" />
                                </td>

                                <td class="campo">
                                    
                                    <g:formatDate date="${modificacionProyectoInstance?.fecha}" format="dd-MM-yyyy HH:mm" />
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'fechaAprobacion', 'error')}">
                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.fechaAprobacion.label"
                                               default="Fecha Aprobacion" />
                                </td>

                                <td class="campo">
                                    
                                    <g:formatDate date="${modificacionProyectoInstance?.fechaAprobacion}" format="dd-MM-yyyy HH:mm" />
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.aprobado.label"
                                               default="Aprobado" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: modificacionProyectoInstance, field: "aprobado")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'observaciones', 'error')}">
                            
                                <td class="label">
                                    <g:message code="modificacionProyecto.observaciones.label"
                                               default="Observaciones" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: modificacionProyectoInstance, field: "observaciones")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="edit" id="${modificacionProyectoInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button delete" action="delete" id="${modificacionProyectoInstance?.id}">
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
