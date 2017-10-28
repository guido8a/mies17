<%@ page import="mies.UnidadEjecutora" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora')}"/>
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
    <g:hasErrors bean="${unidadEjecutoraInstance}">
        <div class="errors">
            <g:renderErrors bean="${unidadEjecutoraInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="subSecretaria"><g:message code="unidadEjecutora.subSecretaria.label"
                                                              default="Sub Secretaria"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'subSecretaria', 'errors')}">
                        <g:select class="field ui-widget-content ui-corner-all" name="subSecretaria.id"
                                  title="subSecretaria" from="${mies.SubSecretaria.list()}" optionKey="id"
                                  value="${unidadEjecutoraInstance?.subSecretaria?.id}" noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="nombre"><g:message code="unidadEjecutora.nombre.label" default="Nombre"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'nombre', 'errors')}">
                        <g:textField name="nombre" id="nombre" title="nombre"
                                     class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                     value="${unidadEjecutoraInstance?.nombre}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="titulo"><g:message code="unidadEjecutora.titulo.label" default="Titulo"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'titulo', 'errors')}">
                        <g:textField name="titulo" id="titulo" title="titulo"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                     value="${unidadEjecutoraInstance?.titulo}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="direccion"><g:message code="unidadEjecutora.direccion.label"
                                                          default="Direccion"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'direccion', 'errors')}">
                        <g:textField name="direccion" id="direccion" title="direccion"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                                     value="${unidadEjecutoraInstance?.direccion}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="sigla"><g:message code="unidadEjecutora.sigla.label" default="Sigla"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'sigla', 'errors')}">
                        <g:textField name="sigla" id="sigla" title="sigla" class="field ui-widget-content ui-corner-all"
                                     minLenght="1" maxLenght="7" value="${unidadEjecutoraInstance?.sigla}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="objetivo"><g:message code="unidadEjecutora.objetivo.label"
                                                         default="Objetivo"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'objetivo', 'errors')}">
                        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024"
                                    name="objetivo" id="objetivo" title="objetivo" cols="40" rows="5"
                                    value="${unidadEjecutoraInstance?.objetivo}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fechaInicio"><g:message code="unidadEjecutora.fechaInicio.label"
                                                            default="Fecha Inicio"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'fechaInicio', 'errors')}">
                        <input type="hidden" value="date.struct" name="fechaInicio">
                        <input type="hidden" name="fechaInicio_day" id="fechaInicio_day"
                               value="${unidadEjecutoraInstance?.fechaInicio?.format('dd')}">
                        <input type="hidden" name="fechaInicio_month" id="fechaInicio_month"
                               value="${unidadEjecutoraInstance?.fechaInicio?.format('MM')}">
                        <input type="hidden" name="fechaInicio_year" id="fechaInicio_year"
                               value="${unidadEjecutoraInstance?.fechaInicio?.format('yyyy')}">
                        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio"
                                     title="fechaInicio" id="fechaInicio"
                                     value="${unidadEjecutoraInstance?.fechaInicio?.format('dd-MM-yyyy')}"/>
                        <script type='text/javascript'>
                            $('#fechaInicio').datepicker({
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
                        <label for="fechaFin"><g:message code="unidadEjecutora.fechaFin.label"
                                                         default="Fecha Fin"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'fechaFin', 'errors')}">
                        <input type="hidden" value="date.struct" name="fechaFin">
                        <input type="hidden" name="fechaFin_day" id="fechaFin_day"
                               value="${unidadEjecutoraInstance?.fechaFin?.format('dd')}">
                        <input type="hidden" name="fechaFin_month" id="fechaFin_month"
                               value="${unidadEjecutoraInstance?.fechaFin?.format('MM')}">
                        <input type="hidden" name="fechaFin_year" id="fechaFin_year"
                               value="${unidadEjecutoraInstance?.fechaFin?.format('yyyy')}">
                        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin"
                                     title="fechaFin" id="fechaFin"
                                     value="${unidadEjecutoraInstance?.fechaFin?.format('dd-MM-yyyy')}"/>
                        <script type='text/javascript'>
                            $('#fechaFin').datepicker({
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
                        <label for="telefono"><g:message code="unidadEjecutora.telefono.label"
                                                         default="Telefono"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'telefono', 'errors')}">
                        <g:textField name="telefono" id="telefono" title="telefono"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                     value="${unidadEjecutoraInstance?.telefono}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fax"><g:message code="unidadEjecutora.fax.label" default="Fax"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'fax', 'errors')}">
                        <g:textField name="fax" id="fax" title="fax" class="field ui-widget-content ui-corner-all"
                                     minLenght="1" maxLenght="63" value="${unidadEjecutoraInstance?.fax}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="email"><g:message code="unidadEjecutora.email.label" default="Email"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'email', 'errors')}">
                        <g:textField name="email" id="email" title="email" class="field ui-widget-content ui-corner-all"
                                     minLenght="1" maxLenght="63" value="${unidadEjecutoraInstance?.email}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="observaciones"><g:message code="unidadEjecutora.observaciones.label"
                                                              default="Observaciones"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'observaciones', 'errors')}">
                        <g:textField name="observaciones" id="observaciones" title="observaciones"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                                     value="${unidadEjecutoraInstance?.observaciones}"/>
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
