<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 6/21/11
  Time: 11:48 AM
  To change this template use File | Settings | File Templates.
--%>


<%@ page import="mies.Proyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>
        <link rel="stylesheet" href="${resource(dir: 'css/menuSemplades', file: 'flow_menu_green.css')}"/>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

        <title>
            <g:message code="default.${type}.label" args="${['Proyecto']}" default="Proyecto details"/>
        </title>
        <style type="text/css">
        textarea {
            max-height : 58px;
        }
        </style>
    </head>

    <body>

        <div class="dialog"
             title="${g.message("code": "default." + type + ".label", "args": ['Proyecto'], "default": "Proyecto details")}">

            <g:hasErrors bean="${proyecto}">
                <div class="errors ui-state-error ui-corner-all">
                    <g:renderErrors bean="${proyecto}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form class="frmProyecto" method="post" action="nuevoProyecto" event="validarProyecto">
                <g:hiddenField name="id" value="${proyecto?.id}"/>
                <g:hiddenField name="version" value="${proyecto?.version}"/>
                <input type="hidden" name="goto" id="goto" value="validarProyecto"/>

                <mf:menuSemplades items='${items}' links="${links}"/>


                <table width="100%" class="ui-widget-content ui-corner-all">

  <thead>
      <tr>
          <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                <g:message code="default.${type}.legend" args="${['Proyecto']}"
                           default="${type.capitalize()} Proyecto details"/>
                </td>
                    </tr>
                </thead>
                <tbody>
                <tbody>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'nombre', 'error')} ${hasErrors(bean: proyecto, field: 'codigoProyecto', 'error')}">

                        <td class="label  mandatory" valign="middle">
                            <g:message code="proyecto.nombre.label" default="Nombre"/>
                        </td>

                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>

                        <td colspan="4" class="mandatory" valign="middle" style="width: 400px;">
                            <g:textArea class="field required ui-widget-content ui-corner-all" name="nombre" id="nombre"
                                        title="${Proyecto.constraints.nombre.attributes.mensaje}" cols="2"
                                        minLenght="1" maxLenght="255" rows="1" style="width: 900px;"
                                        value="${proyecto?.nombre}"/>
                        </td>
                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'codigoProyecto', 'error')}">

                        <td class="label " valign="middle">
                            CUP
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td class="campo" valign="middle">
                            <g:textField name="codigoProyecto" id="codigoProyecto"
                                         title="${Proyecto.constraints.codigoProyecto.attributes.mensaje}"
                                         class="ui-widget-content ui-corner-all" minLenght="1" maxLenght="20"
                                         style="width:240px;"
                                         value="${proyecto?.codigoProyecto}"/>
                        </td>
                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'unidadEjecutora', 'error')}">

                        <td class="label " valign="middle">
                            U. Ejecutora
                        </td>

                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>

                        <td class="campo" valign="middle">
                            <g:select class="required requiredCmb ui-widget-content ui-corner-all" name="unidadEjecutora.id"
                                      title="${Proyecto.constraints.unidadEjecutora.attributes.mensaje}"
                                      style="width: 360px;"
                                      from="${mies.UnidadEjecutora.list()}" optionKey="id"
                                      value="${proyecto?.unidadEjecutora?.id}"/>
                        </td>

                        <td class="label  mandatory" valign="middle">
                            Programa presupuestario
                        </td>

                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>

                        <td class="campo mandatory" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all programaPresupuestario"
                                      name="programaPresupuestario.id"
                                      title="${Proyecto.constraints.programaPresupuestario.attributes.mensaje}"
                                      style="width: 380px;" optionKey="id"
                                      from="${mies.ProgramaPresupuestario.list()}"
                                      value="${proyecto?.programaPresupuestario?.id}"/>
                        </td>
                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'monto', 'error')} ${hasErrors(bean: proyecto, field: 'informacionDias', 'error')}">
                        <td class="label  mandatory" valign="middle">
                            <g:message code="proyecto.monto.label" default="Monto"/>
                        </td>

                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>

                        <td class="campo mandatory" valign="middle">
                            <g:textField class="required ui-widget-content ui-corner-all" name="monto"
                                         title="${Proyecto.constraints.monto.attributes.mensaje}" id="monto"
                                         style="width: 140px"
                                         value="${fieldValue(bean: proyecto, field: 'monto')}"/>
                        </td>

                        <td class="label" valign="middle">
                            <g:message code="proyecto.codigoEsigef.label"
                                       default="Número proyecto"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td>
                            <g:textField class="numeric number field ui-widget-content ui-corner-all"
                                         name="codigoEsigef"
                                         title="${Proyecto.constraints.codigoEsigef.attributes.mensaje}"
                                         style="width: 120px;" maxlength="3"
                                         id="codigoEsigef" value="${proyecto?.codigoEsigef}"/>
                        </td> <!-- campo -->

                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'fechaInicioPlanificada', 'error')} ${hasErrors(bean: proyecto, field: 'fechaInicio', 'error')}">

                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaInicioPlanificada.label" default="Fecha Inicio Planificada"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaInicioPlanificada">

                            <input type="hidden" name="fechaInicioPlanificada_day" id="fechaInicioPlanificada_day"
                                   value="${proyecto?.fechaInicioPlanificada?.format('dd')}">

                            <input type="hidden" name="fechaInicioPlanificada_month" id="fechaInicioPlanificada_month"
                                   value="${proyecto?.fechaInicioPlanificada?.format('MM')}">

                            <input type="hidden" name="fechaInicioPlanificada_year" id="fechaInicioPlanificada_year"
                                   value="${proyecto?.fechaInicioPlanificada?.format('yyyy')}">
                            <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                         name="fechaInicioPlanificada"
                                         style="width: 120px;"
                                         title="${Proyecto.constraints.fechaInicioPlanificada.attributes.mensaje}"
                                         id="fechaInicioPlanificada" autocomplete="off"
                                         value="${proyecto?.fechaInicioPlanificada?.format('dd-MM-yyyy')}"/>
                        </td>

                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaInicio.label" default="Fecha Inicio"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaInicio">

                            <input type="hidden" name="fechaInicio_day" id="fechaInicio_day"
                                   value="${proyecto?.fechaInicio?.format('dd')}">

                            <input type="hidden" name="fechaInicio_month" id="fechaInicio_month"
                                   value="${proyecto?.fechaInicio?.format('MM')}">

                            <input type="hidden" name="fechaInicio_year" id="fechaInicio_year"
                                   value="${proyecto?.fechaInicio?.format('yyyy')}">
                            <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio"
                                         title="${Proyecto.constraints.fechaInicio.attributes.mensaje}"
                                         style="width: 120px;"
                                         id="fechaInicio" value="${proyecto?.fechaInicio?.format('dd-MM-yyyy')}"
                                         autocomplete="off"/>
                        </td>

                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'fechaFinPlanificada', 'error')} ${hasErrors(bean: proyecto, field: 'fechaFin', 'error')}">

                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaFinPlanificada.label" default="Fecha Fin Planificada"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaFinPlanificada">

                            <input type="hidden" name="fechaFinPlanificada_day" id="fechaFinPlanificada_day"
                                   value="${proyecto?.fechaFinPlanificada?.format('dd')}">

                            <input type="hidden" name="fechaFinPlanificada_month" id="fechaFinPlanificada_month"
                                   value="${proyecto?.fechaFinPlanificada?.format('MM')}">

                            <input type="hidden" name="fechaFinPlanificada_year" id="fechaFinPlanificada_year"
                                   value="${proyecto?.fechaFinPlanificada?.format('yyyy')}">
                            <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                         name="fechaFinPlanificada"
                                         style="width: 120px;"
                                         title="${Proyecto.constraints.fechaFinPlanificada.attributes.mensaje}"
                                         id="fechaFinPlanificada"
                                         autocomplete="off"
                                         value="${proyecto?.fechaFinPlanificada?.format('dd-MM-yyyy')}"/>

                        </td>

                        <td class="label " valign="middle">
                            <g:message code="proyecto.fechaFin.label" default="Fecha Fin"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaFin">

                            <input type="hidden" name="fechaFin_day" id="fechaFin_day"
                                   value="${proyecto?.fechaFin?.format('dd')}">

                            <input type="hidden" name="fechaFin_month" id="fechaFin_month"
                                   value="${proyecto?.fechaFin?.format('MM')}">

                            <input type="hidden" name="fechaFin_year" id="fechaFin_year"
                                   value="${proyecto?.fechaFin?.format('yyyy')}">
                            <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin"
                                         title="${Proyecto.constraints.fechaFin.attributes.mensaje}"
                                         style="width: 120px;"
                                         id="fechaFin" value="${proyecto?.fechaFin?.format('dd-MM-yyyy')}"
                                         autocomplete="off"/>
                        </td>

                    </tr>

                    <tr>
                        <td class="label" valign="middle">
                            <g:message code="proyecto.ejeProgramatico.label"
                                       default="Eje Programático"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td>

                            <g:select class="field ui-widget-content ui-corner-all" name="ejeProgramatico.id"
                                      title="${Proyecto.constraints.ejeProgramatico.attributes.mensaje}"
                                      from="${mies.EjeProgramatico.list()}" optionKey="id" style="width: 360px;"
                                      value="${proyecto?.ejeProgramatico?.id}" noSelection="['null': '']"/>
                        </td> <!-- campo -->

                        <td class="label " valign="middle">
                            <g:message code="proyecto.cobertura.label" default="Cobertura"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="cobertura.id"
                                      title="${Proyecto.constraints.cobertura.attributes.mensaje}"
                                      style="width: 360px;"
                                      from="${mies.Cobertura.list()}" optionKey="id" value="${proyecto?.cobertura?.id}"
                                      noSelection="['null': '']"/>
                        </td>

                    </tr>

                    <tr>
                        <td class="label " valign="middle">
                            <g:message code="proyecto.descripcion.label" default="Descripción"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024"
                                        name="descripcion"
                                        id="descripcion" title="${Proyecto.constraints.descripcion.attributes.mensaje}"
                                        cols="40" rows="3"
                                        style="width: 900px;" value="${proyecto?.descripcion}"/>
                        </td>

                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'problema', 'error')}">

                        <td class="label " valign="middle">
                            <g:message code="proyecto.problema.label" default="Problema"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024"
                                        name="problema"
                                        id="problema" title="${Proyecto.constraints.problema.attributes.mensaje}"
                                        cols="40" rows="3"
                                        style="width: 900px;" value="${proyecto?.problema}"/>
                        </td>
                    </tr>

                    <tr>
                        <td class="label " valign="middle">
                            Lineamiento Senplades
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="linea.id"
                                      title="${Proyecto.constraints.linea.attributes.mensaje}" style="width: 900px;"
                                      from="${mies.Linea.list()}" optionKey="id" value="${proyecto?.linea?.id}"
                                      noSelection="['null': '']"/>
                        </td>
                    </tr>

                    <tr>
                        <td class="label" valign="middle">
                            Poblaci&oacute;n Objetivo
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" class="" colspan="3">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024"
                                        name="poblacionObjetivo"
                                        id="poblacionObjetivo"
                                        title="${Proyecto.constraints.poblacionObjetivo.attributes.mensaje}"
                                        cols="40" rows="2"
                                        style="width: 900px;" value="${proyecto?.poblacionObjetivo}"/>
                        </td> <!-- campo -->
                    </tr>

                    <tr>
                        <td class="label" valign="middle">
                            Objetivos Estrat&eacute;gicos
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" class="" colspan="3">
                            <g:select class="ui-widget-content ui-corner-all objetivoEstrategico"
                                      name="objetivoEstrategico.id"
                                      title="${Proyecto.constraints.objetivoEstrategico.attributes.mensaje}"
                                      style="width: 360px;"
                                      from="${mies.ObjetivoEstrategicoProyecto.list()}" optionKey="id"
                                      value="${proyecto?.objetivoEstrategico?.id}"
                                      noSelection="['null': '']"/>
                        </td> <!-- campo -->
                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'subPrograma', 'error')} ${hasErrors(bean: proyecto, field: 'programa', 'error')}">
                        <td class="label " valign="middle">
                            Objetivo GPR
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all objetivoGobiernoResultado"
                                      name="objetivoGobiernoResultado.id"
                                      title="${Proyecto.constraints.objetivoGobiernoResultado.attributes.mensaje}"
                                      style="width: 900px;" from="${mies.ObjetivoGobiernoResultado.list()}"
                                      programaPresupuestario
                                      optionKey="id" optionValue="descripcion"
                                      value="${proyecto?.objetivoGobiernoResultado?.id}"/>
                        </td>

                    </tr>

                    <tr class="prop ${hasErrors(bean: proyecto, field: 'subPrograma', 'error')} ${hasErrors(bean: proyecto, field: 'programa', 'error')}">
                        <td class="label " valign="middle">
                            <g:message code="proyecto.programa.label" default="Programa"/>
                        </td>

                        <td class="indicator">
                            &nbsp;
                        </td>

                        <td colspan="4" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all programaId" name="programa.id"
                                      title="${Proyecto.constraints.programa.attributes.mensaje}"
                                      style="width: 900px;"
                                      from="${mies.Programa.list()}" optionKey="id" value="${proyecto?.programa?.id}"
                                      noSelection="['null': '']"/>
                        </td>

                    </tr>

                </tbody>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="6" class="buttons">
                            <g:if test="${source == 'edit'}">
                                <a href="#" class="button save">
                                    <g:message code="default.button.update.label" default="Update"/>
                                </a>
                                <g:link class="button delete" action="delete" id="${proyecto?.id}">
                                    <g:message code="default.button.delete.label" default="Delete"/>
                                </g:link>
                                <g:link class="button show" action="show" id="${proyecto?.id}">
                                    <g:message code="default.button.show.label" default="Show"/>
                                </g:link>
                            </g:if>
                            <g:else>

                                <div class="botones">
                                    <div class="botones left">
                                        <g:link action="nuevoProyecto" event="salir" class="button salir">Salir</g:link>
                                    </div>

                                    <div class="botones right">
                                        <a href="#" class="button saveOnly" title="Guardar los cambios">
                                            Guardar
                                        </a>

                                        <a href="#" class="button save" title="A objetivos del buen vivir">
                                            Continuar
                                        </a>
                                    </div>
                                </div>

                            </g:else>
                        </td>
                    </tr>
                </tfoot>
                </table>
            </g:form>
        </div>

        <script type="text/javascript">
            $(function () {

                $(".programaPresupuestario").selectmenu({width:370});
                $(".objetivoGobiernoResultado").selectmenu({width:900});
                $(".objetivoEstrategico").selectmenu({width:900});
                $(".programaId").selectmenu({width:900});

                $("#porcentajeNacional, #porcentajeExtranjero").keyup(function (evt) {

                    var este = $(this).val();

                    if (trim(este) != "") {
                        if (isNaN(este)) {
                            este = 100;
                        } else {
                            este = parseInt(este);
                        }

                        if (este > 100) {
                            este = 100;
                        }

                        var otro = 100 - este;
                        if ($(this).attr("id") == "porcentajeExtranjero") {
                            $("#porcentajeExtranjero").val(este);
                            $("#porcentajeNacional").val(otro);
                        } else if ($(this).attr("id") == "porcentajeNacional") {
                            $("#porcentajeNacional").val(este);
                            $("#porcentajeExtranjero").val(otro);
                        }
                    } else {
                        $("#porcentajeNacional").val("");
                        $("#porcentajeExtranjero").val("");
                    }
                });

                /******************* DATEPICKERS ***********************************/
                $('#fechaModificacion').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    dateFormat:'dd-mm-yy',
                    maxDate:new Date(),
                    onClose:function (dateText, inst) {
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
                $('#fechaRegistro').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    dateFormat:'dd-mm-yy',
                    maxDate:new Date(),
                    onClose:function (dateText, inst) {
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

                        var nd = Date.today().set({ year:year, month:month - 1, day:day });
                        $('#fechaModificacion').datepicker("option", "minDate", nd);
                    }
                });

                $('#fechaFinPlanificada').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    dateFormat:'dd-mm-yy',
                    onClose:function (dateText, inst) {
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
                $('#fechaInicioPlanificada').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    dateFormat:'dd-mm-yy',
                    onClose:function (dateText, inst) {
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

                        var nd = Date.today().set({ year:year, month:month - 1, day:day });
                        $('#fechaFinPlanificada').datepicker("option", "minDate", nd);
                    }
                });

                $('#fechaFin').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    dateFormat:'dd-mm-yy',
                    onClose:function (dateText, inst) {
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
                $('#fechaInicio').datepicker({
                    changeMonth:true,
                    changeYear:true,
                    dateFormat:'dd-mm-yy',
                    onClose:function (dateText, inst) {
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

                        var nd = Date.today().set({ year:year, month:month - 1, day:day });
                        $('#fechaFin').datepicker("option", "minDate", nd);
                    }
                });
                /*********************** DATEPICKERS ************************************************/

                var myForm = $(".frmProyecto");

                // Tooltip de informacion para cada field (utiliza el atributo title del textfield)
                var elems = $('.field')
                        .each(function (i) {
                            $.attr(this, 'oldtitle', $.attr(this, 'title'));
                        })
                        .removeAttr('title');
                $('<div />').qtip(
                        {
                            content:' ', // Can use any content here :)
                            position:{
                                target:'event' // Use the triggering element as the positioning target
                            },
                            show:{
                                target:elems,
                                event:'click mouseenter focus'
                            },
                            hide:{
                                target:elems,
                                delay:0,
                                leave:false
                            },
                            events:{
                                show:function (event, api) {
                                    // Update the content of the tooltip on each show
                                    var target = $(event.originalEvent.target);
                                    api.set('content.text', target.attr('title'));
                                }
                            },
                            style:{
                                classes:'ui-tooltip-rounded ui-tooltip-cream'
                            }
                        });
                // fin del codigo para los tooltips

                // Validacion del formulario
                myForm.validate({
                    errorClass:"errormessage",
                    onkeyup:false,
                    errorElement:"em",
                    errorClass:'error',
                    validClass:'valid',
                    errorPlacement:function (error, element) {
                        // Set positioning based on the elements position in the form
                        var elem = $(element),
                                corners = ['right center', 'left center'],
                                flipIt = elem.parents('span.right').length > 0;

                        // Check we have a valid error message
                        if (!error.is(':empty')) {
                            // Apply the tooltip only if it isn't valid
                            elem.filter(':not(.valid)').qtip({
                                overwrite:false,
                                content:error,
                                position:{
                                    my:corners[ flipIt ? 0 : 1 ],
                                    at:corners[ flipIt ? 1 : 0 ],
                                    viewport:$(window)
                                },
                                show:{
                                    event:false,
                                    ready:true
                                },
                                hide:{
                                    target:elems,
                                    delay:0,
                                    leave:false
                                },
                                style:{
                                    classes:'ui-tooltip-rounded ui-tooltip-red' // Make it red... the classic error colour!
                                }
                            })

                                // If we have a tooltip on this element already, just update its content
                                    .qtip('option', 'content.text', error);
                        }

                        // If the error is empty, remove the qTip
                        else {
                            elem.qtip('destroy');
                        }
                    },
                    success:$.noop // Odd workaround for errorPlacement not firing!
                })
                ;
                //fin de la validacion del formulario

                $(".button").button();

                $(".saveOnly").button("option", "icons", {primary:'ui-icon-disk'}).click(function () {
                    if (myForm.valid()) {
                        $("#goto").val("proyecto");
                        myForm.submit();
                    }
                    return false;
                });

                $(".salir").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'}).click(function () {
                    if (confirm("Si sale perderá los cambios no guardados. Continuar?")) {
                        return true;
                    } else {
                        return false;
                    }
                });
                $(".home").button("option", "icons", {primary:'ui-icon-home'});
                $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
                $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
                $(".save").button("option", "icons", {secondary:'ui-icon-arrowthick-1-e'}).click(function () {
                    $("#goto").val("buenVivir");
                    myForm.submit();
                    return false;
                });
                $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function () {
                    if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>