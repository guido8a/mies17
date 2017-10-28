
<%@ page import="mies.IndicadoresSenplades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'indicadoresSemplades.label', default: 'IndicadoresSemplades')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                    %{--<g:message code="home" default="Home" />--}%
                %{--</a>--}%
                %{--<g:link class="button list" action="list">--}%
                    %{--<g:message code="indicadoresSemplades.list" default="IndicadoresSemplades List" />--}%
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
                                         <g:message code="default.show.legend" args="${['IndicadoresSemplades']}" default="Show IndicadoresSemplades details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>


                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'id', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.id.label"
                                               default="Id" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "id")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.proyecto.label"
                                               default="Proyecto" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="proyecto" action="show"
                                                         id="${indicadoresSempladesInstance?.proyecto?.id}">
                                        ${indicadoresSempladesInstance?.proyecto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaAnalisisFinanciero', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.tasaAnalisisFinanciero.label"
                                               default="Tasa Analisis Financiero" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "tasaAnalisisFinanciero")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.valorActualNeto.label"
                                               default="Valor Actual Neto" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "valorActualNeto")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetorno', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.tasaInternaDeRetorno.label"
                                               default="Tasa Interna De Retorno" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "tasaInternaDeRetorno")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.tasaAnalisisEconomico.label"
                                               default="Tasa Analisis Economico" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "tasaAnalisisEconomico")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'valorActualNetoEconomico', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.valorActualNetoEconomico.label"
                                               default="Valor Actual Neto Economico" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "valorActualNetoEconomico")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.tasaInternaDeRetornoEconomico.label"
                                               default="Tasa Interna De Retorno Economico" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "tasaInternaDeRetornoEconomico")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'costoBeneficio', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.costoBeneficio.label"
                                               default="Costo Beneficio" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "costoBeneficio")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.pierdePais.label"
                                               default="Pierde Pais" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "pierdePais")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'impactos', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.impactos.label"
                                               default="Impactos" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "impactos")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.metodologia.label"
                                               default="Metodologia" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "metodologia")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'observaciones', 'error')}">
                            


                                <td class="label">
                                    <g:message code="indicadoresSemplades.observaciones.label"
                                               default="Observaciones" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: indicadoresSempladesInstance, field: "observaciones")}
                                    
                                </td> <!-- campo -->

                                 

                        
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="edit" id="${indicadoresSempladesInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button delete" action="delete" id="${indicadoresSempladesInstance?.id}">
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
