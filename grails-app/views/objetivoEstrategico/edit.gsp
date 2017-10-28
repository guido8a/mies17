

<%@ page import="mies.ObjetivoEstrategico" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'objetivoEstrategico.label', default: 'ObjetivoEstrategico')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${objetivoEstrategicoInstance}">
            <div class="errors">
                <g:renderErrors bean="${objetivoEstrategicoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${objetivoEstrategicoInstance?.id}" />
                <g:hiddenField name="version" value="${objetivoEstrategicoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="proyecto"><g:message code="objetivoEstrategico.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: objetivoEstrategicoInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="Proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${objetivoEstrategicoInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="institucion"><g:message code="objetivoEstrategico.institucion.label" default="Institucion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: objetivoEstrategicoInstance, field: 'institucion', 'errors')}">
                                    <g:textField  name="institucion" id="institucion" title="Objetivo estratégico institucional" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.institucion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="objetivo"><g:message code="objetivoEstrategico.objetivo.label" default="Objetivo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: objetivoEstrategicoInstance, field: 'objetivo', 'errors')}">
                                    <g:textField  name="objetivo" id="objetivo" title="Objetivo" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.objetivo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="politica"><g:message code="objetivoEstrategico.politica.label" default="Politica" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: objetivoEstrategicoInstance, field: 'politica', 'errors')}">
                                    <g:textField  name="politica" id="politica" title="Política" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.politica}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="meta"><g:message code="objetivoEstrategico.meta.label" default="Meta" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: objetivoEstrategicoInstance, field: 'meta', 'errors')}">
                                    <g:textField  name="meta" id="meta" title="Meta" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.meta}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
