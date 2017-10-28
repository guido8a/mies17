
<%@ page import="mies.Ejecucion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'ejecucion.label', default: 'Ejecucion')}" />
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
                            <g:message code="ejecucion.show.legend"
                                       default="Ejecucion details" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.asignacion.label"
                                               default="Asignacion" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="asignacion" action="show"
                                                         id="${ejecucionInstance?.asignacion?.id}">
                                        ${ejecucionInstance?.asignacion?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.compromiso.label"
                                               default="Compromiso" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "compromiso")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.devengado.label"
                                               default="Devengado" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "devengado")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.pagado.label"
                                               default="Pagado" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "pagado")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.saldoDisponible.label"
                                               default="Saldo Disponible" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "saldoDisponible")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.saldoPresupuesto.label"
                                               default="Saldo Presupuesto" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "saldoPresupuesto")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.sigef.label"
                                               default="Sigef" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="sigef" action="show"
                                                         id="${ejecucionInstance?.sigef?.id}">
                                        ${ejecucionInstance?.sigef?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="ejecucion.vigente.label"
                                               default="Vigente" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: ejecucionInstance, field: "vigente")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${ejecucionInstance?.id}">
                                <g:message code="default.button.update.label" default="Edit" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${ejecucionInstance?.id}">
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
