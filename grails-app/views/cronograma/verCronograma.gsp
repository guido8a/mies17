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
    }

    .num {
        text-align : center;
        width      : 100px;
    }

    .disabled {
        background : #ddd;
        width      : 100px;
        text-align : center;
    }
    </style>
</head>

<body>
<div class="body" style="font-size: 11px">

    <div class="breadCrumbHolder module">
        <div id="breadCrumb" class="breadCrumb module">
            <ul>
                <li>
                    <g:link class="bc" controller="proyecto" action="show"
                            id="${proyecto.id}">
                        Proyecto
                    </g:link>
                </li>
                <li>
                    Cronograma
                </li>
            </ul>
        </div>
    </div>

    <div id="" class="toolbar ui-widget-header ui-corner-all" style="margin-bottom: 5px;">
        <g:if test="${anio.estado==0 && proyecto.aprobado!='a'}">
            <g:link class="button edit" controller="cronograma" action="nuevoCronograma" id="${proyecto.id}">
                Editar
            </g:link>
        </g:if>
        <g:link controller="asignacion" action="asignacionProyectov2" id="${proyecto.id}" class="button">Asignaciones</g:link>
    </div> <!-- toolbar -->

    <div class="dialog">
        <table style="width: 1600px;margin-left: -20px" border="1">
            <thead style="background: rgba(110, 182, 213,0.2)">
            <tr>
                <th>&nbsp;</th>
                <g:form action="verCronograma" method="post" class="frm_anio">
                    <input type="hidden" name="id" value="${proyecto.id}">
                    <th colspan="15"><g:select from="${mies.Anio.list()}" optionKey="id" optionValue="anio"
                                               name="anio" id="anio" value="${anio.id}"
                                               style="width: 70px"/></th>
                </g:form>
            </tr>

            <tr>
                <th class="colGrande">Componentes/Rubros</th>
                <g:each in="${mies.Mes.list()}" var="mes">
                    <th class="col">${mes.descripcion}</th>
                </g:each>
                <th style="width: 100px;">Total</th>
                <th style="width: 100px;">Sin asignar</th>
                <th style="width: 100px;">Total metas</th>
            </tr>
            </thead>
            <tbody>
            <g:set var="indice" value="0"></g:set>
            <g:set var="totProy" value="0"></g:set>
            <g:set var="totProyAsig" value="0"></g:set>
            <g:set var="totalMetas" value="0"></g:set>
            <g:set var="totalMetasCronograma" value="${0}"></g:set>
            <g:each in="${componentes}" var="comp" status="j">
                <g:set var="totComp" value="0"></g:set>
                <g:set var="totCompAsig" value="${0}"></g:set>
                <tr>
                    <td class="colGrande componente " style="background: ${colores[indice.toInteger()]}"
                        colspan="16"><b>Componente ${j + 1}</b>: ${(comp.objeto.length() > 100) ? comp.objeto.substring(0, 100) + "..." : comp.objeto}
                    </td>
                </tr>
                <g:each in="${mies.MarcoLogico.findAllByMarcoLogicoAndEstado(comp,0,[sort:'id'])}" var="act" status="i">
                    <g:set var="monto" value="${act.totalMetasAnio(anio)}"></g:set>
                    <g:set var="totComp" value="${totComp.toDouble()+monto}"></g:set>
                    <tr>
                        <td class="colGrande" style="background: ${colores[indice.toInteger()]}"
                            title="${act.objeto}">${(act.objeto.length() > 100) ? act.objeto.substring(0, 100) + "..." : act.objeto}</td>
                        <g:set var="tot" value="0"></g:set>
                        <g:set var="totAct" value="${monto}"></g:set>
                        <g:each in="${mies.Mes.list()}" var="mes" status="k">
                            <g:set var="crga" value='${mies.Cronograma.findAllByMarcoLogicoAndMes(act,mes)}'></g:set>
                            <g:if test="${crga.size()>0}">
                                <g:each in="${crga}" var="c">
                                    <g:if test="${c?.anio==anio}">
                                        <g:set var="crg" value='${c}'></g:set>
                                        <g:set var="totCompAsig" value="${totCompAsig.toDouble()+crg.valor+crg.valor2}"></g:set>
                                    </g:if>
                                </g:each>
                                <g:if test="${crg}">

                                    <g:set var="tot" value="${tot.toDouble()+crg?.valor+crg.valor2}"></g:set>
                                    <g:if test="${true}">

                                        <td class="disabled num" id="crg_${crg.id}" actividad="${act.id}"
                                            tot="${monto}" div="tot_${j}${i}" mt="${mes.descripcion}"
                                            fuente="${crg.fuente.descripcion}">
                                            <g:formatNumber number="${crg.valor+crg.valor2}"
                                                            format="###,##0"
                                                            minFractionDigits="2" maxFractionDigits="2"/>

                                        </td>
                                    %{--<td ><input type="text" value="" class="num" mes="${mes.id}" identificador="${crg.id}" actividad="${act.id}" tot="${monto}" div="tot_${i}" mt="${mes.descripcion}"></td>--}%
                                    </g:if>
                                    <g:else>
                                        <td class="disabled"> 0,00</td>
                                    </g:else>
                                    <g:set var="crg" value="${null}"></g:set>
                                </g:if>
                                <g:else>

                                    <td class="disabled"> 0,00</td>

                                </g:else>
                            </g:if>
                            <g:else>

                                <td class="disabled"> 0,00</td>

                            </g:else>
                        </g:each>
                        <td class="disabled" id="tot_${j}${i}">

                            <g:formatNumber number="${tot}"
                                            format="###,##0"
                                            minFractionDigits="2" maxFractionDigits="2"/>
                        </td>
                        <td class="disabled" id="tot_${j}${i}a">
                            <g:formatNumber number="${totAct.toDouble() - tot.toDouble()}"
                                            format="###,##0"
                                            minFractionDigits="2" maxFractionDigits="2"/>
                        </td>
                        <td class="disabled" id="tot_${j}${i}a">
                            <g:formatNumber number="${monto}"
                                            format="###,##0"
                                            minFractionDigits="2" maxFractionDigits="2"/>
                            <g:set var="totalMetas" value="${totalMetas.toDouble()+monto}"></g:set>
                        </td>

                    </tr>
                </g:each>
                <tr>
                    <td class="colGrande " style="background: ${colores[indice.toInteger()]}"
                        colspan="13"><b>TOTAL</b></td>
                    <td style="text-align: center;background: ${colores[indice.toInteger()]}"><b><div
                            id="totComp_${j}a" class="totCompsa">
                        <g:formatNumber number="${totCompAsig}"
                                        format="###,##0"
                                        minFractionDigits="2" maxFractionDigits="2"/>
                    </div></b>
                    </td>
                    <td style="text-align: center;background: ${colores[indice.toInteger()]}">
                        <b>
                            <div
                                    id="totComp_${j}"
                                    class="totComps">
                                <g:formatNumber number="${(totComp.toDouble() - totCompAsig.toDouble())}"
                                                format="###,##0"
                                                minFractionDigits="2" maxFractionDigits="2"/>
                            </div>
                        </b>
                    </td>
                    <td style="text-align: center;background: ${colores[indice.toInteger()]}">
                        <g:formatNumber number="${totalMetas}"
                                        format="###,##0"
                                        minFractionDigits="2" maxFractionDigits="2"/>

                        <g:set var="totalMetasCronograma" value="${totalMetasCronograma.toDouble()+totalMetas}"></g:set>
                        <g:set var="totalMetas" value="${0}"></g:set>
                    </td>
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
                        id="totGeneralAsignado">
                    <g:formatNumber number="${totProyAsig}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </div></b></td>
                <td style="text-align: center;background: #E0EEF4"><b><div
                        id="totGeneral">
                    <g:formatNumber number="${(totProy.toDouble() - totProyAsig.toDouble())}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </div>
                </b></td>
                <td style="text-align: center;background: #E0EEF4">
                    <g:formatNumber number="${(totalMetasCronograma)}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div id="dlg_editar" title="Cronograma" style="padding-left: 60px">

    <div style="width: 100%;float: left;margin-top: 10px;">
        <div style="width: 80px;float: left;">
            <b>Valor:</b>
        </div>

        <div id="valor"></div>
    </div>

    <div style="width: 100%;float: left;margin-top: 5px;">
        <div style="width: 80px;float: left">
            <b>Fuente:</b>
        </div>

        <div id="fuente"></div>
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

</div>

<script type="text/javascript">
    $(function() {
        $(".button").button();

        $(".edit").button({
            icons: {
                primary:'ui-icon-pencil'
            }
        });

        $("#breadCrumb").jBreadCrumb({
            beginingElementsToLeaveOpen: 10
        });

        $("#anio").change(function() {
            $(".frm_anio").submit()
        });

        $(".num").click(function() {
            $("#valor").html($(this).html())
            $("#mes_texto").html($(this).attr("mt"))
            var mt = $(this).attr("tot")
            $("#mt").html(number_format(mt, 2, ',', '.'))
            $("#fuente").html($(this).attr("fuente"))
            $("#dlg_editar").dialog("open")
        });

        $("#dlg_editar").dialog({
            width:270,
            height:270,
            position:"center",
            modal:true,
            autoOpen:false,
            resizable:false,
            buttons:{
                "Cerrar":function() {
                    $("#dlg_editar").dialog("close")
                }
            }
        });
    });
</script>
</body>
</html>