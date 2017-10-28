<%@ page import="mies.ProgramaPresupuestario" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'programaPresupuestario.label', default: 'Programa Presupuestario')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">

    <div class="body">

        <div id="" class="toolbar ui-widget-header ui-corner-all">
                   <g:link class="button list" action="list">
                       <g:message code="programaPresupuestario.list" default="Lista de Programas Presupuestarios" />
                   </g:link>
                   <g:link class="button create" action="create">Nuevo Programa
                   </g:link>
               </div> <!-- toolbar -->


        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
        </g:if>
        <div>

            <fieldset class="ui-corner-all">
                <legend class="ui-widget ui-widget-header ui-corner-all">
                    <g:message code="programaPresupuestario.show.legend"
                               default="Programa Presupuestario"/>
                </legend>


                <div class="prop">
                    <label>
                        <g:message code="programaPresupuestario.id.label"
                                   default="Id"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: programaPresupuestarioInstance, field: "id")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="prop">
                    <label>
                        <g:message code="programaPresupuestario.codigo.label"
                                   default="Codigo"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: programaPresupuestarioInstance, field: "codigo")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="prop">
                    <label>
                        <g:message code="programaPresupuestario.descripcion.label"
                                   default="Descripcion"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: programaPresupuestarioInstance, field: "descripcion")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="buttons">
                    <g:link class="button edit" action="edit" id="${programaPresupuestarioInstance?.id}">
                        <g:message code="default.button.update.label" default="Edit"/>
                    </g:link>
                    <g:link class="button delete" action="delete" id="${programaPresupuestarioInstance?.id}">
                        <g:message code="default.button.delete.label" default="Delete"/>
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
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
