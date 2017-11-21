<%@ page import="mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones de la unidad: ${unidad}</title>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}" style="" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}" type="text/css"/>

    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript" charset="" language="JavaScript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}" type="text/javascript" language="JavaScript"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>
    <style type="text/css">
    .btnCambiarPrograma {
        width  : 16px;
        height : 16px;
    }
    </style>

</head>

<body>

<div style="margin-left: 10px;">
    %{--<g:if test="${max?.aprobadoCorrientes!=0}">--}%
    %{--<g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad" params="${[unidad:unidad.id,anio:actual.id]}">Solicitar modificación</g:link>--}%
    %{--</g:if>--}%
    <g:link class="btn" controller="asignacion" action="programacionAsignaciones" params="[id:unidad.id,anio:actual.id]">Programación</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    <a href="${createLink(controller: 'asignacion', action: 'asignacionesCorrientesv2')}?id=${unidad.id}&anio=${actual.id}&todo=1" class="btn">Ver todas</a>

    <a href="#" id="btnReporte">Reporte</a>

    <div style="margin-top: 15px;">

        <table width="600">
            <tr>
                <th>Año</th>
                <th>Programa</th>
                <th>Componente</th>
            </tr>

            <tr>
                <td><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/></td>

                <td><g:select from="${programas}" id="programa" optionKey="id" name="programa" class="programa" value="${programa.id}"/></td>

                %{--<td><g:select from="${componentes}" id="componente" optionKey="id" name="componente" class="componente" noSelection="['-1':'Seleccione...']"/></td>--}%
                <td><g:select from="${componentes}" id="componente" optionKey="id" name="componente" class="componente"/></td>
            </tr>
        </table>

    </div>
</div>

<g:if test="${flash.message}">
    <div class="${flash.clase}">
        ${flash.message}
    </div>
</g:if>

<fieldset class="ui-corner-all" style="min-height: 110px;font-size: 11px;">
    <legend>
        Ingreso de datos
    </legend>
    <g:if test="${max}">
        <g:if test="${max?.aprobadoCorrientes==0}">
            <table style="width: 1060px;">
                <thead>
                <th style="width: 300px">Actividad</th>
                <th style="width: 50px;">Partida</th>
                <th style="width: 190px">Desc. Presupuestaria</th>
                <th style="width: 150px;">Fuente</th>
                <th style="width: 50px;">Presupuesto</th>
                <th style="width: 50px;">Meta/Indicador</th>
                <th style="width: 50px;"></th>
                </thead>
                <tbody>

                <tr class="odd">
                    <td class="actividad">
                        <textarea style="width: 300px;height: 40px;resize: vertical;" id="actv"></textarea>
                    </td>

                    <td class="prsp">
                        <input type="hidden" class="prsp" value="" id="prsp_id">

                        <input type="text" id="prsp_num" class="buscar" style="width: 50px;color:black">
                    </td>

                    <td class="desc" id="desc" style="width: 200"></td>

                    <td class="fuente">
                        <g:select from="${fuentes}" id="fuente" optionKey="id" optionValue="descripcion" name="fuente" class="fuente" style="width: 160px;"/>
                    </td>

                    <td class="valor">
                        <input type="text" style="width: 70px;color:black" class="valor" id="valor_txt" value="0">

                    </td>

                    <td class="meta_indi" style="text-align: center">
                        <input type="hidden" id="meta" class="desc">

                        <input type="hidden" id="indi" class="obs" value="">

                        <a href="#" class="btn_editar" desc="meta" obs="indi">Editar</a>
                    </td>

                    <td>
                        <a href="#" id="guardar_btn" class="btn guardar ajax" iden="" icono="ico_001" clase="act_" tr="" anio="${actual.id}">Guardar</a>
                    </td>
                </tr>

                </tbody>
            </table>

            <div id="dlg_desc_obs">
                <input type="hidden" id="hid_desc">

                <input type="hidden" id="hid_obs">
                <b>Meta (255 caracteres):</b><br>

                <textArea name="desc" rows="6" cols="40" id="dlg_desc" ${(max?.aprobadoCorrientes!= 0) ? "disabled" : ""}
                          style="color: black"></textArea>
                <b>Indicador (255 caracteres):</b><br>

                <textArea name="desc" rows="6" cols="40" id="dlg_obs" ${(max?.aprobadoCorrientes!= 0) ? "disabled" : ""}
                          style="color: black"></textArea> <br>

                <div id="dlg_error"
                     style="width: 350px;height: 60px;margin-top: 5px;margin-left: 2px;display: none;padding: 3px;line-height: 24px;border:1px solid red;"
                     class="ui-corner-all"></div>
            </div>
        </g:if>
        <g:else>
            Las asignaciones para este año ya han sido aprobadas
        </g:else>
    </g:if>
    <g:else>
        La unidad ejecutora no tiene asignado presupuesto para este año
    </g:else>
</fieldset>
<fieldset class="ui-corner-all" style="min-height: 100px;font-size: 11px">
    <legend>
        Detalle
    </legend>
    <g:set var="total" value="0"></g:set>
    <table style="width: 100%; margin-bottom: 10px;">
        <thead>

        <th style="width: 220px">Programa</th>
        <th style="width: 120px">Componente</th>
        <th style="width: 240px">Actividad</th>
        <th style="width: 60px;">Partida</th>
        <th style="width: 200px">Desc. Presupuestaria</th>

        <th>Fuente</th>
        <th>Presupuesto</th>
        <th></th>
        <th></th>
        </thead>
        <tbody>
        <g:each in="${asignaciones}" var="asg" status="i">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="det_${i}">

                <td class="programa">
                    ${asg.programa.descripcion}
                    <g:if test="${actual.estado == 0}">
                        <a href="#" class="btnCambiarPrograma" id="btn_${asg.id}">Cambiar</a>
                    </g:if>
                </td>

                <td>
                    ${asg.componente}
                </td>

                <td class="actividad">
                    ${asg.actividad}
                </td>

                <td class="prsp" style="text-align: center">
                    ${asg.presupuesto.numero}
                </td>

                <td class="desc" style="width: 200">
                    ${asg.presupuesto.descripcion}
                </td>

                <td class="fuente">
                    ${asg.fuente.descripcion}
                </td>

                <td class="valor" style="text-align: right">
                    <g:formatNumber number="${(asg.redistribucion==0)?asg.planificado.toDouble():asg.redistribucion.toDouble()}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                    <g:set var="total" value="${total.toDouble().round(2)+((asg.redistribucion==0)?asg.planificado.toDouble().round(2):asg.redistribucion.toDouble().round(2))}"></g:set>
                </td>

                <td style="text-align: center">
                    <g:if test="${max?.aprobadoCorrientes==0}">
                        <a href="#" class="btn editar ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}" prog="${asg.programa.id}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}" fuente="${asg.fuente.id}" valor="${(asg.redistribucion == 0) ? asg.planificado.toDouble().round(2) : asg.redistribucion.toDouble().round(2)}" actv="${asg.actividad}" meta="${asg.meta}" indi="${asg.indicador}" comp="${asg?.componente?.id}">Editar</a>
                    </g:if>
                </td>

                <td style="text-align: center">
                    <g:if test="${max?.aprobadoCorrientes==0}">
                        <a href="#" class="btn eliminar ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}"
                           prog="${asg.programa.id}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}"
                           fuente="${asg.fuente.id}" valor="${(asg.redistribucion == 0) ? asg.planificado.toDouble().round(2) : asg.redistribucion.toDouble().round(2)}" actv="${asg.actividad}"
                           meta="${asg.meta}" indi="${asg.indicador}">Eliminar</a>
                    </g:if>
                </td>
            </tr>

        </g:each>
        </tbody>
    </table>

    <div style="position: absolute;top:5px;right:10px;font-size: 15px;">
        <b>Total programa actual:</b>
        <g:formatNumber number="${total.toDouble()}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:25px;right:10px;font-size: 15px;">
        <b>Total Unidad:</b>
        <g:formatNumber number="${totalUnidad}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:45px;right:10px;font-size: 15px;">
        <b>M&aacute;ximo Corrientes:</b>
        <g:formatNumber number="${maxUnidad}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:65px;right:10px;font-size: 17px;">
        <b>Restante:</b>
        <g:formatNumber number="${maxUnidad - totalUnidad}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

</fieldset>


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

<div id="dlg_buscar_act">
    <input type="hidden" id="id_txt_act">

    <div>
        Buscar por:
        <select id="tipo_act">
            <option value="1">Número</option>
            <option value="2">Descripción</option>
        </select>

        <input type="text" id="par_act" style="width: 160px;">

        <a href="#" class="btn" id="btn_buscar_act">Buscar</a>
    </div>

    <div id="resultado_act" style="width: 450px;margin-top: 10px;" class="ui-corner-all"></div>
</div>


<div id="dlgProg">
    <form id="frmCmbPrg">
        <input type="hidden" id="idAsg" name="idAsg"/>

        <p id="pTexto">
            Seleccione el nuevo programa
        </p>
        <g:select from="${programas}" name="progs" optionKey="id" value="${programa.id}"/>
    </form>
</div>

<script type="text/javascript">

    var valorEditar = 0;

    function validar(tipo) {

        var prsp = $("#prsp_id").val();
        var valorTxt = $("#valor_txt");
        var prspField = $("#prsp_num");
        var valor = valorTxt.val();
        var actField = $("#actv");
        var actividad = actField.val();
        var band = true;

        var meta = $("#meta").val();
        var indi = $("#indi").val();
        valorTxt.removeClass("error");
        prspField.removeClass("error");

        valor = str_replace(".", "", valor);
        valor = str_replace(",", ".", valor);

        var max = parseFloat("${(maxUnidad - totalUnidad).toDouble().round(2)}");
        max = (max * 1 + valorEditar * 1);

        var mensaje, error;
        if (isNaN(valor)) {
            mensaje = "Error: El valor de la asignación debe ser un número";
            band = false;
            error = valorTxt;
        } else {
            valor = parseFloat(valor);
            valorTxt.val(number_format(valor, 2, ",", "."));
            if (valor > max) {
                mensaje = "Error: El valor de la asignación debe ser un número menor a " + number_format(max, 2, ",", ".");
                band = false;
                error = valorTxt;
            }
            if (tipo == 0) {
                if (valor <= 0) {
                    mensaje = "Error: El valor de la asignación debe ser un número mayor a cero";
                    band = false;
                    error = valorTxt;
                }
                if (isNaN(prsp)) {
                    prsp = 0
                }
                if (prsp * 1 == 0) {
                    mensaje = "Error: Seleccione una partida presupuestaria";
                    band = false;
                    error = prspField;
                }
                if (actividad.length == 0) {
                    mensaje = "Error: Debe llenar el campo actividad";
                    band = false;
                    error = actField;
                }
                if (meta.length < 2) {
                    mensaje = "Error: Debe llenar el campo meta";
                    band = false;
                    error = $(".btn_editar");
                }
                if (indi.length < 2) {
                    mensaje = "Error: Debe llenar el campo indicador";
                    band = false;
                    error = $(".btn_editar");
                }
            }
        }

        if (!band) {
            alert(mensaje);
            error.addClass("error").show("pulsate");
        }
        return band;
    }

    $(function () {

        $("#valor_txt").blur(function () {
            validar(1);
        });

        $("#dlgProg").dialog({
            width:430,
            modal:true,
            title:"Cambiar el programa",
            autoOpen:false,
            open:function (event, ui) {
                $("#progs").val(${programa.id});
                $('select#progs').selectmenu("value", "${programa.id}");
            },
            buttons:{
                "Aceptar":function () {
                    var data = $("#frmCmbPrg").serialize();
                    var url = "${createLink(action: 'cambiarPrograma')}?" + data + "&programa=${programa.id}&anio=${actual.id}&id=${unidad.id}";
//                            console.log(url);
                    location.href = url;
                },
                "Cancelar":function () {
                    $(this).dialog("close");
                }
            }
        });
        $(".btnCambiarPrograma").button({
            icons:{
                primary:"ui-icon-shuffle"
            },
            text:false
        }).click(function () {
                    var id = $(this).attr("id");
                    var parts = id.split("_");
                    var act = $(this).parents("tr").find(".actividad").text().trim();
                    $("#idAsg").val(parts[1]);
                    $("#pTexto").html("Seleccione el nuevo programa para la asignación:<br/> <b>" + act + "</b>");
                    $("#dlgProg").dialog("open");
                    return false;
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

        $("#btnReporte").button({
            icons:{
                primary:"ui-icon-calculator"
            }
        }).click(function () {
                    var url = "${createLink(controller: 'reportes', action: 'poaReporteWeb', id: unidad.id)}?anio=" + $("#anio_asg").val();
                    window.open(url);
                });


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
                            $("#dlg_error").html("El campo meta no puede contener mas de 255 caracteres. Actual(" + $("#dlg_obs").val().length + ")")
                            $("#dlg_error").addClass("error")
                            $("#dlg_error").show("pulsate")
                        }
                    } else {
                        $("#dlg_error").html("El campo indicador no puede contener mas de 255 caracteres. Actual(" + $("#dlg_dscr").val().length + ")")
                        $("#dlg_error").addClass("error")
                        $("#dlg_error").show("pulsate")
                    }
                }

            }
        });

        $("#progs").selectmenu({width:380, height:50})
        $("[name=programa]").selectmenu({width:380, height:50})
        $("#componente").selectmenu({width:340, height:50})
        $("#programa-button").css("height", "40px")
        $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
        $(".btn").button()
        $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

        $("#breadCrumb").jBreadCrumb({
            beginingElementsToLeaveOpen:10
        });

        $(".editar").button({
            icons:{
                primary:"ui-icon-pencil"
            },
            text:false
        }).click(function () {

                    valorEditar = $(this).attr("valor");
                    if ($(this).attr("comp") * 1 > 0) {
                        $("#componente").selectmenu("value", $(this).attr("comp"));
                    } else {
                        $("#componente").selectmenu("value", "-1");
                    }
                    $("#programa").selectmenu("value", $(this).attr("prog"));
                    $("#fuente").val($(this).attr("fuente"));
                    $("#valor_txt").val(number_format($(this).attr("valor"), 2, ",", "."));
                    $("#prsp_id").val($(this).attr("prsp_id"));
                    $("#prsp_num").val($(this).attr("prsp_num"));
                    $("#desc").html($(this).attr("desc"));
                    $("#guardar_btn").attr("iden", $(this).attr("iden"));
                    $("#actv").val($(this).attr("actv"));
                    $("#meta").val($(this).attr("meta"));
                    $("#indi").val($(this).attr("indi"));
                });

        $(".eliminar").button({
            icons:{
                primary:"ui-icon-trash"
            },
            text:false
        }).click(function () {
                    if (confirm("Está seguro de querer eliminar esta asignación?\nSe eliminarán las asignaciones hijas, el PAC, y la programación asociadas.")) {
                        var id = $(this).attr("iden");
                        var btn = $(this);
                        $.ajax({
                            type:"POST",
                            url:"${createLink(action:'eliminarAsignacion')}",
                            data:{
                                id:id
                            },
                            success:function (msg) {
                                if (msg == "OK") {
//                                            btn.parents("tr").remove();
                                    window.location.reload(true);
                                } else {
                                    alert("Ha ocurrido un error.")
                                }
                            }
                        });
                    }
                });

        $("#anio_asg, #programa").change(function () {
            location.href = "${createLink(controller:'asignacion',action:'asignacionesCorrientesv2')}?id=${unidad.id}&anio=" + $("#anio_asg").val() + "&programa=" + $("#programa").val();
        });

        $(".guardar").click(function () {
            var prsp = $("#prsp_id").val();
            var valorTxt = $("#valor_txt");
            var prspField = $("#prsp_num");
            var valor = valorTxt.val();
            var actField = $("#actv");
            var actividad = actField.val();
            var band = true;
            var comp = $("#componente").val()
            var meta = $("#meta").val();
            var indi = $("#indi").val();
            var boton = $(this);
            if (validar(0)) {
                var anio = boton.attr("anio")
                var fuente = $("#fuente").val()
                var programa = $("#programa").val()
                $.ajax({
                    type:"POST",
                    url:"${createLink(action:'guardarAsignacion',controller:'asignacion')}",
                    data:"anio.id=" + anio + "&fuente.id=" + fuente + "&programa.id=" + programa + "&planificado=" + valor + "&presupuesto.id=" + prsp + "&unidad.id=${unidad.id}" + "&actividad=" + actividad + "&meta=" + meta + "&indicador=" + indi + "&componente.id=" + comp + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                    success:function (msg) {
                        if (msg * 1 >= 0) {
                            location.reload(true);
                        } else {
                            alert("Error al guardar los datos")
                        }

                    }
                });
            }
        });

        $(".buscar").click(function () {
            $("#id_txt").val($(this).attr("id"))
            $("#buscar").dialog("open")
        });
        $(".buscarAct").click(function () {
            $("#id_txt_act").val($(this).attr("id"))
            $("#dlg_buscar_act").dialog("open")
        });
        $("#btn_buscar").click(function () {
            $.ajax({
                type:"POST",
                url:"${createLink(action:'buscarPresupuesto',controller:'asignacion')}",
                data:"parametro=" + $("#par").val() + "&tipo=" + $("#tipo").val(),
                success:function (msg) {
                    $("#resultado").html(msg)
                }
            });
        });
        $("#buscar").dialog({
            title:"Cuentas presupuestarias",
            width:520,
            height:500,
            autoOpen:false,
            modal:true
        })
        $("#dlg_buscar_act").dialog({
            title:"Actividades corrientes",
            width:480,
            height:500,
            autoOpen:false,
            modal:true
        })
        $("#btn_buscar_act").click(function () {
            $.ajax({
                type:"POST",
                url:"${createLink(action:'buscarActividad',controller:'asignacion')}",
                data:"parametro=" + $("#par_act").val() + "&tipo=" + $("#tipo").val(),
                success:function (msg) {
                    $("#resultado_act").html(msg)
                }
            });
        });
    });
</script>

</body>
</html>