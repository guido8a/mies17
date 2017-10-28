<%@ page import="mies.Proceso" %>
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

    <style type="text/css">
    .tr_click {
        cursor: pointer;
    }
    </style>

</head>

<body>
<div class="dialog" title="${title}">

%{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
%{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
%{--<g:message code="default.home.label" default="Home" />--}%
%{--</a>--}%
%{--<g:link class="button list" action="list">--}%
%{--<g:message code="default.list.label" args="${['Proceso']}" default="Proceso List" />--}%
%{--</g:link>--}%
%{--</div>--}%

<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${procesoInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${procesoInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form action="save" class="frmProceso"
        method="post">
<g:hiddenField name="id" value="${procesoInstance?.id}"/>
<g:hiddenField name="version" value="${procesoInstance?.version}"/>

<table width="100%" class="ui-widget-content ui-corner-all">

<thead>
    <tr>
        <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
            <g:if test="${source == 'edit'}">
                <g:message code="default.edit.legend" args="${['Proceso']}" default="Edit Proceso details"/>
            </g:if>
            <g:else>
                <g:message code="default.create.legend" args="${['Proceso']}" default="Enter Proceso details"/>
            </g:else>
        </td>
    </tr>
</thead>
<tbody>

<tr class="prop ${hasErrors(bean: procesoInstance, field: 'nombre', 'error')}">

    <td class="label  mandatory" valign="middle">
        <g:message code="proceso.nombre.label" default="Nombre"/>
        %{--<span class="indicator">*</span>--}%
    </td>
    <td class="indicator mandatory">
        <span class="indicator">*</span>
    </td>
    <td class="campo mandatory" valign="middle">
        <g:textField name="nombre" id="nombre" title="${Proceso.constraints.nombre.attributes.mensaje}"
                     class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                     value="${procesoInstance?.nombre}"/>
        %{--<span class="indicator">*</span>--}%
    </td>



    <td class="label " valign="middle">
        <g:message code="proceso.descripcion.label" default="Descripcion"/>
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td valign="middle">
        <g:textField name="descripcion" id="descripcion" title="${Proceso.constraints.descripcion.attributes.mensaje}"
                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255"
                     value="${procesoInstance?.descripcion}"/>
        %{----}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: procesoInstance, field: 'fecha', 'error')}">

    <td class="label " valign="middle">
        <g:message code="proceso.fecha.label" default="Fecha"/>
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td valign="middle">
        <input type="hidden" value="date.struct" name="fecha">
        <input type="hidden" name="fecha_day" id="fecha_day"
               value="${procesoInstance?.fecha?.format('dd')}">
        <input type="hidden" name="fecha_month" id="fecha_month"
               value="${procesoInstance?.fecha?.format('MM')}">
        <input type="hidden" name="fecha_year" id="fecha_year"
               value="${procesoInstance?.fecha?.format('yyyy')}">
        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fecha" title="${Proceso.constraints.fecha.attributes.mensaje}"
                     id="fecha" value="${procesoInstance?.fecha?.format('dd-MM-yyyy')}"/>
        <script type='text/javascript'>
            $('#fecha').datepicker({
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
        %{----}%
    </td>



    <td class="label " valign="middle">
        <g:message code="proceso.fechaFin.label" default="Fecha Fin"/>
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td valign="middle">
        <input type="hidden" value="date.struct" name="fechaFin">
        <input type="hidden" name="fechaFin_day" id="fechaFin_day"
               value="${procesoInstance?.fechaFin?.format('dd')}">
        <input type="hidden" name="fechaFin_month" id="fechaFin_month"
               value="${procesoInstance?.fechaFin?.format('MM')}">
        <input type="hidden" name="fechaFin_year" id="fechaFin_year"
               value="${procesoInstance?.fechaFin?.format('yyyy')}">
        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin"
                     title="${Proceso.constraints.fechaFin.attributes.mensaje}" id="fechaFin"
                     value="${procesoInstance?.fechaFin?.format('dd-MM-yyyy')}"/>
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
        %{----}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: procesoInstance, field: 'estado', 'error')}">

    <td class="label " valign="middle">
        <g:message code="proceso.estado.label" default="Estado"/>
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td valign="middle">
        <g:textField name="estado" id="estado" title="${Proceso.constraints.estado.attributes.mensaje}" class="field ui-widget-content ui-corner-all"
                     minLenght="1" maxLenght="1" value="${procesoInstance?.estado}"/>
        %{----}%
    </td>



    <td class="label " valign="middle">
        <g:message code="proceso.observaciones.label" default="Observaciones"/>
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td valign="middle">
        <g:textField name="observaciones" id="observaciones" title="${Proceso.constraints.observaciones.attributes.mensaje}"
                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                     value="${procesoInstance?.observaciones}"/>
        %{----}%
    </td>

</tr>

<tr>

    <td class="label " valign="middle">
        Pasos
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td valign="middle" colspan="6">
        <div style="height: 20px;">
            <g:link style="float: left;" controller="paso" action="create" params="${[proceso:procesoInstance.id]}">
                <img src="${resource(dir: 'images/ico', file: 'Add.png')}" alt="Agregar"/>
            </g:link>
        </div>

        <g:each in="${pasos}" var="pasoInstance" status="i">
            <table id="tbl_${pasoInstance.id}"
                   style="width: 950px; border: solid 3px #6495ed;"
                   class="ui-corner-all">
                <thead>
                    <tr id="tr_${pasoInstance.id}" class="tr_click"
                        paso="${pasoInstance.id}">
                        <th colspan="4" class="${(i % 2) == 0 ? 'odd' : 'even'}"
                            style="text-align: left;">
                            ${pasoInstance.orden}.- ${pasoInstance.nombre}
                            <g:link style="float: right;" class="edit_paso" controller="paso" action="edit"
                                    id="${pasoInstance.id}">
                                <img src="${resource(dir: 'images/ico', file: 'Edit.png')}" alt="Editar"/>
                            </g:link>
                        </th>
                    </tr>
                </thead>
                <tbody id="tbd_${pasoInstance.id}" class="ui-helper-hidden">

                    <tr>
                        <td class="label" width="85">
                            <g:message code="paso.descripcion.label"
                                       default="Descripcion"/>
                        </td>
                        <td>
                            ${fieldValue(bean: pasoInstance, field: "descripcion")}
                        </td> <!-- campo -->
                    </tr>

                    <tr>
                        <td class="label">
                            <g:message code="paso.obligacion.label"
                                       default="Obligatorio"/>
                        </td>
                        <td>
                            ${(pasoInstance.obligacion == 1 || pasoInstance.obligacion == "1") ? "Sí" : "No"}
                        </td> <!-- campo -->
                    </tr>

                    <tr>
                        <td class="label">
                            <g:message code="paso.estado.label"
                                       default="Estado"/>
                        </td>
                        <td>
                            ${pasoInstance.estado == "A" ? "Activo" : "Inactivo"}
                        </td> <!-- campo -->
                    </tr>

                    <tr>
                        <td class="label">
                            <g:message code="paso.tabla.label"
                                       default="Tabla(s)"/>
                        </td>
                        <td>
                            ${fieldValue(bean: pasoInstance, field: "tabla")}
                        </td> <!-- campo -->
                    </tr>
                </tbody>

            </table>
        </g:each>
    </td>

</tr>

</tbody>
<tfoot>
    <tr>
        <td colspan="6" class="buttons" style="text-align: right;">
            <g:if test="${source == 'edit'}">
                <a href="#" class="button save" title="Guardar">
                    Guardar
                </a>
                <g:link class="button show" action="show" id="${procesoInstance?.id}" title="Ver">
                    <g:message code="default.button.show.label" default="Show"/>
                </g:link>
            </g:if>
            <g:else>
                <a href="#" class="button save">
                    <g:message code="default.button.create.label" default="Create"/>
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

        $(".tr_click").click(function() {
            var paso = $(this).attr("paso");
            $("#tbd_" + paso).toggle();
        });

        var myForm = $(".frmProceso");

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