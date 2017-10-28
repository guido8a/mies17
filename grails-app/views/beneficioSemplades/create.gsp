

<%@ page import="mies.BeneficioSenplades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'beneficioSenplades.label', default: 'BeneficioSenplades')}" />
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
            <g:hasErrors bean="${beneficioSempladesInstance}">
            <div class="errors">
                <g:renderErrors bean="${beneficioSempladesInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="proyecto"><g:message code="beneficioSenplades.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: beneficioSempladesInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${beneficioSempladesInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beneficiariosDirectosHombres"><g:message code="beneficioSenplades.beneficiariosDirectosHombres.label" default="Beneficiarios Directos Hombres" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosDirectosHombres', 'errors')}">
                                    <g:textField  name="beneficiariosDirectosHombres" id="beneficiariosDirectosHombres" title="beneficiariosDirectosHombres" class="field ui-widget-content ui-corner-all" value="${beneficioSempladesInstance?.beneficiariosDirectosHombres}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beneficiariosDirectosMujeres"><g:message code="beneficioSenplades.beneficiariosDirectosMujeres.label" default="Beneficiarios Directos Mujeres" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosDirectosMujeres', 'errors')}">
                                    <g:textField  name="beneficiariosDirectosMujeres" id="beneficiariosDirectosMujeres" title="beneficiariosDirectosMujeres" class="field ui-widget-content ui-corner-all" value="${beneficioSempladesInstance?.beneficiariosDirectosMujeres}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beneficiariosIndirectosHombres"><g:message code="beneficioSenplades.beneficiariosIndirectosHombres.label" default="Beneficiarios Indirectos Hombres" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosIndirectosHombres', 'errors')}">
                                    <g:textField  name="beneficiariosIndirectosHombres" id="beneficiariosIndirectosHombres" title="beneficiariosIndirectosHombres" class="field ui-widget-content ui-corner-all" value="${beneficioSempladesInstance?.beneficiariosIndirectosHombres}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beneficiariosIndirectosMujeres"><g:message code="beneficioSenplades.beneficiariosIndirectosMujeres.label" default="Beneficiarios Indirectos Mujeres" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosIndirectosMujeres', 'errors')}">
                                    <g:textField  name="beneficiariosIndirectosMujeres" id="beneficiariosIndirectosMujeres" title="beneficiariosIndirectosMujeres" class="field ui-widget-content ui-corner-all" value="${beneficioSempladesInstance?.beneficiariosIndirectosMujeres}" />
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
