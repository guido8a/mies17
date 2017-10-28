

<%@ page import="mies.Meta" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'meta.label', default: 'Meta')}" />
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
            <g:hasErrors bean="${metaInstance}">
            <div class="errors">
                <g:renderErrors bean="${metaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${metaInstance?.id}" />
                <g:hiddenField name="version" value="${metaInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipoMeta"><g:message code="meta.tipoMeta.label" default="Tipo Meta" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'tipoMeta', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoMeta.id" title="Tipo de Meta" from="${mies.TipoMeta.list()}" optionKey="id" value="${metaInstance?.tipoMeta?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="parroquia"><g:message code="meta.parroquia.label" default="Parroquia" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'parroquia', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="parroquia.id" title="Parroquia en la cual se verificará la meta" from="${mies.Parroquia.list()}" optionKey="id" value="${metaInstance?.parroquia?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="marcoLogico"><g:message code="meta.marcoLogico.label" default="Marco Logico" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'marcoLogico', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="marcoLogico.id" title="Componente del marco lógico" from="${mies.MarcoLogico.list()}" optionKey="id" value="${metaInstance?.marcoLogico?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unidad"><g:message code="meta.unidad.label" default="Unidad" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'unidad', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="unidad.id" title="Unidad de medida" from="${mies.Unidad.list()}" optionKey="id" value="${metaInstance?.unidad?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descripcion"><g:message code="meta.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'descripcion', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="descripcion" id="descripcion" title="Descripción de la meta a alcanzar" cols="40" rows="5" value="${metaInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="indicador"><g:message code="meta.indicador.label" default="Indicador" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'indicador', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="indicador" title="Indicador numérico de la meta" id="indicador" value="${fieldValue(bean: metaInstance, field: 'indicador')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="modificacion"><g:message code="meta.modificacion.label" default="Modificacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'modificacion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="modificacion.id" title="Modificacion" from="${mies.ModificacionProyecto.list()}" optionKey="id" value="${metaInstance?.modificacion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="estado"><g:message code="meta.estado.label" default="Estado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'estado', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="estado" title="Estado" id="estado" value="${fieldValue(bean: metaInstance, field: 'estado')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="anio"><g:message code="meta.anio.label" default="Anio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'anio', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="anio.id" title="Anio" from="${mies.Anio.list()}" optionKey="id" value="${metaInstance?.anio?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cord_x"><g:message code="meta.cord_x.label" default="Cordx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'cord_x', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="cord_x" title="Cord_x" id="cord_x" value="${fieldValue(bean: metaInstance, field: 'cord_x')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cord_y"><g:message code="meta.cord_y.label" default="Cordy" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'cord_y', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="cord_y" title="Cord_y" id="cord_y" value="${fieldValue(bean: metaInstance, field: 'cord_y')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="inversion"><g:message code="meta.inversion.label" default="Inversion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: metaInstance, field: 'inversion', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="inversion" title="Inversion" id="inversion" value="${fieldValue(bean: metaInstance, field: 'inversion')}" />
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
