<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/11/17
  Time: 11:54
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Informe de solicitud de modificación</title>

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/ckeditor', file: 'ckeditor.js')}"></script>
    %{--<script type="text/javascript"--}%
            %{--src="${resource(dir: 'js/jquery/plugins/ckeditor/adapters', file: 'jquery.js')}"></script>--}%

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
</head>

<body>

<div class="dialog">

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
    <g:form action="guardarInforme" class="frmInforme"  method="post">
        <g:hiddenField name="id" value="${informeInstance?.id}"/>
        <g:hiddenField name="version" value="${informeInstance?.version}"/>

        <table width="100%" class="ui-widget-content ui-corner-all">

            <thead>
            <tr>
                <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                    Informe
                </td>
            </tr>
            </thead>
            <tbody>

            <tr class="prop ${hasErrors(bean: informeInstance, field: 'responsableProyecto', 'error')}">

                <td class="label mandatory" valign="middle">
                    Responsable Proyecto
                    %{----}%
                </td>
                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>
                <td class="" valign="middle">
                    <g:select class="ui-widget-content ui-corner-all required requiredCmb" name="responsableProyecto.id"
                              id="responsable"   from="${resp}" optionKey=""
                              optionValue="" value="${informeInstance?.responsableProyecto?.id}"/>
                    %{----}%
                </td>



                <td class="label " valign="middle">
                    %{--<g:message code="informe.tipo.label" default="Tipo"/>--}%
                    Tipo
                    %{----}%
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    <input type="hidden" name="tipo.id" value="2">
                    ${mies.TipoInforme.get(2).descripcion}
                    %{----}%
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: informeInstance, field: 'fecha', 'error')}" style="height: 50px;">

                <td class="label " valign="middle">
                    %{--<g:message code="informe.fecha.label" default="Fecha"/>--}%
                    Fecha
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
                                 id="fecha" style="width: 120px;"
                                 value="${informeInstance?.fecha?.format('dd-MM-yyyy')}"/>
                </td>



            </tr>

            <tr class="prop ${hasErrors(bean: informeInstance, field: 'link', 'error')}">

                <td class="label " valign="middle">
                    %{--<g:message code="informe.link.label" default="Link"/>--}%
                    Link
                    %{----}%
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle" colspan="4">
                    <g:textField name="link" id="link"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="127" value="${informeInstance?.link}"
                                 style="width: 915px;"/>
                    %{----}%
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: informeInstance, field: 'dificultades', 'error')}">

                <td class="label " valign="middle">
                    %{--<g:message code="informe.dificultades.label" default="Dificultades"/>--}%
                    Dificultades
                    %{----}%
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle" colspan="4">
                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                name="dificultades" id="dificultades"
                                cols="40" rows="3"
                                value="${informeInstance?.dificultades}"/>

                    %{--<textarea name="editor1" id="editor1" rows="10" cols="80">--}%
                    %{--This is my textarea to be replaced with CKEditor.--}%
                    %{--</textarea>--}%

                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: informeInstance, field: 'avance', 'error')}">
                <td class="label " valign="middle">
                    Explicación
                    %{----}%
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle" colspan="4">
                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023"
                                name="avance" id="avance"
                                cols="40" rows="5"
                                value="${informeInstance?.avance}"/>
                    %{----}%
                </td>

            </tr>

            </tbody>
            <tfoot>
            <tr>
                <td colspan="6" class="buttons" style="text-align: right;">

                    <a href="#" class="button save">
                        <g:message code="default.button.create.label" default="Create"/>
                    </a>
                </td>
            </tr>
            </tfoot>
        </table>
    </g:form>
</div>



<script type="text/javascript">

    CKEDITOR.replace( 'dificultades', {
        customConfig : '${resource(dir: 'js/jquery/plugins/ckeditor', file: 'config_min.js')}'
    });


    CKEDITOR.replace( 'avance', {
        customConfig : '${resource(dir: 'js/jquery/plugins/ckeditor', file: 'config_min.js')}'
    });

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
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Seguro?')}")) {
                return true;
            }
            return false;
        });
    });


</script>

</body>
</html>