<%@ page import="mies.IndicadoresSenplades" %>
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

    <title>Indicadores Semplades</title>
</head>

<body>
<div class="dialog" title="Indicadores Semplades">

<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${indicadoresSempladesInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${indicadoresSempladesInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form action="semplades" event="guardarIndicadores" class="frmIndicadoresSenplades"
        method="post">
<g:hiddenField name="id" value="${indicadoresSempladesInstance?.id}"/>
<g:hiddenField name="version" value="${indicadoresSempladesInstance?.version}"/>

<mf:menuSemplades items='${items}'/>

<div style="margin: 10px 0 10px 0; padding: 5px;"
     class="${saved ? 'ui-state-highlight' : (error ? 'ui-state-error' : '')} ui-corner-all ${(saved || error) ? '' : 'ui-helper-hidden'}"
     id="divOk">
    <p>
        <span style="float: left; margin-right: .3em;"
              class="ui-icon ui-icon-${saved ? 'circle-check' : (error ? 'alert' : '')}"></span>
        <strong>${message}</strong>
    </p>
</div>

<table width="100%" class="ui-widget-content ui-corner-all">

    <thead>
        <tr>
            <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                Detalles de Indicadores Semplades
            </td>
        </tr>
    </thead>
    <tbody>

        <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'proyecto', 'error')}">
            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.tasaAnalisisFinanciero.label"
                           default="Tasa de Análisis Financiero"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all" name="tasaAnalisisFinanciero"
                             title="${IndicadoresSenplades.constraints.tasaAnalisisFinanciero.attributes.mensaje}"
                             id="tasaAnalisisFinanciero"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaAnalisisFinanciero')}"
                             style="width: 100px;"/>
            </td>
        </tr>

        <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'valorActualNeto', 'error')}">
            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.valorActualNeto.label" default="Valor Actual Neto"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all" name="valorActualNeto"
                             title="${IndicadoresSenplades.constraints.valorActualNeto.attributes.mensaje}"
                             id="valorActualNeto" style="width: 100px;"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'valorActualNeto')}"/>
            </td>

            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.tasaInternaDeRetorno.label" default="Tasa Interna De Retorno"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all" name="tasaInternaDeRetorno"
                             title="${IndicadoresSenplades.constraints.tasaInternaDeRetorno.attributes.mensaje}"
                             id="tasaInternaDeRetorno" style="width: 100px;"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetorno')}"/>
            </td>
        </tr>

        <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaAnalisisEconomico', 'error')}">
            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.tasaAnalisisEconomico.label"
                           default="Tasa de Análisis Económico"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all" name="tasaAnalisisEconomico"
                             title="${IndicadoresSenplades.constraints.tasaAnalisisEconomico.attributes.mensaje}"
                             id="tasaAnalisisEconomico" style="width: 100px;"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaAnalisisEconomico')}"/>
            </td>

            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.valorActualNetoEconomico.label"
                           default="Valor Actual Neto Económico"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all"
                             name="valorActualNetoEconomico"
                             title="${IndicadoresSenplades.constraints.valorActualNetoEconomico.attributes.mensaje}"
                             id="valorActualNetoEconomico" style="width: 100px;"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'valorActualNetoEconomico')}"/>
            </td>
        </tr>

        <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetornoEconomico', 'error')}">
            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.tasaInternaDeRetornoEconomico.label"
                           default="Tasa Interna De Retorno Económico"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all"
                             name="tasaInternaDeRetornoEconomico"
                             title="${IndicadoresSenplades.constraints.tasaInternaDeRetornoEconomico.attributes.mensaje}"
                             id="tasaInternaDeRetornoEconomico" style="width: 100px;"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetornoEconomico')}"/>
            </td>

            <td class="label  mandatory" valign="middle">
                <g:message code="IndicadoresSenplades.costoBeneficio.label" default="Costo Beneficio"/>
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class="mandatory" valign="middle">
                <g:textField class="field required number ui-widget-content ui-corner-all" name="costoBeneficio"
                             title="${IndicadoresSenplades.constraints.costoBeneficio.attributes.mensaje}"
                             id="costoBeneficio" style="width: 100px;"
                             value="${fieldValue(bean: indicadoresSempladesInstance, field: 'costoBeneficio')}"/>
            </td>
        </tr>

        <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'pierdePais', 'error')}">
            <td class="label " valign="middle">
                <g:message code="IndicadoresSenplades.pierdePais.label" default="Pierde Pais"/>
            </td>
            <td class="indicator">
                &nbsp;
            </td>
            <td valign="middle">
                <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                            name="pierdePais" cols="40" rows="3" style="width: 400px;"
                            id="pierdePais" title="${IndicadoresSenplades.constraints.pierdePais.attributes.mensaje}"
                            value="${indicadoresSempladesInstance?.pierdePais}"/>
            </td>

            <td class="label " valign="middle">
                <g:message code="IndicadoresSenplades.impactos.label" default="Impactos"/>
            </td>
            <td class="indicator">
                &nbsp;
            </td>
            <td valign="middle">
                <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="impactos"
                            id="impactos" title="${IndicadoresSenplades.constraints.impactos.attributes.mensaje}"
                            cols="40" rows="3" style="width: 400px;"
                            value="${indicadoresSempladesInstance?.impactos}"/>
            </td>
        </tr>

        <tr class="prop ${hasErrors(bean: indicadoresSempladesInstance, field: 'metodologia', 'error')}">
            <td class="label " valign="middle">
                <g:message code="IndicadoresSenplades.metodologia.label" default="Metodología"/>
            </td>
            <td class="indicator">
                &nbsp;
            </td>
            <td valign="middle">
                <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                            name="metodologia" cols="40" rows="3" style="width: 400px;"
                            id="metodologia" title="${IndicadoresSenplades.constraints.metodologia.attributes.mensaje}"
                            value="${indicadoresSempladesInstance?.metodologia}"/>
            </td>

            <td class="label " valign="middle">
                <g:message code="IndicadoresSenplades.observaciones.label" default="Observaciones"/>
            </td>
            <td class="indicator">
                &nbsp;
            </td>
            <td valign="middle">
                <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                            name="observaciones"
                            id="observaciones"
                            title="${IndicadoresSenplades.constraints.observaciones.attributes.mensaje}"
                            cols="40" rows="3" style="width: 400px;"
                            value="${indicadoresSempladesInstance?.observaciones}"/>
            </td>
        </tr>

    </tbody>
    <tfoot>
        <tr>
            <td colspan="6" class="buttons">

                <div class="botones">
                    <div class="botones left">
                        <g:link action="semplades" event="click" params="${['evento': 'salir']}"
                                class="button salir">Salir</g:link>
                    </div>

                    <div class="botones right">
                        <a href="#" class="button save">
                            Guardar
                        </a>
                    </div>
                </div>
            </td>
        </tr>
    </tfoot>
</table>
</g:form>
</div>

<script type="text/javascript">
    function esconder() {
        $("#divOk").hide("slow");
    }

    $(function() {

        if ($("#divOk").is(":visible")) {
            setTimeout("esconder()", 3000);
        }

        var changed = false;

        $("#menu li a").not(".noLink").click(function() {
            if (changed) {
                if (confirm("Hay cambios no guardados que se perderán.\nContinuar?")) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return true;
            }
        });

        $("input").keypress(function() {
            changed = true;
        });


        var myForm = $(".frmIndicadoresSenplades");

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
        $(".salir").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});
        $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
            myForm.submit();
            return false;
        });
    });
</script>

</body>
</html>