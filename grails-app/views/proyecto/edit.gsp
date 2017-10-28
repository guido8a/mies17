

<%@ page import="mies.Proyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'proyecto.label', default: 'Proyecto')}" />
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
            <g:hasErrors bean="${proyectoInstance}">
            <div class="errors">
                <g:renderErrors bean="${proyectoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${proyectoInstance?.id}" />
                <g:hiddenField name="version" value="${proyectoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unidadEjecutora"><g:message code="proyecto.unidadEjecutora.label" default="Unidad Ejecutora" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'unidadEjecutora', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="unidadEjecutora.id" title="unidadEjecutora" from="${mies.UnidadEjecutora.list()}" optionKey="id" value="${proyectoInstance?.unidadEjecutora?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="etapa"><g:message code="proyecto.etapa.label" default="Etapa" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'etapa', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="etapa.id" title="etapa" from="${mies.Etapa.list()}" optionKey="id" value="${proyectoInstance?.etapa?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fase"><g:message code="proyecto.fase.label" default="Fase" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fase', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="fase.id" title="fase" from="${mies.Fase.list()}" optionKey="id" value="${proyectoInstance?.fase?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipoProducto"><g:message code="proyecto.tipoProducto.label" default="Tipo Producto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'tipoProducto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoProducto.id" title="tipoProducto" from="${mies.TipoProducto.list()}" optionKey="id" value="${proyectoInstance?.tipoProducto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="estadoProyecto"><g:message code="proyecto.estadoProyecto.label" default="Estado Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'estadoProyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="estadoProyecto.id" title="estadoProyecto" from="${mies.EstadoProyecto.list()}" optionKey="id" value="${proyectoInstance?.estadoProyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="linea"><g:message code="proyecto.linea.label" default="Linea" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'linea', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="linea.id" title="linea" from="${mies.Linea.list()}" optionKey="id" value="${proyectoInstance?.linea?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipoInversion"><g:message code="proyecto.tipoInversion.label" default="Tipo Inversion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'tipoInversion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="tipoInversion.id" title="tipoInversion" from="${mies.TipoInversion.list()}" optionKey="id" value="${proyectoInstance?.tipoInversion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cobertura"><g:message code="proyecto.cobertura.label" default="Cobertura" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'cobertura', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="cobertura.id" title="cobertura" from="${mies.Cobertura.list()}" optionKey="id" value="${proyectoInstance?.cobertura?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="calificacion"><g:message code="proyecto.calificacion.label" default="Calificacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'calificacion', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="calificacion.id" title="calificacion" from="${mies.Calificacion.list()}" optionKey="id" value="${proyectoInstance?.calificacion?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="programa"><g:message code="proyecto.programa.label" default="Programa" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'programa', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="programa.id" title="programa" from="${mies.Programa.list()}" optionKey="id" value="${proyectoInstance?.programa?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="codigoProyecto"><g:message code="proyecto.codigoProyecto.label" default="Codigo Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'codigoProyecto', 'errors')}">
                                    <g:textField  name="codigoProyecto" id="codigoProyecto" title="codigoProyecto" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="20" value="${proyectoInstance?.codigoProyecto}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fechaRegistro"><g:message code="proyecto.fechaRegistro.label" default="Fecha Registro" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fechaRegistro', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaRegistro">
<input type="hidden" name="fechaRegistro_day" id="fechaRegistro_day"  value="${proyectoInstance?.fechaRegistro?.format('dd')}" >
<input type="hidden" name="fechaRegistro_month" id="fechaRegistro_month" value="${proyectoInstance?.fechaRegistro?.format('MM')}">
<input type="hidden" name="fechaRegistro_year" id="fechaRegistro_year" value="${proyectoInstance?.fechaRegistro?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaRegistro" title="fechaRegistro" id="fechaRegistro" value="${proyectoInstance?.fechaRegistro?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaRegistro').datepicker({
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
                                  <label for="fechaModificacion"><g:message code="proyecto.fechaModificacion.label" default="Fecha Modificacion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fechaModificacion', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaModificacion">
<input type="hidden" name="fechaModificacion_day" id="fechaModificacion_day"  value="${proyectoInstance?.fechaModificacion?.format('dd')}" >
<input type="hidden" name="fechaModificacion_month" id="fechaModificacion_month" value="${proyectoInstance?.fechaModificacion?.format('MM')}">
<input type="hidden" name="fechaModificacion_year" id="fechaModificacion_year" value="${proyectoInstance?.fechaModificacion?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaModificacion" title="fechaModificacion" id="fechaModificacion" value="${proyectoInstance?.fechaModificacion?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaModificacion').datepicker({
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
                                  <label for="nombre"><g:message code="proyecto.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'nombre', 'errors')}">
                                    <g:textField  name="nombre" id="nombre" title="nombre" class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${proyectoInstance?.nombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="monto"><g:message code="proyecto.monto.label" default="Monto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'monto', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="monto" title="monto" id="monto" value="${fieldValue(bean: proyectoInstance, field: 'monto')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="parroquiasDistrito"><g:message code="proyecto.parroquiasDistrito.label" default="Parroquias Distrito" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'parroquiasDistrito', 'errors')}">
                                    <g:textField  name="parroquiasDistrito" id="parroquiasDistrito" title="parroquiasDistrito" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${proyectoInstance?.parroquiasDistrito}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descripcion"><g:message code="proyecto.descripcion.label" default="Descripcion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'descripcion', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="descripcion" id="descripcion" title="descripcion" cols="40" rows="5" value="${proyectoInstance?.descripcion}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fechaInicioPlanificada"><g:message code="proyecto.fechaInicioPlanificada.label" default="Fecha Inicio Planificada" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fechaInicioPlanificada', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaInicioPlanificada">
<input type="hidden" name="fechaInicioPlanificada_day" id="fechaInicioPlanificada_day"  value="${proyectoInstance?.fechaInicioPlanificada?.format('dd')}" >
<input type="hidden" name="fechaInicioPlanificada_month" id="fechaInicioPlanificada_month" value="${proyectoInstance?.fechaInicioPlanificada?.format('MM')}">
<input type="hidden" name="fechaInicioPlanificada_year" id="fechaInicioPlanificada_year" value="${proyectoInstance?.fechaInicioPlanificada?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicioPlanificada" title="fechaInicioPlanificada" id="fechaInicioPlanificada" value="${proyectoInstance?.fechaInicioPlanificada?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaInicioPlanificada').datepicker({
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
                                  <label for="fechaInicio"><g:message code="proyecto.fechaInicio.label" default="Fecha Inicio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fechaInicio', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaInicio">
<input type="hidden" name="fechaInicio_day" id="fechaInicio_day"  value="${proyectoInstance?.fechaInicio?.format('dd')}" >
<input type="hidden" name="fechaInicio_month" id="fechaInicio_month" value="${proyectoInstance?.fechaInicio?.format('MM')}">
<input type="hidden" name="fechaInicio_year" id="fechaInicio_year" value="${proyectoInstance?.fechaInicio?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio" title="fechaInicio" id="fechaInicio" value="${proyectoInstance?.fechaInicio?.format('dd-MM-yyyy')}" />
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
                                  <label for="fechaFinPlanificada"><g:message code="proyecto.fechaFinPlanificada.label" default="Fecha Fin Planificada" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fechaFinPlanificada', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaFinPlanificada">
<input type="hidden" name="fechaFinPlanificada_day" id="fechaFinPlanificada_day"  value="${proyectoInstance?.fechaFinPlanificada?.format('dd')}" >
<input type="hidden" name="fechaFinPlanificada_month" id="fechaFinPlanificada_month" value="${proyectoInstance?.fechaFinPlanificada?.format('MM')}">
<input type="hidden" name="fechaFinPlanificada_year" id="fechaFinPlanificada_year" value="${proyectoInstance?.fechaFinPlanificada?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFinPlanificada" title="fechaFinPlanificada" id="fechaFinPlanificada" value="${proyectoInstance?.fechaFinPlanificada?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaFinPlanificada').datepicker({
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
                                  <label for="fechaFin"><g:message code="proyecto.fechaFin.label" default="Fecha Fin" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'fechaFin', 'errors')}">
                                    <input type="hidden" value="date.struct" name="fechaFin">
<input type="hidden" name="fechaFin_day" id="fechaFin_day"  value="${proyectoInstance?.fechaFin?.format('dd')}" >
<input type="hidden" name="fechaFin_month" id="fechaFin_month" value="${proyectoInstance?.fechaFin?.format('MM')}">
<input type="hidden" name="fechaFin_year" id="fechaFin_year" value="${proyectoInstance?.fechaFin?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin" title="fechaFin" id="fechaFin" value="${proyectoInstance?.fechaFin?.format('dd-MM-yyyy')}" />
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
                                  <label for="mes"><g:message code="proyecto.mes.label" default="Mes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'mes', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="mes" title="mes" id="mes" value="${fieldValue(bean: proyectoInstance, field: 'mes')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="problema"><g:message code="proyecto.problema.label" default="Problema" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'problema', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="problema" id="problema" title="problema" cols="40" rows="5" value="${proyectoInstance?.problema}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="informacionDias"><g:message code="proyecto.informacionDias.label" default="Informacion Dias" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'informacionDias', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="informacionDias" title="informacionDias" id="informacionDias" value="${fieldValue(bean: proyectoInstance, field: 'informacionDias')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="subPrograma"><g:message code="proyecto.subPrograma.label" default="Sub Programa" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: proyectoInstance, field: 'subPrograma', 'errors')}">
                                    <g:textField  name="subPrograma" id="subPrograma" title="subPrograma" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="2" value="${proyectoInstance?.subPrograma}" />
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
