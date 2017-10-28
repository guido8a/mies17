
<%@ page import="mies.EjecucionUE" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'ejecucionUE.label', default: 'EjecucionUE')}" />
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
                            <g:message code="ejecucionUE.show.legend"
                                       default="EjecucionUE details" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionUEInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.vigente.label"
                                               default="Vigente" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionUEInstance, field: "vigente")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.comprometido.label"
                                               default="Comprometido" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionUEInstance, field: "comprometido")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.fuente.label"
                                               default="Fuente" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="fuente" action="show"
                                                         id="${ejecucionUEInstance?.fuente?.id}">
                                        ${ejecucionUEInstance?.fuente?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.presupuesto.label"
                                               default="Presupuesto" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="presupuesto" action="show"
                                                         id="${ejecucionUEInstance?.presupuesto?.id}">
                                        ${ejecucionUEInstance?.presupuesto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.programa.label"
                                               default="Programa" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="programaPresupuestario" action="show"
                                                         id="${ejecucionUEInstance?.programa?.id}">
                                        ${ejecucionUEInstance?.programa?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.proyecto.label"
                                               default="Proyecto" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="proyecto" action="show"
                                                         id="${ejecucionUEInstance?.proyecto?.id}">
                                        ${ejecucionUEInstance?.proyecto?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.sigef.label"
                                               default="Sigef" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="sigef" action="show"
                                                         id="${ejecucionUEInstance?.sigef?.id}">
                                        ${ejecucionUEInstance?.sigef?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucionUE.unidadEjecutora.label"
                                               default="Unidad Ejecutora" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="unidadEjecutora" action="show"
                                                         id="${ejecucionUEInstance?.unidadEjecutora?.id}">
                                        ${ejecucionUEInstance?.unidadEjecutora?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${ejecucionUEInstance?.id}">
                                <g:message code="default.button.update.label" default="Edit" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${ejecucionUEInstance?.id}">
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
