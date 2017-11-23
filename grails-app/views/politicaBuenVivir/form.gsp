<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/11/17
  Time: 12:14
--%>


<%@ page import="mies.PoliticaBuenVivir" %>
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

    <title>Editar Política del Buen Vivir</title>
</head>

<body>
<div class="dialog">


    <div class="body">
        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">
                <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
            </div>
        </g:if>
        <g:hasErrors bean="${politicaBuenVivirInstance}">
            <div class="errors ui-state-error ui-corner-all">
                <g:renderErrors bean="${politicaBuenVivirInstance}" as="list" />
            </div>
        </g:hasErrors>
        <g:form action="save" class="frmPoliticaBuenVivir"
                method="post"  >
            <g:hiddenField name="id" value="${politicaBuenVivirInstance?.id}"/>
            <g:hiddenField name="version" value="${politicaBuenVivirInstance?.version}" />
            <div>
                <fieldset class="ui-corner-all" style="width: 1000px">
                    <legend class="ui-widget ui-widget-header ui-corner-all">
                        Política del Buen Vivir
                    </legend>

                    <div class="prop mandatory ${hasErrors(bean: politicaBuenVivirInstance, field: 'objetivo', 'error')}">
                        <label>
                            Objetivo
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:select class="field required requiredCmb ui-widget-content ui-corner-all"
                                      style="width: 800px" name="objetivo.id" title="Objetivo del buen vivir" from="${mies.ObjetivoBuenVivir.list()}"
                                      optionKey="id" value="${politicaBuenVivirInstance?.objetivo?.id}"  />
                        </div>
                    </div>

                    <div class="prop mandatory ${hasErrors(bean: politicaBuenVivirInstance, field: 'codigo', 'error')}">
                        <label for="codigo">
                            Código
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="codigo" title="Código de la política" id="codigo" value="${fieldValue(bean: politicaBuenVivirInstance, field: 'codigo')}" />
                        </div>
                    </div>

                    <div class="prop ${hasErrors(bean: politicaBuenVivirInstance, field: 'descripcion', 'error')}">
                        <label for="descripcion">
                            Descripción
                        </label>
                        <div class="campo">
                            <g:textField  name="descripcion" id="descripcion" style="width: 800px" title="Descripción de la política" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${politicaBuenVivirInstance?.descripcion}" />
                        </div>
                    </div>

                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                Guardar
                            </a>
                            <g:link class="button delete" action="delete" id="${politicaBuenVivirInstance?.id}">
                                Eliminar
                            </g:link>
                            <g:link class="button show" action="show" id="${politicaBuenVivirInstance?.id}">
                                Detalles
                            </g:link>
                        </g:if>
                        <g:else>
                            <a href="#" class="button save">
                                Guardar
                            </a>
                        </g:else>
                    </div>

                </fieldset>
            </div>
        </g:form>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        var myForm = $(".frmPoliticaBuenVivir");

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
            if(confirm("está seguro de eliminar la Política del Buen Vivir?")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>