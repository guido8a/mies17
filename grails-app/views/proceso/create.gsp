<%@ page import="mies.Proceso" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'proceso.label', default: 'Proceso')}"/>
        <title><g:message code="default.create.label" args="[entityName]"/></title>
    </head>

    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message
                    code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                                   args="[entityName]"/></g:link></span>
        </div>

        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${procesoInstance}">
                <div class="errors">
                    <g:renderErrors bean="${procesoInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="save">
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="proceso.nombre.label"
                                                                   default="Nombre"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: procesoInstance, field: 'nombre', 'errors')}">
                                    <g:textField name="nombre" id="nombre" title="nombre"
                                                 class="field required ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="63" value="${procesoInstance?.nombre}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="proceso.descripcion.label"
                                                                        default="Descripcion"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: procesoInstance, field: 'descripcion', 'errors')}">
                                    <g:textField name="descripcion" id="descripcion" title="descripcion"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="255" value="${procesoInstance?.descripcion}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fecha"><g:message code="proceso.fecha.label" default="Fecha"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: procesoInstance, field: 'fecha', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fecha">
                                    <input type="hidden" name="fecha_day" id="fecha_day"
                                           value="${procesoInstance?.fecha?.format('dd')}">
                                    <input type="hidden" name="fecha_month" id="fecha_month"
                                           value="${procesoInstance?.fecha?.format('MM')}">
                                    <input type="hidden" name="fecha_year" id="fecha_year"
                                           value="${procesoInstance?.fecha?.format('yyyy')}">
                                    <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha"
                                                 title="fecha" id="fecha"
                                                 value="${procesoInstance?.fecha?.format('dd-MM-yyyy')}"/>
                                    <script type='text/javascript'>
                                        $('#fecha').datepicker({
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
                                    <label for="fechaFin"><g:message code="proceso.fechaFin.label"
                                                                     default="Fecha Fin"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: procesoInstance, field: 'fechaFin', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaFin">
                                    <input type="hidden" name="fechaFin_day" id="fechaFin_day"
                                           value="${procesoInstance?.fechaFin?.format('dd')}">
                                    <input type="hidden" name="fechaFin_month" id="fechaFin_month"
                                           value="${procesoInstance?.fechaFin?.format('MM')}">
                                    <input type="hidden" name="fechaFin_year" id="fechaFin_year"
                                           value="${procesoInstance?.fechaFin?.format('yyyy')}">
                                    <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                                 name="fechaFin" title="fechaFin" id="fechaFin"
                                                 value="${procesoInstance?.fechaFin?.format('dd-MM-yyyy')}"/>
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
                                    <label for="estado"><g:message code="proceso.estado.label"
                                                                   default="Estado"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: procesoInstance, field: 'estado', 'errors')}">
                                    <g:textField name="estado" id="estado" title="estado"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="1" value="${procesoInstance?.estado}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="observaciones"><g:message code="proceso.observaciones.label"
                                                                          default="Observaciones"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: procesoInstance, field: 'observaciones', 'errors')}">
                                    <g:textField name="observaciones" id="observaciones" title="observaciones"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="127" value="${procesoInstance?.observaciones}"/>
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
