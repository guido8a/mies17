
<%@ page import="mies.UnidadEjecutora" %>
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
                    <g:hasErrors bean="${unidadEjecutoraInstance}">
                        <div class="errors ui-state-error ui-corner-all">
                            <g:renderErrors bean="${unidadEjecutoraInstance}" as="list" />
                        </div>
                    </g:hasErrors>
                    <g:form action="save" class="frmUnidadEjecutora"
                            method="post"  >
                        <g:hiddenField name="id" value="${unidadEjecutoraInstance?.id}" />
                        <g:hiddenField name="version" value="${unidadEjecutoraInstance?.version}" />
                    <div>
                        <fieldset class="ui-corner-all">
                            <legend class="ui-widget ui-widget-header ui-corner-all">
                                <g:if test="${source == 'edit'}">
                                    <g:message code="unidadEjecutora.edit.legend" default="Edit UnidadEjecutora details"/>
                                </g:if>
                                <g:else>
                                    <g:message code="unidadEjecutora.create.legend" default="Enter UnidadEjecutora details"/>
                                </g:else>
                </legend>
                    
                    <div class="prop mandatory ${hasErrors(bean: unidadEjecutoraInstance, field: 'tipoInstitucion', 'error')}">
                        <label for="tipoInstitucion">
                            <g:message code="unidadEjecutora.tipoInstitucion.label" default="Tipo Institucion" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="tipoInstitucion.id" title="Tipo de institución" from="${mies.TipoInstitucion.list()}" optionKey="id" value="${unidadEjecutoraInstance?.tipoInstitucion?.id}"  />
                        </div>
                    </div>
                                        
                    <div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'provincia', 'error')}">
                        <label for="provincia">
                            <g:message code="unidadEjecutora.provincia.label" default="Provincia" />
                            
                        </label>
                        <div class="campo">
                            <g:select class="field ui-widget-content ui-corner-all" name="provincia.id" title="Provincia de la unidad ejecutora" from="${mies.Provincia.list()}" optionKey="id" value="${unidadEjecutoraInstance?.provincia?.id}" noSelection="['null': '']" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'codigo', 'error')}">
                        <label for="codigo">
                            <g:message code="unidadEjecutora.codigo.label" default="Codigo" />
                            
                        </label>
                        <div class="campo">
                            <g:textField  name="codigo" id="codigo" title="Código según el ESIGEF" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="4" value="${unidadEjecutoraInstance?.codigo}" />
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'fechaInicio', 'error')}">
                        <label for="fechaInicio">
                            <g:message code="unidadEjecutora.fechaInicio.label" default="Fecha Inicio" />
                            
                        </label>
                        <div class="campo">
                            <input type="hidden" value="date.struct" name="fechaInicio">
<input type="hidden" name="fechaInicio_day" id="fechaInicio_day"  value="${unidadEjecutoraInstance?.fechaInicio?.format('dd')}" >
<input type="hidden" name="fechaInicio_month" id="fechaInicio_month" value="${unidadEjecutoraInstance?.fechaInicio?.format('MM')}">
<input type="hidden" name="fechaInicio_year" id="fechaInicio_year" value="${unidadEjecutoraInstance?.fechaInicio?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio" title="Fecha de creación" id="fechaInicio" value="${unidadEjecutoraInstance?.fechaInicio?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaInicio').datepicker({
        changeMonth: true,
        changeYear:true,
        dateFormat: 'dd-mm-yy',
        onClose: function(dateText, inst) {
            var date = $(this).datepicker('getDate');
            var day, month, year;
            if(date != null) {
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
</script>
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'fechaFin', 'error')}">
                        <label for="fechaFin">
                            <g:message code="unidadEjecutora.fechaFin.label" default="Fecha Fin" />
                            
                        </label>
                        <div class="campo">
                            <input type="hidden" value="date.struct" name="fechaFin">
<input type="hidden" name="fechaFin_day" id="fechaFin_day"  value="${unidadEjecutoraInstance?.fechaFin?.format('dd')}" >
<input type="hidden" name="fechaFin_month" id="fechaFin_month" value="${unidadEjecutoraInstance?.fechaFin?.format('MM')}">
<input type="hidden" name="fechaFin_year" id="fechaFin_year" value="${unidadEjecutoraInstance?.fechaFin?.format('yyyy')}">
<g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin" title="Fecha de cierre o final" id="fechaFin" value="${unidadEjecutoraInstance?.fechaFin?.format('dd-MM-yyyy')}" />
<script type='text/javascript'>
    $('#fechaFin').datepicker({
        changeMonth: true,
        changeYear:true,
        dateFormat: 'dd-mm-yy',
        onClose: function(dateText, inst) {
            var date = $(this).datepicker('getDate');
            var day, month, year;
            if(date != null) {
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
</script>
                        </div>
                    </div>
                    
                    <div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'padre', 'error')}">
                        <label for="padre">
                            <g:message code="unidadEjecutora.padre.label" default="Padre" />
                            
                        </label>
                        <div class="campo">
                            <g:select class="field ui-widget-content ui-corner-all" name="padre.id" title="Unidad Ejecutora padre" from="${mies.UnidadEjecutora.list()}" optionKey="id" value="${unidadEjecutoraInstance?.padre?.id}" noSelection="['null': '']" />
                        </div>
                    </div>
                    

                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="update" default="Update" />
                            </a>
                            <g:link class="button delete" action="delete" id="${unidadEjecutoraInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete" />
                            </g:link>
                            <g:link class="button show" action="show" id="${unidadEjecutoraInstance?.id}">
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
                var myForm = $(".frmUnidadEjecutora");

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