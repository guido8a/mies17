
<%@ page import="mies.BeneficioSenplades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                    %{--<g:message code="home" default="Home" />--}%
                %{--</a>--}%
                %{--<g:link class="button list" action="list">--}%
                    %{--<g:message code="beneficioSemplades.list" default="BeneficioSemplades List" />--}%
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
                                         <g:message code="default.show.legend" args="${['BeneficioSenplades']}" default="Show BeneficioSenplades details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>


                        

                            
                                <tr class="prop ${hasErrors(bean: beneficioSempladesInstance, field: 'id', 'error')}">
                            


                                <td class="label">
                                    <g:message code="beneficioSenplades.id.label"
                                               default="Id" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: beneficioSempladesInstance, field: "id")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="beneficioSemplades.proyecto.label"
                                               default="Proyecto" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="proyecto" action="show"
                                                         id="${beneficioSempladesInstance?.proyecto?.id}">
                                        ${beneficioSempladesInstance?.proyecto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosDirectosHombres', 'error')}">
                            


                                <td class="label">
                                    <g:message code="beneficioSenplades.beneficiariosDirectosHombres.label"
                                               default="Beneficiarios Directos Hombres" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosDirectosHombres")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="beneficioSenplades.beneficiariosDirectosMujeres.label"
                                               default="Beneficiarios Directos Mujeres" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosDirectosMujeres")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        

                            
                                <tr class="prop ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosIndirectosHombres', 'error')}">
                            


                                <td class="label">
                                    <g:message code="beneficioSenplades.beneficiariosIndirectosHombres.label"
                                               default="Beneficiarios Indirectos Hombres" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosIndirectosHombres")}
                                    
                                </td> <!-- campo -->

                                 

                        

                            


                                <td class="label">
                                    <g:message code="beneficioSenplades.beneficiariosIndirectosMujeres.label"
                                               default="Beneficiarios Indirectos Mujeres" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosIndirectosMujeres")}
                                    
                                </td> <!-- campo -->

                                 
                                    </tr>
                                

                        
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="edit" id="${beneficioSempladesInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button delete" action="delete" id="${beneficioSempladesInstance?.id}">
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
