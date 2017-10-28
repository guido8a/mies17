
<%@ page import="mies.IndicadoresSenplades" %>
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
                        %{--<g:message code="default.list.label" args="${['IndicadoresSemplades']}" default="IndicadoresSemplades List" />--}%
                    %{--</g:link>--}%
                %{--</div>--}%

                    <g:if test="${flash.message}">
                        <div class="message ui-state-highlight ui-corner-all">
                            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
                        </div>
                    </g:if>
                    <g:hasErrors bean="${indicadoresSempladesInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${indicadoresSempladesInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmIndicadoresSemplades"
                            method="post"  >
                        <g:hiddenField name="id" value="${indicadoresSempladesInstance?.id}" />
                        <g:hiddenField name="version" value="${indicadoresSempladesInstance?.version}" />

                        <table width="100%" class="ui-widget-content ui-corner-all">

                            <thead>
                                <tr>
                                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                        <g:if test="${source == 'edit'}">
                                            <g:message code="default.edit.legend" args="${['IndicadoresSemplades']}" default="Edit IndicadoresSemplades details"/>
                                        </g:if>
                                        <g:else>
                                            <g:message code="default.create.legend" args="${['IndicadoresSemplades']}" default="Enter IndicadoresSemplades details"/>
                                        </g:else>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                    
                    
                    <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'proyecto', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="indicadoresSemplades.proyecto.label" default="Proyecto" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="${IndicadoresSemplades.constraints.proyecto.attributes.mensaje}" from="${mies.Proyecto.list()}" optionKey="id" value="${indicadoresSempladesInstance?.proyecto?.id}" noSelection="['null': '']" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.tasaAnalisisFinanciero.label" default="Tasa Analisis Financiero" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="tasaAnalisisFinanciero" title="${IndicadoresSemplades.constraints.tasaAnalisisFinanciero.attributes.mensaje}" id="tasaAnalisisFinanciero" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaAnalisisFinanciero')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'valorActualNeto', 'error')}">
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.valorActualNeto.label" default="Valor Actual Neto" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="valorActualNeto" title="${IndicadoresSemplades.constraints.valorActualNeto.attributes.mensaje}" id="valorActualNeto" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'valorActualNeto')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.tasaInternaDeRetorno.label" default="Tasa Interna De Retorno" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="tasaInternaDeRetorno" title="${IndicadoresSemplades.constraints.tasaInternaDeRetorno.attributes.mensaje}" id="tasaInternaDeRetorno" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetorno')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaAnalisisEconomico', 'error')}">
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.tasaAnalisisEconomico.label" default="Tasa Analisis Economico" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="tasaAnalisisEconomico" title="${IndicadoresSemplades.constraints.tasaAnalisisEconomico.attributes.mensaje}" id="tasaAnalisisEconomico" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaAnalisisEconomico')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.valorActualNetoEconomico.label" default="Valor Actual Neto Economico" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="valorActualNetoEconomico" title="${IndicadoresSemplades.constraints.valorActualNetoEconomico.attributes.mensaje}" id="valorActualNetoEconomico" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'valorActualNetoEconomico')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetornoEconomico', 'error')}">
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.tasaInternaDeRetornoEconomico.label" default="Tasa Interna De Retorno Economico" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="tasaInternaDeRetornoEconomico" title="${IndicadoresSemplades.constraints.tasaInternaDeRetornoEconomico.attributes.mensaje}" id="tasaInternaDeRetornoEconomico" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetornoEconomico')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    
                    
                        <td class="label  mandatory" valign="middle">
                            <g:message code="indicadoresSemplades.costoBeneficio.label" default="Costo Beneficio" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                        <td class="indicator mandatory">
                            <span class="indicator">*</span>
                        </td>
                        <td class="campo mandatory" valign="middle">
                            <g:textField class="field required ui-widget-content ui-corner-all" name="costoBeneficio" title="${IndicadoresSemplades.constraints.costoBeneficio.attributes.mensaje}" id="costoBeneficio" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'costoBeneficio')}" />
                            %{--<span class="indicator">*</span>--}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'pierdePais', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="indicadoresSemplades.pierdePais.label" default="Pierde Pais" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="pierdePais" id="pierdePais" title="${IndicadoresSemplades.constraints.pierdePais.attributes.mensaje}" cols="40" rows="5" value="${indicadoresSempladesInstance?.pierdePais}" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="indicadoresSemplades.impactos.label" default="Impactos" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="impactos" id="impactos" title="${IndicadoresSemplades.constraints.impactos.attributes.mensaje}" cols="40" rows="5" value="${indicadoresSempladesInstance?.impactos}" />
                            %{----}%
                        </td>
                    
                    </tr>
                    
                    
                    
                    <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'metodologia', 'error')}">
                    
                        <td class="label " valign="middle">
                            <g:message code="indicadoresSemplades.metodologia.label" default="Metodologia" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="metodologia" id="metodologia" title="${IndicadoresSemplades.constraints.metodologia.attributes.mensaje}" cols="40" rows="5" value="${indicadoresSempladesInstance?.metodologia}" />
                            %{----}%
                        </td>
                    
                    
                    
                        <td class="label " valign="middle">
                            <g:message code="indicadoresSemplades.observaciones.label" default="Observaciones" />
                            %{----}%
                        </td>
                        <td class="indicator">
                            &nbsp;
                        </td>
                        <td class="campo" valign="middle">
                            <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="observaciones" id="observaciones" title="${IndicadoresSemplades.constraints.observaciones.attributes.mensaje}" cols="40" rows="5" value="${indicadoresSempladesInstance?.observaciones}" />
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
                            <g:link class="button delete" action="delete" id="${indicadoresSempladesInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${indicadoresSempladesInstance?.id}">
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
                var myForm = $(".frmIndicadoresSemplades");

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