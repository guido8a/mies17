
<%@ page import="mies.MetaBuenVivir" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="${message(code: 'metaBuenVivir.label', default: 'MetaBuenVivir')}" />
        <title>Detalles Meta del Buen Vivir</title>
    </head>

    <body>

        <div class="dialog" title="Meta del Buen Vivir">


            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                    <fieldset class="ui-corner-all">
                        <legend class="ui-widget ui-widget-header ui-corner-all">
                            <g:message code="metaBuenVivir.show.legend"
                                       default="Meta del Buen Vivir" />
                        </legend>

                        

                            <div class="prop">
                                <label>
                                    <g:message code="metaBuenVivir.id.label"
                                               default="Id" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaBuenVivirInstance, field: "id")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="metaBuenVivir.politica.label"
                                               default="Política" />
                                </label>

                                <div class="campo">
                                    
                                    %{--<g:link controller="politicaBuenVivir" action="show"--}%
                                                         %{--id="${metaBuenVivirInstance?.politica?.id}">--}%
                                        %{--${metaBuenVivirInstance?.politica?.encodeAsHTML()}--}%
                                    %{--</g:link>--}%

                                    ${metaBuenVivirInstance?.politica?.encodeAsHTML()}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="metaBuenVivir.codigo.label"
                                               default="Código" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaBuenVivirInstance, field: "codigo")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                            <div class="prop">
                                <label>
                                    <g:message code="metaBuenVivir.descripcion.label"
                                               default="Descripción" />
                                </label>

                                <div class="campo">
                                    
                                    ${fieldValue(bean: metaBuenVivirInstance, field: "descripcion")}
                                    
                                </div> <!-- campo -->
                            </div> <!-- prop -->
                        

                        <div class="buttons">
                            <g:link class="button edit" action="edit" id="${metaBuenVivirInstance?.id}">
                                Editar
                            </g:link>
                            <g:link class="button delete" action="delete_ajax" id="${metaBuenVivirInstance?.id}">
                               Eliminar
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
                    if(confirm("está seguro de eliminar la Meta del Buen Vivir?")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
