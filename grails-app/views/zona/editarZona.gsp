<%@ page import="mies.Zona" %>

<g:form action="save" class="frm_editar"
        method="post">
    <g:hiddenField name="id" value="${zonaInstance?.id}"/>
    <g:hiddenField name="version" value="${zonaInstance?.version}"/>
    <g:hiddenField name="tipo" value="${tipo}"/>

    <table width="100%" class="ui-widget-content ui-corner-all">

        <tbody>

            <tr class="prop ${hasErrors(bean: zonaInstance, field: 'numero', 'error')}">
                <td class="label " valign="middle">
                    <g:message code="zona.numero.label" default="Numero"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="numero" id="numero" title="${Zona.constraints.numero.attributes.mensaje}"
                                 class="field number ui-widget-content ui-corner-all" value="${zonaInstance?.numero}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="zona.nombre.label" default="Nombre"/>
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="nombre" id="nombre" title="${Zona.constraints.nombre.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                 value="${zonaInstance?.nombre}"/>
                </td>
            </tr>

        </tbody>
    </table>
</g:form>


<script type="text/javascript">
    $(function() {
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