<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 7/8/11
  Time: 4:06 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.Entidad" %>

<g:form action="save" class="frm_editar"
        method="post">
    <g:hiddenField name="id" value="${entidadInstance?.id}"/>
    <g:hiddenField name="version" value="${entidadInstance?.version}"/>
    <g:hiddenField name="tipo" value="${tipo}"/>

    <table width="100%" class="ui-widget-content ui-corner-all">

        <tbody>

            <tr class="prop ${hasErrors(bean: entidadInstance, field: 'codigo', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="entidad.codigo.label" default="Codigo"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="codigo" id="codigo" title="${Entidad.constraints.codigo.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="3" value="${entidadInstance?.codigo}"/>
                </td>

                <td class="label  mandatory" valign="middle">
                    <g:message code="entidad.nombre.label" default="Nombre"/>
                </td>
                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>
                <td class="campo mandatory" valign="middle">
                    <g:textField name="nombre" id="nombre" title="${Entidad.constraints.nombre.attributes.mensaje}"
                                 class="field required ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="63" value="${entidadInstance?.nombre}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: entidadInstance, field: 'titulo', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="entidad.titulo.label" default="Titulo"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="titulo" id="titulo" title="${Entidad.constraints.titulo.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="63" value="${entidadInstance?.titulo}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="entidad.direccion.label" default="Direccion"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="direccion" id="direccion" title="${Entidad.constraints.direccion.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="127" value="${entidadInstance?.direccion}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: entidadInstance, field: 'sigla', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="entidad.sigla.label" default="Sigla"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="sigla" id="sigla" title="${Entidad.constraints.sigla.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                                 minLenght="1"
                                 maxLenght="7" value="${entidadInstance?.sigla}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="entidad.objetivo.label" default="Objetivo"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="objetivo" id="objetivo" title="${Entidad.constraints.objetivo.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="63" value="${entidadInstance?.objetivo}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: entidadInstance, field: 'fechaInicio', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="entidad.fechaInicio.label" default="Fecha Inicio"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <input type="hidden" value="date.struct" name="fechaInicio">
                    <input type="hidden" name="fechaInicio_day" id="fechaInicio_day"
                           value="${entidadInstance?.fechaInicio?.format('dd')}">
                    <input type="hidden" name="fechaInicio_month" id="fechaInicio_month"
                           value="${entidadInstance?.fechaInicio?.format('MM')}">
                    <input type="hidden" name="fechaInicio_year" id="fechaInicio_year"
                           value="${entidadInstance?.fechaInicio?.format('yyyy')}">
                    <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio"
                                 title="${Entidad.constraints.fechaInicio.attributes.mensaje}"
                                 id="fechaInicio" value="${entidadInstance?.fechaInicio?.format('dd-MM-yyyy')}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="entidad.fechaFin.label" default="Fecha Fin"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <input type="hidden" value="date.struct" name="fechaFin">
                    <input type="hidden" name="fechaFin_day" id="fechaFin_day"
                           value="${entidadInstance?.fechaFin?.format('dd')}">
                    <input type="hidden" name="fechaFin_month" id="fechaFin_month"
                           value="${entidadInstance?.fechaFin?.format('MM')}">
                    <input type="hidden" name="fechaFin_year" id="fechaFin_year"
                           value="${entidadInstance?.fechaFin?.format('yyyy')}">
                    <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin"
                                 title="${Entidad.constraints.fechaFin.attributes.mensaje}"
                                 id="fechaFin" value="${entidadInstance?.fechaFin?.format('dd-MM-yyyy')}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: entidadInstance, field: 'telefono', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="entidad.telefono.label" default="Telefono"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="telefono" id="telefono" title="${Entidad.constraints.telefono.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="63" value="${entidadInstance?.telefono}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="entidad.fax.label" default="Fax"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="fax" id="fax" title="${Entidad.constraints.fax.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                                 minLenght="1"
                                 maxLenght="63" value="${entidadInstance?.fax}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: entidadInstance, field: 'email', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="entidad.email.label" default="Email"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="email" id="email" title="${Entidad.constraints.email.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                                 minLenght="1"
                                 maxLenght="63" value="${entidadInstance?.email}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="entidad.observaciones.label" default="Observaciones"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="observaciones" id="observaciones" title="${Entidad.constraints.observaciones.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                                 value="${entidadInstance?.observaciones}"/>
                </td>

            </tr>

        </tbody>
    </table>
</g:form>

<script type="text/javascript">
    $(function() {

        $('#fechaInicio').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
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

        $('#fechaFin').datepicker({
            changeMonth: true,
            changeYear:true,
            dateFormat: 'dd-mm-yy',
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

        var myForm = $(".frm_editar");

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
                else {
                    elem.qtip('destroy');
                }
            },
            success: $.noop // Odd workaround for errorPlacement not firing!
        })
                ;
        //fin de la validacion del formulario

        $(".button").button();
    });
</script>