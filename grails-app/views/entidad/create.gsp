

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'entidad.label', default: 'Entidad')}" />
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
            <g:hasErrors bean="${entidadInstance}">
            <div class="errors">
                <g:renderErrors bean="${entidadInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="entidad.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'nombre', 'errors')}">
                                    <g:textField  name="nombre" id="nombre" title="Nombre de la entidad o ministerio" class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="direccion"><g:message code="entidad.direccion.label" default="Direccion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'direccion', 'errors')}">
                                    <g:textField  name="direccion" id="direccion" title="Dirección de la entidad o ministerio" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${entidadInstance?.direccion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sigla"><g:message code="entidad.sigla.label" default="Sigla" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'sigla', 'errors')}">
                                    <g:textField  name="sigla" id="sigla" title="Sigla identificativa (por ejemplo, MIES)" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="7" value="${entidadInstance?.sigla}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="objetivo"><g:message code="entidad.objetivo.label" default="Objetivo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'objetivo', 'errors')}">
                                    <g:textField  name="objetivo" id="objetivo" title="Objetivo institucional o de la entidad" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.objetivo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telefono"><g:message code="entidad.telefono.label" default="Telefono" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'telefono', 'errors')}">
                                    <g:textField  name="telefono" id="telefono" title="Teléfonos, se los separa con “;”" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.telefono}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fax"><g:message code="entidad.fax.label" default="Fax" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'fax', 'errors')}">
                                    <g:textField  name="fax" id="fax" title="Números de fax, se los separa con “;”" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.fax}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="entidad.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'email', 'errors')}">
                                    <g:textField  name="email" id="email" title="Dirección de correo electrónico institucional" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="observaciones"><g:message code="entidad.observaciones.label" default="Observaciones" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entidadInstance, field: 'observaciones', 'errors')}">
                                    <g:textField  name="observaciones" id="observaciones" title="Observaciones" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${entidadInstance?.observaciones}" />
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
