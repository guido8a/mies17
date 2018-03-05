<%@ page import="mies.PresupuestoUnidad; mies.Anio; mies.UnidadEjecutora; mies.Provincia; mies.TipoInstitucion" %>

<form id="frm_editar" class="frm_editar">

    <g:hiddenField name="unidad.id" value="${unidad.id}"/>

    <table width="100%">
        <tbody>
            <tr class="prop">
                <td class="label">Padre:</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td colspan="4" style="font-size: larger; font-weight: bolder;">
                    %{--${padre?.nombre}--}%
                    %{--<g:hiddenField name="unidad.padre.id" value="${padre?.id}"/>--}%

                    <g:select from="${UnidadEjecutora.list(sort:'nombre')}" optionKey="id"
                              optionValue="nombre" class="field ui-widget-content ui-corner-all"
                              title="${UnidadEjecutora.constraints.padre.attributes.mensaje}"
                              value="${padre?.id}" name="unidad.padre.id"/>

                </td>
            </tr>

            <tr class="prop">
                <td class="label">Orden:</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td colspan="4" style="font-size: larger; font-weight: bolder;">
                    <g:textField name="unidad.orden" value="${unidad?.orden}"/>
                </td>
            </tr>


            <tr class="prop">
                <td class="label  mandatory" valign="middle">
                    Tipo de institución
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class="mandatory">
                    <g:select from="${TipoInstitucion.list(sort:'descripcion')}" optionKey="id"
                              optionValue="descripcion" class="field ui-widget-content ui-corner-all"
                              title="${UnidadEjecutora.constraints.tipoInstitucion.attributes.mensaje}"
                              value="${unidad?.tipoInstitucion?.id}" name="unidad.tipoInstitucion.id"/>
                </td> <!-- campo -->

                <td class="label">C&oacute;digo eSIGEF</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    <g:textField value="${unidad?.codigo}" name="unidad.codigo"
                                 class="field ui-widget-content ui-corner-all" maxlength="4" style="width: 80px;"
                                 title="${UnidadEjecutora.constraints.codigo.attributes.mensaje}"/>
                </td> <!-- campo -->
            </tr>

            <tr class="prop">
                <td class="label mandatory">Nombre</td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class="mandatory">
                    <g:textField value="${unidad?.nombre}" name="unidad.nombre"
                                 class="field required ui-widget-content ui-corner-all" maxlength="63" style="width: 300px;"
                                 title="${UnidadEjecutora.constraints.nombre.attributes.mensaje}"/>
                </td> <!-- campo -->

                <td class="label">Sigla</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    <g:textField value="${unidad?.sigla}" name="unidad.sigla"
                                 class="field ui-widget-content ui-corner-all" maxlength="7" style="width: 80px;"
                                 title="${UnidadEjecutora.constraints.sigla.attributes.mensaje}"/>
                </td> <!-- campo -->
            </tr>

            <tr class="prop">
                <td class="label">Direcci&oacute;n</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td colspan="4">
                    <g:textArea cols="75" rows="2" value="${unidad?.direccion}" name="unidad.direccion"
                                class="field ui-widget-content ui-corner-all" maxlength="127" style="width: 600px;"
                                title="${UnidadEjecutora.constraints.direccion.attributes.mensaje}"/>
                </td> <!-- campo -->
            </tr>

            <tr class="prop">
                <td class="label">Misión</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td colspan="4">
                    <g:textArea cols="75" rows="2" value="${unidad?.objetivo}" name="unidad.objetivo"
                                class="field ui-widget-content ui-corner-all" maxlength="1023" style="width: 620px; height: 100px;"
                                title="${UnidadEjecutora.constraints.objetivo.attributes.mensaje}"/>
                </td> <!-- campo -->
            </tr>

            <tr class="prop">
                <td class="label">Tel&eacute;fono</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    <g:textField value="${unidad?.telefono}" name="unidad.telefono"
                                 class="field ui-widget-content ui-corner-all" maxlength="63"
                                 title="${UnidadEjecutora.constraints.telefono.attributes.mensaje}"/>
                </td> <!-- campo -->

                <td class="label">Fax</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    <g:textField value="${unidad?.fax}" name="unidad.fax" class="field ui-widget-content ui-corner-all"
                                 title="${UnidadEjecutora.constraints.fax.attributes.mensaje}" maxlength="63"/>
                </td> <!-- campo -->
            </tr>

            <tr class="prop">
                <td class="label">E-mail</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    <g:textField value="${unidad?.email}" name="unidad.email"
                                 class="field ui-widget-content ui-corner-all" maxlength="63"
                                 title="${UnidadEjecutora.constraints.email.attributes.mensaje}"/>
                </td> <!-- campo -->

                <td class="label">Provincia</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    <g:select from="${Provincia.list(sort:'nombre')}" value="${unidad?.provincia?.id}"
                              name="unidad.provincia.id" optionKey="id" optionValue="nombre"
                              noSelection="${['null':'Ninguna']}" class="field ui-widget-content ui-corner-all"
                              title="${UnidadEjecutora.constraints.provincia.attributes.mensaje}"/>
                </td> <!-- campo -->
            </tr>

            <tr class="prop">
                <td class="label">Fecha Inicio</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    %{--<g:textField value="${unidad?.fechaInicio?.format("dd-MM-yyyy")}" name="unidad.fechaInicio"/>--}%

                    <input type="hidden" value="date.struct" name="unidad.fechaInicio">

                    <input type="hidden" name="unidad.fechaInicio_day" id="fechaInicio_day"
                           value="${unidad?.fechaInicio?.format('dd')}">

                    <input type="hidden" name="unidad.fechaInicio_month" id="fechaInicio_month"
                           value="${unidad?.fechaInicio?.format('MM')}">

                    <input type="hidden" name="unidad.fechaInicio_year" id="fechaInicio_year"
                           value="${unidad?.fechaInicio?.format('yyyy')}">
                    <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                 name="unidad.fechaInicio_date" style="width: 120px;" id="fechaInicio"
                                 autocomplete="off" value="${unidad?.fechaInicio?.format('dd-MM-yyyy')}"
                                 title="${UnidadEjecutora.constraints.fechaInicio.attributes.mensaje}"/>

                </td> <!-- campo -->

                <td class="label">Fecha Fin</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td>
                    %{--<g:textField value="${unidad?.fechaFin?.format("dd-MM-yyyy")}" name="unidad.fechaFin"/>--}%

                    <input type="hidden" value="date.struct" name="unidad.fechaFin">

                    <input type="hidden" name="unidad.fechaFin_day" id="fechaFin_day"
                           value="${unidad?.fechaFin?.format('dd')}">

                    <input type="hidden" name="unidad.fechaFin_month" id="fechaFin_month"
                           value="${unidad?.fechaFin?.format('MM')}">

                    <input type="hidden" name="unidad.fechaFin_year" id="fechaFin_year"
                           value="${unidad?.fechaFin?.format('yyyy')}">
                    <g:textField class="datepicker field ui-widget-content ui-corner-all"
                                 name="unidad.fechaFin_date" style="width: 120px;" id="fechaFin" autocomplete="off"
                                 title="${UnidadEjecutora.constraints.fechaFin.attributes.mensaje}"
                                 value="${unidad?.fechaFin?.format('dd-MM-yyyy')}"/>
                </td> <!-- campo -->
            </tr>

        <tr class="prop">
            <td class="label">Frontera</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td>
                <g:textField name="unidad.frontera" value="${unidad?.frontera}" class="field ui-widget-content ui-corner-all" title="Frontera cerca a la que se encuentra la unidad"/>
            </td> <!-- campo -->
        </tr>

            <tr class="prop">
                <td class="label">Observaciones</td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td colspan="4">
                    <g:textArea cols="75" rows="2" value="${unidad?.observaciones}" name="unidad.observaciones"
                                title="${UnidadEjecutora.constraints.observaciones.attributes.mensaje}" style="width: 600px;"
                                class="field ui-widget-content ui-corner-all" maxlength="127"/>
                </td> <!-- campo -->
            </tr>

        </tbody>
    </table>
</form>

<script type="text/javascript">
    $(function () {
        /******************* DATEPICKERS ***********************************/
        $('#fechaInicio').datepicker({
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

        var myForm = $(".frm_editar");

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
                            }
                    )

                        // If we have a tooltip on this element already, just update its content
                            .
                            qtip('option', 'content.text', error);
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


    })
    ;
</script>