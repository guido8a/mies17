<%@ page import="mies.Paso" %>
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

%{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
%{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
%{--<g:message code="default.home.label" default="Home" />--}%
%{--</a>--}%
%{--<g:link class="button list" action="list">--}%
%{--<g:message code="default.list.label" args="${['Paso']}" default="Paso List" />--}%
%{--</g:link>--}%
%{--</div>--}%

    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${pasoInstance}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${pasoInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" class="frmPaso"
            method="post">
        <g:hiddenField name="id" value="${pasoInstance?.id}"/>
        <g:hiddenField name="version" value="${pasoInstance?.version}"/>

        <table width="100%" class="ui-widget-content ui-corner-all">

            <thead>
                <tr>
                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                        <g:if test="${source == 'edit'}">
                            <g:message code="default.edit.legend" args="${['Paso']}" default="Edit Paso details"/>
                        </g:if>
                        <g:else>
                            <g:message code="default.create.legend" args="${['Paso']}" default="Enter Paso details"/>
                        </g:else>
                    </td>
                </tr>
            </thead>
            <tbody>

                <tr class="prop ${hasErrors(bean: pasoInstance, field: 'proceso', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="paso.proceso.label" default="Proceso"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:if test="${source == 'create' && pasoInstance.proceso?.id}">
                            ${pasoInstance?.proceso?.nombre}
                            <g:hiddenField name="proceso.id" value="${pasoInstance.proceso.id}"/>
                        </g:if>
                        <g:else>
                            <g:select class="field ui-widget-content ui-corner-all" name="proceso.id" title="${Paso.constraints.proceso.attributes.mensaje}"
                                      from="${mies.Proceso.list()}" optionKey="id" value="${pasoInstance?.proceso?.id}"
                                      noSelection="['null': '']"/>
                        </g:else>
                        %{----}%
                    </td>



                    <td class="label " valign="middle">
                        <g:message code="paso.orden.label" default="Orden"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="orden" id="orden" title="${Paso.constraints.orden.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                                     value="${pasoInstance?.orden}"/>
                        %{----}%
                    </td>

                </tr>



                <tr class="prop ${hasErrors(bean: pasoInstance, field: 'nombre', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="paso.nombre.label" default="Nombre"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="nombre" id="nombre" title="${Paso.constraints.nombre.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                     value="${pasoInstance?.nombre}"/>
                        %{----}%
                    </td>



                    <td class="label " valign="middle">
                        <g:message code="paso.descripcion.label" default="Descripcion"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="descripcion" id="descripcion" title="${Paso.constraints.descripcion.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255"
                                     value="${pasoInstance?.descripcion}"/>
                        %{----}%
                    </td>

                </tr>



                <tr class="prop ${hasErrors(bean: pasoInstance, field: 'obligacion', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="paso.obligacion.label" default="Obligacion"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="obligacion" id="obligacion" title="${Paso.constraints.obligacion.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1"
                                     value="${pasoInstance?.obligacion}"/>
                        %{----}%
                    </td>



                    <td class="label  mandatory" valign="middle">
                        <g:message code="paso.tabla.label" default="Tabla"/>
                        %{--<span class="indicator">*</span>--}%
                    </td>
                    <td class="indicator mandatory">
                        <span class="indicator">*</span>
                    </td>
                    <td class="campo mandatory" valign="middle">
                        <g:textField name="tabla" id="tabla" title="${Paso.constraints.tabla.attributes.mensaje}"
                                     class="field required ui-widget-content ui-corner-all" minLenght="1"
                                     maxLenght="127" value="${pasoInstance?.tabla}"/>
                        %{--<span class="indicator">*</span>--}%
                    </td>

                </tr>



                <tr class="prop ${hasErrors(bean: pasoInstance, field: 'estado', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="paso.estado.label" default="Estado"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:textField name="estado" id="estado" title="${Paso.constraints.estado.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1"
                                     value="${pasoInstance?.estado}"/>
                        %{----}%
                    </td>

                </tr>

            </tbody>
            <tfoot>
                <tr>
                    <td colspan="6" class="buttons" style="text-align: right;">
                        <g:if test="${source == 'edit'}">
                            <g:link class="button exit" controller="proceso" action="show" id="${pasoInstance.proceso.id}">
                                Salir sin guardar
                            </g:link>
                            <a href="#" class="button save">
                                Guardar
                            </a>
                            <g:link class="button delete" action="delete" id="${pasoInstance?.id}">
                                <g:message code="default.button.delete.label" default="Delete"/>
                            </g:link>
                            <g:link class="button show" action="show" id="${pasoInstance?.id}">
                                <g:message code="default.button.show.label" default="Show"/>
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link class="button exit" controller="proceso" action="show" id="${pasoInstance.proceso.id}">
                                Salir sin guardar
                            </g:link>
                            <a href="#" class="button save">
                                Guardar
                            </a>
                        </g:else>
                    </td>
                </tr>
            </tfoot>
        </table>
    </g:form>
</div>

<script type="text/javascript">
    $(function() {
        var myForm = $(".frmPaso");

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
        $(".exit").button("option", "icons", {primary:'ui-icon-circle-arrow-w'});
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