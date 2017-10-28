<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Cronograma</title>
        <meta name="layout" content="main"/>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
              type="text/css"/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
              type="text/css"/>

        <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
                language="JavaScript"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
                type="text/javascript" language="JavaScript"></script>

        <style type="text/css">
        .col {
            width : 80px
        }

        .colGrande {
            width : 300px
        }

        .componente {
            /*background : rgba(248, 220, 86, 0.2) !important;*/

        }

        .num {
            text-align : center;
            width      : 80px;
            border     : 0px;
        }

        .disabled {
            background : #ddd;
            width      : 80px;
            text-align : center;
        }

        tbody tr:nth-child(even) {
            background : none !important;
        }

        tbody tr:nth-child(odd) {
            background : none !important;
        }
        </style>
    </head>

    <body>
        <div class="body" style="font-size: 11px">

            <div class="dialog">

                <div style="margin-bottom: 10px;" class="toolbar ui-widget-header ui-corner-all">
                    <span class="menuButton">
                        <g:link class="save" controller="modificacion" action="terminarModificacionCronograma">
                            Guardar
                        </g:link>
                    </span>
                </div>

                <table style="width: 1600px;margin-left: -20px" border="1">
                    <thead style="background: rgba(110, 182, 213,0.2)">
                        <tr>
                            <th style="width: 300px">&nbsp;</th>
                            <g:form action="nuevoCronograma" method="post" class="frm_anio">
                                <input type="hidden" name="id" value="${proyecto.id}">
                                <th colspan="12"><g:select from="${mies.Anio.list()}" optionKey="id" optionValue="anio"
                                                           name="anio" id="anio" value="${anio.id}"
                                                           style="width: 80px"/></th>
                            </g:form>
                        </tr>

                        <tr>
                            <th class="colGrande" style="width: 300px;">Componentes/Rubros</th>
                            <g:each in="${mies.Mes.list()}" var="mes">
                                <th class="col" style="width: 80px;">${mes.descripcion}</th>
                            </g:each>
                            <th style="width: 100px;">Asignado</th>
                            <th style="width: 100px;">Sin asignar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:set var="idCelda" value="0"/>

                        <g:set var="indice" value="0"></g:set>
                        <g:set var="totProy" value="0"></g:set>
                        <g:set var="totProyAsig" value="0"></g:set>
                        <g:each in="${componentes}" var="comp" status="j">
                            <g:set var="totComp" value="0"></g:set>
                            <g:set var="totCompAsig" value="0"></g:set>
                            <tr>
                                <td class="colGrande componente" style="background: ${colores[indice.toInteger()]}"
                                    colspan="15"><b>Componente ${j + 1}</b>: ${(comp.objeto.length() > 100) ? comp.objeto.substring(0, 100) + "..." : comp.objeto}
                                </td>
                            </tr>
                            <g:each in="${mies.MarcoLogico.findAllByMarcoLogicoAndEstado(comp,0,[sort:'id'])}" var="act"
                                    status="i">
                                <g:set var="totComp" value="${totComp.toDouble()+act.monto}"></g:set>
                                <tr>

                                    <td class="colGrande" style="background: ${colores[indice.toInteger()]}"
                                        title="${act.objeto}">${(act.objeto.length() > 100) ? act.objeto.substring(0, 100) + "..." : act.objeto}</td>
                                    <g:set var="tot" value="0"></g:set>
                                    <g:set var="totAct" value="${act.monto}"></g:set>
                                    <g:each in="${mies.Mes.list()}" var="mes" status="k">
                                        <g:set var="crga"
                                               value='${mies.Cronograma.findAllByMarcoLogicoAndMes(act,mes)}'></g:set>
                                        <g:if test="${crga.size()>0}">
                                            <g:each in="${crga}" var="c">
                                                <g:if test="${c?.anio==anio && c?.cronograma == null}">
                                                    <g:set var="crg" value='${c}'></g:set>
                                                    <g:set var="totCompAsig"
                                                           value="${totCompAsig.toDouble()+crg.valor}"></g:set>
                                                </g:if>
                                            </g:each>
                                            <g:if test="${crg}">
                                                <g:set var="tot" value="${tot.toDouble()+crg?.valor}"></g:set>
                                                <g:if test="${act.monto.toDouble()>0}">
                                                    <td>
                                                        <input type="text" id="crg_${crg.id}" value="${crg.valor}"
                                                               class="num" mes="${mes.id}" identificador="${crg.id}"
                                                               actividad="${act.id}" tot="${act.monto}"
                                                               div="tot_${j}${i}" id=""
                                                               mt="${mes.descripcion}" idCelda="${idCelda}"/>
                                                        %{--(${idCelda})--}%
                                                        <g:set var="idCelda" value="${idCelda.toInteger()+1}"/>
                                                    </td>
                                                </g:if>
                                                <g:else>
                                                    <td class="disabled">0</td>
                                                </g:else>
                                                <g:set var="crg" value="${null}"></g:set>
                                            </g:if>
                                            <g:else>
                                                <g:if test="${act.monto.toDouble()>0}">
                                                    <td>
                                                        <input type="text" id="crg_0${j}${i}${k}" value="0" class="num"
                                                               mes="${mes.id}" actividad="${act.id}" identificador="0"
                                                               tot="${act.monto}" div="tot_${j}${i}"
                                                               mt="${mes.descripcion}" idCelda="${idCelda}"/>
                                                        %{--(${idCelda})--}%
                                                        <g:set var="idCelda" value="${idCelda.toInteger()+1}"/>
                                                    </td>
                                                </g:if>
                                            </g:else>
                                        </g:if>
                                        <g:else>
                                            <g:if test="${act.monto.toDouble()>0}">
                                                <td>
                                                    <input type="text" id="crg_0${j}${i}${k}" value="0" class="num"
                                                           mes="${mes.id}" actividad="${act.id}" identificador="0"
                                                           tot="${act.monto}" div="tot_${j}${i}"
                                                           mt="${mes.descripcion}" idCelda="${idCelda}"/>
                                                    %{--(${idCelda})--}%
                                                    <g:set var="idCelda" value="${idCelda.toInteger()+1}"/>
                                                </td>
                                            </g:if>
                                            <g:else>
                                                <td class="disabled">0</td>
                                            </g:else>
                                        </g:else>
                                    </g:each>
                                    <td class="disabled" id="tot_${j}${i}" div="totComp_${j}">${tot}</td>
                                    <td class="disabled" id="tot_${j}${i}a"
                                        div="totComp_${j}a">${totAct.toDouble() - tot.toDouble()}</td>
                                </tr>
                            </g:each>
                            <tr>
                                <td class="colGrande " style="background: ${colores[indice.toInteger()]}"
                                    colspan="13"><b>TOTAL</b></td>
                                <td style="text-align: center;background: ${colores[indice.toInteger()]}"><b><div
                                        id="totComp_${j}a" class="totCompsa">${totCompAsig.toFloat().round(2)}</div></b>
                                </td>
                                <td style="text-align: center;background: ${colores[indice.toInteger()]}"><b><div
                                        id="totComp_${j}"
                                        class="totComps">${(totComp.toDouble() - totCompAsig.toDouble()).toFloat().round(2)}</div>
                                </b></td>
                                <g:set var="totProyAsig"
                                       value="${totProyAsig.toDouble()+totCompAsig.toDouble()}"></g:set>
                                <g:set var="totProy" value="${totProy.toDouble()+totComp.toDouble()}"></g:set>
                                <g:set var="indice" value="${indice.toInteger()+1}"></g:set>
                                <g:if test="${indice>4}">
                                    <g:set var="indice" value="${0}"></g:set>
                                </g:if>
                            </tr>
                        </g:each>
                        <tr>
                            <td class="colGrande " style="background: #E0EEF4" colspan="13"><b>TOTAL DEL PROYECTO</b>
                            </td>
                            <td style="text-align: center;background: #E0EEF4"><b><div
                                    id="totGeneralAsignado">${totProyAsig.toFloat().round(2)}</div></b></td>
                            <td style="text-align: center;background: #E0EEF4"><b><div
                                    id="totGeneral">${(totProy.toDouble() - totProyAsig.toDouble()).toFloat().round(2)}</div>
                            </b></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="dlg_editar" title="Cronograma">
            <input type="hidden" id="mes"/>
            <input type="hidden" id="iden"/>
            <input type="hidden" id="act"/>
            <input type="hidden" id="div"/>
            <input type="hidden" id="vold"/>
            <input type="hidden" id="idCelda"/>

            <div style="width: 100%;float: left;margin-top: 10px;">
                <div style="width: 80px;float: left;">
                    <b>Valor:</b>
                </div>
                <input type="text" class="ui-corner-all" id="valor" style="border: 1px solid black;width: 200px;">
            </div>

            <div style="width: 100%;float: left;margin-top: 5px;">
                <div style="width: 80px;float: left">
                    <b>Fuente:</b>
                </div>
                <g:select from="${fuentes}" id="fuente" optionKey="id" optionValue="descripcion" style="width: 200px;"/>
            </div>

            <div style="width: 100%;float: left;margin-top: 10px;">
                <div style="width: 80px;float: left">
                    <b>Año:</b>
                </div>
                ${anio.anio}
            </div>

            <div style="width: 100%;float: left;margin-top: 10px;">
                <div style="width: 80px;float: left">
                    <b>Mes:</b>
                </div>

                <div id="mes_texto"></div>
            </div>

            <div style="width: 100%;float: left;margin-top: 10px;">
                <div style="width: 80px;float: left">
                    <b>Monto total:</b>
                </div>

                <div id="mt"></div>
            </div>

            <div style="width: 100%;float: left;margin-top: 10px;">
                <div style="width: 80px;float: left">
                    <b>Asignado:</b>
                </div>

                <div id="as"></div>
            </div>

            <div style="width: 100%;float: left;margin-top: 10px;">
                <div style="width: 80px;float: left">
                    <b>Por asignar:</b>
                </div>

                <div id="pa"></div>
            </div>
        </div>

        <script type="text/javascript">
            $(function() {

                $(".save").button({
                    icons: {
                        primary: "ui-icon-disk"
                    }
                }).click(function() {
                            if (confirm("Está seguro de terminar esta modificación?\nNo podrá hacer más cambios sin otra solicitud aprobada.")) {
                                return true;
                            } else {
                                return false;
                            }
                        });

                $("#anio").change(function() {
                    $(".frm_anio").submit()
                });

                $(".num").click(function() {
                    $("#valor").css("border", "black solid 1px")
                    $("#mes").val($(this).attr("mes"))
                    $("#iden").val($(this).attr("identificador"))
                    $("#act").val($(this).attr("actividad"))
                    $("#div").val($(this).attr("id"))
                    $("#valor").val($(this).val())
                    $("#vold").val($(this).val())
                    $("#idCelda").val($(this).attr("idCelda"));
                    $("#mes_texto").html($(this).attr("mt"))
                    var mt = $(this).attr("tot")
                    var as = $("#" + $(this).attr("div")).html()
                    $("#mt").html(mt)
                    $("#as").html(as)
                    $("#pa").html(mt * 1 - as * 1)
                    $("#dlg_editar").dialog("open")
                });

                $("#dlg_editar").dialog({
                    width:350,
                    height:330,
                    position:"center",
                    modal:true,
                    autoOpen:false,
                    resizable:false,
                    buttons:{
                        "Aceptar":function() {
                            if ($("#valor").val() != "" && $("#valor").val() != " ") {
                                var valor = $("#valor").val()
                                var valorPrevio = $("#vold").val()

                                if (valor < 0) {
                                    alert("Ingrese numeros positivos")
                                    $("#valor").css("border", "red solid 1px")
                                    $("#valor").show("pulsate")
                                }
                                if (isNaN(valor)) {
                                    alert("Ingrese solo numeros")
                                    $("#valor").css("border", "red solid 1px")
                                    $("#valor").show("pulsate")
                                    valor = -1
                                }
                                if (valor > -1) {
                                    $("#" + $("#div").val()).val($("#valor").val())
                                    var tot = 0
                                    $.each($("#" + $("#div").val()).parent().parent().children(), function() {
                                        var temp = $(this).find(".num").val() * 1
                                        if (isNaN(temp))
                                            temp = 0
                                        tot += temp
                                    });
                                    if (tot > $("#" + $("#div").val()).attr("tot") * 1) {
                                        alert("Error: Los valores asignados ($" + tot + ") superan al monto total de la actividad ($" + $("#" + $("#div").val()).attr("tot") + ")")
                                        $("#" + $("#div").val()).val($("#vold").val())
                                    } else {
                                        $.ajax({
                                            type: "POST",
                                            url: "${createLink(action:'guardarModificacionCronograma')}",
                                            data: {
                                                mes:$("#mes").val(),
                                                anio:$("#anio").val(),
                                                valor:valor,
                                                act:$("#act").val(),
                                                id: $("#iden").val(),
                                                fuente:$("#fuente").val(),
                                                idCelda: $("#idCelda").val()
                                            },
                                            success: function(msg) {
                                                if (msg != "no") {
                                                    $("#" + $("#div").val()).val($("#valor").val() * 1)
                                                    $("#" + $("#div").val()).css({
                                                        background: "#AFE2FF"
                                                    });
                                                    $("#" + $("#div").val()).parent().css({
                                                        background: "#AFE2FF"
                                                    });
                                                    $("#" + $("#div").val()).attr("identificador", msg)
                                                    var tot = 0
                                                    $.each($("#" + $("#div").val()).parent().parent().children(), function() {
                                                        var temp = $(this).find(".num").val() * 1
                                                        if (isNaN(temp))
                                                            temp = 0
                                                        tot += temp
                                                    });
//                                                    //console.log($("#" + $("#" + $("#div").val()).attr("div") + "a"))
                                                    var anterior1 = $("#" + $("#" + $("#div").val()).attr("div")).html() * 1
                                                    var anterior2 = $("#" + $("#" + $("#div").val()).attr("div") + "a").html() * 1
                                                    var dif = anterior1 - tot
                                                    var dif2 = anterior2 - ($("#" + $("#div").val()).attr("tot") * 1 - tot)
                                                    $("#" + $("#" + $("#div").val()).attr("div")).html(tot)
                                                    $("#" + $("#" + $("#div").val()).attr("div") + "a").html($("#" + $("#div").val()).attr("tot") * 1 - tot)
                                                    if (dif > 0) {
                                                        $("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div") + "a").html($("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div") + "a").html() * 1 + dif)
                                                        $("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div")).html($("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div")).html() * 1 + dif2)
                                                    } else {
                                                        $("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div") + "a").html($("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div") + "a").html() * 1 - dif)
                                                        $("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div")).html($("#" + $("#" + $("#" + $("#div").val()).attr("div")).attr("div")).html() * 1 - dif2)
                                                    }
                                                    var total = 0
                                                    var totAsignado = 0
                                                    $.each($(".totComps"), function() {
                                                        total += $(this).html() * 1
                                                    });
                                                    $.each($(".totCompsa"), function() {
                                                        totAsignado += $(this).html() * 1
                                                    });
                                                    $("#totGeneralAsignado").html(totAsignado)
                                                    $("#totGeneral").html(total)
                                                    $("#valor").css("border", "black solid 1px")
                                                    $("#dlg_editar").dialog("close")

                                                } else {
                                                    $("#" + $("#div").val()).val($("#vold").val())
                                                    alert("Error al guardar los datos. Revise los cronogramas de años anteriores y posteriores")
                                                }
                                            }
                                        });
                                    }
                                }

                            }

                        }
                    }
                });
            });
        </script>
    </body>
</html>