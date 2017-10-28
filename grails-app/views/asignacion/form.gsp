
<%@ page import="mies.Asignacion" %>
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
                        %{--<g:message code="default.list.label" args="${['Asignacion']}" default="Asignacion List" />--}%
                    %{--</g:link>--}%
                %{--</div>--}%


                <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button list" action="listaAsignaciones">
                    <g:message code="asignacion.list" default="Lista" />
                </g:link>
            </div> <!-- toolbar -->

                    <g:if test="${flash.message}">
                        <div class="message ui-state-highlight ui-corner-all">
                            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
                        </div>
                    </g:if>
                    <g:hasErrors bean="${asignacionInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${asignacionInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmAsignacion"
                            method="post"  >
                        <g:hiddenField name="id" value="${asignacionInstance?.id}" />
                        <g:hiddenField name="version" value="${asignacionInstance?.version}" />

                        <table style="width: 800px;" class="show ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                        <g:if test="${source == 'edit'}">
                                            <g:message code="default.edit.legend" args="${['Asignacion']}" default="Edit Asignacion details"/>
                                        </g:if>
                                        <g:else>
                                            <g:message code="default.create.legend" args="${['Asignacion']}" default="Enter Asignacion details"/>
                                        </g:else>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                    
                    <tr>
                            <td colspan="6" class="blanco">&nbsp;</td>
                        </tr>
                    
                    
                    <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'anio', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="asignacion.anio.label" default="Anio" />:
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="anio.id" title="Año o “ejercicio”" from="${mies.Anio.list()}" optionKey="id" value="${asignacionInstance?.anio?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="asignacion.fuente.label" default="Fuente" />:
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="fuente.id" title="Fuente de financiamiento" from="${mies.Fuente.list()}" optionKey="id" value="${asignacionInstance?.fuente?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="asignacion.marcoLogico.label" default="Marco Logico" />:
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="marcoLogico.id" title="Actividad del marco lógico" from="${mies.MarcoLogico.list()}" optionKey="id" value="${asignacionInstance?.marcoLogico?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="asignacion.actividad.label" default="Actividad" />:
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="actividad.id" title="Actividad de gasto corriente" from="${mies.Actividad.list()}" optionKey="id" value="${asignacionInstance?.actividad?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'presupuesto', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="asignacion.presupuesto.label" default="Presupuesto" />:
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="presupuesto.id" title="Partida presupuestaria" from="${mies.Presupuesto.list()}" optionKey="id" value="${asignacionInstance?.presupuesto?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="asignacion.tipoGasto.label" default="Tipo Gasto" />:
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="tipoGasto.id" title="Tipo de gasto o grupo de gasto" from="${mies.TipoGasto.list()}" optionKey="id" value="${asignacionInstance?.tipoGasto?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'planificado', 'error')}">
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="asignacion.planificado.label" default="Planificado" />:
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class=" mandatory" valign="middle">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="planificado" title="Planificado" id="planificado" value="${fieldValue(bean: asignacionInstance, field: 'planificado')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="asignacion.redistribucion.label" default="Redistribucion" />:
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class=" mandatory" valign="middle">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="redistribucion" title="redistribuido (en + o en – según aumente o disminuya la asignación), lo asignado_real = valor_asignado + redistribuido." id="redistribucion" value="${fieldValue(bean: asignacionInstance, field: 'redistribucion')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                                 <tr>
                            <td colspan="6" class="blanco">&nbsp;</td>
                        </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="6" class="buttons" style="text-align: right;">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="default.button.update.label" default="Update" />
                            </a>
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
                var myForm = $(".frmAsignacion");

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