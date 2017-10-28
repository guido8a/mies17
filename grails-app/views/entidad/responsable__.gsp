<%@ page import="mies.ResponsableProyecto" %>

<style type="text/css">
select.field {
    width : 235px;
}

.datepicker {
    width : 215px;
}
</style>

<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${responsableAdministrativo}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${responsableAdministrativo}" as="list"/>
    </div>
</g:hasErrors>

<g:set var="administrativo" value="${responsableAdministrativo?.id ? true: false}"/>
<g:set var="financiero" value="${responsableFinanciero?.id ? true: false}"/>
<g:set var="planificacion" value="${responsablePlanificacion?.id ? true: false}"/>

<g:if test="${usuarios.size() > 0 ? true: false}">
    <g:form action="saveResponsable" class="frmResponsableProyecto" method="post" name="administrativo">
        <g:hiddenField name="administrativo.id" value="${responsableAdministrativo?.id}"/>
        <g:hiddenField name="administrativo.version" value="${responsableAdministrativo?.version}"/>
        <g:hiddenField name="administrativo.unidad.id"  value="${unidad.id}"/>
        <g:hiddenField name="administrativo.tipo" id="tipo_administrativo" value="insert"/>

        <table width="100%" class="ui-widget-content ui-corner-all ${administrativo ? 'ui-helper-hidden' : ''}"
               id="create_administrativo">
            <thead>
                <tr>
                    <td width="430" colspan="5" class="ui-widget ui-widget-header ui-corner-left"
                        style="padding: 3px;">
                        Responsable Administrativo
                    </td>
                    <td class="ui-widget ui-widget-header ui-corner-right">
                        <a href="#" tipo="administrativo" class="btn save">Guardar</a>
                        <a href="#" tipo="administrativo" class="btn cancel">Cancelar</a>
                    </td>
                </tr>
            </thead>

            <tbody>

                <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'responsable', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="administrativo.responsable.id"
                                  title="${ResponsableProyecto.constraints.responsable.attributes.mensaje}"
                                  from="${mies.seguridad.Usro.findAllByUnidad(mies.UnidadEjecutora.get(93))}" optionKey="id" noSelection="['null': '']" optionValue="persona"/>
                    </td>
                </tr>

                <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'desde', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.desde.label" default="Desde"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="administrativo.desde1"/>
                        <input type="hidden" name="administrativo.desde_day" id="desde_day"/>
                        <input type="hidden" name="administrativo.desde_month" id="desde_month"/>
                        <input type="hidden" name="administrativo.desde_year" id="desde_year"/>
                        <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                     name="administrativo.desde"
                                     title="${ResponsableProyecto.constraints.desde.attributes.mensaje}"
                                     id="desde"/>
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="administrativo.hasta1"/>
                        <input type="hidden" name="administrativo.hasta_day" id="hasta_day"/>
                        <input type="hidden" name="administrativo.hasta_month" id="hasta_month"/>
                        <input type="hidden" name="administrativo.hasta_year" id="hasta_year"/>
                        <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                     name="administrativo.hasta"
                                     title="${ResponsableProyecto.constraints.hasta.attributes.mensaje}"
                                     id="hasta"/>
                    </td>
                </tr>

                <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'observaciones', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textField name="administrativo.observaciones" id="observaciones"
                                     title="${ResponsableProyecto.constraints.observaciones.attributes.mensaje}"
                                     style="width: 560px;" class="field ui-widget-content ui-corner-all"
                                     minLenght="1"
                                     maxLenght="127"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </g:form>

    <table width="100%" class="ui-widget-content ui-corner-all ${!administrativo ? 'ui-helper-hidden' : ''}"
           id="show_administrativo">

        <thead>
            <tr>
                <td width="430" colspan="5" class="ui-widget ui-widget-header ui-corner-left" style="padding: 3px;">
                    Responsable Administrativo
                </td>
                <td class="ui-widget ui-widget-header ui-corner-right">
                    <a href="#" tipo="administrativo" class="btn show">Reasignar</a>
                </td>
            </tr>
        </thead>

        <tbody>

            <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'responsable', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsableAdministrativo?.responsable}
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'desde', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.desde.label" default="Desde"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsableAdministrativo?.desde?.format('dd-MM-yyyy')}
                </td>

                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsableAdministrativo?.hasta?.format('dd-MM-yyyy')}
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'observaciones', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle" colspan="4">
                    ${responsableAdministrativo?.observaciones}
                </td>
            </tr>

        </tbody>
    </table>

    <br/>

    <g:form action="saveResponsable" class="frmResponsableProyecto" method="post" name="financiero">
        <g:hiddenField name="financiero.id" value="${responsableFinanciero?.id}"/>
        <g:hiddenField name="financiero.version" value="${responsableFinanciero?.version}"/>
        <g:hiddenField name="financiero.unidad.id"  value="${unidad.id}"/>
        <g:hiddenField name="financiero.tipo" id="tipo_financiero" value="insert"/>

        <table width="100%" class="ui-widget-content ui-corner-all ${financiero ? 'ui-helper-hidden' : ''}"
               id="create_financiero">

            <thead>
                <tr>
                    <td width="430" colspan="5" class="ui-widget ui-widget-header ui-corner-left"
                        style="padding: 3px;">
                        Responsable Financiero
                    </td>
                    <td class="ui-widget ui-widget-header ui-corner-right">
                        <a href="#" tipo="financiero" class="btn save">Guardar</a>
                        <a href="#" tipo="financiero" class="btn cancel">Cancelar</a>
                    </td>
                </tr>
            </thead>

            <tbody>

                <tr class="prop ${hasErrors(bean: responsableFinanciero, field: 'responsable', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="administrativo.responsable.id"
                                  title="${ResponsableProyecto.constraints.responsable.attributes.mensaje}"
                                  from="${mies.seguridad.Usro.findAllByUnidad(mies.UnidadEjecutora.get(94))}" optionKey="id" noSelection="['null': '']" optionValue="persona"/>
                    </td>
                </tr>

                <tr class="prop ${hasErrors(bean: responsableEjecucion, field: 'desde', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.desde.label" default="Desde"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="financiero.desde2">
                        <input type="hidden" name="financiero.desde_day" id="desde2_day"
                               value="${responsableFinanciero?.desde?.format('dd')}">
                        <input type="hidden" name="financiero.desde_month" id="desde2_month"
                               value="${responsableFinanciero?.desde?.format('MM')}">
                        <input type="hidden" name="financiero.desde_year" id="desde2_year"
                               value="${responsableFinanciero?.desde?.format('yyyy')}">
                        <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                     name="financiero.desde"
                                     title="${ResponsableProyecto.constraints.desde.attributes.mensaje}"
                                     id="desde2"/>
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="financiero.hasta2">
                        <input type="hidden" name="financiero.hasta_day" id="hasta2_day"
                               value="${responsableFinanciero?.hasta?.format('dd')}">
                        <input type="hidden" name="financiero.hasta_month" id="hasta2_month"
                               value="${responsableFinanciero?.hasta?.format('MM')}">
                        <input type="hidden" name="financiero.hasta_year" id="hasta2_year"
                               value="${responsableFinanciero?.hasta?.format('yyyy')}">
                        <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                     name="financiero.hasta"
                                     title="${ResponsableProyecto.constraints.hasta.attributes.mensaje}"
                                     id="hasta2"/>
                    </td>
                </tr>

                <tr class="prop ${hasErrors(bean: responsableFinanciero, field: 'observaciones', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textField name="financiero.observaciones" id="observaciones"
                                     title="${ResponsableProyecto.constraints.observaciones.attributes.mensaje}"
                                     style="width: 560px;"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"/>
                    </td>
                </tr>

            </tbody>
        </table>
    </g:form>

    <table width="100%" class="ui-widget-content ui-corner-all ${!financiero ? 'ui-helper-hidden' : ''}"
           id="show_financiero">

        <thead>
            <tr>
                <td width="430" colspan="5" class="ui-widget ui-widget-header ui-corner-left" style="padding: 3px;">
                    Responsable Financiero
                </td>
                <td class="ui-widget ui-widget-header ui-corner-right">
                    <a href="#" tipo="financiero" class="btn show">Reasignar</a>
                </td>
            </tr>
        </thead>

        <tbody>

            <tr class="prop ${hasErrors(bean: responsableFinanciero, field: 'responsable', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsableFinanciero?.responsable}
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: responsableFinanciero, field: 'desde', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.desde.label" default="Desde"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsableFinanciero?.desde?.format('dd-MM-yyyy')}
                </td>

                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsableFinanciero?.hasta?.format('dd-MM-yyyy')}
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: responsableFinanciero, field: 'observaciones', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle" colspan="4">
                    ${responsableFinanciero?.observaciones}
                </td>
            </tr>

        </tbody>
    </table>

    <br/>

    <g:form action="saveResponsable" class="frmResponsableProyecto" method="post" name="planificacion">
        <g:hiddenField name="planificacion.id" value="${responsablePlanificacion?.id}"/>
        <g:hiddenField name="planificacion.version" value="${responsablePlanificacion?.version}"/>
        <g:hiddenField name="planificacion.unidad.id"  value="${unidad.id}"/>

        <g:hiddenField name="planificacion.tipo" id="tipo_planificacion" value="insert"/>

        <table width="100%" class="ui-widget-content ui-corner-all ${planificacion ? 'ui-helper-hidden' : ''}"
               id="create_planificacion">
            <thead>
                <tr>
                    <td width="430" colspan="5" class="ui-widget ui-widget-header ui-corner-left"
                        style="padding: 3px;">
                        Responsable de Planificación
                    </td>
                    <td class="ui-widget ui-widget-header ui-corner-right">
                        <a href="#" tipo="planificacion" class="btn save">Guardar</a>
                        <a href="#" tipo="planificacion" class="btn cancel">Cancelar</a>
                    </td>
                </tr>
            </thead>

            <tbody>

                <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'responsable', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="planificacion.responsable.id"
                                  title="${ResponsableProyecto.constraints.responsable.attributes.mensaje}"
                                  from="${mies.seguridad.Usro.findAllByUnidad(mies.UnidadEjecutora.get(85))}" optionKey="id" noSelection="['null': '']"/>
                    </td>
                </tr>

                <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'desde', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.desde.label" default="Desde"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="planificacion.desde3"/>
                        <input type="hidden" name="planificacion.desde_day" id="desde3_day"/>
                        <input type="hidden" name="planificacion.desde_month" id="desde3_month"/>
                        <input type="hidden" name="planificacion.desde_year" id="desde3_year"/>
                        <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                     name="planificacion.desde"
                                     title="${ResponsableProyecto.constraints.desde.attributes.mensaje}"
                                     id="desde3"/>
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="planificacion.hasta3"/>
                        <input type="hidden" name="planificacion.hasta_day" id="hasta3_day"/>
                        <input type="hidden" name="planificacion.hasta_month" id="hasta3_month"/>
                        <input type="hidden" name="planificacion.hasta_year" id="hasta3_year"/>
                        <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                     name="planificacion.hasta"
                                     title="${ResponsableProyecto.constraints.hasta.attributes.mensaje}"
                                     id="hasta3"/>
                    </td>
                </tr>

                <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'observaciones', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textField name="planificacion.observaciones" id="observaciones"
                                     title="${ResponsableProyecto.constraints.observaciones.attributes.mensaje}"
                                     style="width: 560px;" class="field ui-widget-content ui-corner-all"
                                     minLenght="1"
                                     maxLenght="127"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </g:form>

    <table width="100%" class="ui-widget-content ui-corner-all ${!planificacion ? 'ui-helper-hidden' : ''}"
           id="show_planificacion">

        <thead>
            <tr>
                <td width="430" colspan="5" class="ui-widget ui-widget-header ui-corner-left" style="padding: 3px;">
                    Responsable de Planificación
                </td>
                <td class="ui-widget ui-widget-header ui-corner-right">
                    <a href="#" tipo="planificacion" class="btn show">Reasignar</a>
                </td>
            </tr>
        </thead>

        <tbody>

            <tr class="prop ${hasErrors(bean: responsableAdministrativo, field: 'responsable', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsablePlanificacion?.responsable}
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: responsablePlanificacion, field: 'desde', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.desde.label" default="Desde"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsablePlanificacion?.desde?.format('dd-MM-yyyy')}
                </td>

                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    ${responsablePlanificacion?.hasta?.format('dd-MM-yyyy')}
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: responsablePlanificacion, field: 'observaciones', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle" colspan="4">
                    ${responsablePlanificacion?.observaciones}
                </td>
            </tr>

        </tbody>
    </table>

</g:if>
<g:else>
    <div style="padding: 0 .7em;" class="ui-state-highlight ui-corner-all">
        <p>
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-info"></span>
            <strong>Atenci&oacute;n</strong><br/>
            No existen usuarios en esta unidad ejecutora. Agregue usuarios para poder asignar responsables.
        </p>
    </div>
</g:else>


<script type="text/javascript">
    $(function() {

        $(".show").button({
            icons: {
                primary: "ui-icon-shuffle"
            }
        }).click(function() {
                    var tipo = $(this).attr("tipo");
                    $("#show_" + tipo).hide();
                    $("#create_" + tipo).show();

                    $("#tipo_" + tipo).val("update");

                    return false;
                });

        $(".cancel").button({
            icons: {
                primary: "ui-icon-close"
            }
        }).click(function() {
                    var tipo = $(this).attr("tipo");
                    $("#create_" + tipo).hide();
                    $("#show_" + tipo).show();

                    $("#tipo_" + tipo).val("insert");

                    return false;
                });

        $(".save").button({
            icons: {
                primary: "ui-icon-disk"
            }
        }).click(function() {
                    var tipo = $(this).attr("tipo");

                    var form = $("[name=" + tipo + "]");
                    var data = form.serialize();

                    var url = form.attr("action");
                    var href = "${createLink(action: 'responsable', id: unidad.id)}";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: data,
                        success: function(msg) {
                            if (msg == "OK") {
                                $("#actuales").load(href);
                            }
                        }
                    });
                    return false;
                });

        $('#desde').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
            minDate: new Date(),
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

                $("#hasta").datepicker("option", "minDate", date.add(1).days());
            }
        });

        $('#hasta').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
            minDate: new Date().add(2).days(),
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

        $('#desde2').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
            minDate: new Date(),
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

                $("#hasta2").datepicker("option", "minDate", date.add(1).days());
            }
        });

        $('#hasta2').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
            minDate: new Date().add(2).days(),
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

         $('#desde3').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
            minDate: new Date(),
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

                $("#hasta3").datepicker("option", "minDate", date.add(1).days());
            }
        });

        $('#hasta3').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
            minDate: new Date().add(2).days(),
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

        var myForm = $(".frmResponsableProyecto");

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
                        target: elems,
                        delay : 0,
                        leave: false
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
                else {
                    elem.qtip('destroy');
                }
            },
            success: $.noop // Odd workaround for errorPlacement not firing!
        })
                ;
        //fin de la validacion del formulario
    });
</script>