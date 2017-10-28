
<%@ page import="mies.Componente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'componente.label', default: 'Componente')}" />
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
                            <g:message code="componente.show.legend"
                                       default="Componente details" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="componente.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: componenteInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="componente.descripcion.label"
                                               default="Descripcion" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: componenteInstance, field: "descripcion")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${componenteInstance?.id}">
                                <g:message code="default.button.update.label" default="Edit" />
                            </g:link>
                            <g:link class="button delete" action="delete" id="${componenteInstance?.id}">
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
