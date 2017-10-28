<%@ page import="mies.Avance" %>
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

    <title>Avance</title>
</head>

<body>
<div class="dialog">


    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${avance}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${avance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form class="frmAvance" action="registrarAvance" event="siguiente"  method="post">

        <table style="width: 800px;" class="show ui-widget-content ui-corner-all">

            <tbody>
            <tr>
                <td colspan="6" class="blanco">&nbsp;</td>
            </tr>
            <tr class="prop ${hasErrors(bean: avance, field: 'informe', 'error')}">
                 <td class="label  mandatory" valign="middle">
                    <g:message code="avance.valor.label" default="Valor"/>:
                    %{--<span class="indicator">*</span>--}%
                </td>
                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>
                <td class=" mandatory" valign="middle">
                    <g:textField class="field number required ui-widget-content ui-corner-all" name="valor"
                                 title="valor" id="valor" value="${fieldValue(bean: avance, field: 'valor')}"/>
                    %{--<span class="indicator">*</span>--}%
                </td>

            </tr>
            <tr class="prop ${hasErrors(bean: avance, field: 'descripcion', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="avance.descripcion.label" default="Descripcion"/>:
                    %{----}%
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="" valign="middle">
                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="descripcion"
                                id="tasa" title="tasa" cols="40" rows="5" value="${avance?.descripcion}" style="width: 700px"/>
                    %{----}%
                </td>

            </tr>


            <tr>
                <td colspan="6" class="blanco">&nbsp;</td>
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
    $(function() {
        var myForm = $(".frmAvance");

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