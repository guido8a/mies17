<%@ page import="mies.BeneficioSenplades" %>
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

    <title>Beneficios Semplades</title>
</head>

<body>
<div class="dialog" title="Beneficios Semplades">

    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${beneficioSempladesInstance}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${beneficioSempladesInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="semplades" event="guardarBeneficios" class="frmBeneficioSemplades"
            method="post">
        <g:hiddenField name="id" value="${beneficioSempladesInstance?.id}"/>
        <g:hiddenField name="version" value="${beneficioSempladesInstance?.version}"/>

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

        <table width="100%" class="ui-widget-content ui-corner-all"  style="margin-top: 10px;">

            <thead>
                <tr>
                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                        <g:if test="${source == 'edit'}">
                            <g:message code="default.edit.legend" args="${['BeneficioSemplades']}"
                                       default="Edit BeneficioSemplades details"/>
                        </g:if>
                        <g:else>
                            <g:message code="default.create.legend" args="${['BeneficioSemplades']}"
                                       default="Enter BeneficioSemplades details"/>
                        </g:else>
                    </td>
                </tr>
            </thead>
            <tbody>

                <tr><td colspan="6"> &nbsp;</td></tr>
                <tr class="prop ${hasErrors(bean: beneficioSempladesInstance, field: 'proyecto', 'error')}">

                    <td class="etiqueta" valign="middle">
                        <g:message code="beneficioSemplades.beneficiariosDirectosHombres.label"
                                   default="Beneficiarios Directos Hombres"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="beneficiariosDirectosHombres" id="beneficiariosDirectosHombres"
                                     title="${BeneficioSenplades.constraints.beneficiariosDirectosHombres.attributes.mensaje}"
                                     class="field digits ui-widget-content ui-corner-all"
                                     value="${beneficioSempladesInstance?.beneficiariosDirectosHombres}"/>
                        %{----}%
                    </td>

                    <td class="etiqueta" valign="middle">
                        <g:message code="beneficioSemplades.beneficiariosIndirectosHombres.label"
                                   default="Beneficiarios Indirectos Hombres"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="beneficiariosIndirectosHombres" id="beneficiariosIndirectosHombres"
                                     title="${BeneficioSenplades.constraints.beneficiariosIndirectosHombres.attributes.mensaje}"
                                     class="field digits ui-widget-content ui-corner-all"
                                     value="${beneficioSempladesInstance?.beneficiariosIndirectosHombres}"/>
                        %{----}%
                    </td>

                </tr>



                <tr class="prop ${hasErrors(bean: beneficioSempladesInstance, field: 'beneficiariosDirectosMujeres', 'error')}">

                    <td class="etiqueta" valign="middle">
                        <g:message code="beneficioSemplades.beneficiariosDirectosMujeres."
                                   default="Beneficiarios Directos Mujeres"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="beneficiariosDirectosMujeres" id="beneficiariosDirectosMujeres"
                                     title="${BeneficioSenplades.constraints.beneficiariosDirectosMujeres.attributes.mensaje}"
                                     class="field digits ui-widget-content ui-corner-all"
                                     value="${beneficioSempladesInstance?.beneficiariosDirectosMujeres}"/>
                        %{----}%
                    </td>

                    <td class="etiqueta" valign="middle">
                        <g:message code="beneficioSemplades.beneficiariosIndirectosMujeres.label"
                                   default="Beneficiarios Indirectos Mujeres"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="beneficiariosIndirectosMujeres" id="beneficiariosIndirectosMujeres"
                                     title="${BeneficioSenplades.constraints.beneficiariosIndirectosMujeres.attributes.mensaje}"
                                     class="field digits ui-widget-content ui-corner-all"
                                     value="${beneficioSempladesInstance?.beneficiariosIndirectosMujeres}"/>
                        %{----}%
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

        var myForm = $(".frmBeneficioSemplades");

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
        });
        //fin de la validacion del formulario

        $(".save").button({ icons: { primary:'ui-icon-disk' } }).click(function() {
//                            //console.log(myForm);
//                            //console.log(myForm.attr("action"));
            myForm.submit();
            return false;
        });

        $(".salir").button({icons: {primary:'ui-icon-arrowreturnthick-1-w'}});
    });
</script>

</body>
</html>