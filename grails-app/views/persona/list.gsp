<%@ page import="mies.Persona" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'persona.label', default: 'Persona')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">
    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <g:link class="button create" action="create">Nueva Persona</g:link>
    </div> <!-- toolbar -->

    <div class="body">
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <div class="list" style="width: 900px;">
            <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                %{--<div id="example_length" class="dataTables_length">--}%
                %{--<g:message code="show" default="Show" />&nbsp;--}%
                %{--<g:select from="${[10,20,30,40,50,60,70,80,90,100]}" name="max" value="${params.max}" />&nbsp;--}%
                %{--<g:message code="entries" default="entries" />--}%


                %{--<g:select--}%
                %{--from="['asc':message(code:'asc', default:'Ascendente'), 'desc':message(code:'desc', default:'Descendente')]"--}%
                %{--name="order"--}%
                %{--optionKey="key"--}%
                %{--optionValue="value"--}%
                %{--value="${params.order}"--}%
                %{--class="ui-widget-content ui-corner-all"/>--}%
                %{--</div>--}%
            </div>
            <table style="width: 900px;">
                <thead>
                <tr>
                    <tdn:sortableColumn property="nombre" class="ui-state-default"
                                        title="${message(code: 'persona.nombre.label', default: 'Nombre')}"/>
                    <tdn:sortableColumn property="apellido" class="ui-state-default"
                                        title="${message(code: 'persona.apellido.label', default: 'Apellido')}"/>
                    <tdn:sortableColumn property="mail" class="ui-state-default"
                                        title="${message(code: 'persona.cedula.label', default: 'Mail')}"/>
                    <tdn:sortableColumn property="cedula" class="ui-state-default"
                                        title="${message(code: 'persona.cedula.label', default: 'Cédula')}"/>
                    <tdn:sortableColumn property="telefono" class="ui-state-default"
                                        title="${message(code: 'persona.cedula.label', default: 'Teléfono')}"/>
                    <tdn:sortableColumn property="sexo" class="ui-state-default"
                                        title="${message(code: 'persona.sexo.label', default: 'Sexo')}"/>
                    <tdn:sortableColumn property="fechaNacimiento" class="ui-state-default"
                                        title="${message(code: 'persona.sexo.label', default: 'FechaNac.')}"/>

                </tr>
                </thead>
                <tbody>
                <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td><g:link action="show" id="${personaInstance.id}">
                            ${fieldValue(bean: personaInstance, field: "nombre")}</g:link></td>
                        <td>${fieldValue(bean: personaInstance, field: "apellido")}</td>
                        <td>${fieldValue(bean: personaInstance, field: "mail")}</td>
                        <td>${fieldValue(bean: personaInstance, field: "cedula")}</td>
                        <td>${fieldValue(bean: personaInstance, field: "telefono")}</td>
                        <td>${fieldValue(bean: personaInstance, field: "sexo")}</td>
                        <td>${personaInstance.fechaNacimiento?.format('dd-MM-yyyy')}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
            <tdn:paginate total="${personaInstanceTotal}"/>
        </div>
    </div> <!-- body -->
</div> <!-- dialog -->

<script type="text/javascript">
    $(function() {
        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
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
