

<%@ page import="mies.ModificacionProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'modificacionProyecto.label', default: 'ModificacionProyecto')}" />
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
            <g:hasErrors bean="${modificacionProyectoInstance}">
            <div class="errors">
                <g:renderErrors bean="${modificacionProyectoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="informe"><g:message code="modificacionProyecto.informe.label" default="Informe" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'informe', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="informe.id" title="informe" from="${mies.Informe.list()}" optionKey="id" value="${modificacionProyectoInstance?.informe?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tipoModificacion"><g:message code="modificacionProyecto.tipoModificacion.label" default="Tipo Modificacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'tipoModificacion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoModificacion.id" title="tipoModificacion" from="${mies.TipoModificacion.list()}" optionKey="id" value="${modificacionProyectoInstance?.tipoModificacion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="valor"><g:message code="modificacionProyecto.valor.label" default="Valor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'valor', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="valor" title="valor" id="valor" value="${fieldValue(bean: modificacionProyectoInstance, field: 'valor')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="modificacionProyecto.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'descripcion', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="descripcion" id="descripcion" title="descripcion" cols="40" rows="5" value="${modificacionProyectoInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fecha"><g:message code="modificacionProyecto.fecha.label" default="Fecha" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'fecha', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fecha">
<input type="hidden" name="fecha_day" id="fecha_day"  value="${modificacionProyectoInstance?.fecha?.format('dd')}" >
<input type="hidden" name="fecha_month" id="fecha_month" value="${modificacionProyectoInstance?.fecha?.format('MM')}">
<input type="hidden" name="fecha_year" id="fecha_year" value="${modificacionProyectoInstance?.fecha?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha" title="fecha" id="fecha" value="${modificacionProyectoInstance?.fecha?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fecha').datepicker({
        changeMonth: true,
        changeYear:true,
        dateFormat: 'dd-mm-yy',
        onClose: function(dateText, inst) {
            var date = $(this).datepicker('getDate');
            var day, month, year;
            if(date != null) {
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
                                    <label for="fechaAprobacion"><g:message code="modificacionProyecto.fechaAprobacion.label" default="Fecha Aprobacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'fechaAprobacion', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaAprobacion">
<input type="hidden" name="fechaAprobacion_day" id="fechaAprobacion_day"  value="${modificacionProyectoInstance?.fechaAprobacion?.format('dd')}" >
<input type="hidden" name="fechaAprobacion_month" id="fechaAprobacion_month" value="${modificacionProyectoInstance?.fechaAprobacion?.format('MM')}">
<input type="hidden" name="fechaAprobacion_year" id="fechaAprobacion_year" value="${modificacionProyectoInstance?.fechaAprobacion?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaAprobacion" title="fechaAprobacion" id="fechaAprobacion" value="${modificacionProyectoInstance?.fechaAprobacion?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaAprobacion').datepicker({
        changeMonth: true,
        changeYear:true,
        dateFormat: 'dd-mm-yy',
        onClose: function(dateText, inst) {
            var date = $(this).datepicker('getDate');
            var day, month, year;
            if(date != null) {
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
                                    <label for="aprobado"><g:message code="modificacionProyecto.aprobado.label" default="Aprobado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'aprobado', 'errors')}">
                                    <g:textField  name="aprobado" id="aprobado" title="aprobado" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="15" value="${modificacionProyectoInstance?.aprobado}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="observaciones"><g:message code="modificacionProyecto.observaciones.label" default="Observaciones" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modificacionProyectoInstance, field: 'observaciones', 'errors')}">
                                    <g:textField  name="observaciones" id="observaciones" title="observaciones" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${modificacionProyectoInstance?.observaciones}" />
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
