<%@ page import="mies.Informe" %>
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
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/slider', file: 'selectToUISlider.jQuery.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/slider', file: 'ui.slider.extras.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/ckeditor', file: 'ckeditor.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/ckeditor/adapters', file: 'jquery.js')}"></script>

    <title>${title}</title>


    <style type="text/css">
    .prct {
        width : 250px;
    }
    </style>

</head>

<body>
<div class="dialog">

%{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
%{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
%{--<g:message code="default.home.label" default="Home" />--}%
%{--</a>--}%
%{--<g:link class="button list" action="list">--}%
%{--<g:message code="default.list.label" args="${['Informe']}" default="Informe List" />--}%
%{--</g:link>--}%
%{--</div>--}%

    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${informeInstance}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${informeInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" class="frmInforme"
            method="post">
        <g:hiddenField name="id" value="${informeInstance?.id}"/>
        <g:hiddenField name="version" value="${informeInstance?.version}"/>

        <table width="100%" class="ui-widget-content ui-corner-all">

            <thead>
                <tr>
                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                        <g:if test="${source == 'edit'}">
                            <g:message code="default.edit.legend" args="${['Informe']}" default="Editar detalles"/>
                        </g:if>
                        <g:else>
                            <g:message code="default.create.legend" args="${['Informe']}"
                                       default="Detalles del informe"/>
                        </g:else>
                    </td>
                </tr>
            </thead>
            <tbody>

                <tr class="prop ${hasErrors(bean: informeInstance, field: 'responsableProyecto', 'error')}">

                    <td class="label mandatory" valign="middle">
                        <g:message code="informe.responsableProyecto.label" default="Responsable Proyecto"/>
                        %{----}%
                    </td>
                    <td class="indicator mandatory">
                        <span class="indicator">*</span>
                    </td>
                    <td class="" valign="middle">
                        <g:select class="ui-widget-content ui-corner-all required requiredCmb" name="responsableProyecto.id"
                                  id="responsable" title="${Informe.constraints.responsableProyecto.attributes.mensaje}"
                                  from="${resps}" optionKey="id"
                                  optionValue="texto" value="${informeInstance?.responsableProyecto?.id}"/>
                        %{----}%
                    </td>



                    <td class="label " valign="middle">
                        <g:message code="informe.tipo.label" default="Tipo"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="tipo.id"
                                  title="${Informe.constraints.tipo.attributes.mensaje}"
                                  from="${mies.TipoInforme.findAll('from TipoInforme where id <> 2')}" optionKey="id" optionValue="descripcion"
                                  value="${informeInstance?.tipo?.id}" id="tipo"/>
                        %{----}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informeInstance, field: 'fecha', 'error')}" style="height: 50px;">

                    <td class="label " valign="middle">
                        <g:message code="informe.fecha.label" default="Fecha"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <input type="hidden" value="date.struct" name="fecha">
                        <input type="hidden" name="fecha_day" id="fecha_day"
                               value="${informeInstance?.fecha?.format('dd')}">
                        <input type="hidden" name="fecha_month" id="fecha_month"
                               value="${informeInstance?.fecha?.format('MM')}">
                        <input type="hidden" name="fecha_year" id="fecha_year"
                               value="${informeInstance?.fecha?.format('yyyy')}">
                        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha"
                                     title="${Informe.constraints.fecha.attributes.mensaje}"
                                     id="fecha" style="width: 120px;"
                                     value="${informeInstance?.fecha?.format('dd-MM-yyyy')}"/>
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="informe.porcentaje.label" default="Porcentaje"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle">
                        <div id="porc" style="width: 250px; float: left;"></div>

                        <div style="float: left; margin-left: 15px; margin-top: -8px;">
                            <g:select from="${0..100}" name="porcentaje" id="prc"
                                      value="${informeInstance?.porcentaje ? informeInstance?.porcentaje : 0}"/>
                        </div>
                        <span>%</span>

                        %{--<div id="valPrct"--}%
                        %{--style="float: left; margin-left: 10px; margin-top: -2px; font-family: 'Courier New'; width: 30px;"></div>--}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informeInstance, field: 'link', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="informe.link.label" default="Link"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textField name="link" id="link" title="${Informe.constraints.link.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all"
                                     minLenght="1" maxLenght="127" value="${informeInstance?.link}"
                                     style="width: 915px;"/>
                        %{----}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informeInstance, field: 'dificultades', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="informe.dificultades.label" default="Dificultades"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                    name="dificultades" id="dificultades"
                                    title="${Informe.constraints.dificultades.attributes.mensaje}" cols="40" rows="3"
                                    value="${informeInstance?.dificultades}"/>
                        %{----}%
                    </td>

                </tr>

                <tr class="prop ${hasErrors(bean: informeInstance, field: 'avance', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="informe.avance.label" default="Avance"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                    name="avance" id="avance" title="${Informe.constraints.avance.attributes.mensaje}"
                                    cols="40" rows="5"
                                    value="${informeInstance?.avance}"/>
                        %{----}%
                    </td>

                </tr>

            </tbody>
            <tfoot>
                <tr>
                    <td colspan="6" class="buttons" style="text-align: right;">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="default.button.update.label" default="Update"/>
                            </a>
                            <g:link class="button delete" action="delete" id="${informeInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete"/>
                            </g:link>
                            <g:link class="button show" action="show" id="${informeInstance?.id}">
                                <g:message code="default.button.show.label" default="Show"/>
                            </g:link>
                        </g:if>
                        <g:else>
                            <a href="#" class="button save">
                                <g:message code="default.button.create.label" default="Create"/>
                            </a>
                        </g:else>
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

    function calcColor(porc) {
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

        var hex = "#" + dec2hex(Math.round(nr)) + dec2hex(Math.round(ng)) + dec2hex(Math.round(nb));
        return hex;
    }

    function refreshPrct() {
        var porc = $("#porc").slider("value");
        $("#porc").find(".ui-slider-range, .ui-slider-handle").css({
            background: calcColor(porc),
            borderColor: "black"
        });
        $("#prc").val(porc);
    }

    function changePrct() {
        var porc = $("#prc").val();
        $("#porc").find(".ui-slider-range, .ui-slider-handle").css({
            background: calcColor(porc),
            borderColor: "black"
        });
        $("#porc").slider("option", "value", porc);
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


        $("#prc").change(function() {
            changePrct();
        });

        refreshPrct();

        /***********************************************/
        $('#responsable').selectmenu({
            width: 250,
            format: proyectoFormatting
        });
        $('#tipo').selectmenu({
            width: 250
        });

//        $('#prc').selectToUISlider({
//            labels: 5,
//            sliderOptions: {
//                slide: function(event, ui) {
//                    var thisHandle = jQuery(ui.handle);
//                    //handle feedback
//                    var textval = ui.value;
//                    thisHandle
//                            .attr('aria-valuetext', textval)
//                            .attr('aria-valuenow', ui.value)
//                            .find('.ui-slider-tooltip .ttContent')
//                            .text(textval);
//
//                    //control original select menu
//                    var currSelect = jQuery('#' + thisHandle.attr('id').split('handle_')[1]);
//                    currSelect.find('option').eq(ui.value).attr('selected', 'selected');
//
//                    $("#valPrct").text(textval);
//                }
//            }
//        })/*.hide()*/;
        /************************************************/


        $('#fecha').datepicker({
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
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
        $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
        $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
            myForm.submit();
            return false;
        });
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>