%{--
    TODO:
        1. Verificar el icono q parpadea el incorrecto
        2. Hacer q aparezca el boton agregar cuando se guarda
        3. Validar q la suma de los hijos no sume mas q el total posible
--}%

<%@ page import="mies.Asignacion; mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>P.A.C. de la unidad: ${unidad}</title>

    <style type="text/css">
    .error {
        border-color : #892727;
        background   : #FFCCCC;
    }
    </style>

</head>

<body style="font-size: 10px;">

<div style="margin-left: 10px;">
    <g:link class="btn_arbol btn" controller="entidad" action="arbol_asg"
            style="margin-bottom: 5px;">Unidades Ejecutoras</g:link>
    <a class="btn_arbol btn"  href="${g.createLink(action: 'pacWeb',controller: 'reportes')}/?id=${unidad.id}&anio=${actual.id}">Reporte</a>
</div>

<div style="margin-left: 10px;"><b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg"
                                                     name="anio" optionKey="id" optionValue="anio"
                                                     value="${actual.id}"/></div>

<div id="accordion" style="width:1030px">

    <g:set var="totalPresupuestos" value="${0}"/>
    <g:set var="totalCostos" value="${0}"/>

    <fieldset class="ui-corner-all" style="position: relative;">
        <legend>Asignaciones corrientes de la unidad ejecutora: ${unidad}</legend>
        <table style="margin-top: 40px;">
            <thead>
            <th style="width: 20px;">#</th>
            <th width="70">Fuente</th>
            <th width="75">Presupuesto</th>
            <th width="155">Descripci&oacute;n</th>
            <th width="100">Unidad</th>
            <th width="85">Codigo CPC</th>
            <th width="107">Tipo</th>
            <th width="48">Cant.</th>
            <th width="78">Costo</th>
            <th width="22">C1</th>
            <th width="22">C2</th>
            <th width="22">C3</th>
            <th width="16">Desc</th>
            <th width="16"></th>
            <th width="16"></th>
            <th width="16"></th>
            </thead>
            <tbody>
            <g:set var="cont"  value="${0}"/>
            <g:each in="${asgs}" var="asg" status="i">
                <g:set var="obras" value="${mies.Obra.findAllByAsignacionAndObraIsNull(asg, [sort:'id'])}"/>
                <g:if test="${obras.size() > 0}">
                    <g:set var="asigs" value="${0}"/>
                    <g:each in="${obras}" var="obra" status="k">
                        <g:set var="cont"  value="${cont.toInteger()+1}"/>
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td style="text-align: center;width: 20px;">${cont}</td>
                            <td class="fuente" style="font-size: 11px;">
                                <g:if test="${asigs == 0}">
                                    ${(asg.fuente.toString().size() > 40) ? asg.fuente.toString().substring(0, 40) : asg.fuente}
                                </g:if>
                            </td>
                            <td class="asg" style="font-size: 11px; text-align: right;">
                                <g:if test="${asigs == 0}">
                                    <input type="hidden" class="asg" value="${asg.id}">
                                    <g:formatNumber number="${asg.planificado}" format="###,##0"
                                                    minFractionDigits="2" maxFractionDigits="2"/>
                                </g:if>
                            </td>
                            <td>
                                ${asg.actividad} (${asg.presupuesto.numero})
                            </td>
                            <g:set var="asigs" value="${asigs+1}"/>

                            <td class="unidad">
                                <g:select from="${unidades}" name="unidad" value="${obra.unidad.id}"
                                          optionKey="id" optionValue="descripcion"
                                          style="font-size: 9px;"/>

                            </td>
                            <td class="cp">
                                <input type="hidden" class="cpac" value="${obra.codigoComprasPublicas.id}">

                                <input type="text" id="cpac_${k}${i}${j}" style="width: 70px;color:black"
                                       value="${obra.codigoComprasPublicas.numero}" ${(max?.aprobadoCorrientes != 0) ? "disabled" : 'class="buscar"'}>
                            </td>
                            <td class="tipo">
                                <g:select from="${tipoCompra}" name="tipoCompra" optionKey="id"
                                          optionValue="descripcion" value="${obra.tipoCompra.id}"
                                          style="font-size: 9px;"/>
                            </td>

                            <td class="cantidad">
                                <input type="text" style="width: 30px;color:black"
                                       class="cantidad can_${asg.id}" asg="${asg.id}" max="${asg.planificado}"
                                       value="${g.formatNumber(number: obra.cantidad, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2)}" ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}>
                            </td>

                            <td class="costo">
                                <input type="text" style="width: 60px;;color:black; text-align: right;"
                                       class="costo costo_${asg.id}" asg="${asg.id}" max="${asg.planificado}"
                                       value="${g.formatNumber(number: obra.costo, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2)}" ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}>
                            </td>

                            <td class="ctr1">
                                <input type="checkbox"
                                       class="chk ctr1" ${(obra.cuatrimestre1 == "1") ? "checked" : ""} ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}>
                            </td>

                            <td class="ctr2">
                                <input type="checkbox"
                                       class="chk ctr2" ${(obra.cuatrimestre2 == "1") ? "checked" : ""} ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}>
                            </td>

                            <td class="ctr3">
                                <input type="checkbox"
                                       class="chk ctr3" ${(obra.cuatrimestre3 == "1") ? "checked" : ""} ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}>
                            </td>

                            <td class="desc_obs">
                                <input type="hidden" id="dscr_${k}${i}" class="desc"
                                       value="${obra.descripcion}">

                                <input type="hidden" id="obs_${k}${i}" class="obs"
                                       value="${obra.observaciones}">

                                <a href="#" class="btn_editar" desc="dscr_${k}${i}"
                                   obs="obs_${k}${i}">Editar</a>
                            </td>

                            <td class="agr">
                                <a href="#" class="btn_agregar" desc="agr_${k}${i}" ml="${asg.id}" max="${asg.planificado}"
                                   obs="agr_${k}${i}">Agregar</a>

                                <a href="#" class="btn_eliminar" desc="elm_${k}${i}" ml="${asg.id}" max="${asg.planificado}" iden="${obra.id}"
                                   obs="elm_${k}${i}">Eliminar</a>
                            </td>

                            <td>
                                <g:if test="${max?.aprobadoCorrientes==0}">
                                    <a href="#" class="btn guardar ajax" ml="${asg.id}" iden="${obra.id}"
                                       icono="ico_${k}${i}${j}" max="${asg.planificado}" clase="_${asg.id}"
                                       asg="asignado_${asg.id}">Guardar</a>
                                </g:if>
                            </td>

                            <td class="ui-state-active">
                                <span class="" id="ico_${k}${i}${j}" title="asignado">
                                    <span class="ui-icon ui-icon-check"></span>
                                </span>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <g:set var="cont"  value="${cont.toInteger()+1}"/>
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <g:if test="${max?.aprobadoCorrientes==0}">
                            <td>${cont}</td>
                            <td class="fuente"
                                style="font-size: 11px;">${(asg.fuente.toString().size() > 40) ? asg.fuente.toString().substring(0, 40) : asg.fuente}</td>

                            <td class="asg" style="font-size: 11px; text-align: right;">
                                <input type="hidden" class="asg" value="${asg.id}">
                                <g:formatNumber number="${asg.planificado}" format="###,##0"
                                                minFractionDigits="2" maxFractionDigits="2"/>
                            </td>

                            <td>
                                ${asg.actividad} (${asg.presupuesto.numero})
                            </td>

                            <td class="unidad">
                                <g:select
                                        from="${mies.Unidad.list([sort:'descripcion',order:'asc'])}"
                                        name="unidad" value="" optionKey="id" optionValue="descripcion"
                                        style="font-size: 9px;"/>
                            </td>

                            <td class="cp">
                                <input type="hidden" class="cpac" value="nan">

                                <input type="text" id="cpac_n${k}${i}" style="width: 70px;" class="buscar">
                            </td>

                            <td class="tipo">
                                <g:select from="${tipoCompra}" name="tipoCompra" optionKey="id"
                                          optionValue="descripcion"
                                          style="font-size: 9px;"/>
                            </td>

                            <td class="cantidad">
                                <input type="text" style="width: 30px;" asg="${asg.id}" max="${asg.planificado}"
                                       class="cantidad can_${asg.id}" value="1,00">
                            </td>

                            <td class="costo">
                                <input type="text" style="width: 60px;" asg="${asg.id}" max="${asg.planificado}"
                                       class="costo costo_${asg.id}">
                            </td>

                            <td class="ctr1">
                                <input type="checkbox" class="chk ctr1">
                            </td>

                            <td class="ctr2">
                                <input type="checkbox" class="chk ctr2">
                            </td>

                            <td class="ctr3">
                                <input type="checkbox" class="chk ctr3">
                            </td>

                            <td class="desc_obs">
                                <input type="hidden" id="dscr_${k}${i}" class="desc">

                                <input type="hidden" id="obs_${k}${i}" class="obs">

                                <a href="#" class="btn_editar" desc="dscr_${k}${i}"
                                   obs="obs_${k}${i}">Editar</a>
                            </td>

                            <td class="agr">
                                <a href="#" class="btn_agregar" id="agr_${k}${i}${j}" desc="agr_${k}${i}${j}" ml="${asg.id}" style="display: none;" max="${asg.planificado}"
                                   obs="agr_${k}${i}">Agregar</a>

                                <a href="#" class="btn_eliminar" id="elm_${k}${i}${j}" desc="elm_${k}${i}${j}" ml="${asg.id}" style="display: none;" max="${asg.planificado}"
                                   obs="elm_${k}${i}">Eliminar</a>
                            </td>

                            <td>
                                <a href="#" class="btn guardar ajax" ml="${asg.id}" icono="ico_${k}${i}${j}"
                                   max="${asg.planificado}" clase="_${asg.id}" ident="${k}${i}${j}"
                                   asg="asignado_${asg.id}">Guardar</a>
                            </td>

                            <td class="ui-state-active">
                                <span class="" id="ico_${k}${i}${j}" title="asignado"
                                      style="display: none">
                                    <span class="ui-icon ui-icon-check"></span>
                                </span>
                            </td>
                        </g:if>
                    </tr>
                </g:else>
            </g:each>
            </tbody>
        </table>

        <div id="divTotalPresupuestos" style="position: absolute; top: 2px; left: 2px;">
            <span style="font-weight: bold; margin-right: 5px;">Total Presupuestos:</span>
            <span id="totalPresupuestos">

            </span>
        </div>

        <div id="divTotalCostos" style="position: absolute; top: 2px; left: 222px;">
            <span style="font-weight: bold; margin-right: 5px;">Total Costos:</span>
            <span id="totalCostos">

            </span>
        </div>

        <div class="ui-corner-all" style="height: 15px;margin-top: 5px;">
            %{--<div style="width: 100px;float: left"><b>Monto:</b> ${act.monto}</div><div style="width: 100px;float: left;margin-left: 10px;"><b>Por asignar:</b></div> <div id="asignado_${act.id}" class="asignado" style="width: 100px;float: left" monto="${act.monto}">${(act.monto-asignado.toDouble()).toFloat().round(2)}</div><br>--}%
        </div>

    </fieldset>

</div>

<div id="buscar">
    <input type="hidden" id="id_txt">

    <div>
        Buscar por:
        <select id="tipo">
            <option value="1">Número</option>
            <option value="2">Descripción</option>
        </select>

        <input type="text" id="par" style="width: 160px;">

        <a href="#" class="btn" id="btn_buscar">Buscar</a>
    </div>

    <div id="resultado" style="width: 450px;margin-top: 10px;" class="ui-corner-all"></div>
</div>

<div id="dlg_desc_obs">
    <input type="hidden" id="hid_desc">

    <input type="hidden" id="hid_obs">
    <b>Descripción (255 caracteres):</b><br>

    <textArea name="desc" rows="6" cols="40" id="dlg_desc" ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}
              style="color: black"></textArea>
    <b>Observaciones (127 caracteres):</b><br>

    <textArea name="desc" rows="4" cols="40" id="dlg_obs" ${(max?.aprobadoCorrientes != 0) ? "disabled" : ""}
              style="color: black"></textArea> <br>

    <div id="dlg_error"
         style="width: 350px;height: 60px;margin-top: 5px;margin-left: 2px;display: none;padding: 3px;line-height: 24px;border:1px solid red;"
         class="ui-corner-all"></div>
</div>

%{--TODO validar al rato de guardar, poner en disabled los campos despues de guardar--}%

<script type="text/javascript">

    function sumas() {

        var tp = 0, tc = 0;

        $(".asg").each(function () {
            var v = $(this).text().trim();
            v = str_replace(".", "", v);
            v = str_replace(",", ".", v);
            v = parseFloat(v);
            if (!isNaN(v)) {
                tp += v;
            }
        });

        $("input.costo").each(function () {
            var v = $(this).val().trim();
            v = str_replace(".", "", v);
            v = str_replace(",", ".", v);
            v = parseFloat(v);
            if (!isNaN(v)) {
                var cant = parseFloat($(this).parent().prev().children().first().val());
                tc += (cant * v);
            }
        });

        $("#totalPresupuestos").html(number_format(tp, 2, ",", "."));
        $("#totalCostos").html(number_format(tc, 2, ",", "."));
    }

    function validarMax(asg, max) {
        var total = 0;

        var arr = new Array();

        $(".error").removeClass("error");

        $(".costo [asg=" + asg + "]").each(function () {
            var costo = $(this).val();
            var cant = parseFloat($(this).parent().prev().children().first().val());

            arr.push($(this).parent().prev().children().first());
            arr.push($(this));

            costo = str_replace(".", "", costo);
            costo = str_replace(",", ".", costo);
            costo = parseFloat(costo);
            $(this).val(number_format(costo, 2, ",", ".")).css({textAlign:"right"});

//                    //console.log(costo + " x " + cant + " = " + (costo * cant) + "          " + total);

            total += (cant * costo);
        });

        if (total > max) {
            for (var i = 0; i < arr.length; i++) {
                arr[i].addClass("error");
            }
            alert("La suma de los campos marcados con rojo (" + number_format(total, 2, ",", ".") + ") debe ser inferior a " + number_format(max, 2, ",", "."));
            return false;
        } else {
            return true;
        }
    }

    $(function () {
        sumas();

        $(".costo").blur(function () {
            validarMax($(this).attr("asg"), parseFloat($(this).attr("max")));
        });

        $(".cantidad").blur(function () {
            validarMax($(this).attr("asg"), parseFloat($(this).attr("max")));
        });

        $(".btn").button();

        $(".btn_eliminar").button({
            icons:{
                primary:"ui-icon-trash"
            },
            text:false
        }).css({
            width:18,
            height:18
        }).click(function () {
            if (confirm("Desea eliminar esta entrada?")) {
                var btn = $(this);
                var id = btn.attr("iden");

                $.ajax({
                    type:"POST",
                    url:"${createLink(action:'eliminarFila',controller:'obra')}",
                    data:{
                        id:id
                    },
                    success:function (msg) {
                        if (msg == "OK") {
                            window.location.reload(true);
                        }
                    }
                });

            }
        });

        $(".btn_agregar").button({
            icons:{
                primary:"ui-icon-plusthick"
            },
            text:false
        }).css({
            width:18,
            height:18
        }).click(function () {
            if (confirm("Desea crear una nueva entrada en el plan de compras?")) {
                var band = true
                var mensaje = ""
                var error
                var max = $(this).attr("max") * 1
                var asignado = 0
                var padre = $(this).parent().parent()
                var boton = $(this)
                var costo = 0
                var cantidad = 1
                var unidad = padre.find(".unidad").children().val()
                var cp = padre.find(".cp").find(".cpac").val()
                var tipo = padre.find(".tipo").children().val()
                var c1 = 0
                var c2 = 0
                var c3 = 0
                var asg = boton.attr("ml")
                var icono = $("#" + $(this).attr("icono"))
                var valor = 0

                $.ajax({
                    type:"POST",
                    url:"${createLink(action:'agregarFila',controller:'obra')}",
                    data:"costo=" + costo + "&unidad.id=" + unidad + "&cantidad=" + cantidad + "&tipoCompra.id=" + tipo + "&codigoComprasPublicas.id=" + cp + "&cuatrimestre1=" + c1 + "&cuatrimestre2=" + c2 + "&cuatrimestre3=" + c3 + "&asignacion.id=" + asg + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                    success:function (msg) {
                        window.location.reload(true);
                    }
                });
            }
        });

        $(".btn_editar").button({
            icons:{
                primary:"ui-icon-pencil"
            },
            text:false
        }).click(function () {
            $("#hid_desc").val($(this).attr("desc"))
            $("#hid_obs").val($(this).attr("obs"))
            $("#dlg_desc").val($("#" + $(this).attr("desc")).val())
            $("#dlg_obs").val($("#" + $(this).attr("obs")).val())
            $("#dlg_error").hide().html("")
            $("#dlg_desc_obs").dialog("open")
        });

        $("#anio_asg").change(function () {
            location.href = "${createLink(controller:'obra',action:'pacCorrientes')}?id=${unidad.id}&anio=" + $(this).val()
        });

        $(".guardar").button({
            icons:{
                primary:"ui-icon-disk"
            },
            text:false
        }).click(function () {
            var boton = $(this)
            var max = $(this).attr("max") * 1;
            var asg = boton.attr("ml")
            var idObra = $(this).attr('iden')

            if (validarMax(asg, max)) {
                var band = true
                var mensaje = ""
                var error
                var asignado = 0
                var padre = $(this).parent().parent()

                var costo = padre.find(".costo").children().val();
                costo = str_replace(".", "", costo);
                costo = str_replace(",", ".", costo);
                costo = parseFloat(costo);
                var cantidad = padre.find(".cantidad").children().val();
                cantidad = str_replace(".", "", cantidad);
                cantidad = str_replace(",", ".", cantidad);
                cantidad = parseFloat(cantidad);
                var unidad = padre.find(".unidad").children().val()
                var cp = padre.find(".cp").find(".cpac").val()
                var tipo = padre.find(".tipo").children().val()
                var c1 = (padre.find(".ctr1").find(".ctr1").attr("checked") == "checked") ? 1 : 0
                var c2 = (padre.find(".ctr2").find(".ctr2").attr("checked") == "checked") ? 1 : 0
                var c3 = (padre.find(".ctr3").find(".ctr3").attr("checked") == "checked") ? 1 : 0
                var desc = padre.find(".desc_obs").find(".desc").val()
                var obs = padre.find(".desc_obs").find(".obs").val()

                var icono = $("#" + $(this).attr("icono"));
                var agr = $("#agr_" + $(this).attr("ident"));
                var elm = $("#elm_" + $(this).attr("ident"));
                var valor = 0
                if (isNaN(costo) || isNaN(cantidad)) {
                    band = false
                    mensaje = "El costo y la cantidad deben ser números"
                } else {
                    valor = cantidad * costo
                    if (valor > max) {
                        band = false
                        mensaje = "El valor total (" + valor + ") supera al monto de la asignación (" + max + ")"
                    } else {
                        if (valor == 0) {
                            band = false
                            mensaje = "El costo y la cantidad deben ser mayores a 0"
                        }
                    }
                }
                if (c1 + c2 + c3 < 1) {
                    band = false
                    mensaje = "Seleccione al menos un cuatrimestre"
                }

                if (isNaN(cp)) {
                    band = false
                    mensaje = "Seleccione un código de compras publicas"
                }

                ////console.log("costo "+costo+" cantidad "+cantidad+" unidad "+unidad+" cp "+cp+" tipo "+tipo+" c1 "+c1+" c2 "+c2+" c3 "+c3+" desc "+desc+" obs "+obs+" asg "+asg )

                if (band) {
                    $.ajax({
                        type:"POST",
                        url:"${createLink(action:'guardarObra',controller:'obra')}",
//                        data:"costo=" + costo + "&unidad.id=" + unidad + "&cantidad=" + cantidad + "&tipoCompra.id=" + tipo + "&codigoComprasPublicas.id=" + cp + "&cuatrimestre1=" + c1 + "&cuatrimestre2=" + c2 + "&cuatrimestre3=" + c3 + "&descripcion=" + desc + "&observaciones=" + obs + "&asignacion.id=" + asg + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                        data:"costo=" + costo + "&unidad.id=" + unidad + "&cantidad=" + cantidad + "&tipoCompra.id=" + tipo + "&codigoComprasPublicas.id=" + cp + "&cuatrimestre1=" + c1 + "&cuatrimestre2=" + c2 + "&cuatrimestre3=" + c3 + "&descripcion=" + desc + "&observaciones=" + obs + "&asignacion.id=" + asg + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + idObra),
                        success:function (msg) {
                            if (msg * 1 >= 0) {
                                var totalCostos = 0;

//                                                $("input.costo").each(function () {
//                                                    var cant = $(this).parent().prev().children().first().val();
//                                                    var cost = $(this).val();
//                                                    cant = parseFloat(cant);
//                                                    cost = parseFloat(cost);
//                                                    totalCostos += (cost * cant);
//                                                });
//
//                                                $("#totalCostos").text(number_format(totalCostos, 2, ',', '.'));
                                boton.attr("iden", msg);
                                icono.show("pulsate");
                                agr.show();
                                elm.show();
                                var v = number_format(costo, 2, ",", ".");
                                padre.find(".costo").children().css({textAlign:"right"}).val(v);
                                sumas();

                            } else {
                                alert("Error al guardar los datos")
                            }

                        }
                    });
                } else {
                    alert(mensaje)
                }
            }
            return false;
        });

        $(".buscar").click(function () {
            $("#id_txt").val($(this).attr("id"))
            $("#buscar").dialog("open")
        });
        $("#btn_buscar").click(function () {
            $.ajax({
                type:"POST",
                url:"${createLink(action:'buscarCcp',controller:'asignacion')}",
                data:"parametro=" + $("#par").val() + "&tipo=" + $("#tipo").val(),
                success:function (msg) {
                    $("#resultado").html(msg)
                }
            });
        });
        $("#buscar").dialog({
            title:"Cuentas presupuestarias",
            width:620,
            height:500,
            autoOpen:false,
            modal:true
        })
        $("#dlg_desc_obs").dialog({
            title:"Editar descripción y observaciones",
            width:400,
            height:400,
            autoOpen:false,
            modal:true,
            buttons:{
                "Aceptar":function () {
                    if ($("#dlg_desc").val().length < 255) {
                        if ($("#dlg_obs").val().length < 127) {
                            $("#" + $("#hid_desc").val()).val($("#dlg_desc").val())
                            $("#dlg_desc").val("")
                            $("#" + $("#hid_obs").val()).val($("#dlg_obs").val())
                            $("#dlg_obs").val("")
                            $("#dlg_desc_obs").dialog("close")
                        } else {
                            $("#dlg_error").html("El campo observaciones no puede contener mas de 127 caracteres. Actual(" + $("#dlg_obs").val().length + ")")
                            $("#dlg_error").addClass("error")
                            $("#dlg_error").show("pulsate")
                        }
                    } else {
                        $("#dlg_error").html("El campo descripción no puede contener mas de 255 caracteres. Actual(" + $("#dlg_dscr").val().length + ")")
                        $("#dlg_error").addClass("error")
                        $("#dlg_error").show("pulsate")
                    }
                }

            }
        })
    });
</script>

</body>
</html>