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


<g:if test="${flash.message}">
    <div class="${flash.clase}">
        ${flash.message}
    </div>
</g:if>


<div style="margin-left: 10px;">
    <g:link class="btn" controller="asignacion" action="programacionAsignaciones" params="[id:unidad.id,anio:actual.id]">Programación</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    <a href="${createLink(controller: 'asignacion', action: 'asignacionesCorrientesv2')}?id=${unidad.id}&anio=${actual.id}&todo=1" class="btn">Ver todas</a>

    <a href="#" id="btnReporte">Reporte</a>

    <div style="margin-top: 20px; width: 550px">
        %{--<table width="200">--}%
            %{--<tr>--}%
                %{--<th>Año</th>--}%
                %{--<th>Unidad</th>--}%
            %{--</tr>--}%
            %{--<tr>--}%
                %{--<td><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/></td>--}%
                %{--<td class="unidad">--}%
                    %{--<textarea style="width: 230px;height: 40px;resize: none;" id="unidadA"></textarea>--}%
                %{--</td>--}%
            %{--</tr>--}%
        %{--</table>--}%


        <b>Año</b> <g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}" style="margin-right: 30px"/>

        <b>Unidad</b>  <g:textField name="unidadA_name" id="unidadA" style="width: 350px"/>

    </div>
</div>


<div style="margin-top: 10px;">
    <table width="600">
        <tr>
            %{--<th>Año</th>--}%

            <th>Programa Presupuestario</th>
            <th>Actividad Presupuestaria</th>
            <th>Política de Igualdad</th>
        </tr>

        <tr>
            <td><g:select from="${programas}" id="programa" optionKey="id" name="programa" class="programa" value="${programa.id}"/></td>
            <td id="tdActividad"></td>
            %{--<td><g:select from="${mies.PoliticasIgualdad.list().sort{it.descripcion}}" id="politica" name="politica_name" optionKey="id" optionValue="descripcion" value="${''}"/></td>--}%
            <td id="tdPoliticas"></td>
        </tr>
    </table>
</div>

<fieldset class="ui-corner-all" style="min-height: 100px;font-size: 11px;">
    <legend>Objetivos</legend>
    <table style="width: 100%">
        <tr>
            <th style="width: 25%">Plan de Desarrollo</th>
            <th style="width: 25%">Objetivo Institucional</th>
            <th style="width: 25%">Objetivo Específico</th>
            <th style="width: 25%">Objetivo Operativo</th>
        </tr>

        <tr>
            <td id="tdPlan"></td>
            <td id="tdInstitucional"></td>
            <td id="tdEspecifico"></td>
            <td id="tdOperativo"></td>
        </tr>
    </table>
</fieldset>


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

                    <td class="desc" id="desc" style="width: 200px"></td>

                    <td class="fuente">
                        <g:select from="${fuentes}" id="fuente" optionKey="id" optionValue="descripcion" name="fuente" class="fuente" style="width: 160px;"/>
                    </td>

                    <td class="valor">
                        <input type="text" style="width: 70px;color:black" class="valor" id="valor_txt" value="0">

                    </td>

                    <td class="meta_indi" style="text-align: center">
                        <input type="hidden" id="meta" class="desc">
                        <input type="hidden" id="indi" class="obs" value="">
                        <input type="hidden" id="met" class="met" value="">

                        <a href="#" class="btn_editar" desc="meta" obs="indi" met="met">Editar</a>
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
                <input type="hidden" id="hid_met">


                <b>Modalidad de Servicios (255 caracteres):</b><br>

                %{--<textArea name="desc" rows="5" cols="40" id="dlg_desc" ${(max?.aprobadoCorrientes!= 0) ? "disabled" : ""}--}%
                %{--style="color: black; resize: none"></textArea>--}%

                <textArea name="met" rows="5" cols="40" id="dlg_met" ${(max?.aprobadoCorrientes!= 0) ? "disabled" : ""}
                          style="color: black; resize: none"></textArea>

                <b>Meta (numérico):</b>

                <input type="text" id="dlg_desc" name="desc" class="validacionNumeroSinPuntos" style="width: 70px;color:black"> <br>


                <b>Indicador (255 caracteres):</b><br>

                <textArea name="desc" rows="5" cols="40" id="dlg_obs" ${(max?.aprobadoCorrientes!= 0) ? "disabled" : ""}
                          style="color: black; resize: none"></textArea> <br>

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
    <g:set var="total" value="0"/>
    <table style="width: 100%; margin-bottom: 10px;">
        <thead>

        <th style="width: 220px">Programa</th>
        %{--<th style="width: 120px">Componente</th>--}%
        <th style="width: 120px">Act. Presupuestaria</th>
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
                    %{--${asg.componente}--}%
                    ${asg?.actividadPresupuesto?.descripcion}
                </td>

                <td class="actividad">
                    ${asg.actividad}
                </td>

                <td class="prsp" style="text-align: center">
                    ${asg.presupuesto.numero}
                </td>

                <td class="desc" style="width: 200px">
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
                        <a href="#" class="btn editar ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}" prog="${asg.programa.id}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}" fuente="${asg.fuente.id}" valor="${(asg.redistribucion == 0) ? asg.planificado.toDouble().round(2) : asg.redistribucion.toDouble().round(2)}" actv="${asg.actividad}" meta="${asg.meta}" indi="${asg.indicador}" met="${asg?.modalidad}" comp="${asg?.componente?.id}" un="${asg?.unidadAdministrativa}" plan="${asg?.planDesarrollo?.id}" ope="${asg?.objetivoOperativo?.id}" pol="${asg?.politicasIgualdad?.id}">Editar</a>
                    </g:if>
                </td>

                <td style="text-align: center">
                    <g:if test="${max?.aprobadoCorrientes==0}">
                        <a href="#" class="btn eliminar ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}"
                           prog="${asg.programa.id}" actpr="${asg.actividadPresupuesto.id}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}"
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

        <div style="margin-top: 15px">Programa Presupuestario</div>

        <g:select from="${programas}" name="progs" optionKey="id" value="${programa.id}"/>

        <div style="margin-top: 15px">Actividad Presupuestaria</div>

        <div id="divActividad"></div>

    </form>
</div>

<script type="text/javascript">

    cargarPolitica(null);

    function cargarPolitica (politica) {
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'asignacion', action: 'politica_ajax')}',
            data:{
                politica: politica
            },
            success: function (msg){
               $("#tdPoliticas").html(msg)
            }
        });
    }

    cargarObInstitucional(null);

    function cargarObInstitucional(institucional) {
        $.ajax({
           type: 'POST',
            url:'${createLink(controller: 'asignacion', action: 'institucional_ajax')}',
            data:{
                institucional: institucional
            },
            success: function (msg){
                $("#tdInstitucional").html(msg)
            }
        });
    }

    cargarPlanDesarrollo(null);

    function cargarPlanDesarrollo (plan) {
        $.ajax({
           type: 'POST',
            url:'${createLink(controller: 'asignacion', action: 'plan_ajax')}',
            data:{
            plan: plan
            },
            success: function (msg){
                $("#tdPlan").html(msg)
            }
        });
    }

    function cargarCombos(oo) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'asignacion', action: 'revisarCombos_ajax')}',
            data:{
                operativo: oo
            },
            success: function (msg){
                var parts = msg.split("_");
                cargarObjEspecifico(parts[1],parts[0], oo);
                cargarObjOperativo (parts[1], oo);
                cargarObInstitucional(parts[0]);
            }
        })
    }

    cargarObjEspecifico($("#institucional").val(),null, null);

    function cargarObjEspecifico (objetivo, especifico, operativo) {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'asignacion', action:'especifico_ajax')}',
            data:{
                objetivo: objetivo,
                especifico: especifico,
                operativo: operativo

            },
            success: function (msg) {
                $("#tdEspecifico").html(msg)
            }
        });
    }

//    $("#institucional").change(function () {
//        var objetivo = $(this).val();
//        cargarObjEspecifico(objetivo, null, null)
//    });


    $("#progs").change(function () {
        var programa = $(this).val();
        cargarActividadDialogo(programa);
    });

    cargarActividadDialogo($("#progs").val());

    function cargarActividadDialogo(programa){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'asignacion', action: 'cargarActividad_ajax')}',
            data:{
                programa: programa
            },
            success: function (msg) {
                $("#divActividad").html(msg)
            }
        });
    }

    cargarActivdad($("#programa").val(), null)

    $("#programa").change(function () {
        var programa = $(this).val();
        cargarActivdad(programa, null)
    });

    function cargarActivdad (programa, actividad ){
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'asignacion', action: 'actividad_ajax')}',
            data:{
                programa: programa,
                actividad: actividad
            },
            success: function (msg) {
                $("#tdActividad").html(msg)
            }
        });
    }

    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

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
        var acpr = $("#actividadPresupuestaria").val();
        var uni = $("#unidadA").val();
        var opera = $("#objetivoOperativo").val();
        var pln = $("#plan").val();

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
                if (indi.length < 2) {
                    mensaje = "Error: Debe llenar el campo indicador";
                    band = false;
                    error = $(".btn_editar");
                }
                if(acpr == null){
                    mensaje = "Error: Debe seleccionar una actividad presupuestaria";
                    band = false;
                }
                if(uni == ''){
                    mensaje = "Error: Debe ingresar una unidad";
                    band = false;
                }
                if(opera == '' || opera == null){
                    mensaje = "Error: Debe seleccionar un objetivo operativo";
                    band = false;
                }
                if(pln == '' || pln == null){
                    mensaje = "Error: Debe seleccionar un plan de desarrollo";
                    band = false;
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
                    var act = $("#actividadPre").val();

                    if(act == null){
                        alert("Error: Debe seleccionar una actividad presupuestaria");
                        return
                    }else{
                        var url = "${createLink(action: 'cambiarPrograma')}?" + data + "&programa=${programa.id}&anio=${actual.id}&id=${unidad.id}" + "&act=" + act;
                        location.href = url;
                    }
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
            cargarActividadDialogo($("#progs").val());
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
            $("#hid_met").val($(this).attr("met"))
            $("#dlg_desc").val($("#" + $(this).attr("desc")).val())
            $("#dlg_met").val($("#" + $(this).attr("met")).val())
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
                            $("#" + $("#hid_desc").val()).val($("#dlg_desc").val());
                            $("#dlg_desc").val("");
                            $("#" + $("#hid_obs").val()).val($("#dlg_obs").val());
                            $("#dlg_obs").val("");
                            $("#" + $("#hid_met").val()).val($("#dlg_met").val());
                            $("#dlg_met").val("");
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
            $("#met").val($(this).attr("met"));
            $("#unidadA").val($(this).attr("un"));

            cargarActivdad($(this).attr("prog"), $(this).attr("actpr"));
            cargarCombos($(this).attr("ope"));
            cargarPlanDesarrollo($(this).attr('plan'));
            cargarPolitica($(this).attr('pol'));

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
//        $("#anio_asg").change(function () {
            location.href = "${createLink(controller:'asignacion',action:'asignacionesCorrientesv2')}?id=${unidad.id}&anio=" + $("#anio_asg").val() + "&programa=" + $("#programa").val();
        });

        $(".guardar").click(function () {
            var prsp = $("#prsp_id").val();
            var valorTxt = $("#valor_txt");
            var prspField = $("#prsp_num");
            var valor = valorTxt.val();
            var actField = $("#actv");
            var actividad = actField.val();
            var actividadPresupuestaria = $("#actividadPresupuestaria").val();
            var unidadAdministrativa = $("#unidadA").val();
            var operativo = $("#objetivoOperativo").val();
            var plan = $("#plan").val();
            var comp = $("#componente").val(null);
            var meta = $("#meta").val();
            var indi = $("#indi").val();
            var met = $("#met").val();
            var boton = $(this);
            var poli = $("#politica").val();
            var band = true;
            if (validar(0)) {
                var anio = boton.attr("anio");
                var fuente = $("#fuente").val();
                var programa = $("#programa").val();
                $.ajax({
                    type:"POST",
                    url:"${createLink(action:'guardarAsignacion',controller:'asignacion')}",
                    %{--data:"anio.id=" + anio + "&fuente.id=" + fuente + "&programa.id=" + programa + "&planificado=" + valor + "&presupuesto.id=" + prsp + "&unidad.id=${unidad.id}" + "&actividad=" + actividad + "&meta=" + meta + "&indicador=" + indi + "&met=" + met + "&componente.id=" + comp + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),--}%
                    data:"anio.id=" + anio + "&fuente.id=" + fuente + "&programa.id=" + programa + "&planificado=" + valor + "&presupuesto.id=" + prsp + "&unidad.id=${unidad.id}" + "&actividad=" + actividad + "&meta=" + meta + "&indicador=" + indi + "&met=" + met + "&actividadPresupuestaria=" + actividadPresupuestaria + "&unidadA=" + unidadAdministrativa + "&operativo=" + operativo + "&plan=" + plan + "&politica=" + poli + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
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