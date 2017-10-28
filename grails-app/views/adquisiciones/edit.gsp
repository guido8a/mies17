

<%@ page import="mies.Adquisiciones" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'adquisiciones.label', default: 'Adquisiciones')}" />
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
            <g:hasErrors bean="${adquisicionesInstance}">
            <div class="errors">
                <g:renderErrors bean="${adquisicionesInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${adquisicionesInstance?.id}" />
                <g:hiddenField name="version" value="${adquisicionesInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="TipoAdquisicion"><g:message code="adquisiciones.TipoAdquisicion.label" default="Tipo Aquisicion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adquisicionesInstance, field: 'TipoAdquisicion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="TipoAdquisicion.id" title="TipoAdquisicion" from="${mies.TipoAdquisicion.list()}" optionKey="id" value="${adquisicionesInstance?.TipoAdquisicion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="proyecto"><g:message code="adquisiciones.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adquisicionesInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${adquisicionesInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipoProcedencia"><g:message code="adquisiciones.tipoProcedencia.label" default="Tipo Procedencia" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adquisicionesInstance, field: 'tipoProcedencia', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoProcedencia.id" title="tipoProcedencia" from="${mies.TipoProcedencia.list()}" optionKey="id" value="${adquisicionesInstance?.tipoProcedencia?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descripcion"><g:message code="adquisiciones.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adquisicionesInstance, field: 'descripcion', 'errors')}">
                                    <g:textField  name="descripcion" id="descripcion" title="descripcion" class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${adquisicionesInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valor"><g:message code="adquisiciones.valor.label" default="Valor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adquisicionesInstance, field: 'valor', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="valor" title="valor" id="valor" value="${fieldValue(bean: adquisicionesInstance, field: 'valor')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="porcentaje"><g:message code="adquisiciones.porcentaje.label" default="Porcentaje" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adquisicionesInstance, field: 'porcentaje', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="porcentaje" title="porcentaje" id="porcentaje" value="${fieldValue(bean: adquisicionesInstance, field: 'porcentaje')}" />
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
