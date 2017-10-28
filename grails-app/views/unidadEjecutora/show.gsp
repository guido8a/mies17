
<%@ page import="mies.UnidadEjecutora" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">


            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                    <fieldset class="ui-corner-all">
                        <legend class="ui-widget ui-widget-header ui-corner-all">
                            <g:message code="unidadEjecutora.show.legend"
                                       default="UnidadEjecutora details" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: unidadEjecutoraInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.tipoInstitucion.label"
                                               default="Tipo Institucion" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="tipoInstitucion" action="show"
                                                         id="${unidadEjecutoraInstance?.tipoInstitucion?.id}">
                                        ${unidadEjecutoraInstance?.tipoInstitucion?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        
                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.provincia.label"
                                               default="Provincia" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="provincia" action="show"
                                                         id="${unidadEjecutoraInstance?.provincia?.id}">
                                        ${unidadEjecutoraInstance?.provincia?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.codigo.label"
                                               default="Codigo" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: unidadEjecutoraInstance, field: "codigo")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.fechaInicio.label"
                                               default="Fecha Inicio" />
                                </label>

                                <div class="campo">
                                    
                                    <g:formatDate date="${unidadEjecutoraInstance?.fechaInicio}" format="dd-MM-yyyy HH:mm" />
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.fechaFin.label"
                                               default="Fecha Fin" />
                                </label>

                                <div class="campo">
                                    
                                    <g:formatDate date="${unidadEjecutoraInstance?.fechaFin}" format="dd-MM-yyyy HH:mm" />
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="unidadEjecutora.padre.label"
                                               default="Padre" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="unidadEjecutora" action="show"
                                                         id="${unidadEjecutoraInstance?.padre?.id}">
                                        ${unidadEjecutoraInstance?.padre?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${unidadEjecutoraInstance?.id}">
                                <g:message code="default.button.update.label" default="Edit" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${unidadEjecutoraInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                        </div>

                    </fieldset>
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
