

<%@ page import="mies.Obra" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'obra.label', default: 'Obra')}" />
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
            <g:hasErrors bean="${obraInstance}">
            <div class="errors">
                <g:renderErrors bean="${obraInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="undd__id"><g:message code="obra.undd__id.label" default="Unddid" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'undd__id', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="undd__id" title="undd__id" id="undd__id" value="${fieldValue(bean: obraInstance, field: 'undd__id')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="codigoComprasPublicas"><g:message code="obra.codigoComprasPublicas.label" default="Codigo Compras Publicas" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'codigoComprasPublicas', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="codigoComprasPublicas.id" title="codigoComprasPublicas" from="${mies.CodigoComprasPublicas.list()}" optionKey="id" value="${obraInstance?.codigoComprasPublicas?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tipoCompra"><g:message code="obra.tipoCompra.label" default="Tipo Compra" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'tipoCompra', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoCompra.id" title="tipoCompra" from="${mies.TipoCompra.list()}" optionKey="id" value="${obraInstance?.tipoCompra?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="asignacion"><g:message code="obra.asignacion.label" default="Asignacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'asignacion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="asignacion.id" title="asignacion" from="${mies.Asignacion.list()}" optionKey="id" value="${obraInstance?.asignacion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="obra"><g:message code="obra.obra.label" default="Obra" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'obra', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="obra.id" title="obra" from="${mies.Obra.list()}" optionKey="id" value="${obraInstance?.obra?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="modificacionProyecto"><g:message code="obra.modificacionProyecto.label" default="Modificacion Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'modificacionProyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="modificacionProyecto.id" title="ModificacionProyecto" from="${mies.ModificacionProyecto.list()}" optionKey="id" value="${obraInstance?.modificacionProyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descripcion"><g:message code="obra.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'descripcion', 'errors')}">
                                    <g:textField  name="descripcion" id="descripcion" title="descripcion" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${obraInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cantidad"><g:message code="obra.cantidad.label" default="Cantidad" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'cantidad', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="cantidad" title="cantidad" id="cantidad" value="${fieldValue(bean: obraInstance, field: 'cantidad')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costo"><g:message code="obra.costo.label" default="Costo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'costo', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="costo" title="costo" id="costo" value="${fieldValue(bean: obraInstance, field: 'costo')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cuatrimestre1"><g:message code="obra.cuatrimestre1.label" default="Cuatrimestre1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'cuatrimestre1', 'errors')}">
                                    <g:textField  name="cuatrimestre1" id="cuatrimestre1" title="cuatrimestre1" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1" value="${obraInstance?.cuatrimestre1}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cuatrimestre2"><g:message code="obra.cuatrimestre2.label" default="Cuatrimestre2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'cuatrimestre2', 'errors')}">
                                    <g:textField  name="cuatrimestre2" id="cuatrimestre2" title="cuatrimestre2" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1" value="${obraInstance?.cuatrimestre2}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cuatrimestre3"><g:message code="obra.cuatrimestre3.label" default="Cuatrimestre3" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'cuatrimestre3', 'errors')}">
                                    <g:textField  name="cuatrimestre3" id="cuatrimestre3" title="cuatrimestre3" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1" value="${obraInstance?.cuatrimestre3}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ejecucion"><g:message code="obra.ejecucion.label" default="Ejecucion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'ejecucion', 'errors')}">
                                    <g:textField class="field number required ui-widget-content ui-corner-all" name="ejecucion" title="ejecucion" id="ejecucion" value="${fieldValue(bean: obraInstance, field: 'ejecucion')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estado"><g:message code="obra.estado.label" default="Estado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'estado', 'errors')}">
                                    <g:textField  name="estado" id="estado" title="estado" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1" value="${obraInstance?.estado}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fechaInicio"><g:message code="obra.fechaInicio.label" default="Fecha Inicio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'fechaInicio', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaInicio">
<input type="hidden" name="fechaInicio_day" id="fechaInicio_day"  value="${obraInstance?.fechaInicio?.format('dd')}" >
<input type="hidden" name="fechaInicio_month" id="fechaInicio_month" value="${obraInstance?.fechaInicio?.format('MM')}">
<input type="hidden" name="fechaInicio_year" id="fechaInicio_year" value="${obraInstance?.fechaInicio?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio" title="fechaInicio" id="fechaInicio" value="${obraInstance?.fechaInicio?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaInicio').datepicker({
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
                                    <label for="fechaFin"><g:message code="obra.fechaFin.label" default="Fecha Fin" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'fechaFin', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaFin">
<input type="hidden" name="fechaFin_day" id="fechaFin_day"  value="${obraInstance?.fechaFin?.format('dd')}" >
<input type="hidden" name="fechaFin_month" id="fechaFin_month" value="${obraInstance?.fechaFin?.format('MM')}">
<input type="hidden" name="fechaFin_year" id="fechaFin_year" value="${obraInstance?.fechaFin?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin" title="fechaFin" id="fechaFin" value="${obraInstance?.fechaFin?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaFin').datepicker({
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
                                    <label for="observaciones"><g:message code="obra.observaciones.label" default="Observaciones" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: obraInstance, field: 'observaciones', 'errors')}">
                                    <g:textField  name="observaciones" id="observaciones" title="observaciones" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${obraInstance?.observaciones}" />
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
