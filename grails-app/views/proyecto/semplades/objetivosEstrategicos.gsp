<%@ page import="mies.ObjetivoEstrategico; mies.EstudiosTecnicos" %>
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
    <link rel="stylesheet" href="${resource(dir: 'css/menuSemplades', file: 'flow_menu_green.css')}"/>

    <g:set var="titulo" value="Objetivos Estratégicos"/>
    <g:set var="sing" value="Objetivo Estratégico"/>
    <g:set var="min" value="objetivosEstrategicos"/>
    <g:set var="may" value="ObjetivosEstrategicos"/>
    <g:set var="abr" value="Objetivo"/>

    <title>${titulo} del proyecto ${proyecto}</title>
</head>

<body>

<div class="dialog" title="${titulo} del proyecto ${proyecto}">

    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${objetivoEstrategicoInstance}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${objetivoEstrategicoInstance}" as="list"/>
        </div>
    </g:hasErrors>


    <mf:menuSemplades items='${items}'/>


    <div style="margin-top: 10px;">
        <div style="padding: 5px; margin-top: 5px; margin-bottom: 5px;" id="divError1"
             class="ui-state-error ui-corner-all ui-helper-hidden">
            <p>
                <span style="float: left;" class="ui-icon ui-icon-alert"></span>
                <span id="spanError1" style="font-weight: bold;"></span>
            </p>
        </div>

        <a href="#" class="button agregar">Agregar</a>
        <a href="#" class="button delete">Eliminar</a>

        <div id="ajaxTabla" style="margin-top: 10px;"></div>

        <div class="botones" style="margin-top: 5px;">
            <div class="botones left">
                <g:link action="semplades" event="click" params="${['evento': 'salir']}"
                        class="button salir">Salir</g:link>
            </div>
        </div>

        <div id="dlg_nuevo${abr}" title="Nuevo ${sing}">

            <div style="padding: 5px; margin-top: 5px; margin-bottom: 5px;" id="divError"
                 class="ui-state-error ui-corner-all ui-helper-hidden">
                <p>
                    <span style="float: left;" class="ui-icon ui-icon-alert"></span>
                    <span id="spanError" style="font-weight: bold;"></span>
                </p>
            </div>

            <g:form action="save${may}" class="frm${may}"
                    method="post">
                <g:hiddenField name="id" value="${objetivoEstrategicoInstance?.id}"/>
                <g:hiddenField name="version" value="${objetivoEstrategicoInstance?.version}"/>

                <table width="100%" class="ui-widget-content ui-corner-all">

                    <tbody>

                        <tr>
                            <td class="label " valign="middle">
                                <g:message code="objetivoEstrategico.institucion.label" default="Institución"/>
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:textField name="institucion" id="institucion" title="${ObjetivoEstrategico.constraints.institucion.attributes.mensaje}"
                                             class="field ui-widget-content ui-corner-all"
                                             value="${objetivoEstrategicoInstance?.institucion}"/>
                            </td>
                        </tr>

                        <tr>
                            <td class="label " valign="middle">
                                <g:message code="objetivoEstrategico.objetivo.label" default="Objetivo"/>
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:textField name="objetivo" id="objetivo" title="${ObjetivoEstrategico.constraints.objetivo.attributes.mensaje}"
                                             class="field ui-widget-content ui-corner-all"
                                             value="${objetivoEstrategicoInstance?.objetivo}"/>
                            </td>
                        </tr>

                        <tr>
                            <td class="label " valign="middle">
                                <g:message code="objetivoEstrategico.politica.label" default="Política"/>
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:textField name="politica" id="politica" title="${ObjetivoEstrategico.constraints.politica.attributes.mensaje}"
                                             class="field ui-widget-content ui-corner-all"
                                             value="${objetivoEstrategicoInstance?.politica}"/>
                            </td>
                        </tr>

                        <tr>
                            <td class="label " valign="middle">
                                <g:message code="objetivoEstrategico.meta.label" default="Meta"/>
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:textField name="meta" id="meta" title="${ObjetivoEstrategico.constraints.meta.attributes.mensaje}"
                                             class="field ui-widget-content ui-corner-all"
                                             value="${objetivoEstrategicoInstance?.meta}"/>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </g:form>
        </div>
    </div>

</div>

<script type="text/javascript">
    $(function() {

        $(".salir").button({icons: {primary:'ui-icon-arrowreturnthick-1-w'}});

        function reloadDatos() {
            var url = "${createLink(controller: 'proyecto', action:'getDatos')}";
            $.ajax({
                type: "POST",
                url: url,
                data: "id=${proyecto.id}&tipo=${min}",
                success: function(msg) {
                    $("#ajaxTabla").html(msg);
                }
            });
        }

        reloadDatos();

        var myForm = $(".frm${may}");

        $("#dlg_nuevo${abr}").dialog({
            width: 350,
            zIndex: 2000,
            position: 'center',
            resizable: false,
            modal: true,
            autoOpen: false,
            open: function(event, ui) {
                $("#spanError").text("");
                $("#divError").hide();
                $(this).find("input").val("");
            },
            buttons: {
                "Cancelar": function() {
                    $(this).dialog("close");
                },
                "Guardar": function() {
                    var url = "${createLink(controller: 'proyecto', action:'save'+may)}";
                    var data = myForm.serialize();
                    data += "&proyecto.id=" +${proyecto.id};

                    ////console.log(data);

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: data,
                        success: function(msg) {
                            if (msg == "OK") {
                                $("#dlg_nuevo${abr}").dialog("close");
                                reloadDatos();
                            } else {
                                $("#spanError").text("Ha ocurrido un error al guardar el ${sing}");
                                $("#divError").show();
                            }
                        }
                    });
                }
            }
        });


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
        $(".agregar").button("option", "icons", {primary:'ui-icon-plusthick'}).click(function() {
            $("#dlg_nuevo${abr}").dialog("open");
            return false;
        });
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            var del = $(".del:checked");
            if (del.length > 0) {
                if (confirm("Eliminar todos los ${titulo} marcados?")) {
                    var url = "${createLink(controller: 'proyecto', action:'delete'+may)}";
                    var data = del.serialize();

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: data,
                        success: function(msg) {
                            if (msg == "NO") {
                                $("#spanError1").text("Ha ocurrido un error al eliminar uno o más ${titulo}");
                                $("#divError1").show();
                            }
                            reloadDatos();
                        }
                    });
                }
            } else {
                alert("Seleccione al menos un ${sing} para eliminar");
            }
            return false;
        });


    });
</script>

</body>
</html>