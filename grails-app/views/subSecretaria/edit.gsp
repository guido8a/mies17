<%@ page import="mies.SubSecretaria" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'subSecretaria.label', default: 'SubSecretaria')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${subSecretariaInstance}">
        <div class="errors">
            <g:renderErrors bean="${subSecretariaInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${subSecretariaInstance?.id}"/>
        <g:hiddenField name="version" value="${subSecretariaInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="entidad"><g:message code="subSecretaria.entidad.label" default="Entidad"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: subSecretariaInstance, field: 'entidad', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="entidad.id" title="entidad"
                                  from="${mies.Entidad.list()}" optionKey="id"
                                  value="${subSecretariaInstance?.entidad?.id}" noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="nombre"><g:message code="subSecretaria.nombre.label" default="Nombre"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: subSecretariaInstance, field: 'nombre', 'errors')}">
                        <g:textField name="nombre" id="nombre" title="nombre"
                                     class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                     value="${subSecretariaInstance?.nombre}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="titulo"><g:message code="subSecretaria.titulo.label" default="Titulo"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: subSecretariaInstance, field: 'titulo', 'errors')}">
                        <g:textField name="titulo" id="titulo" title="titulo"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                     value="${subSecretariaInstance?.titulo}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update"
                                                 value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete"
                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
