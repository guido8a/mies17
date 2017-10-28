<%@ page import="mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Asignaciones de la unidad: ${unidad}</title>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
              type="text/css"/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
              type="text/css"/>

        <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
                language="JavaScript"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
                type="text/javascript" language="JavaScript"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>
    </head>

    <body>

        <div style="margin-left: 10px;">
            <g:if test="${actual.estado!=0}">
                <g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad" params="${[unidad:unidad.id,anio:actual.id]}">Solicitar modificación</g:link>
            </g:if>
            <g:link class="btn" controller="asignacion" action="programacionAsignaciones" id="${unidad.id}">Programación</g:link>
            <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
            <div style="margin-top: 15px;">
                <b>Año:</b>
                <g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
                &nbsp;&nbsp;&nbsp;
                <b>Programa:</b>
                <g:select from="${programas}" id="programa" optionKey="id" optionValue="descripcion" name="programa" class="programa" value="${programa.id}"/>
            </div>
        </div>

        <fieldset class="ui-corner-all" style="min-height: 110px;font-size: 11px;">
            <legend>
                Ingreso de datos
            </legend>
            <g:if test="${actual.estado==0}">
                <table style="width: 1060px;">
                    <thead>
                        <th style="width: 320px">Actividad</th>
                        <th style="width: 50px;">Partida</th>
                        <th style="width: 200px">Desc. Presupuestaria</th>
                        <th style="width: 160px;">Fuente</th>
                        <th style="width: 50px;">Presupuesto</th>
                        <th style="width: 50px;"></th>
                    </thead>
                    <tbody>

                        <tr class="odd">
                            <td class="actividad">
                                <textarea style="width: 330px;height: 40px;resize: vertical;" id="actv"></textarea>
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

                            <td>
                                <a href="#" id="guardar_btn" class="btn guardar ajax" iden="" icono="ico_001" clase="act_" tr="" anio="${actual.id}">Guardar</a>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </g:if>
            <g:else>
                Las asignaciones para este año ya han sido aprobadas
            </g:else>
        </fieldset>
        <fieldset class="ui-corner-all" style="min-height: 100px;font-size: 11px">
            <legend>
                Detalle
            </legend>
            <g:set var="total" value="0"></g:set>
            <table style="width: 1000px;margin-bottom: 10px;">
                <thead>
                    <th style="width: 280px">Programa</th>
                    <th>Actividad</th>
                    <th style="width: 60px;">Partida</th>
                    <th style="width: 240px">Desc. Presupuestaria</th>

                    <th>Fuente</th>
                    <th>Presupuesto</th>
                    <th></th>
                </thead>
                <tbody>
                    <g:each in="${asignaciones}" var="asg" status="i">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="det_${i}">
                            <td class="programa">
                                ${asg.programa.descripcion}
                            </td>

                            <td class="actividad">
                                ${asg.actividad}
                            </td>

                            <td class="prsp" style="text-align: center">
                                ${asg.presupuesto.numero}
                            </td>

                            <td class="desc" style="width: 240">
                                ${asg.presupuesto.descripcion}
                            </td>

                            <td class="fuente">
                                ${asg.fuente.descripcion}
                            </td>

                            <td class="valor" style="text-align: right">
                                <g:formatNumber number="${(asg.redistribucion==0)?asg.planificado.toFloat():asg.redistribucion.toFloat()}"
                                                format="###,##0"
                                                minFractionDigits="2" maxFractionDigits="2"/>
                                <g:set var="total" value="${total.toDouble()+((asg.redistribucion==0)?asg.planificado.toDouble():asg.redistribucion.toDouble())}"></g:set>
                            </td>

                            <td style="text-align: center">
                                <g:if test="${actual.estado==0}">
                                    <a href="#" class="btn editar ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}" prog="${asg.programa.id}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}" fuente="${asg.fuente.id}" valor="${(asg.redistribucion == 0) ? asg.planificado.toFloat().round(2) : asg.redistribucion.toFloat().round(2)}" actv="${asg.actividad}">Editar</a>
                                </g:if>
                            </td>
                        </tr>

                    </g:each>
                </tbody>
            </table>

            <div style="position: absolute;top:5px;right:10px;font-size: 15px;">
                <b>Total programa actual:</b>
                <g:formatNumber number="${total.toFloat()}"
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

        <script type="text/javascript">

            function validar() {
                var prsp = $("#prsp_id").val();
                var valorTxt = $("#valor_txt");
                var prspField = $("#prsp_num");
                var valor = valorTxt.val();
                var actField = $("#actv");
                var actividad = actField.val();
                var band = true;

                valor = str_replace(".", "", valor);
                valor = str_replace(",", ".", valor);
                valor = parseFloat(valor);

                var mensaje, error;
                if (isNaN(valor)) {
                    mensaje = "Error: El valor de la asignación debe ser un número";
                    band = false;
                    error = valorTxt;
                } else {
                    valorTxt.val(number_format(valor, 2, ",", "."));
                    if (valor <= 0) {
                        mensaje = "Error: El valor de la asignación debe ser un número mayor a cero";
                        band = false;
                        error = valorTxt;
                    }
                    if (valor > ${maxUnidad - totalUnidad}) {
                        mensaje = "Error: El valor de la asignación debe ser un número menor a " + number_format(${maxUnidad - totalUnidad}, 2, ",", ".");
                        error = valorTxt;
                    }
                    if (isNaN(prsp))
                        prsp = 0
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
                }

                if (!band) {
                    alert(mensaje);
                    error.addClass("error").show("pulsate");
                }
                return band;
            }

            $(function () {
                $("#valor_txt").blur(function () {
                    validar();
                });


                $("[name=programa]").selectmenu({width:550, height:50})
                $("#programa-button").css("height", "40px")
                $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
                $(".btn").button()
                $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

                $("#breadCrumb").jBreadCrumb({
                    beginingElementsToLeaveOpen:10
                });

                $(".editar").click(function () {
                    $("#programa").selectmenu("value", $(this).attr("prog"))
                    $("#fuente").val($(this).attr("fuente"))
                    $("#valor_txt").val($(this).attr("valor"))
                    $("#prsp_id").val($(this).attr("prsp_id"))
                    $("#prsp_num").val($(this).attr("prsp_num"))
                    $("#desc").html($(this).attr("desc"))
                    $("#guardar_btn").attr("iden", $(this).attr("iden"))
                    $("#actv").val($(this).attr("actv"))
                });

                $("#anio_asg, #programa").change(function () {
                    location.href = "${createLink(controller:'asignacion',action:'asignacionesCorrientesv2')}?id=${unidad.id}&anio=" + $("#anio_asg").val() + "&programa=" + $("#programa").val();
                });

                $(".guardar").click(function () {
                    var valorTxt = $("#valor_txt")
                    var prspField = $("#prsp_num")
                    var valor = valorTxt.val()
                    var prsp = $("#prsp_id").val()
                    var boton = $(this)
                    var actividad = $("#actv").val()
                    valorTxt.removeClass("error")
                    prspField.removeClass("error")

                    if (validar()) {
                        var anio = boton.attr("anio")
                        var fuente = $("#fuente").val()
                        var programa = $("#programa").val()
                        $.ajax({
                            type:"POST",
                            url:"${createLink(action:'guardarAsignacion',controller:'asignacion')}",
                            data:"anio.id=" + anio + "&fuente.id=" + fuente + "&programa.id=" + programa + "&planificado=" + valor + "&presupuesto.id=" + prsp + "&unidad.id=${unidad.id}" + "&actividad=" + actividad + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                            success:function (msg) {
                                if (msg * 1 >= 0) {
                                    location.reload(true)
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
                    width:480,
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