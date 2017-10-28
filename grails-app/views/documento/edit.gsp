

<%@ page import="mies.Documento" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
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
            <g:hasErrors bean="${documentoInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${documentoInstance?.id}" />
                <g:hiddenField name="version" value="${documentoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="proyecto"><g:message code="documento.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentoInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${documentoInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="grupoProcesos"><g:message code="documento.grupoProcesos.label" default="Grupo Procesos" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentoInstance, field: 'grupoProcesos', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="grupoProcesos.id" title="grupoProcesos" from="${mies.GrupoProcesos.list()}" optionKey="id" value="${documentoInstance?.grupoProcesos?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descripcion"><g:message code="documento.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentoInstance, field: 'descripcion', 'errors')}">
                                    <g:textField  name="descripcion" id="descripcion" title="descripcion" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${documentoInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="clave"><g:message code="documento.clave.label" default="Clave" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentoInstance, field: 'clave', 'errors')}">
                                    <g:textField  name="clave" id="clave" title="clave" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${documentoInstance?.clave}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="resumen"><g:message code="documento.resumen.label" default="Resumen" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentoInstance, field: 'resumen', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="resumen" id="resumen" title="resumen" cols="40" rows="5" value="${documentoInstance?.resumen}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documento"><g:message code="documento.documento.label" default="Documento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentoInstance, field: 'documento', 'errors')}">
                                    <g:textField  name="documento" id="documento" title="documento" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${documentoInstance?.documento}" />
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
