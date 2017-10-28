

<%@ page import="mies.Presupuesto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'presupuesto.label', default: 'Presupuesto')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${presupuestoInstance}">
            <div class="errors">
                <g:renderErrors bean="${presupuestoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="presupuesto"><g:message code="presupuesto.presupuesto.label" default="Presupuesto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: presupuestoInstance, field: 'presupuesto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="presupuesto.id" title="presupuesto" from="${mies.Presupuesto.list()}" optionKey="id" value="${presupuestoInstance?.presupuesto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numero"><g:message code="presupuesto.numero.label" default="Numero" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: presupuestoInstance, field: 'numero', 'errors')}">
                                    <g:textField  name="numero" id="numero" title="numero" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="15" value="${presupuestoInstance?.numero}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="presupuesto.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: presupuestoInstance, field: 'descripcion', 'errors')}">
                                    <g:textField  name="descripcion" id="descripcion" title="descripcion" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${presupuestoInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nivel"><g:message code="presupuesto.nivel.label" default="Nivel" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: presupuestoInstance, field: 'nivel', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="nivel" title="nivel" id="nivel" value="${fieldValue(bean: presupuestoInstance, field: 'nivel')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
