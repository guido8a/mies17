<%@ page import="mies.TipoResponsable; mies.ResponsableProyecto" %>

<style type="text/css">
select.field {
    width : 235px;
}

.datepicker {
    width : 215px;
}
</style>

<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>

<g:if test="${usuarios.size() > 0 ? true : false}">
    <g:form action="saveResponsable" class="frmResponsableProyecto" method="post">
        <table width="100%" class="ui-widget-content ui-corner-all">
            <thead>
                <tr>
                    <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                        Agregar Responsable
                    </td>
                </tr>
            </thead>

            <tbody>

                <tr class="prop">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.tipo.label" default="Tipo de responsable"/>
                    </td>
                    <td class="" valign="middle">
                        <g:select class="field required ui-widget-content ui-corner-all" name="tipo" id="tipo"
                                  title="${ResponsableProyecto.constraints.tipo.attributes.mensaje}" noSelection="['': '']"
                                  from="${TipoResponsable.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion"/>
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.responsable.label" default="Responsable"/>
                    </td>
                    <td class="" valign="middle" id="tdResponsable">
                        <g:select class="field required ui-widget-content ui-corner-all" name="responsable"
                                  title="${ResponsableProyecto.constraints.responsable.attributes.mensaje}"
                                  from="" optionKey="id" noSelection="['': '']" optionValue="persona"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.desde.label" default="Desde"/>
                    </td>
                    <td class="" valign="middle">
                        <g:textField class="datepicker field required ui-widget-content ui-corner-all"
                                     name="desde"
                                     title="${ResponsableProyecto.constraints.desde.attributes.mensaje}"
                                     id="desde"/>
                    </td>

                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.hasta.label" default="Hasta"/>
                    </td>
                    <td class="" valign="middle">
                        <g:textField class="datepicker field required ui-widget-content ui-corner-all"
                                     name="hasta"
                                     title="${ResponsableProyecto.constraints.hasta.attributes.mensaje}"
                                     id="hasta"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td class="label " valign="middle">
                        <g:message code="responsableProyecto.observaciones.label" default="Observaciones"/>
                    </td>
                    <td class="" valign="middle" colspan="4">
                        <g:textField name="observaciones" id="observaciones"
                                     title="${ResponsableProyecto.constraints.observaciones.attributes.mensaje}"
                                     style="width: 560px;" class="field ui-widget-content ui-corner-all"
                                     minLenght="1"
                                     maxLenght="127"/>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 1px; text-align:right;">
                        <a href="#" id="btnAgregarResponsable">Agregar</a>
                    </td>
                </tr>
            </tfoot>
        </table>
    </g:form>

    <div id="ajxDivResponsables" style="margin-top:5px;">
        <table width="100%" class="ui-widget-content ui-corner-all">
            <thead>
                <tr>
                    <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                        Responsables actuales
                    </td>
                </tr>
                <tr>
                    <th>Responsable</th>
                    <th>Tipo</th>
                    <th>Desde</th>
                    <th>Hasta</th>   
                    <th>Observaciones</th>
                    <th width="35">&nbsp;</th>
                </tr>
            </thead>

            <tbody id="tbResponsables">
                <g:each in="${responsables}" var="res">
                    <tr class="${res.tipo.id}_${res.responsable.id}" id="${res.id}">
                        <td class="responsable" id="${res.responsable.id}">
                            ${res.responsable.persona.nombre} ${res.responsable.persona.apellido}
                        </td>
                        <td class="tipo" id="${res.tipo.descripcion}">
                            ${res.tipo.descripcion}
                        </td>
                        <td class="desde">
                            ${res.desde.format("dd-MM-yyyy")}
                        </td>
                        <td class="hasta">
                            ${res.hasta.format("dd-MM-yyyy")}
                        </td>
                        <td class="observaciones">
                            ${res.observaciones}
                        </td>
                        <td>
                            <a href="#" class="btnDeleteRes" id="dl_${res.id}">Dar de baja</a>
                            %{--<a href="#" class="btnUpdateRes" id="up_${res.id}">Editar</a>--}%
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>

</g:if>
<g:else>
    <div style="padding: 0 .7em;" class="ui-state-highlight ui-corner-all">
        <p>
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-info"></span>
            <strong>Atenci&oacute;n</strong><br/>
            No existen usuarios en esta unidad ejecutora. Agregue usuarios para poder asignar responsables.
        </p>
    </div>
</g:else>


<script type="text/javascript">

    function reloadResponsables() {
        var tipo = $("#tipo").val();
        var unidad = "${unidad.id}";
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'entidad', action: 'getResponsables')}",
            data    : {
                tipo   : tipo,
                unidad : unidad
            },
            success : function (msg) {
                $("#tdResponsable").html(msg);
            }
        });
    }

    $(function () {
        var myForm = $(".frmResponsableProyecto");

        $("#tipo").change(function () {
            reloadResponsables();
        });


        $(".btnDeleteRes").livequery(function () {
            $(".btnDeleteRes").button({
                icons : {
                    primary : "ui-icon-triangle-1-s"
                },
                text  : false
            }).css({
                        width  : 18,
                        height : 18
                    }).click(function () {

                        var btn = $(this);
                        var tr = btn.parents("tr");
                        var id = tr.attr("id");

                        $.ajax({
                            type    : "POST",
                            async   : true,
                            url     : "${createLink(controller:'entidad', action: 'bajaResponsable')}",
                            data    : {
                                id     : id,
                                unidad : "${unidad.id}"
                            },
                            success : function (msg) {
                                if (msg == "NO") {
                                    //console.log("ERROR");
                                } else {
                                    $("#ajxDivResponsables").html(msg);
                                    $(".field").val("");
                                    reloadResponsables();
                                    $.box({
                                        imageClass : "box_info",
                                        title      : "",
                                        iconClose  : false,
                                        text       : "El responsable ha sido dado de baja.",
                                        dialog     : {
                                            resizable : false,
                                            draggable : false,
                                            buttons   : {
                                                "Aceptar" : function () {
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    });
        });

//        $(".btnUpdateRes").livequery(function () {
//            $(".btnUpdateRes").button({
//                icons : {
//                    primary : "ui-icon-pencil"
//                },
//                text  : false
//            }).css({
//                        width  : 18,
//                        height : 18
//                    });
//
//        });


        $("#btnAgregarResponsable").button({
            icons : {
                primary : "ui-icon-plusthick"
            }
        }).click(function () {

                    var continuar = true;
                    var ft = false;
                    var msg = "";
                    var tipo = $("#tipo").val();
                    var resp = $("#responsable").val();
                    var strTipo = $("#tipo option:selected").text();
                    var strResp = $("#responsable option:selected").text();
                    var tb = $("#tbResponsables");

                    var tr = tb.find("." + tipo + "_" + resp);
                    var cant = tr.length;

//                    console.group("validaciones");
//                    console.log("Hay " + cant + " de tipo " + tipo + "_" + resp);
//                    console.groupEnd();

                    //si ya hay uno del mismo tipo (misma persona mismo tipo)
                    if (cant == 1) {
                        //verifico si esta en el mismo periodo

                        var d = trim(tr.find(".desde").text());
                        var h = trim(tr.find(".hasta").text());

//                        console.group("elementos");
//                        console.log(tr);
//                        console.log(d);
//                        console.log(h);
//                        console.groupEnd();

                        var di = $("#desde").val();
                        var hi = $("#hasta").val();

                        var desde = Date.parse(d);
                        var hasta = Date.parse(h);

                        var desdei = Date.parse(di);
                        var hastai = Date.parse(hi);

//                        console.group("FECHAS!");
//                        console.log(desde);
//                        console.log(hasta);
//                        console.log(desdei);
//                        console.log(hastai);
//                        console.groupEnd();

                        if (desdei.isAfterE(hasta)) {
//                            console.log("YES");
                            ft = true;
                            continuar = true;
                        } else {
                            msg = "No puede ingresar nuevamente a " + strResp + " como responsable de " + strTipo + " antes del " + hasta.toString('dd-MM-yyyy');
                            $.box({
                                imageClass : "box_error",
                                title      : "Error",
                                iconClose  : false,
                                text       : msg,
                                dialog     : {
                                    resizable : false,
                                    draggable : false,
                                    buttons   : {
                                        "Aceptar" : function () {
                                        }
                                    }
                                }
                            });
                            continuar = false;
                        }
                    }

                    if (!myForm.valid()) {
                        continuar = false;
                    }

                    if (continuar) {
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(controller:'entidad', action: 'saveResponsable')}",
                            data    : myForm.serialize() + "&unidad=${unidad.id}",
                            success : function (msg) {
                                if (msg == "NO") {
                                    //console.log("ERROR");
                                } else {
                                    $("#ajxDivResponsables").html(msg);
                                    $(".field").val("");
                                    reloadResponsables();
                                    if (ft) {
                                        $.box({
                                            imageClass : "box_info",
                                            title      : "",
                                            iconClose  : false,
                                            text       : "El responsable ha sido guardado en un periodo futuro. Puede verlo en la sección Historial.",
                                            dialog     : {
                                                resizable : false,
                                                draggable : false,
                                                buttons   : {
                                                    "Aceptar" : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        });
                    }

                    return false;
                });

        $('#desde').datepicker({
            changeMonth : true,
            changeYear  : true,
            dateFormat  : 'dd-mm-yy',
            minDate     : new Date(),
            onClose     : function (dateText, inst) {
                var date = $(this).datepicker('getDate');
                $("#hasta").datepicker("option", "minDate", date.add(1).days());
            }
        });

        $('#hasta').datepicker({
            changeMonth : true,
            changeYear  : true,
            dateFormat  : 'dd-mm-yy',
            minDate     : new Date().add(2).days(),
            onClose     : function (dateText, inst) {
            }
        });


        // Tooltip de informacion para cada field (utiliza el atributo title del textfield)
        var elems = $('.field')
                .each(function (i) {
                    $.attr(this, 'oldtitle', $.attr(this, 'title'));
                })
                .removeAttr('title');
        $('<div />').qtip(
                {
                    content  : ' ', // Can use any content here :)
                    position : {
                        target : 'event' // Use the triggering element as the positioning target
                    },
                    show     : {
                        target : elems,
                        event  : 'click mouseenter focus'
                    },
                    hide     : {
                        target : elems,
                        delay  : 0,
                        leave  : false
                    },
                    events   : {
                        show : function (event, api) {
                            // Update the content of the tooltip on each show
                            var target = $(event.originalEvent.target);
                            api.set('content.text', target.attr('title'));
                        }
                    },
                    style    : {
                        classes : 'ui-tooltip-rounded ui-tooltip-cream'
                    }
                });
        // fin del codigo para los tooltips

        // Validacion del formulario
        myForm.validate({
            errorClass     : "errormessage",
            onkeyup        : false,
            errorElement   : "em",
            errorClass     : 'error',
            validClass     : 'valid',
            errorPlacement : function (error, element) {
                // Set positioning based on the elements position in the form
                var elem = $(element),
                        corners = ['right center', 'left center'],
                        flipIt = elem.parents('span.right').length > 0;

                // Check we have a valid error message
                if (!error.is(':empty')) {
                    // Apply the tooltip only if it isn't valid
                    elem.filter(':not(.valid)').qtip({
                        overwrite : false,
                        content   : error,
                        position  : {
                            my       : corners[ flipIt ? 0 : 1 ],
                            at       : corners[ flipIt ? 1 : 0 ],
                            viewport : $(window)
                        },
                        show      : {
                            event : false,
                            ready : true
                        },
                        hide      : false,
                        style     : {
                            classes : 'ui-tooltip-rounded ui-tooltip-red' // Make it red... the classic error colour!
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
            success        : $.noop // Odd workaround for errorPlacement not firing!
        })
        ;
        //fin de la validacion del formulario
    });
</script>