
<%@ page import="mies.ModificacionProyecto" %>
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
            <div class="dialog">

                %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
                    %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
                        %{--<g:message code="default.home.label" default="Home" />--}%
                    %{--</a>--}%
                    %{--<g:link class="button list" action="list">--}%
                        %{--<g:message code="default.list.label" args="${['ModificacionProyecto']}" default="ModificacionProyecto List" />--}%
                    %{--</g:link>--}%
                %{--</div>--}%

                    <g:if test="${flash.message}">
                        <div class="message ui-state-highlight ui-corner-all">
                            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
                        </div>
                    </g:if>
                    <g:hasErrors bean="${modificacionProyectoInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${modificacionProyectoInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmModificacionProyecto"
                            method="post"  >
                        <g:hiddenField name="id" value="${modificacionProyectoInstance?.id}" />
                        <g:hiddenField name="version" value="${modificacionProyectoInstance?.version}" />

                        <table width="100%" class="ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                        <g:if test="${source == 'edit'}">
                                            <g:message code="default.edit.legend" args="${['ModificacionProyecto']}" default="Edit ModificacionProyecto details"/>
                                        </g:if>
                                        <g:else>
                                            <g:message code="default.create.legend" args="${['ModificacionProyecto']}" default="Enter ModificacionProyecto details"/>
                                        </g:else>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                    
                    
                    <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'informe', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.informe.label" default="Informe" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="informe.id" title="${ModificacionProyecto.constraints.informe.attributes.mensaje}" from="${mies.Informe.list()}" optionKey="id" value="${modificacionProyectoInstance?.informe?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.tipoModificacion.label" default="Tipo Modificacion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="tipoModificacion.id" title="${ModificacionProyecto.constraints.tipoModificacion.attributes.mensaje}" from="${mies.TipoModificacion.list()}" optionKey="id" value="${modificacionProyectoInstance?.tipoModificacion?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'valor', 'error')}">
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="modificacionProyecto.valor.label" default="Valor" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="valor" title="${ModificacionProyecto.constraints.valor.attributes.mensaje}" id="valor" value="${fieldValue(bean: modificacionProyectoInstance, field: 'valor')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.descripcion.label" default="Descripcion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="descripcion" id="descripcion" title="${ModificacionProyecto.constraints.descripcion.attributes.mensaje}" cols="40" rows="5" value="${modificacionProyectoInstance?.descripcion}" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'fecha', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.fecha.label" default="Fecha" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fecha">
<input type="hidden" name="fecha_day" id="fecha_day"  value="${modificacionProyectoInstance?.fecha?.format('dd')}" >
<input type="hidden" name="fecha_month" id="fecha_month" value="${modificacionProyectoInstance?.fecha?.format('MM')}">
<input type="hidden" name="fecha_year" id="fecha_year" value="${modificacionProyectoInstance?.fecha?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha" title="${ModificacionProyecto.constraints.fecha.attributes.mensaje}" id="fecha" value="${modificacionProyectoInstance?.fecha?.format('dd-MM-yyyy')}" />
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
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.fechaAprobacion.label" default="Fecha Aprobacion" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <input type="hidden" value="date.struct" name="fechaAprobacion">
<input type="hidden" name="fechaAprobacion_day" id="fechaAprobacion_day"  value="${modificacionProyectoInstance?.fechaAprobacion?.format('dd')}" >
<input type="hidden" name="fechaAprobacion_month" id="fechaAprobacion_month" value="${modificacionProyectoInstance?.fechaAprobacion?.format('MM')}">
<input type="hidden" name="fechaAprobacion_year" id="fechaAprobacion_year" value="${modificacionProyectoInstance?.fechaAprobacion?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaAprobacion" title="${ModificacionProyecto.constraints.fechaAprobacion.attributes.mensaje}" id="fechaAprobacion" value="${modificacionProyectoInstance?.fechaAprobacion?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaAprobacion').datepicker({
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
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: modificacionProyectoInstance, field: 'aprobado', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.aprobado.label" default="Aprobado" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textField  name="aprobado" id="aprobado" title="${ModificacionProyecto.constraints.aprobado.attributes.mensaje}" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="15" value="${modificacionProyectoInstance?.aprobado}" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="modificacionProyecto.observaciones.label" default="Observaciones" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textField  name="observaciones" id="observaciones" title="${ModificacionProyecto.constraints.observaciones.attributes.mensaje}" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${modificacionProyectoInstance?.observaciones}" />
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
                            <g:link class="button delete" action="delete" id="${modificacionProyectoInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${modificacionProyectoInstance?.id}">
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
                var myForm = $(".frmModificacionProyecto");

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