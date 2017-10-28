

<%@ page import="mies.ResponsableProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'responsableProyecto.label', default: 'ResponsableProyecto')}" />
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
            <g:hasErrors bean="${responsableProyectoInstance}">
            <div class="errors">
                <g:renderErrors bean="${responsableProyectoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="responsable"><g:message code="responsableProyecto.responsable.label" default="Responsable" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: responsableProyectoInstance, field: 'responsable', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="responsable.id" title="responsable" from="${mies.seguridad.Usro.list()}" optionKey="id" value="${responsableProyectoInstance?.responsable?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="proyecto"><g:message code="responsableProyecto.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: responsableProyectoInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${responsableProyectoInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="desde"><g:message code="responsableProyecto.desde.label" default="Desde" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: responsableProyectoInstance, field: 'desde', 'errors')}">
                                    <input type="hidden" value="date.struct" name="desde">
<input type="hidden" name="desde_day" id="desde_day"  value="${responsableProyectoInstance?.desde?.format('dd')}" >
<input type="hidden" name="desde_month" id="desde_month" value="${responsableProyectoInstance?.desde?.format('MM')}">
<input type="hidden" name="desde_year" id="desde_year" value="${responsableProyectoInstance?.desde?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="desde" title="desde" id="desde" value="${responsableProyectoInstance?.desde?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#desde').datepicker({
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
                                    <label for="hasta"><g:message code="responsableProyecto.hasta.label" default="Hasta" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: responsableProyectoInstance, field: 'hasta', 'errors')}">
                                    <input type="hidden" value="date.struct" name="hasta">
<input type="hidden" name="hasta_day" id="hasta_day"  value="${responsableProyectoInstance?.hasta?.format('dd')}" >
<input type="hidden" name="hasta_month" id="hasta_month" value="${responsableProyectoInstance?.hasta?.format('MM')}">
<input type="hidden" name="hasta_year" id="hasta_year" value="${responsableProyectoInstance?.hasta?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="hasta" title="hasta" id="hasta" value="${responsableProyectoInstance?.hasta?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#hasta').datepicker({
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
                                    <label for="observaciones"><g:message code="responsableProyecto.observaciones.label" default="Observaciones" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: responsableProyectoInstance, field: 'observaciones', 'errors')}">
                                    <g:textField  name="observaciones" id="observaciones" title="observaciones" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${responsableProyectoInstance?.observaciones}" />
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
