<%@ page import="mies.Persona" %>
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

    <title>${title}</title>
</head>

<body>
<div class="dialog" title="${title}">

<div id="" class="toolbar ui-widget-header ui-corner-all">
    <g:link class="button list" action="list">
        <g:message code="persona.list" default="Lista de Personas"/>
    </g:link>
</div>


<div class="body">
<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${personaInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${personaInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form action="save" class="frmPersona"
        method="post">
<g:hiddenField name="id" value="${personaInstance?.id}"/>
<g:hiddenField name="version" value="${personaInstance?.version}"/>
<div>
<fieldset class="ui-corner-all">
<legend class="ui-widget ui-widget-header ui-corner-all">
    <g:if test="${source == 'edit'}">
        <g:message code="persona.edit.legend" default="Editar los datos de la Persona"/>
    </g:if>
    <g:else>
        <g:message code="persona.create.legend" default="Ingrese los datos de la Persona"/>
    </g:else>
</legend>

<div class="prop mandatory ${hasErrors(bean: personaInstance, field: 'cedula', 'error')}">
    <label for="cedula">
        <g:message code="persona.cedula.label" default="Cédula"/>
        <span class="indicator">*</span>
    </label>

    <div class="campo">
        <g:textField name="cedula" id="cedula" title="${Persona.constraints.cedula.attributes.mensaje}"
                     class="6 field required ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="13" style="width: 100px;" value="${personaInstance?.cedula}"/>
    </div>
</div>

<div class="prop mandatory ${hasErrors(bean: personaInstance, field: 'nombre', 'error')}">
    <label for="nombre">
        <g:message code="persona.nombre.label" default="Nombre"/>
        <span class="indicator">*</span>
    </label>

    <div class="campo">
        <g:textField name="nombre" id="nombre" title="${Persona.constraints.nombre.attributes.mensaje}"
                     class="6 field required ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="40" value="${personaInstance?.nombre}"/>
    </div>
</div>

<div class="prop mandatory ${hasErrors(bean: personaInstance, field: 'apellido', 'error')}">
    <label for="apellido">
        <g:message code="persona.apellido.label" default="Apellido"/>
        <span class="indicator">*</span>
    </label>

    <div class="campo">
        <g:textField name="apellido" id="apellido" title="${Persona.constraints.apellido.attributes.mensaje}"
                     class="6 field required ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="40" value="${personaInstance?.apellido}"/>
    </div>
</div>

<div class="prop mandatory ${hasErrors(bean: personaInstance, field: 'sexo', 'error')}">
    <label for="sexo">
        <g:message code="persona.sexo.label" default="Sexo"/>
        <span class="indicator">*</span>
    </label>

    <div class="campo">
        <g:select class="field required ui-widget-content ui-corner-all" name="sexo"
                  title="${Persona.constraints.sexo.attributes.mensaje}"
                  id="sexo" from="${personaInstance.constraints.sexo.inList}" style="width: 60px;"
                  value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'discapacitado', 'error')}">
    <label for="discapacitado">
        <g:message code="persona.discapacitado.label" default="Discapacitado"/>

    </label>

    <div class="campo">
        <g:select from="${[0,1]}" name="discapacitado" class="ui-corner-all"
                  title="${Persona.constraints.discapacitado.attributes.mensaje}"
                  value="${fieldValue(bean: personaInstance, field: 'discapacitado')}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'fechaNacimiento', 'error')}">
    <label for="fechaNacimiento">
        <g:message code="persona.fechaNacimiento.label" default="Fecha Nacimiento"/>

    </label>

    <div class="campo">
        <input type="hidden" value="date.struct" name="fechaNacimiento">
        <input type="hidden" name="fechaNacimiento_day" id="fechaNacimiento_day"
               value="${personaInstance?.fechaNacimiento?.format('dd')}">
        <input type="hidden" name="fechaNacimiento_month" id="fechaNacimiento_month"
               value="${personaInstance?.fechaNacimiento?.format('MM')}">
        <input type="hidden" name="fechaNacimiento_year" id="fechaNacimiento_year"
               value="${personaInstance?.fechaNacimiento?.format('yyyy')}">
        <g:textField class="25 datepicker field ui-widget-content ui-corner-all"
                     name="fechaNacimiento" title="${Persona.constraints.fechaNacimiento.attributes.mensaje}"
                     id="fechaNacimiento" style="width: 120px;"
                     value="${personaInstance?.fechaNacimiento?.format('dd-MM-yyyy')}"/>
        <script type='text/javascript'>
            $('#fechaNacimiento').datepicker({
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
        </script>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'direccion', 'error')}">
    <label for="direccion">
        <g:message code="persona.direccion.label" default="Dirección"/>

    </label>

    <div class="campo">
        <g:textField name="direccion" id="direccion" title="${Persona.constraints.direccion.attributes.mensaje}"
                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                     style="width: 600px;" value="${personaInstance?.direccion}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'telefono', 'error')}">
    <label for="telefono">
        <g:message code="persona.telefono.label" default="Teléfonos"/>

    </label>

    <div class="campo">
        <g:textField name="telefono" id="telefono" title="${Persona.constraints.telefono.attributes.mensaje}"
                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="40"
                     value="${personaInstance?.telefono}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'mail', 'error')}">
    <label for="mail">
        <g:message code="persona.mail.label" default="Mail"/>

    </label>

    <div class="campo">
        <g:textField name="mail" id="mail" title="${Persona.constraints.mail.attributes.mensaje}"
                     class="6 field email ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="40" style="width: 400px;" value="${personaInstance?.mail}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'fax', 'error')}">
    <label for="fax">
        <g:message code="persona.fax.label" default="Fax"/>

    </label>

    <div class="campo">
        <g:textField name="fax" id="fax" title="${Persona.constraints.fax.attributes.mensaje}"
                     class="6 field ui-widget-content ui-corner-all"
                     minLenght="1" maxLenght="40" value="${personaInstance?.fax}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: personaInstance, field: 'observaciones', 'error')}">
    <label for="observaciones">
        <g:message code="persona.observaciones.label" default="Observaciones"/>

    </label>

    <div class="campo">
        <g:textField name="observaciones" id="observaciones"
                     title="${Persona.constraints.observaciones.attributes.mensaje}"
                     class="6 field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                     style="width: 700px;" value="${personaInstance?.observaciones}"/>
    </div>
</div>


<div class="buttons">
    <g:if test="${source == 'edit'}">
        <a href="#" class="button save">
            <g:message code="update" default="Actualizar"/>
        </a>
        <g:link class="button delete" action="delete" id="${personaInstance?.id}">
            <g:message code="default.button.delete.label" default="Eliminar"/>
        </g:link>
        <g:link class="button show" action="show" id="${personaInstance?.id}">
            <g:message code="default.button.show.label" default="Ver"/>
        </g:link>
    </g:if>
    <g:else>
        <a href="#" class="button save">
            <g:message code="create" default="Crear"/>
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
        var myForm = $(".frmPersona");

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