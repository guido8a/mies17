

<%@ page import="mies.EstudiosTecnicos" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${estudiosTecnicosInstance}">
            <div class="errors">
                <g:renderErrors bean="${estudiosTecnicosInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${estudiosTecnicosInstance?.id}" />
                <g:hiddenField name="version" value="${estudiosTecnicosInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="proyecto"><g:message code="estudiosTecnicos.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: estudiosTecnicosInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${estudiosTecnicosInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="resumen"><g:message code="estudiosTecnicos.resumen.label" default="Resumen" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: estudiosTecnicosInstance, field: 'resumen', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="resumen" id="resumen" title="resumen" cols="40" rows="5" value="${estudiosTecnicosInstance?.resumen}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documento"><g:message code="estudiosTecnicos.documento.label" default="Documento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: estudiosTecnicosInstance, field: 'documento', 'errors')}">
                                    <g:textField  name="documento" id="documento" title="documento" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${estudiosTecnicosInstance?.documento}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fecha"><g:message code="estudiosTecnicos.fecha.label" default="Fecha" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: estudiosTecnicosInstance, field: 'fecha', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fecha">
<input type="hidden" name="fecha_day" id="fecha_day"  value="${estudiosTecnicosInstance?.fecha?.format('dd')}" >
<input type="hidden" name="fecha_month" id="fecha_month" value="${estudiosTecnicosInstance?.fecha?.format('MM')}">
<input type="hidden" name="fecha_year" id="fecha_year" value="${estudiosTecnicosInstance?.fecha?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha" title="fecha" id="fecha" value="${estudiosTecnicosInstance?.fecha?.format('dd-MM-yyyy')}" />
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
