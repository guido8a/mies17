<%@ page import="mies.UnidadEjecutora" %>
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
    <a class="button home" href="${createLinkTo(dir: '')}">
        <g:message code="default.home.label" default="Home"/>
    </a>
    <g:link class="button list" action="list">
        <g:message code="default.list.label" args="${['UnidadEjecutora']}" default="UnidadEjecutora List"/>
    </g:link>
</div>


<div class="body">
<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${unidadEjecutoraInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${unidadEjecutoraInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form action="save" class="frmUnidadEjecutora"
        method="post">
<g:hiddenField name="id" value="${unidadEjecutoraInstance?.id}"/>
<g:hiddenField name="version" value="${unidadEjecutoraInstance?.version}"/>
<div>
<fieldset class="ui-corner-all">
<legend class="ui-widget ui-widget-header ui-corner-all">
    <g:if test="${source == 'edit'}">
        <g:message code="default.edit.legend" args="${['UnidadEjecutora']}" default="Edit UnidadEjecutora details"/>
    </g:if>
    <g:else>
        <g:message code="default.create.legend" args="${['UnidadEjecutora']}"
                   default="Enter UnidadEjecutora details"/>
    </g:else>
</legend>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'subSecretaria', 'error')}">
    <label for="subSecretaria">
        <g:message code="unidadEjecutora.subSecretaria.label" default="Sub Secretaria"/>

    </label>

    <div class="campo">
        <g:select class="field ui-widget-content ui-corner-all" name="subSecretaria.id" title="subSecretaria"
                  from="${mies.SubSecretaria.list()}" optionKey="id"
                  value="${unidadEjecutoraInstance?.subSecretaria?.id}" noSelection="['null': '']"/>
    </div>
</div>

<div class="prop mandatory ${hasErrors(bean: unidadEjecutoraInstance, field: 'nombre', 'error')}">
    <label for="nombre">
        <g:message code="unidadEjecutora.nombre.label" default="Nombre"/>
        <span class="indicator">*</span>
    </label>

    <div class="campo">
        <g:textField name="nombre" id="nombre" title="nombre" class="field required ui-widget-content ui-corner-all"
                     minLenght="1" maxLenght="63" value="${unidadEjecutoraInstance?.nombre}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'titulo', 'error')}">
    <label for="titulo">
        <g:message code="unidadEjecutora.titulo.label" default="Titulo"/>

    </label>

    <div class="campo">
        <g:textField name="titulo" id="titulo" title="titulo" class="field ui-widget-content ui-corner-all"
                     minLenght="1" maxLenght="63" value="${unidadEjecutoraInstance?.titulo}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'direccion', 'error')}">
    <label for="direccion">
        <g:message code="unidadEjecutora.direccion.label" default="Direccion"/>

    </label>

    <div class="campo">
        <g:textField name="direccion" id="direccion" title="direccion" class="field ui-widget-content ui-corner-all"
                     minLenght="1" maxLenght="127" value="${unidadEjecutoraInstance?.direccion}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'sigla', 'error')}">
    <label for="sigla">
        <g:message code="unidadEjecutora.sigla.label" default="Sigla"/>

    </label>

    <div class="campo">
        <g:textField name="sigla" id="sigla" title="sigla" class="field ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="7" value="${unidadEjecutoraInstance?.sigla}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'objetivo', 'error')}">
    <label for="objetivo">
        <g:message code="unidadEjecutora.objetivo.label" default="Objetivo"/>

    </label>

    <div class="campo">
        <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024" name="objetivo"
                    id="objetivo" title="objetivo" cols="40" rows="5" value="${unidadEjecutoraInstance?.objetivo}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'fechaInicio', 'error')}">
    <label for="fechaInicio">
        <g:message code="unidadEjecutora.fechaInicio.label" default="Fecha Inicio"/>

    </label>

    <div class="campo">
        <input type="hidden" value="date.struct" name="fechaInicio">
        <input type="hidden" name="fechaInicio_day" id="fechaInicio_day"
               value="${unidadEjecutoraInstance?.fechaInicio?.format('dd')}">
        <input type="hidden" name="fechaInicio_month" id="fechaInicio_month"
               value="${unidadEjecutoraInstance?.fechaInicio?.format('MM')}">
        <input type="hidden" name="fechaInicio_year" id="fechaInicio_year"
               value="${unidadEjecutoraInstance?.fechaInicio?.format('yyyy')}">
        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio" title="fechaInicio"
                     id="fechaInicio" value="${unidadEjecutoraInstance?.fechaInicio?.format('dd-MM-yyyy')}"/>
        <script type='text/javascript'>
            $('#fechaInicio').datepicker({
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

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'fechaFin', 'error')}">
    <label for="fechaFin">
        <g:message code="unidadEjecutora.fechaFin.label" default="Fecha Fin"/>

    </label>

    <div class="campo">
        <input type="hidden" value="date.struct" name="fechaFin">
        <input type="hidden" name="fechaFin_day" id="fechaFin_day"
               value="${unidadEjecutoraInstance?.fechaFin?.format('dd')}">
        <input type="hidden" name="fechaFin_month" id="fechaFin_month"
               value="${unidadEjecutoraInstance?.fechaFin?.format('MM')}">
        <input type="hidden" name="fechaFin_year" id="fechaFin_year"
               value="${unidadEjecutoraInstance?.fechaFin?.format('yyyy')}">
        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin" title="fechaFin"
                     id="fechaFin" value="${unidadEjecutoraInstance?.fechaFin?.format('dd-MM-yyyy')}"/>
        <script type='text/javascript'>
            $('#fechaFin').datepicker({
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

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'telefono', 'error')}">
    <label for="telefono">
        <g:message code="unidadEjecutora.telefono.label" default="Telefono"/>

    </label>

    <div class="campo">
        <g:textField name="telefono" id="telefono" title="telefono" class="field ui-widget-content ui-corner-all"
                     minLenght="1" maxLenght="63" value="${unidadEjecutoraInstance?.telefono}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'fax', 'error')}">
    <label for="fax">
        <g:message code="unidadEjecutora.fax.label" default="Fax"/>

    </label>

    <div class="campo">
        <g:textField name="fax" id="fax" title="fax" class="field ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="63" value="${unidadEjecutoraInstance?.fax}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'email', 'error')}">
    <label for="email">
        <g:message code="unidadEjecutora.email.label" default="Email"/>

    </label>

    <div class="campo">
        <g:textField name="email" id="email" title="email" class="field ui-widget-content ui-corner-all" minLenght="1"
                     maxLenght="63" value="${unidadEjecutoraInstance?.email}"/>
    </div>
</div>

<div class="prop ${hasErrors(bean: unidadEjecutoraInstance, field: 'observaciones', 'error')}">
    <label for="observaciones">
        <g:message code="unidadEjecutora.observaciones.label" default="Observaciones"/>

    </label>

    <div class="campo">
        <g:textField name="observaciones" id="observaciones" title="observaciones"
                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                     value="${unidadEjecutoraInstance?.observaciones}"/>
    </div>
</div>


<div class="buttons">
    <g:if test="${source == 'edit'}">
        <a href="#" class="button save">
            <g:message code="default.button.update.label" default="Update"/>
        </a>
        <g:link class="button delete" action="delete" id="${unidadEjecutoraInstance?.id}">
            <g:message code="default.button.delete.label" default="Delete"/>
        </g:link>
        <g:link class="button show" action="show" id="${unidadEjecutoraInstance?.id}">
            <g:message code="default.button.show.label" default="Show"/>
        </g:link>
    </g:if>
    <g:else>
        <a href="#" class="button save">
            <g:message code="default.button.create.label" default="Create"/>
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