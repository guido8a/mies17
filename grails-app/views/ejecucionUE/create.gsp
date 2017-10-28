

<%@ page import="mies.EjecucionUE" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ejecucionUE.label', default: 'EjecucionUE')}" />
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
            <g:hasErrors bean="${ejecucionUEInstance}">
            <div class="errors">
                <g:renderErrors bean="${ejecucionUEInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vigente"><g:message code="ejecucionUE.vigente.label" default="Vigente" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'vigente', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="vigente" title="Vigente" id="vigente" value="${fieldValue(bean: ejecucionUEInstance, field: 'vigente')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comprometido"><g:message code="ejecucionUE.comprometido.label" default="Comprometido" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'comprometido', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="comprometido" title="Comprometido" id="comprometido" value="${fieldValue(bean: ejecucionUEInstance, field: 'comprometido')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fuente"><g:message code="ejecucionUE.fuente.label" default="Fuente" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'fuente', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="fuente.id" title="Fuente" from="${mies.Fuente.list()}" optionKey="id" value="${ejecucionUEInstance?.fuente?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="presupuesto"><g:message code="ejecucionUE.presupuesto.label" default="Presupuesto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'presupuesto', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="presupuesto.id" title="Presupuesto" from="${mies.Presupuesto.list()}" optionKey="id" value="${ejecucionUEInstance?.presupuesto?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="programa"><g:message code="ejecucionUE.programa.label" default="Programa" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'programa', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="programa.id" title="Programa" from="${mies.ProgramaPresupuestario.list()}" optionKey="id" value="${ejecucionUEInstance?.programa?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="proyecto"><g:message code="ejecucionUE.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="proyecto.id" title="Proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${ejecucionUEInstance?.proyecto?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sigef"><g:message code="ejecucionUE.sigef.label" default="Sigef" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'sigef', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="sigef.id" title="Sigef" from="${mies.Sigef.list()}" optionKey="id" value="${ejecucionUEInstance?.sigef?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unidadEjecutora"><g:message code="ejecucionUE.unidadEjecutora.label" default="Unidad Ejecutora" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ejecucionUEInstance, field: 'unidadEjecutora', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="unidadEjecutora.id" title="UnidadEjecutora" from="${mies.UnidadEjecutora.list()}" optionKey="id" value="${ejecucionUEInstance?.unidadEjecutora?.id}"  />
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
