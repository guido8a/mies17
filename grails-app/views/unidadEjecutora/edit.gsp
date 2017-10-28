<%@ page import="mies.UnidadEjecutora" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora')}"/>
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
            <g:hasErrors bean="${unidadEjecutoraInstance}">
                <div class="errors">
                    <g:renderErrors bean="${unidadEjecutoraInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${unidadEjecutoraInstance?.id}"/>
                <g:hiddenField name="version" value="${unidadEjecutoraInstance?.version}"/>
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tipoInstitucion"><g:message code="unidadEjecutora.tipoInstitucion.label"
                                                                            default="Tipo Institucion"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'tipoInstitucion', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all"
                                              name="tipoInstitucion.id" title="Tipo de institución"
                                              from="${mies.TipoInstitucion.list()}" optionKey="id"
                                              value="${unidadEjecutoraInstance?.tipoInstitucion?.id}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="provincia"><g:message code="unidadEjecutora.provincia.label"
                                                                      default="Provincia"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'provincia', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="provincia.id"
                                              title="Provincia de la unidad ejecutora" from="${mies.Provincia.list()}"
                                              optionKey="id" value="${unidadEjecutoraInstance?.provincia?.id}"
                                              noSelection="['null': '']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="codigo"><g:message code="unidadEjecutora.codigo.label"
                                                                   default="Codigo"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'codigo', 'errors')}">
                                    <g:textField name="codigo" id="codigo" title="Código según el ESIGEF"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="4" value="${unidadEjecutoraInstance?.codigo}"/>
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
                                    <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                                 name="fechaInicio" title="Fecha de creación" id="fechaInicio"
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
                                    <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                                 name="fechaFin" title="Fecha de cierre o final" id="fechaFin"
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
                                    <label for="padre"><g:message code="unidadEjecutora.padre.label"
                                                                  default="Padre"/></label>
                                </td>
                                <td valign="top"
                                    class="value ${hasErrors(bean: unidadEjecutoraInstance, field: 'padre', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="padre.id"
                                              title="Unidad Ejecutora padre" from="${mies.UnidadEjecutora.list()}"
                                              optionKey="id" value="${unidadEjecutoraInstance?.padre?.id}"
                                              noSelection="['null': '']"/>
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
