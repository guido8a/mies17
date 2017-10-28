<%@ page import="mies.UnidadEjecutora" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">
<div id="" class="toolbar ui-widget-header ui-corner-all">
    <a class="button home" href="${createLinkTo(dir: '')}">
        <g:message code="home" default="Home"/>
    </a>
    <g:link class="button list" action="list">
        <g:message code="unidadEjecutora.list" default="UnidadEjecutora List"/>
    </g:link>
    <g:link class="button create" action="create">
        <g:message code="default.new.label" args="[entityName]"/>
    </g:link>
</div> <!-- toolbar -->

<div class="body">
<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
</g:if>
<div>

<fieldset class="ui-corner-all">
<legend class="ui-widget ui-widget-header ui-corner-all">
    <g:message code="unidadEjecutora.show.legend"
               default="UnidadEjecutora details"/>
</legend>


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.id.label"
                   default="Id"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "id")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.subSecretaria.label"
                   default="Sub Secretaria"/>
    </label>

    <div class="campo">

        <g:link controller="subSecretaria" action="show"
                id="${unidadEjecutoraInstance?.subSecretaria?.id}">
            ${unidadEjecutoraInstance?.subSecretaria?.encodeAsHTML()}
        </g:link>

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.nombre.label"
                   default="Nombre"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "nombre")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.titulo.label"
                   default="Titulo"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "titulo")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.direccion.label"
                   default="Direccion"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "direccion")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.sigla.label"
                   default="Sigla"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "sigla")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.objetivo.label"
                   default="Objetivo"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "objetivo")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.fechaInicio.label"
                   default="Fecha Inicio"/>
    </label>

    <div class="campo">

        <g:formatDate date="${unidadEjecutoraInstance?.fechaInicio}" format="dd-MM-yyyy HH:mm"/>

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.fechaFin.label"
                   default="Fecha Fin"/>
    </label>

    <div class="campo">

        <g:formatDate date="${unidadEjecutoraInstance?.fechaFin}" format="dd-MM-yyyy HH:mm"/>

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.telefono.label"
                   default="Telefono"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "telefono")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.fax.label"
                   default="Fax"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "fax")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.email.label"
                   default="Email"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "email")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="prop">
    <label>
        <g:message code="unidadEjecutora.observaciones.label"
                   default="Observaciones"/>
    </label>

    <div class="campo">

        ${fieldValue(bean: unidadEjecutoraInstance, field: "observaciones")}

    </div> <!-- campo -->
</div> <!-- prop -->


<div class="buttons">
    <g:link class="button edit" action="edit" id="${unidadEjecutoraInstance?.id}">
        <g:message code="default.button.update.label" default="Edit"/>
    </g:link>
    <g:link class="button delete" action="delete" id="${unidadEjecutoraInstance?.id}">
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
