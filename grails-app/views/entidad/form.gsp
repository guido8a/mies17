
<%@ page import="mies.Entidad" %>
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
                    <g:hasErrors bean="${entidadInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${entidadInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmEntidad"
                            method="post"  >
                        <g:hiddenField name="id" value="${entidadInstance?.id}" />
                        <g:hiddenField name="version" value="${entidadInstance?.version}" />
                    <div>
                        <fieldset class="ui-corner-all">
                            <legend class="ui-widget ui-widget-header ui-corner-all">
                                <g:if test="${source == 'edit'}">
                                    <g:message code="entidad.edit.legend" default="Edit Entidad details"/>
                                </g:if>
                                <g:else>
                                    <g:message code="entidad.create.legend" default="Enter Entidad details"/>
                                </g:else>
                </legend>
                    
                    <div class="prop mandatory ${hasErrors(bean: entidadInstance, field: 'nombre', 'error')}">
                        <label for="nombre">
                            <g:message code="entidad.nombre.label" default="Nombre" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField  name="nombre" id="nombre" title="Nombre de la entidad o ministerio" class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.nombre}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'direccion', 'error')}">
                        <label for="direccion">
                            <g:message code="entidad.direccion.label" default="Direccion" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="direccion" id="direccion" title="Dirección de la entidad o ministerio" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${entidadInstance?.direccion}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'sigla', 'error')}">
                        <label for="sigla">
                            <g:message code="entidad.sigla.label" default="Sigla" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="sigla" id="sigla" title="Sigla identificativa (por ejemplo, MIES)" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="7" value="${entidadInstance?.sigla}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'objetivo', 'error')}">
                        <label for="objetivo">
                            <g:message code="entidad.objetivo.label" default="Objetivo" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="objetivo" id="objetivo" title="Objetivo institucional o de la entidad" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.objetivo}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'telefono', 'error')}">
                        <label for="telefono">
                            <g:message code="entidad.telefono.label" default="Telefono" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="telefono" id="telefono" title="Teléfonos, se los separa con “;”" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.telefono}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'fax', 'error')}">
                        <label for="fax">
                            <g:message code="entidad.fax.label" default="Fax" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="fax" id="fax" title="Números de fax, se los separa con “;”" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.fax}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'email', 'error')}">
                        <label for="email">
                            <g:message code="entidad.email.label" default="Email" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="email" id="email" title="Dirección de correo electrónico institucional" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63" value="${entidadInstance?.email}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: entidadInstance, field: 'observaciones', 'error')}">
                        <label for="observaciones">
                            <g:message code="entidad.observaciones.label" default="Observaciones" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="observaciones" id="observaciones" title="Observaciones" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${entidadInstance?.observaciones}" />
                        </div>
                    </div>
                    

                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="update" default="Update" />
                            </a>
                            <g:link class="button delete" action="delete" id="${entidadInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${entidadInstance?.id}">
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
                var myForm = $(".frmEntidad");

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