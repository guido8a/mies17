
<%@ page import="mies.Asignacion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'asignacion.label', default: 'Asignacion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                        <table style="width: 800px;" class="show ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                         <g:message code="default.show.legend" args="${['Asignacion']}" default="Show Asignacion details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                        
                        <tr>
                            <td colspan="4" class="blanco">&nbsp;</td>
                        </tr>
                        

                            

                            
                                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'anio', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.anio.label"
                                               default="Anio" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="anio" action="show"
                                                         id="${asignacionInstance?.anio?.id}">
                                        ${asignacionInstance?.anio?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.fuente.label"
                                               default="Fuente" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="fuente" action="show"
                                                         id="${asignacionInstance?.fuente?.id}">
                                        ${asignacionInstance?.fuente?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.marcoLogico.label"
                                               default="Marco Logico" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="marcoLogico" action="show"
                                                         id="${asignacionInstance?.marcoLogico?.id}">
                                        ${asignacionInstance?.marcoLogico?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.actividad.label"
                                               default="Actividad" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="actividad" action="show"
                                                         id="${asignacionInstance?.actividad?.id}">
                                        ${asignacionInstance?.actividad?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'presupuesto', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.presupuesto.label"
                                               default="Presupuesto" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="presupuesto" action="show"
                                                         id="${asignacionInstance?.presupuesto?.id}">
                                        ${asignacionInstance?.presupuesto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.tipoGasto.label"
                                               default="Tipo Gasto" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="tipoGasto" action="show"
                                                         id="${asignacionInstance?.tipoGasto?.id}">
                                        ${asignacionInstance?.tipoGasto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'planificado', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.planificado.label"
                                               default="Planificado" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: asignacionInstance, field: "planificado")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="asignacion.redistribucion.label"
                                               default="Redistribucion" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: asignacionInstance, field: "redistribucion")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                
                            <tr>
                                <td colspan="4" class="label">&nbsp;</td>
                            </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="form" id="${asignacionInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button" action="pacAsignacion" id="${asignacionInstance?.id}">
                                            P.A.C
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
