<%@ page import="mies.Provincia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'provincia.label', default: 'Provincia')}"/>
        <title><g:message code="default.create.label" args="[entityName]"/></title>
    </head>

    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message
                    code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                                   args="[entityName]"/></g:link></span>
        </div>

        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${provinciaInstance}">
                <div class="errors">
                    <g:renderErrors bean="${provinciaInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="save">
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zona"><g:message code="provincia.zona.label" default="Zona"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: provinciaInstance, field: 'zona', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="zona.id" title="zona"
                                              from="${mies.Zona.list()}" optionKey="id"
                                              value="${provinciaInstance?.zona?.id}" noSelection="['null': '']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="region"><g:message code="provincia.region.label"
                                                                   default="Region"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: provinciaInstance, field: 'region', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="region.id"
                                              title="region" from="${mies.Region.list()}" optionKey="id"
                                              value="${provinciaInstance?.region?.id}" noSelection="['null': '']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numero"><g:message code="provincia.numero.label"
                                                                   default="Numero"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: provinciaInstance, field: 'numero', 'errors')}">
                                    <g:textField name="numero" id="numero" title="numero"
                                                 class="field ui-widget-content ui-corner-all"
                                                 value="${provinciaInstance?.numero}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="provincia.nombre.label"
                                                                   default="Nombre"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: provinciaInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" id="nombre" title="nombre"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="63" value="${provinciaInstance?.nombre}"/>
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
