

<%@ page import="mies.Sigef" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sigef.label', default: 'Sigef')}" />
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
            <g:hasErrors bean="${sigefInstance}">
            <div class="errors">
                <g:renderErrors bean="${sigefInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anio"><g:message code="sigef.anio.label" default="Anio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sigefInstance, field: 'anio', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="anio.id" title="Anio" from="${mies.Anio.list()}" optionKey="id" value="${sigefInstance?.anio?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mes"><g:message code="sigef.mes.label" default="Mes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sigefInstance, field: 'mes', 'errors')}">
                                    <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="mes.id" title="Mes" from="${mies.Mes.list()}" optionKey="id" value="${sigefInstance?.mes?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fecha"><g:message code="sigef.fecha.label" default="Fecha" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sigefInstance, field: 'fecha', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fecha">
<input type="hidden" name="fecha_day" id="fecha_day"  value="${sigefInstance?.fecha?.format('dd')}" >
<input type="hidden" name="fecha_month" id="fecha_month" value="${sigefInstance?.fecha?.format('MM')}">
<input type="hidden" name="fecha_year" id="fecha_year" value="${sigefInstance?.fecha?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha" title="Fecha de carga de datos" id="fecha" value="${sigefInstance?.fecha?.format('dd-MM-yyyy')}" />
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
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
