
<%@ page import="mies.Documento" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'documento.label', default: 'Documento')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                    %{--<g:message code="home" default="Home" />--}%
                %{--</a>--}%
                %{--<g:link class="button list" action="list">--}%
                    %{--<g:message code="documento.list" default="Documento List" />--}%
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
                                         <g:message code="default.show.legend" args="${['Documento']}" default="Show Documento details"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                        

                            
                                <tr class="prop ${hasErrors(bean: documentoInstance, field: 'id', 'error')}">
                            
                                <td class="label">
                                    <g:message code="documento.id.label"
                                               default="Id" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: documentoInstance, field: "id")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="documento.proyecto.label"
                                               default="Proyecto" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="proyecto" action="show"
                                                         id="${documentoInstance?.proyecto?.id}">
                                        ${documentoInstance?.proyecto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: documentoInstance, field: 'grupoProcesos', 'error')}">
                            
                                <td class="label">
                                    <g:message code="documento.grupoProcesos.label"
                                               default="Grupo Procesos" />
                                </td>

                                <td class="campo">
                                    
                                    <g:link controller="grupoProcesos" action="show"
                                                         id="${documentoInstance?.grupoProcesos?.id}">
                                        ${documentoInstance?.grupoProcesos?.encodeAsHTML()}
                                    </g:link>
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="documento.descripcion.label"
                                               default="Descripcion" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: documentoInstance, field: "descripcion")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: documentoInstance, field: 'clave', 'error')}">
                            
                                <td class="label">
                                    <g:message code="documento.clave.label"
                                               default="Clave" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: documentoInstance, field: "clave")}
                                    
                                </td> <!-- campo -->
                                 
                                

                            
                                <td class="label">
                                    <g:message code="documento.resumen.label"
                                               default="Resumen" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: documentoInstance, field: "resumen")}
                                    
                                </td> <!-- campo -->
                                 
                                    </tr>
                                
                                

                            
                                <tr class="prop ${hasErrors(bean: documentoInstance, field: 'documento', 'error')}">
                            
                                <td class="label">
                                    <g:message code="documento.documento.label"
                                               default="Documento" />
                                </td>

                                <td class="campo">
                                    
                                    ${fieldValue(bean: documentoInstance, field: "documento")}
                                    
                                </td> <!-- campo -->
                                 
                                
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="buttons" style="text-align: right;">
                                        <g:link class="button edit" action="edit" id="${documentoInstance?.id}">
                                            <g:message code="default.button.update.label" default="Edit" />
                                        </g:link>
                                        <g:link class="button delete" action="delete" id="${documentoInstance?.id}">
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
