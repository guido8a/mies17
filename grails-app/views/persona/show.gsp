<%@ page import="mies.Persona" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'persona.label', default: 'Persona')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">
<div id="" class="toolbar ui-widget-header ui-corner-all">
    <g:link class="button list" action="list"><g:message code="persona.list" default="Lista de Personas"/></g:link>
    <g:link class="button create" action="create">Nueva Persona</g:link>
</div> <!-- toolbar -->

<div class="body">
    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
    </g:if>
    <div>

        <fieldset class="ui-corner-all" style="width: 600px;">
            <legend class="ui-widget ui-widget-header ui-corner-all">
                <g:message code="persona.show.legend"
                           default="Detalles de Persona"/>
            </legend>


            <div class="prop">
                <label>
                    <g:message code="persona.id.label"
                               default="Id"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "id")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.cedula.label"
                               default="Cedula"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "cedula")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.nombre.label"
                               default="Nombre"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "nombre")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.apellido.label"
                               default="Apellido"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "apellido")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.sexo.label"
                               default="Sexo"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "sexo")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.discapacitado.label"
                               default="Discapacitado"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "discapacitado")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.fechaNacimiento.label"
                               default="Fecha Nacimiento"/>
                </label>

                <div class="campo">

                    <g:formatDate date="${personaInstance?.fechaNacimiento}" format="dd-MM-yyyy HH:mm"/>

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.direccion.label"
                               default="Direccion"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "direccion")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.telefono.label"
                               default="Telefono"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "telefono")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.mail.label"
                               default="Mail"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "mail")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.fax.label"
                               default="Fax"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "fax")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="prop">
                <label>
                    <g:message code="persona.observaciones.label"
                               default="Observaciones"/>
                </label>

                <div class="campo">

                    ${fieldValue(bean: personaInstance, field: "observaciones")}

                </div> <!-- campo -->
            </div> <!-- prop -->


            <div class="buttons">
                <g:link class="button edit" action="edit" id="${personaInstance?.id}">
                    <g:message code="default.button.update.label" default="Edit"/>
                </g:link>
                <g:link class="button delete" action="delete" id="${personaInstance?.id}">
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
