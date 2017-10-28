

<%@ page import="mies.Ejecucion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ejecucion.label', default: 'Ejecucion')}" />
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
            <g:hasErrors bean="${ejecucionInstance}">
            <div class="errors">
                <g:renderErrors bean="${ejecucionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="asignacion"><g:message code="ejecucion.asignacion.label" default="Asignacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'asignacion', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="asignacion.id" title="Asignacion" from="${mies.Asignacion.list()}" optionKey="id" value="${ejecucionInstance?.asignacion?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="compromiso"><g:message code="ejecucion.compromiso.label" default="Compromiso" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'compromiso', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="compromiso" title="Compromiso" id="compromiso" value="${fieldValue(bean: ejecucionInstance, field: 'compromiso')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="devengado"><g:message code="ejecucion.devengado.label" default="Devengado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'devengado', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="devengado" title="Devengado" id="devengado" value="${fieldValue(bean: ejecucionInstance, field: 'devengado')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pagado"><g:message code="ejecucion.pagado.label" default="Pagado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'pagado', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="pagado" title="Pagado" id="pagado" value="${fieldValue(bean: ejecucionInstance, field: 'pagado')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="saldoDisponible"><g:message code="ejecucion.saldoDisponible.label" default="Saldo Disponible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'saldoDisponible', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="saldoDisponible" title="SaldoDisponible" id="saldoDisponible" value="${fieldValue(bean: ejecucionInstance, field: 'saldoDisponible')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="saldoPresupuesto"><g:message code="ejecucion.saldoPresupuesto.label" default="Saldo Presupuesto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'saldoPresupuesto', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="saldoPresupuesto" title="SaldoPresupuesto" id="saldoPresupuesto" value="${fieldValue(bean: ejecucionInstance, field: 'saldoPresupuesto')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sigef"><g:message code="ejecucion.sigef.label" default="Sigef" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'sigef', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="sigef.id" title="Sigef" from="${mies.Sigef.list()}" optionKey="id" value="${ejecucionInstance?.sigef?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vigente"><g:message code="ejecucion.vigente.label" default="Vigente" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionInstance, field: 'vigente', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="vigente" title="Vigente" id="vigente" value="${fieldValue(bean: ejecucionInstance, field: 'vigente')}" />
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
