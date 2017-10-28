
<%@ page import="mies.ObjetivoEstrategico" %>
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
                    <g:hasErrors bean="${objetivoEstrategicoInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${objetivoEstrategicoInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmObjetivoEstrategico"
                            method="post"  >
                        <g:hiddenField name="id" value="${objetivoEstrategicoInstance?.id}" />
                        <g:hiddenField name="version" value="${objetivoEstrategicoInstance?.version}" />
                    <div>
                        <fieldset class="ui-corner-all">
                            <legend class="ui-widget ui-widget-header ui-corner-all">
                                <g:if test="${source == 'edit'}">
                                    <g:message code="objetivoEstrategico.edit.legend" default="Edit ObjetivoEstrategico details"/>
                                </g:if>
                                <g:else>
                                    <g:message code="objetivoEstrategico.create.legend" default="Enter ObjetivoEstrategico details"/>
                                </g:else>
                </legend>
                    
                    <div class="prop ${hasErrors(bean: objetivoEstrategicoInstance, field: 'proyecto', 'error')}">
                        <label for="proyecto">
                            <g:message code="objetivoEstrategico.proyecto.label" default="Proyecto" />
                            
                        </label>
                        <div class="campo">
                            <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="Proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${objetivoEstrategicoInstance?.proyecto?.id}" noSelection="['null': '']" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: objetivoEstrategicoInstance, field: 'institucion', 'error')}">
                        <label for="institucion">
                            <g:message code="objetivoEstrategico.institucion.label" default="Institucion" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="institucion" id="institucion" title="Objetivo estratégico institucional" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.institucion}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: objetivoEstrategicoInstance, field: 'objetivo', 'error')}">
                        <label for="objetivo">
                            <g:message code="objetivoEstrategico.objetivo.label" default="Objetivo" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="objetivo" id="objetivo" title="Objetivo" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.objetivo}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: objetivoEstrategicoInstance, field: 'politica', 'error')}">
                        <label for="politica">
                            <g:message code="objetivoEstrategico.politica.label" default="Politica" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="politica" id="politica" title="Política" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.politica}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: objetivoEstrategicoInstance, field: 'meta', 'error')}">
                        <label for="meta">
                            <g:message code="objetivoEstrategico.meta.label" default="Meta" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="meta" id="meta" title="Meta" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${objetivoEstrategicoInstance?.meta}" />
                        </div>
                    </div>
                    

                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="update" default="Update" />
                            </a>
                            <g:link class="button delete" action="delete" id="${objetivoEstrategicoInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${objetivoEstrategicoInstance?.id}">
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
                var myForm = $(".frmObjetivoEstrategico");

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