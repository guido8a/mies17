<%@ page import="mies.Persona" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${personaInstance}">
        <div class="errors">
            <g:renderErrors bean="${personaInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="cedula"><g:message code="persona.cedula.label" default="Cedula"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'cedula', 'errors')}">
                        <g:textField name="cedula" id="cedula" title="Cedula"
                                     class="6 field required ui-widget-content ui-corner-all" minLenght="1"
                                     maxLenght="13" value="${personaInstance?.cedula}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="nombre"><g:message code="persona.nombre.label" default="Nombre"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'nombre', 'errors')}">
                        <g:textField name="nombre" id="nombre" title="Nombre"
                                     class="6 field required ui-widget-content ui-corner-all" minLenght="1"
                                     maxLenght="40" value="${personaInstance?.nombre}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="apellido"><g:message code="persona.apellido.label" default="Apellido"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'apellido', 'errors')}">
                        <g:textField name="apellido" id="apellido" title="Apellido"
                                     class="6 field required ui-widget-content ui-corner-all" minLenght="1"
                                     maxLenght="40" value="${personaInstance?.apellido}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="sexo"><g:message code="persona.sexo.label" default="Sexo"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'sexo', 'errors')}">
                        <g:select class="5 field required ui-widget-content ui-corner-all" name="sexo" title="Sexo"
                                  id="sexo" from="${personaInstance.constraints.sexo.inList}"
                                  value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="discapacitado"><g:message code="persona.discapacitado.label"
                                                              default="Discapacitado"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: personaInstance, field: 'discapacitado', 'errors')}">
                        <g:textField name="discapacitado" id="discapacitado" title="Discapacitado"
                                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1"
                                     value="${personaInstance?.discapacitado}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fechaNacimiento"><g:message code="persona.fechaNacimiento.label"
                                                                default="Fecha Nacimiento"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: personaInstance, field: 'fechaNacimiento', 'errors')}">
                        <input type="hidden" value="date.struct" name="fechaNacimiento">
                        <input type="hidden" name="fechaNacimiento_day" id="fechaNacimiento_day"
                               value="${personaInstance?.fechaNacimiento?.format('dd')}">
                        <input type="hidden" name="fechaNacimiento_month" id="fechaNacimiento_month"
                               value="${personaInstance?.fechaNacimiento?.format('MM')}">
                        <input type="hidden" name="fechaNacimiento_year" id="fechaNacimiento_year"
                               value="${personaInstance?.fechaNacimiento?.format('yyyy')}">
                        <g:textField class="25 datepicker field ui-widget-content ui-corner-all" name="fechaNacimiento"
                                     title="FechaNacimiento" id="fechaNacimiento"
                                     value="${personaInstance?.fechaNacimiento?.format('dd-MM-yyyy')}"/>
                        <script type='text/javascript'>
                            $('#fechaNacimiento').datepicker({
                                        changeMonth: true,
                                        changeYear:true,
                                        dateFormat: 'dd-mm-yy',
                                        onClose: function(dateText, inst) {
                                            var date = $(this).datepicker('getDate');
                                            var day, month, year;
                                            if (date != null) {
                                                day = date.getDate();
                                                month = parseInt(date.getMonth()) + 1;
                                                year = date.getFullYear();
                                            } else {
                                                day = '';
                                                month = '';
                                                year = '';
                                            }
                                            var id = $(this).attr('id');
                                            $('#' + id + '_day').val(day);
                                            $('#' + id + '_month').val(month);
                                            $('#' + id + '_year').val(year);
                                        }
                                    });
                        </script>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="direccion"><g:message code="persona.direccion.label" default="Direccion"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'direccion', 'errors')}">
                        <g:textField name="direccion" id="direccion" title="Direccion"
                                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                                     value="${personaInstance?.direccion}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="telefono"><g:message code="persona.telefono.label" default="Telefono"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'telefono', 'errors')}">
                        <g:textField name="telefono" id="telefono" title="Telefono"
                                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="40"
                                     value="${personaInstance?.telefono}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="mail"><g:message code="persona.mail.label" default="Mail"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'mail', 'errors')}">
                        <g:textField name="mail" id="mail" title="Mail"
                                     class="6 field email ui-widget-content ui-corner-all" minLenght="1" maxLenght="40"
                                     value="${personaInstance?.mail}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fax"><g:message code="persona.fax.label" default="Fax"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personaInstance, field: 'fax', 'errors')}">
                        <g:textField name="fax" id="fax" title="Fax" class="6 field ui-widget-content ui-corner-all"
                                     minLenght="1" maxLenght="40" value="${personaInstance?.fax}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="observaciones"><g:message code="persona.observaciones.label"
                                                              default="Observaciones"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: personaInstance, field: 'observaciones', 'errors')}">
                        <g:textField name="observaciones" id="observaciones" title="Observaciones"
                                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                                     value="${personaInstance?.observaciones}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save"
                                                 value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
