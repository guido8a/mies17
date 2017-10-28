<%@ page import="mies.Avance" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'avance.label', default: 'Avance')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${avanceInstance}">
        <div class="errors">
            <g:renderErrors bean="${avanceInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="informe"><g:message code="avance.informe.label" default="Informe"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: avanceInstance, field: 'informe', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="informe.id" title="informe"
                                  from="${mies.Informe.list()}" optionKey="id" value="${avanceInstance?.informe?.id}"
                                  noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="meta"><g:message code="avance.meta.label" default="Meta"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: avanceInstance, field: 'meta', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="meta.id" title="meta"
                                  from="${mies.Meta.list()}" optionKey="id" value="${avanceInstance?.meta?.id}"
                                  noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="tasa"><g:message code="avance.tasa.label" default="Tasa"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: avanceInstance, field: 'tasa', 'errors')}">
                        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                    name="tasa" id="tasa" title="tasa" cols="40" rows="5"
                                    value="${avanceInstance?.tasa}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="valor"><g:message code="avance.valor.label" default="Valor"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: avanceInstance, field: 'valor', 'errors')}">
                        <g:textField class="field number required ui-widget-content ui-corner-all" name="valor"
                                     title="valor" id="valor"
                                     value="${fieldValue(bean: avanceInstance, field: 'valor')}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save"
                                                 value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
