
<%@ page import="mies.Proyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}" />

        <title>${title}</title>
    </head>

    <body>
            <div class="dialog" title="${title}">

                %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                    %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                        %{--<g:message code="default.home.label" default="Home" />--}%
                    %{--</a>--}%
                    %{--<g:link class="button list" action="list">--}%
                        %{--<g:message code="default.list.label" args="${['Proyecto']}" default="Proyecto List" />--}%
                    %{--</g:link>--}%
                %{--</div>--}%

                    <g:if test="${flash.message}">
                        <div class="message ui-state-highlight ui-corner-all">
                            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
                        </div>
                    </g:if>
                    <g:hasErrors bean="${proyectoInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${proyectoInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmProyecto"
                            method="post"  >
                        <g:hiddenField name="id" value="${proyectoInstance?.id}" />
                        <g:hiddenField name="version" value="${proyectoInstance?.version}" />

                        <table width="100%" class="ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                        <g:if test="${source == 'edit'}">
                                            <g:message code="default.edit.legend" args="${['Proyecto']}" default="Edit Proyecto details"/>
                                        </g:if>
                                        <g:else>
                                            <g:message code="default.create.legend" args="${['Proyecto']}" default="Enter Proyecto details"/>
                                        </g:else>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'unidadEjecutora', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.unidadEjecutora.label" default="Unidad Ejecutora" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="unidadEjecutora.id" title="${Proyecto.constraints.unidadEjecutora.attributes.mensaje}" from="${mies.UnidadEjecutora.list()}" optionKey="id" value="${proyectoInstance?.unidadEjecutora?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.etapa.label" default="Etapa" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="etapa.id" title="${Proyecto.constraints.etapa.attributes.mensaje}" from="${mies.Etapa.list()}" optionKey="id" value="${proyectoInstance?.etapa?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'fase', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fase.label" default="Fase" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="fase.id" title="${Proyecto.constraints.fase.attributes.mensaje}" from="${mies.Fase.list()}" optionKey="id" value="${proyectoInstance?.fase?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.tipoProducto.label" default="Tipo Producto" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="tipoProducto.id" title="${Proyecto.constraints.tipoProducto.attributes.mensaje}" from="${mies.TipoProducto.list()}" optionKey="id" value="${proyectoInstance?.tipoProducto?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'estadoProyecto', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.estadoProyecto.label" default="Estado Proyecto" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="estadoProyecto.id" title="${Proyecto.constraints.estadoProyecto.attributes.mensaje}" from="${mies.EstadoProyecto.list()}" optionKey="id" value="${proyectoInstance?.estadoProyecto?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.linea.label" default="Linea" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="linea.id" title="${Proyecto.constraints.linea.attributes.mensaje}" from="${mies.Linea.list()}" optionKey="id" value="${proyectoInstance?.linea?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'tipoInversion', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.tipoInversion.label" default="Tipo Inversion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="tipoInversion.id" title="${Proyecto.constraints.tipoInversion.attributes.mensaje}" from="${mies.TipoInversion.list()}" optionKey="id" value="${proyectoInstance?.tipoInversion?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.cobertura.label" default="Cobertura" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="cobertura.id" title="${Proyecto.constraints.cobertura.attributes.mensaje}" from="${mies.Cobertura.list()}" optionKey="id" value="${proyectoInstance?.cobertura?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'calificacion', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.calificacion.label" default="Calificacion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="calificacion.id" title="${Proyecto.constraints.calificacion.attributes.mensaje}" from="${mies.Calificacion.list()}" optionKey="id" value="${proyectoInstance?.calificacion?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.programa.label" default="Programa" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="programa.id" title="${Proyecto.constraints.programa.attributes.mensaje}" from="${mies.Programa.list()}" optionKey="id" value="${proyectoInstance?.programa?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'codigoProyecto', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.codigoProyecto.label" default="Codigo Proyecto" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textField  name="codigoProyecto" id="codigoProyecto" title="${Proyecto.constraints.codigoProyecto.attributes.mensaje}" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="20" value="${proyectoInstance?.codigoProyecto}" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaRegistro.label" default="Fecha Registro" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaRegistro">
<input type="hidden" name="fechaRegistro_day" id="fechaRegistro_day"  value="${proyectoInstance?.fechaRegistro?.format('dd')}" >
<input type="hidden" name="fechaRegistro_month" id="fechaRegistro_month" value="${proyectoInstance?.fechaRegistro?.format('MM')}">
<input type="hidden" name="fechaRegistro_year" id="fechaRegistro_year" value="${proyectoInstance?.fechaRegistro?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaRegistro" title="${Proyecto.constraints.fechaRegistro.attributes.mensaje}" id="fechaRegistro" value="${proyectoInstance?.fechaRegistro?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'fechaModificacion', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaModificacion.label" default="Fecha Modificacion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaModificacion">
<input type="hidden" name="fechaModificacion_day" id="fechaModificacion_day"  value="${proyectoInstance?.fechaModificacion?.format('dd')}" >
<input type="hidden" name="fechaModificacion_month" id="fechaModificacion_month" value="${proyectoInstance?.fechaModificacion?.format('MM')}">
<input type="hidden" name="fechaModificacion_year" id="fechaModificacion_year" value="${proyectoInstance?.fechaModificacion?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaModificacion" title="${Proyecto.constraints.fechaModificacion.attributes.mensaje}" id="fechaModificacion" value="${proyectoInstance?.fechaModificacion?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="proyecto.nombre.label" default="Nombre" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField  name="nombre" id="nombre" title="${Proyecto.constraints.nombre.attributes.mensaje}" class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${proyectoInstance?.nombre}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'monto', 'error')}">
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="proyecto.monto.label" default="Monto" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="monto" title="${Proyecto.constraints.monto.attributes.mensaje}" id="monto" value="${fieldValue(bean: proyectoInstance, field: 'monto')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.parroquiasDistrito.label" default="Parroquias Distrito" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textField  name="parroquiasDistrito" id="parroquiasDistrito" title="${Proyecto.constraints.parroquiasDistrito.attributes.mensaje}" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${proyectoInstance?.parroquiasDistrito}" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'descripcion', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.descripcion.label" default="Descripcion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="descripcion" id="${Proyecto.constraints.descripcion.attributes.mensaje}" title="descripcion" cols="40" rows="5" value="${proyectoInstance?.descripcion}" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaInicioPlanificada.label" default="Fecha Inicio Planificada" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaInicioPlanificada">
<input type="hidden" name="fechaInicioPlanificada_day" id="fechaInicioPlanificada_day"  value="${proyectoInstance?.fechaInicioPlanificada?.format('dd')}" >
<input type="hidden" name="fechaInicioPlanificada_month" id="fechaInicioPlanificada_month" value="${proyectoInstance?.fechaInicioPlanificada?.format('MM')}">
<input type="hidden" name="fechaInicioPlanificada_year" id="fechaInicioPlanificada_year" value="${proyectoInstance?.fechaInicioPlanificada?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicioPlanificada" title="${Proyecto.constraints.fechaInicioPlanificada.attributes.mensaje}" id="fechaInicioPlanificada" value="${proyectoInstance?.fechaInicioPlanificada?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'fechaInicio', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaInicio.label" default="Fecha Inicio" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaInicio">
<input type="hidden" name="fechaInicio_day" id="fechaInicio_day"  value="${proyectoInstance?.fechaInicio?.format('dd')}" >
<input type="hidden" name="fechaInicio_month" id="fechaInicio_month" value="${proyectoInstance?.fechaInicio?.format('MM')}">
<input type="hidden" name="fechaInicio_year" id="fechaInicio_year" value="${proyectoInstance?.fechaInicio?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio" title="${Proyecto.constraints.fechaInicio.attributes.mensaje}" id="fechaInicio" value="${proyectoInstance?.fechaInicio?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaFinPlanificada.label" default="Fecha Fin Planificada" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaFinPlanificada">
<input type="hidden" name="fechaFinPlanificada_day" id="fechaFinPlanificada_day"  value="${proyectoInstance?.fechaFinPlanificada?.format('dd')}" >
<input type="hidden" name="fechaFinPlanificada_month" id="fechaFinPlanificada_month" value="${proyectoInstance?.fechaFinPlanificada?.format('MM')}">
<input type="hidden" name="fechaFinPlanificada_year" id="fechaFinPlanificada_year" value="${proyectoInstance?.fechaFinPlanificada?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFinPlanificada" title="${Proyecto.constraints.fechaFinPlanificada.attributes.mensaje}" id="fechaFinPlanificada" value="${proyectoInstance?.fechaFinPlanificada?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'fechaFin', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaFin.label" default="Fecha Fin" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaFin">
<input type="hidden" name="fechaFin_day" id="fechaFin_day"  value="${proyectoInstance?.fechaFin?.format('dd')}" >
<input type="hidden" name="fechaFin_month" id="fechaFin_month" value="${proyectoInstance?.fechaFin?.format('MM')}">
<input type="hidden" name="fechaFin_year" id="fechaFin_year" value="${proyectoInstance?.fechaFin?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin" title="${Proyecto.constraints.fechaFin.attributes.mensaje}" id="fechaFin" value="${proyectoInstance?.fechaFin?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="proyecto.mes.label" default="Mes" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="mes" title="${Proyecto.constraints.mes.attributes.mensaje}" id="mes" value="${fieldValue(bean: proyectoInstance, field: 'mes')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'problema', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.problema.label" default="Problema" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="problema" id="problema" title="${Proyecto.constraints.problema.attributes.mensaje}" cols="40" rows="5" value="${proyectoInstance?.problema}" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="proyecto.informacionDias.label" default="Informacion Dias" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="informacionDias" title="${Proyecto.constraints.informacionDias.attributes.mensaje}" id="informacionDias" value="${fieldValue(bean: proyectoInstance, field: 'informacionDias')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: proyectoInstance, field: 'subPrograma', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="proyecto.subPrograma.label" default="Sub Programa" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textField  name="subPrograma" id="subPrograma" title="${Proyecto.constraints.subPrograma.attributes.mensaje}" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="2" value="${proyectoInstance?.subPrograma}" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="6" class="buttons" style="text-align: right;">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="default.button.update.label" default="Update" />
                            </a>
                            <g:link class="button delete" action="delete" id="${proyectoInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${proyectoInstance?.id}">
                                <g:message code="default.button.show.label" default="Show" />
                            </g:link>
                        </g:if>
                        <g:else>
                            <a href="#" class="button save">
                                <g:message code="default.button.create.label" default="Create" />
                            </a>
                        </g:else>
                                    </td>
                                </tr>
                            </tfoot>
                            </table>
                    </g:form>
            </div>

        <script type="text/javascript">
            $(function() {
                var myForm = $(".frmProyecto");

                // Tooltip de informacion para cada field (utiliza el atributo title del textfield)
                var elems = $('.field')
                        .each(function(i) {
                            $.attr(this, 'oldtitle', $.attr(this, 'title'));
                        })
                        .removeAttr('title');
                $('<div />').qtip(
                        {
                            content: ' ', // Can use any content here :)
                            position: {
                                target: 'event' // Use the triggering element as the positioning target
                            },
                            show: {
                                target: elems,
                                event: 'click mouseenter focus'
                            },
                            hide: {
                                target: elems
                            },
                            events: {
                                show: function(event, api) {
                                    // Update the content of the tooltip on each show
                                    var target = $(event.originalEvent.target);
                                    api.set('content.text', target.attr('title'));
                                }
                            },
                            style: {
                                classes: 'ui-tooltip-rounded ui-tooltip-cream'
                            }
                        });
                // fin del codigo para los tooltips

                // Validacion del formulario
                myForm.validate({
                            errorClass: "errormessage",
                            onkeyup: false,
                            errorElement: "em",
                            errorClass: 'error',
                            validClass: 'valid',
                            errorPlacement: function(error, element) {
                                // Set positioning based on the elements position in the form
                                var elem = $(element),
                                        corners = ['right center', 'left center'],
                                        flipIt = elem.parents('span.right').length > 0;

                                // Check we have a valid error message
                                if (!error.is(':empty')) {
                                    // Apply the tooltip only if it isn't valid
                                    elem.filter(':not(.valid)').qtip({
                                                overwrite: false,
                                                content: error,
                                                position: {
                                                    my: corners[ flipIt ? 0 : 1 ],
                                                    at: corners[ flipIt ? 1 : 0 ],
                                                    viewport: $(window)
                                                },
                                show: {
                                    event: false,
                                ready:
                                    true
                                },
                                hide: false,
                                style: {
                                    classes: 'ui-tooltip-rounded ui-tooltip-red' // Make it red... the classic error colour!
                                }
                            })

                    // If we have a tooltip on this element already, just update its content
                        .qtip('option', 'content.text', error);
            }

            // If the error is empty, remove the qTip
            else
            {
                elem.qtip('destroy');
            }
            },
            success: $.noop // Odd workaround for errorPlacement not firing!
            })
            ;
            //fin de la validacion del formulario


            $(".button").button();
            $(".home").button("option", "icons", {primary:'ui-icon-home'});
            $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
            $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
            $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
                myForm.submit();
                return false;
            });
            $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
                    if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>