<%@ page import="mies.Informe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'informe.label', default: 'Informe')}"/>
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
            <g:hasErrors bean="${informeInstance}">
                <div class="errors">
                    <g:renderErrors bean="${informeInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="save">
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="responsableProyecto"><g:message code="informe.responsableProyecto.label"
                                                                                default="Responsable Proyecto"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'responsableProyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all"
                                              name="responsableProyecto.id" title="responsableActividad"
                                              from="${mies.ResponsableProyecto.list()}" optionKey="id"
                                              value="${informeInstance?.responsableProyecto?.id}"
                                              noSelection="['null': '']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tipo"><g:message code="informe.tipo.label" default="Tipo"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'tipo', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipo.id" title="tipo"
                                              from="${mies.TipoInforme.list()}" optionKey="id"
                                              value="${informeInstance?.tipo?.id}" noSelection="['null': '']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fecha"><g:message code="informe.fecha.label" default="Fecha"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'fecha', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fecha">
                                    <input type="hidden" name="fecha_day" id="fecha_day"
                                           value="${informeInstance?.fecha?.format('dd')}">
                                    <input type="hidden" name="fecha_month" id="fecha_month"
                                           value="${informeInstance?.fecha?.format('MM')}">
                                    <input type="hidden" name="fecha_year" id="fecha_year"
                                           value="${informeInstance?.fecha?.format('yyyy')}">
                                    <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha"
                                                 title="fecha" id="fecha"
                                                 value="${informeInstance?.fecha?.format('dd-MM-yyyy')}"/>
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
                                    <label for="avance"><g:message code="informe.avance.label"
                                                                   default="Avance"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'avance', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1"
                                                maxLenght="1023" name="avance" id="avance" title="avance" cols="40"
                                                rows="5" value="${informeInstance?.avance}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dificultades"><g:message code="informe.dificultades.label"
                                                                         default="Dificultades"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'dificultades', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1"
                                                maxLenght="1023" name="dificultades" id="dificultades"
                                                title="dificultades" cols="40" rows="5"
                                                value="${informeInstance?.dificultades}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="porcentaje"><g:message code="informe.porcentaje.label"
                                                                       default="Porcentaje"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'porcentaje', 'errors')}">
                                    <g:textField name="porcentaje" id="porcentaje" title="porcentaje"
                                                 class="field ui-widget-content ui-corner-all"
                                                 value="${informeInstance?.porcentaje}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="link"><g:message code="informe.link.label" default="Link"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: informeInstance, field: 'link', 'errors')}">
                                    <g:textField name="link" id="link" title="link"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="127" value="${informeInstance?.link}"/>
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
