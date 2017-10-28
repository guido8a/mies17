<%@ page import="mies.Informe" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>

    <script type="text/javascript"  src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"  src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
    <script type="text/javascript"  src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>
    <script type="text/javascript"  src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/slider', file: 'selectToUISlider.jQuery.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/slider', file: 'ui.slider.extras.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/ckeditor', file: 'ckeditor.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/ckeditor/adapters', file: 'jquery.js')}"></script>

    <title>Informe de avance</title>


    <style type="text/css">
    .prct {
        width: 250px;
    }
    </style>

</head>

<body>
<div class="dialog">

    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${informe}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${informe}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="registrarAvance" event="siguiente" class="frmInforme"  method="post">

        <table width="100%" class="ui-widget-content ui-corner-all">

            <tbody>

                <tr class="prop ${hasErrors(bean: informe, field: 'responsableProyecto', 'error')}">

                    <td class="label " valign="middle">
                       Responsable
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        ${responsable.responsable.usroLogin}
                        <input type="hidden" name="responsableProyecto.id" value="${responsable.id}">
                    </td>



                    <td class="label " valign="middle">
                        <g:message code="informe.tipo.label" default="Tipo"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        Informe de avance
                        <input type="hidden" name="tipo.id" value="3">
                        %{----}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informe, field: 'fecha', 'error')}" style="height: 50px;">

                    <td class="label " valign="middle">
                        <g:message code="informe.fecha.label" default="Fecha"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                       ${new Date().format("dd/MM/yyyy")}
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="informe.porcentaje.label" default="Porcentaje"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <div class="prct" style="float: left;">
                            <g:select from="${0..100}" name="porcentaje" id="prc"
                                      value="${informe?.porcentaje ? informe?.porcentaje : 0}"/>
                        </div>

                        <div id="porc" style="width: 250px; float: left;"></div>

                        <div id="valPrct"
                             style="float: left; margin-left: 10px; margin-top: -2px; font-family: 'Courier New'; width: 30px;"></div>
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informe, field: 'link', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="informe.link.label" default="Link"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textField name="link" id="link" title="link" class="field ui-widget-content ui-corner-all"
                                     minLenght="1" maxLenght="127" value="${informe?.link}" style="width: 915px;"/>
                        %{----}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informe, field: 'dificultades', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="informe.dificultades.label" default="Dificultades"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                    name="dificultades" id="dificultades" title="dificultades" cols="40" rows="5"
                                    value="${informe?.dificultades}"/>
                        %{----}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informe, field: 'avance', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="informe.avance.label" default="Avance"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                    name="avance" id="avance" title="avance" cols="40" rows="5"
                                    value="${informe?.avance}"/>
                        %{----}%
                    </td>

                </tr>

            </tbody>
            <tfoot>
                <tr>
                    <td colspan="6" class="buttons" style="text-align: right;">
                        <g:submitButton name="siguiente" value="Siguiente" event="siguiente" class="button"/>
                    </td>
                </tr>
            </tfoot>
        </table>
    </g:form>

</div>

<script type="text/javascript">
    //a custom format option callback
    var proyectoFormatting = function(text) {
        var newText = text;
        //array of find replaces
        var findreps = [
            {find:/^([^\-]+) \- /g, rep: '<span class="ui-selectmenu-item-header">$1</span>'},
            {find:/([^\|><]+) \ /g, rep: '<span class="ui-selectmenu-item-content">$1</span>'}
        ];

        for (var i in findreps) {
            newText = newText.replace(findreps[i].find, findreps[i].rep);
        }
        return newText;
    }

    function dec2hex(d) {
        return d.toString(16);
    }
    function hex2dec(h) {
        return parseInt(h, 16);
    }

    function refreshPrct() {
        var porc = $("#porc").slider("value");
        var r = {
            r: 239,
            g: 41,
            b: 41
        };
        var g = {
            r: 138,
            g: 226,
            b: 52
        };
        var dr = Math.abs(r.r - g.r);
        var dg = Math.abs(r.g - g.g);
        var db = Math.abs(r.b - g.b);

        var pr = dr / 100;
        var pg = dg / 100;
        var pb = db / 100;

        var nr = r.r - (porc * pr);
        var ng = r.g + (porc * pg);
        var nb = r.b + (porc * pb);

        var hex = "#" + dec2hex(Math.round(nr)) + dec2hex(Math.round(ng)) + dec2hex(Math.round(nb))

        $("#porc").find(".ui-slider-range, .ui-slider-handle").css({
            background: hex,
            borderColor: "black"
        });

        $("#prc").val(porc);
        $("#valPrct").text(str_pad(porc, 3, ' ', 'STR_PAD_LEFT') + "%");
    }

    $(function() {

        $('textarea').ckeditor(function() { /* callback code */
                },
                {
                    customConfig : '${resource(dir: 'js/jquery/plugins/ckeditor', file: 'config_min.js')}'
                });


        $("#porc").slider({
            orientation: "horizontal",
            range: "min",
            max: 100,
            slide: refreshPrct,
            change: refreshPrct,
            value: $("#prc").val()
        });
        $('#prc').hide();

        refreshPrct();



        var myForm = $(".frmInforme");

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

</body>
</html>