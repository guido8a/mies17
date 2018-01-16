<%@ page import="mies.ProgramacionAsignacion; mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main2"/>
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

        <style type="text/css">
        .valor {
            width      : 60px;
            text-align : center;
            margin     : 0px;
            color      : #000000;
        }
        </style>
    </head>

    <body>

        <div style="margin-left: 10px;">
            <g:link class="btn_arbol" controller="asignacion" action="asignacionesCorrientesv2" id="${unidad.id}">Ver/Editar Asignaciones corrientes</g:link>
            <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades Ejecutoras</g:link>
            <g:link class="btn" controller="reportes" action="poaCorrientesReporteWeb" id="${unidad.id}" params="${[anio: actual.id]}"
                    target="_blank">Reporte</g:link>
            <span style="margin-left: 200px">Año:</span>
            <g:select from="${mies.Anio.list([sort: 'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
        </div>

        <div id="accordion" style="width:1270px;margin-top: 5px;font-size: 11px;">
            <ul>
                <li><a href="#tabs-1">Gasto corriente</a></li>
            </ul>


            <div id="tabs-1">
                <table style="width: 100% !important;">
                    <thead>
                        <th>Enero</th>
                        <th>Feb.</th>
                        <th>Marzo</th>
                        <th>Abril</th>
                        <th>Mayo</th>
                        <th>Junio</th>
                        <th>Julio</th>
                        <th>Agos.</th>
                        <th>Sept.</th>
                        <th>Oct.</th>
                        <th>Nov.</th>
                        <th>Dic.</th>
                        <th>Total</th>
                        <th></th>
                        <th></th>
                    </thead>
                    <tbody>
                        <g:set var="ene" value="${0}"/>
                        <g:set var="feb" value="${0}"/>
                        <g:set var="mar" value="${0}"/>
                        <g:set var="abr" value="${0}"/>
                        <g:set var="may" value="${0}"/>
                        <g:set var="jun" value="${0}"/>
                        <g:set var="jul" value="${0}"/>
                        <g:set var="ago" value="${0}"/>
                        <g:set var="sep" value="${0}"/>
                        <g:set var="oct" value="${0}"/>
                        <g:set var="nov" value="${0}"/>
                        <g:set var="dic" value="${0}"/>
                        <g:set var="asignado" value="0"/>
                        <g:each in="${corrientes}" var="asg" status="i">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td colspan="15"><b>Programa:</b>${asg.programa} <b>Actividad:</b> ${asg.actividad} <b>Partida:</b> ${asg.presupuesto.descripcion}
                                </td>
                            </tr>

                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <g:set var="suma" value="${0}"/>
                                <g:each in="${meses}" var="mes">
                                    <g:set var="progra" value="${ProgramacionAsignacion.findAll('from ProgramacionAsignacion where asignacion = ' + asg.id + ' and mes = ' + mes + ' and padre is null')}"/>

                                    <g:if test="${progra.size() > 0}">
                                        <g:set var="progra" value="${progra.pop()}"/>
                                    </g:if>
                                    <g:else>
                                        <g:set var="progra" value="${[valor: 0]}"/>
                                    </g:else>

                                    <td class="${mes}" style="width: 70px;">
                                        <input type="text" class="${mes} valor asg_cor_${asg.id}" mes="${mes}" ${(max.aprobadoCorrientes != 0) ? "disabled" : ""}
                                               value="${g.formatNumber(number: progra?.valor, format: '###,##0', minFractionDigits: '2', maxFractionDigits: '2')}"/>
                                        <g:set var="suma" value="${suma + progra.valor}"/>
                                        <g:if test="${mes == 1}">
                                            <g:set var="ene" value="${ene.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 2}">
                                            <g:set var="feb" value="${feb.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 3}">
                                            <g:set var="mar" value="${mar.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 4}">
                                            <g:set var="abr" value="${abr.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 5}">
                                            <g:set var="may" value="${may.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 6}">
                                            <g:set var="jun" value="${jun.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 7}">
                                            <g:set var="jul" value="${jul.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 8}">
                                            <g:set var="ago" value="${ago.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 9}">
                                            <g:set var="sep" value="${sep.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 10}">
                                            <g:set var="oct" value="${oct.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 11}">
                                            <g:set var="nov" value="${nov.toDouble() + progra?.valor}"/>
                                        </g:if>
                                        <g:if test="${mes == 12}">
                                            <g:set var="dic" value="${dic.toDouble() + progra?.valor}"/>
                                        </g:if>
                                    </td>
                                </g:each>
                                <td class="total" id="total_cor_${asg.id}" style="width: 80px;">
                                    <g:if test="${suma.toDouble().round(2) != asg.planificado}">
                                        <span style="color: red;"><g:formatNumber number="${suma}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></span>
                                    </g:if>
                                    <g:else>
                                        <g:formatNumber number="${(asg.redistribucion == 0) ? asg.planificado : asg.redistribucion}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                                    </g:else>
                                </td>
                                <g:if test="${max.aprobadoCorrientes == 0}">
                                    <td class=""><a href="#" class="btn guardar ajax" asg="${asg.id}" icono="ico_cor_${i}" max="${(asg.redistribucion == 0) ? asg.planificado : asg.redistribucion}" clase="asg_cor_${asg.id}" total="total_cor_${asg.id}">Guardar</a>
                                    </td>
                                </g:if>
                                <td class="ui-state-active"><span class="" id="ico_cor_${i}" title="Guardado" style="display: none"><span class="ui-icon ui-icon-check"></span>
                                </span></td>
                            </tr>

                        </g:each>
                        <tr>
                            <td colspan="15"><b>TOTALES</b></td>
                        </tr>

                        <tr>
                            <td style="text-align: center"><g:formatNumber number="${ene}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${feb}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${mar}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${abr}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${may}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${jun}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${jul}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${ago}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${sep}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${oct}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${nov}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${dic}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

                            <td style="text-align: center"><g:formatNumber number="${ene + feb + mar + abr + may + jun + jul + ago + sep + oct + nov + dic}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        </tr>
                    </tbody>
                </table>

            </div>

        </div>



        <script type="text/javascript">
            $("#accordion").tabs();
            $("[name=programa]").selectmenu({width : 180});
            $(".btn_arbol").button({icons : { primary : "ui-icon-bullet"}})
            $(".btn").button()
            $(".back").button("option", "icons", {primary : 'ui-icon-arrowreturnthick-1-w'});

            $(".guardar").button({
                icons : {
                    primary : "ui-icon-disk"
                },
                text  : false
            })
            $("#anio_asg").change(function () {
                location.href = "${createLink(controller:'asignacion',action:'programacionAsignaciones')}?id=${unidad.id}&anio=" + $(this).val()
            });

            $(".guardar").click(function () {
                var icono = $("#" + $(this).attr("icono"))
                var total = 0
                var max = $(this).attr("max") * 1
                var datos = ""
                $.each($("." + $(this).attr("clase")), function () {
                    var val = $(this).val()
                    val = str_replace(".", "", val)
                    val = str_replace(",", ".", val)
                    val = val * 1
                    total += val
                    datos += $(this).attr("mes") + ":" + val + ";"
                });
                total = parseFloat(total).toFixed(2);
                if (total != max) {
                    alert("El total programado (" + total + ") es diferente al monto de la asignación" + max)
                    $("#" + $(this).attr("total")).html(total).css("color", "red").show("pulsate")
                } else {
                    $("#" + $(this).attr("total")).html(total).css("color", "black")
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'guardarProgramacion',controller:'asignacion')}",
                        data    : "asignacion=" + $(this).attr("asg") + "&datos=" + datos,
                        success : function (msg) {
                            if (msg == "ok") {
                                icono.show("pulsate")
                                window.location.reload(true)
                            }
                        }
                    });
                }

            });


        </script>

    </body>
</html>