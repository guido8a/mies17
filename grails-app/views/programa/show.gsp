
<%@ page import="mies.Programa" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'programa.label', default: 'Programa')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="${title}">

            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button list" action="list">
                    <g:message code="programa.list" default="Lista de Programas" />
                </g:link>
                <g:link class="button create" action="create">Nuevo Programa</g:link>
            </div> <!-- toolbar -->


            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                    <fieldset class="ui-corner-all">
                        <legend class="ui-widget ui-widget-header ui-corner-all">
                            <g:message code="programa.show.legend"
                                       default="Datos del Programa" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="programa.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: programaInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="programa.codigo.label"
                                               default="Codigo" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: programaInstance, field: "codigo")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="programa.descripcion.label"
                                               default="Descripcion" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: programaInstance, field: "descripcion")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${programaInstance?.id}">
                                <g:message code="default.button.update.label" default="Editar" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${programaInstance?.id}">
                                <g:message code="default.button.delete.label" default="Eliminar" />
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
                    if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Está usted seguro?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
