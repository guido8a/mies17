
<%@ page import="mies.Meta" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'meta.label', default: 'Meta')}" />
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
                            <g:message code="meta.show.legend"
                                       default="Meta details" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.tipoMeta.label"
                                               default="Tipo Meta" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="tipoMeta" action="show"
                                                         id="${metaInstance?.tipoMeta?.id}">
                                        ${metaInstance?.tipoMeta?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.parroquia.label"
                                               default="Parroquia" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="parroquia" action="show"
                                                         id="${metaInstance?.parroquia?.id}">
                                        ${metaInstance?.parroquia?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.marcoLogico.label"
                                               default="Marco Logico" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="marcoLogico" action="show"
                                                         id="${metaInstance?.marcoLogico?.id}">
                                        ${metaInstance?.marcoLogico?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.unidad.label"
                                               default="Unidad" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="unidad" action="show"
                                                         id="${metaInstance?.unidad?.id}">
                                        ${metaInstance?.unidad?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.descripcion.label"
                                               default="Descripcion" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "descripcion")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.indicador.label"
                                               default="Indicador" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "indicador")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.modificacion.label"
                                               default="Modificacion" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="modificacionProyecto" action="show"
                                                         id="${metaInstance?.modificacion?.id}">
                                        ${metaInstance?.modificacion?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.estado.label"
                                               default="Estado" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "estado")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.anio.label"
                                               default="Anio" />
                                </label>

                                <div class="campo">
                                    
                                    <g:link controller="anio" action="show"
                                                         id="${metaInstance?.anio?.id}">
                                        ${metaInstance?.anio?.encodeAsHTML()}
                                    </g:link>
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.cord_x.label"
                                               default="Cordx" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "cord_x")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.cord_y.label"
                                               default="Cordy" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "cord_y")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="meta.inversion.label"
                                               default="Inversion" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaInstance, field: "inversion")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${metaInstance?.id}">
                                <g:message code="default.button.update.label" default="Edit" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${metaInstance?.id}">
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
