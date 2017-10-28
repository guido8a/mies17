
<%@ page import="mies.Obra" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'obra.label', default: 'Obra')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                        <table style="width: 800px;" class="show ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                         <g:message code="default.show.legend" args="${['Obra']}" default="Show Obra details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                        
                        <tr>
                            <td colspan="4" class="blanco">&nbsp;</td>
                        </tr>
                        

                            

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'undd__id', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.undd__id.label"
                                               default="Unddid" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "undd__id")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.codigoComprasPublicas.label"
                                               default="Codigo Compras Publicas" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="codigoComprasPublicas" action="show"
                                                         id="${obraInstance?.codigoComprasPublicas?.id}">
                                        ${obraInstance?.codigoComprasPublicas?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'tipoCompra', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.tipoCompra.label"
                                               default="Tipo Compra" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="tipoCompra" action="show"
                                                         id="${obraInstance?.tipoCompra?.id}">
                                        ${obraInstance?.tipoCompra?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.asignacion.label"
                                               default="Asignacion" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="asignacion" action="show"
                                                         id="${obraInstance?.asignacion?.id}">
                                        ${obraInstance?.asignacion?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'obra', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.obra.label"
                                               default="Obra" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="obra" action="show"
                                                         id="${obraInstance?.obra?.id}">
                                        ${obraInstance?.obra?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.modificacionProyecto.label"
                                               default="Modificacion Proyecto" />:
                                </td>

                                <td class="">
                                    
                                    <g:link controller="modificacionProyecto" action="show"
                                                         id="${obraInstance?.modificacionProyecto?.id}">
                                        ${obraInstance?.modificacionProyecto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'descripcion', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.descripcion.label"
                                               default="Descripcion" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "descripcion")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.cantidad.label"
                                               default="Cantidad" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "cantidad")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'costo', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.costo.label"
                                               default="Costo" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "costo")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.cuatrimestre1.label"
                                               default="Cuatrimestre1" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "cuatrimestre1")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'cuatrimestre2', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.cuatrimestre2.label"
                                               default="Cuatrimestre2" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "cuatrimestre2")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.cuatrimestre3.label"
                                               default="Cuatrimestre3" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "cuatrimestre3")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'ejecucion', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.ejecucion.label"
                                               default="Ejecucion" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "ejecucion")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.estado.label"
                                               default="Estado" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "estado")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'fechaInicio', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.fechaInicio.label"
                                               default="Fecha Inicio" />:
                                </td>

                                <td class="">
                                    
                                    <g:formatDate date="${obraInstance?.fechaInicio}" format="dd-MM-yyyy HH:mm" />
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.fechaFin.label"
                                               default="Fecha Fin" />:
                                </td>

                                <td class="">
                                    
                                    <g:formatDate date="${obraInstance?.fechaFin}" format="dd-MM-yyyy HH:mm" />
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: obraInstance, field: 'observaciones', 'error')}">
                            
                                <td class="label" style="width: 10em;">
                                    <g:message code="obra.observaciones.label"
                                               default="Observaciones" />:
                                </td>

                                <td class="">
                                    
                                    ${fieldValue(bean: obraInstance, field: "observaciones")}
                                    
                                </td> <!-- campo -->
                                 
                                
                            <tr>
                                <td colspan="4" class="label">&nbsp;</td>
                            </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="edit" id="${obraInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button delete" action="delete" id="${obraInstance?.id}">
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
