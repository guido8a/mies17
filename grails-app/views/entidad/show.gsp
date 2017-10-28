
<%@ page import="mies.Entidad" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'entidad.label', default: 'Entidad')}" />
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
                            <g:message code="entidad.show.legend"
                                       default="Entidad details" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.nombre.label"
                                               default="Nombre" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "nombre")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.direccion.label"
                                               default="Direccion" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "direccion")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.sigla.label"
                                               default="Sigla" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "sigla")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.objetivo.label"
                                               default="Objetivo" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "objetivo")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.telefono.label"
                                               default="Telefono" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "telefono")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.fax.label"
                                               default="Fax" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "fax")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.email.label"
                                               default="Email" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "email")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="entidad.observaciones.label"
                                               default="Observaciones" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: entidadInstance, field: "observaciones")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${entidadInstance?.id}">
                                <g:message code="default.button.update.label" default="Edit" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${entidadInstance?.id}">
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
