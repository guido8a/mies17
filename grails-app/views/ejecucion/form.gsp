
<%@ page import="mies.Ejecucion" %>
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




                <div class="body">
                    <g:if test="${flash.message}">
                        <div class="message ui-state-highlight ui-corner-all">
                            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
                        </div>
                    </g:if>
                    <g:hasErrors bean="${ejecucionInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${ejecucionInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmEjecucion"
                            method="post"  >
                        <g:hiddenField name="id" value="${ejecucionInstance?.id}" />
                        <g:hiddenField name="version" value="${ejecucionInstance?.version}" />
                    <div>
                        <fieldset class="ui-corner-all">
                            <legend class="ui-widget ui-widget-header ui-corner-all">
                                <g:if test="${source == 'edit'}">
                                    <g:message code="ejecucion.edit.legend" default="Edit Ejecucion details"/>
                                </g:if>
                                <g:else>
                                    <g:message code="ejecucion.create.legend" default="Enter Ejecucion details"/>
                                </g:else>
                </legend>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'asignacion', 'error')}">
                        <label for="asignacion">
                            <g:message code="ejecucion.asignacion.label" default="Asignacion" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="asignacion.id" title="Asignacion" from="${mies.Asignacion.list()}" optionKey="id" value="${ejecucionInstance?.asignacion?.id}"  />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'compromiso', 'error')}">
                        <label for="compromiso">
                            <g:message code="ejecucion.compromiso.label" default="Compromiso" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="compromiso" title="Compromiso" id="compromiso" value="${fieldValue(bean: ejecucionInstance, field: 'compromiso')}" />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'devengado', 'error')}">
                        <label for="devengado">
                            <g:message code="ejecucion.devengado.label" default="Devengado" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="devengado" title="Devengado" id="devengado" value="${fieldValue(bean: ejecucionInstance, field: 'devengado')}" />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'pagado', 'error')}">
                        <label for="pagado">
                            <g:message code="ejecucion.pagado.label" default="Pagado" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="pagado" title="Pagado" id="pagado" value="${fieldValue(bean: ejecucionInstance, field: 'pagado')}" />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'saldoDisponible', 'error')}">
                        <label for="saldoDisponible">
                            <g:message code="ejecucion.saldoDisponible.label" default="Saldo Disponible" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="saldoDisponible" title="SaldoDisponible" id="saldoDisponible" value="${fieldValue(bean: ejecucionInstance, field: 'saldoDisponible')}" />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'saldoPresupuesto', 'error')}">
                        <label for="saldoPresupuesto">
                            <g:message code="ejecucion.saldoPresupuesto.label" default="Saldo Presupuesto" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="saldoPresupuesto" title="SaldoPresupuesto" id="saldoPresupuesto" value="${fieldValue(bean: ejecucionInstance, field: 'saldoPresupuesto')}" />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'sigef', 'error')}">
                        <label for="sigef">
                            <g:message code="ejecucion.sigef.label" default="Sigef" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="sigef.id" title="Sigef" from="${mies.Sigef.list()}" optionKey="id" value="${ejecucionInstance?.sigef?.id}"  />
                        </div>
                    </div>
                    
                    <div class="prop mandatory ${hasErrors(bean: ejecucionInstance, field: 'vigente', 'error')}">
                        <label for="vigente">
                            <g:message code="ejecucion.vigente.label" default="Vigente" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="vigente" title="Vigente" id="vigente" value="${fieldValue(bean: ejecucionInstance, field: 'vigente')}" />
                        </div>
                    </div>
                    

                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="update" default="Update" />
                            </a>
                            <g:link class="button delete" action="delete" id="${ejecucionInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${ejecucionInstance?.id}">
                                <g:message code="default.button.show.label" default="Show" />
                            </g:link>
                        </g:if>
                        <g:else>
                            <a href="#" class="button save">
                                <g:message code="create" default="Create" />
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
                var myForm = $(".frmEjecucion");

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