

<%@ page import="mies.EntidadesProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto')}" />
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
            <g:hasErrors bean="${entidadesProyectoInstance}">
            <div class="errors">
                <g:renderErrors bean="${entidadesProyectoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="entidad"><g:message code="entidadesProyecto.entidad.label" default="Entidad" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadesProyectoInstance, field: 'entidad', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="entidad.id" title="entidad" from="${mies.Entidad.list()}" optionKey="id" value="${entidadesProyectoInstance?.entidad?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tipoParticipacion"><g:message code="entidadesProyecto.tipoParticipacion.label" default="Tipo Participacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadesProyectoInstance, field: 'tipoParticipacion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoParticipacion.id" title="tipoParticipacion" from="${mies.TipoParticipacion.list()}" optionKey="id" value="${entidadesProyectoInstance?.tipoParticipacion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="proyecto"><g:message code="entidadesProyecto.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadesProyectoInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${entidadesProyectoInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="monto"><g:message code="entidadesProyecto.monto.label" default="Monto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadesProyectoInstance, field: 'monto', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="monto" title="monto" id="monto" value="${fieldValue(bean: entidadesProyectoInstance, field: 'monto')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="rol"><g:message code="entidadesProyecto.rol.label" default="Rol" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadesProyectoInstance, field: 'rol', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="rol" id="rol" title="rol" cols="40" rows="5" value="${entidadesProyectoInstance?.rol}" />
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
