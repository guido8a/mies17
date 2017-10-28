<%@ page import="mies.Paso" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'paso.label', default: 'Paso')}"/>
        <title><g:message code="default.edit.label" args="[entityName]"/></title>
    </head>

    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message
                    code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                                   args="[entityName]"/></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                                       args="[entityName]"/></g:link></span>
        </div>

        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pasoInstance}">
                <div class="errors">
                    <g:renderErrors bean="${pasoInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${pasoInstance?.id}"/>
                <g:hiddenField name="version" value="${pasoInstance?.version}"/>
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="proceso"><g:message code="paso.proceso.label"
                                                                    default="Proceso"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'proceso', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proceso.id"
                                              title="proceso" from="${mies.Proceso.list()}" optionKey="id"
                                              value="${pasoInstance?.proceso?.id}" noSelection="['null': '']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="orden"><g:message code="paso.orden.label" default="Orden"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'orden', 'errors')}">
                                    <g:textField name="orden" id="orden" title="orden"
                                                 class="field ui-widget-content ui-corner-all"
                                                 value="${pasoInstance?.orden}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="paso.nombre.label" default="Nombre"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" id="nombre" title="nombre"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="63" value="${pasoInstance?.nombre}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="paso.descripcion.label"
                                                                        default="Descripcion"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'descripcion', 'errors')}">
                                    <g:textField name="descripcion" id="descripcion" title="descripcion"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="255" value="${pasoInstance?.descripcion}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="obligacion"><g:message code="paso.obligacion.label"
                                                                       default="Obligacion"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'obligacion', 'errors')}">
                                    <g:textField name="obligacion" id="obligacion" title="obligacion"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="1" value="${pasoInstance?.obligacion}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tabla"><g:message code="paso.tabla.label" default="Tabla"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'tabla', 'errors')}">
                                    <g:textField name="tabla" id="tabla" title="tabla(s)"
                                                 class="field required ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="127" value="${pasoInstance?.tabla}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estado"><g:message code="paso.estado.label" default="Estado"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: pasoInstance, field: 'estado', 'errors')}">
                                    <g:textField name="estado" id="estado" title="estado"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="1" value="${pasoInstance?.estado}"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update"
                                                         value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete"
                                                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
