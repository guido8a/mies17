<%@ page import="mies.Financiamiento" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'financiamiento.label', default: 'Financiamiento')}"/>
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
    <g:hasErrors bean="${financiamientoInstance}">
        <div class="errors">
            <g:renderErrors bean="${financiamientoInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${financiamientoInstance?.id}"/>
        <g:hiddenField name="version" value="${financiamientoInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="anio"><g:message code="financiamiento.anio.label" default="Anio"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: financiamientoInstance, field: 'anio', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="anio.id" title="anio"
                                  from="${mies.Anio.list()}" optionKey="id" value="${financiamientoInstance?.anio?.id}"
                                  noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fuente"><g:message code="financiamiento.fuente.label" default="Fuente"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: financiamientoInstance, field: 'fuente', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="fuente.id" title="fuente"
                                  from="${mies.Fuente.list()}" optionKey="id"
                                  value="${financiamientoInstance?.fuente?.id}" noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="proyecto"><g:message code="financiamiento.proyecto.label"
                                                         default="Proyecto"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: financiamientoInstance, field: 'proyecto', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto"
                                  from="${mies.Proyecto.list()}" optionKey="id"
                                  value="${financiamientoInstance?.proyecto?.id}" noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="monto"><g:message code="financiamiento.monto.label" default="Monto"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: financiamientoInstance, field: 'monto', 'errors')}">
                        <g:textField class="field number required ui-widget-content ui-corner-all" name="monto"
                                     title="monto" id="monto"
                                     value="${fieldValue(bean: financiamientoInstance, field: 'monto')}"/>
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
