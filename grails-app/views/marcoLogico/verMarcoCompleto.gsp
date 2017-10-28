<%@ page import="mies.Indicador" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Marco logico del proyecto (${proyecto.codigoProyecto}): ${(proyecto?.nombre.length() > 40) ? proyecto?.nombre.substring(0, 40) + "..." : proyecto.nombre}</title>


    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
          type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
          type="text/css"/>

    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
            language="JavaScript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
            type="text/javascript" language="JavaScript"></script>

    <style type="text/css">
    .ui-tabs .ui-tabs-hide {
        position : absolute;
        left     : -10000px;
    }

    .cmp {
        width       : 235px;
        margin      : 5px;
        min-height  : 100px;
        /*border: 1px solid black;*/
        float       : left;
        padding     : 5px;
        padding-top : 0px;
        position    : relative;

    }

    .cmpDoble {
        width      : 470px;
        margin     : 5px;
        min-height : 100px;
        /*border: 1px solid black;*/
        float      : left;
        padding    : 5px;
        position   : relative;
    }

    .fila {
        width      : 98%;
        margin     : 2px;
        min-height : 35px;
        float      : left;
        /*border: 1px solid black;*/
    }

    .filaMedio {
        width      : 47.5%;
        margin     : 2px;
        min-height : 35px;
        float      : left;
        /*border: 1px solid black;*/
    }

    .todo {
        height : 100%;
    }

    .titulo {
        width         : 90%;
        margin        : 5%;
        margin-top    : 2px;
        height        : 30px;
        line-height   : 30px;
        text-align    : center;
        font-family   : fantasy;
        font-style    : italic;
        border-bottom : 1px solid black;

    }

    .filaCombo {
        width         : 90%;
        margin        : 5%;
        margin-top    : -10px;
        height        : 40px;
        line-height   : 40px;
        text-align    : center;
        font-family   : fantasy;
        font-style    : italic;
        border-bottom : 1px solid black;
    }

    .texto {
        width      : 90%;
        min-height : 115px;
        margin     : 5%;
        font-size  : 11px
    }

    textarea {
        width      : 93%;
        padding    : 5px;
        min-height : 115px;
        resize     : vertical;
    }

    .agregado {
        width      : 90%;
        margin     : 2px;
        text-align : justify;
        padding    : 4px;
        min-height : 20px;
        word-wrap  : break-word;
    }

    .fin {
        background : rgba(145, 192, 95, 0.2)
    }

    .proposito {
        background : rgba(110, 182, 213, 0.2)
    }
    </style>
</head>

<body>

<div class="body">

<div class="dialog">
%{--<div style="float: left;margin-bottom: 20px;height: 20px;width: 91%;display: block">--}%
%{--<g:link action="showMarco" controller="MarcoLogico" id="${proyecto.id}" class="btn">Editar</g:link>--}%
%{--</div>--}%

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
                Marco L&oacute;gico
            </li>
        </ul>
    </div>
</div>

<div id="tabs"
     style="overflow-y: auto;float: left;margin-left: -20px;overflow-x: hidden;width: 1030px;">
<ul>

    <li><a href="#tabs-1">Fin</a></li>

    <li><a href="#tabs-2">Prop&oacute;sito</a></li>

    <li><a href="#tabs-3">Componentes</a></li>

    <li><a href="#tabs-4">Actividades</a></li>

    <li><a href="#tabs-5">Metas</a></li>

</ul>


<div id="tabs-1"
     style="width: 990px;float: left;border: 1px solid  rgba(145, 192, 95,0.6);margin-top: 5px;margin-left: 1px"
     class="ui-corner-all">

    <div class="matriz ui-corner-all campo cmp datos " ml="Fin" div="div_fin"
         identificador="${fin?.id}"
         style="margin-left: -10px;">
        <div class="titulo">Fin</div>

        <div class="texto agregado ui-corner-all proposito" style="min-height: 115px;" id="div_fin"
             identificador="${fin?.id}">
            ${fin?.objeto}
        </div>

    </div>
    <g:if test="${fin}">
        <div class="matriz ui-corner-all campo cmpDoble " id="div_indi_medios">
            <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                <div class="titulo">Indicadores</div>
            </div>

            <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                <div class="titulo">Medios de Verificaci&oacute;n</div>
            </div>
            <g:set var="band" value="0"></g:set>

            <g:each in="${mies.Indicador.findAllByMarcoLogicoAndEstado(fin,0)}" var="indicador"
                    status="i">
                <g:set var="band" value="1"></g:set>
                <div class="matriz ui-corner-all  fila " id="ind" style="margin-top:-5px">
                    <div class="filaMedio izq " style="margin-right: 10px">
                        <div class="texto agregado ui-corner-all proposito varios  ">
                            ${indicador?.descripcion}
                        </div>
                    </div>

                    <div class="filaMedio der">
                        <g:each in="${mies.MedioVerificacion.findAllByIndicadorAndEstado(indicador,0)}"
                                var="med">
                            <div class="texto agregado ui-corner-all md proposito varios">${med.descripcion}</div>
                        </g:each>
                    </div>
                </div>
            </g:each>

        </div>

        <div class="matriz ui-corner-all campo cmp" style="margin-left: 0px">
            <div class="titulo">Supuestos</div>

            <div class="texto" style=" min-height: 115px;" id="supuestos">
                <g:each in="${mies.Supuesto.findAllByMarcoLogicoAndEstado(fin,0)}" var="su">
                    <div class="agregado ui-corner-all proposito varios"
                         id="sf_${su.id}">${su.descripcion}</div>
                </g:each>

            </div>
        </div>
    </g:if>

</div>%{--end del fin--}%

<div id="tabs-2"
     style="width: 990px;float: left;border: 1px solid  rgba(110, 182, 213,0.6);margin-top: 5px;margin-left: 1px"
     class="ui-corner-all">
    <div class="matriz ui-corner-all campoProp cmp datos" style="margin-left: -10px;">
        <div class="titulo">Prop&oacute;sito</div>

        <div class="texto agregado ui-corner-all proposito" style="min-height: 115px;" id="div_prop"
             identificador="${proposito?.id}">
            ${proposito?.objeto}
        </div>

    </div>
    <g:if test="${proposito}">
        <div class="matriz ui-corner-all  cmpDoble  campoProp" id="div_indi_medios_prop">
            <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                <div class="titulo">Indicadores</div>
            </div>

            <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                <div class="titulo">Medios de Verificaci&oacute;n</div>
            </div>
            <g:set var="band" value="0"></g:set>
            <g:each in="${mies.Indicador.findAllByMarcoLogicoAndEstado(proposito,0)}" var="indiProp"
                    status="i">
                <g:set var="band" value="1"></g:set>
                <div class="matriz ui-corner-all  fila " id="ind" style="margin-top:-5px">
                    <div class="filaMedio izq " style="margin-right: 10px">
                        <div class="texto agregado ui-corner-all proposito varios">
                            ${indiProp?.descripcion}
                        </div>
                    </div>

                    <div class="filaMedio der">
                        <g:each in="${mies.MedioVerificacion.findAllByIndicadorAndEstado(indiProp,0)}"
                                var="med">
                            <div class="texto agregado ui-corner-all md proposito varios">${med.descripcion}</div>
                        </g:each>

                    </div>
                </div>
            </g:each>
        </div>

        <div class="matriz ui-corner-all campoProp cmp">
            <div class="titulo">Supuestos</div>

            <div class="texto" style=" min-height: 115px;" id="div_sup_prop">
                <g:each in="${mies.Supuesto.findAllByMarcoLogicoAndEstado(proposito,0)}" var="su">
                    <div class="agregado ui-corner-all proposito varios"
                         id="sp_${su.id}">${su.descripcion}</div>
                </g:each>
                <div class="agregado ui-corner-all proposito varios editar edicion">Agregar</div>

            </div>
        </div>
    </g:if>

</div>%{--end del proposito--}%

<div id="tabs-3" style="width: 1030px;float: left;margin-top: 5px;" class="ui-corner-all">
    <g:each in="${componentes}" var="comp" status="k">
        <fieldset
                style="width: 1000px;float: left;margin-top: 5px;margin-left: -10px;;border: 1px solid  rgba(150, 150, 150,0.6)"
                class="ui-corner-all fl">
            <legend>Componente ${k + 1}</legend>

            <div class="matriz ui-corner-all campo2 cmp datos " ml="1" div="cmp_${k}">
                <div class="titulo">Componente</div>

                <div class="texto agregado ui-corner-all proposito comp " id="cmp_${k}" ml="1"
                     style="min-height: 115px;" id="rn_${k}">
                    ${comp?.objeto}
                </div>

            </div>
            %{--inicio de indicadores--}%
            <div class="matriz ui-corner-all campo2 cmpDoble " id="div_indi_medios_fin">
                <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                    <div class="titulo">Indicadores</div>
                </div>

                <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                    <div class="titulo">Medios de Verificaci&oacute;n</div>
                </div>
                <g:set var="band" value="0"></g:set>
                <g:each in="${mies.Indicador.findAllByMarcoLogicoAndEstado(comp,0)}" var="indicador"
                        status="i">
                    <g:set var="band" value="1"></g:set>
                    <div class="matriz ui-corner-all  fila " id="ind"
                         style="${(i == 0) ? 'margin-top:-10px;' : ''}">
                        <div class="filaMedio izq ">
                            <div class="texto agregado ui-corner-all proposito varios  ">
                                ${indicador?.descripcion}
                            </div>
                        </div>

                        <div class="filaMedio der">
                            <g:each in="${mies.MedioVerificacion.findAllByIndicadorAndEstado(indicador,0)}"
                                    var="med">
                                <div class="texto agregado ui-corner-all md proposito varios">${med.descripcion}</div>
                            </g:each>
                        </div>
                    </div>
                </g:each>

            </div>%{--Fin de indicadores--}%
            <div class="matriz ui-corner-all campo2 cmp">
                <div class="titulo">Supuestos</div>

                <div class="texto" style=" min-height: 115px;">
                    <g:each in="${mies.Supuesto.findAllByMarcoLogicoAndEstado(comp,0)}" var="su">
                        <div class="agregado ui-corner-all proposito varios">${su.descripcion}</div>
                    </g:each>
                </div>
            </div>
        </fieldset>
    </g:each>

</div>
%{--fin componentes--}%
<div id="tabs-4" style="width: 1030px;float: left;margin-top: 5px;margin-left: -15px;"
     class="ui-corner-all ">

</div>
%{--fin actividades--}%
<div id="tabs-5" style="width: 1030px;float: left;margin-top: 5px;margin-left: -15px;" class="ui-corner-all ">
    <g:link action="buscadorMetas" controller="meta" class="boton" style="margin-bottom: 5px;">Buscador</g:link>
</div>
%{--fin metas--}%

</div>
%{--Tabs--}%
</div>
%{--Dialog--}%
</div>
%{--Body--}%
<div class="accordion">
    <g:set var="tc" value="0"></g:set>
    <g:each in="${componentes}" var="comp" status="k">
        <h3><a href="#">Componente ${k + 1} : ${(comp?.objeto.length() > 40) ? comp?.objeto.substring(0, 40) + "..." : comp.objeto}</a>
        </h3>

        <div>
            <g:set var="total" value="${0}"></g:set>
            <g:each in="${mies.MarcoLogico.findAllByMarcoLogicoAndEstado(comp,0,[sort:'id'])}" var="act" status="l">
                <fieldset
                        style="width: 970px;float: left;margin-top: 5px;margin-left: -10px;;border: 1px solid  rgba(150, 150, 150,0.6)"
                        class="ui-corner-all">
                    <legend>Actividad ${l + 1}</legend>

                    <div class="matriz ui-corner-all campo3 cmp datos actividades">
                        <div class="titulo">Actividad</div>

                        <div class="texto agregado ui-corner-all proposito" ml="1" style="min-height: 115px;">
                            ${act?.objeto}
                        </div>
                    </div>

                    <div class="matriz ui-corner-all campo3 cmp datos actividades" style="width:170px">
                        <div class="titulo">Monto</div>

                        <div class="texto agregado ui-corner-all proposito" ml="1"
                             style="height: 115px;text-align: center;line-height: 115px;">
                            $<g:formatNumber number="${act?.monto}" format="###,##0"
                                             minFractionDigits="2" maxFractionDigits="2"/>

                            <g:set var="total" value="${total.toDouble()+act.monto}"></g:set>
                        </div>
                    </div>

                    <div class="matriz ui-corner-all campo3 cmp datos actividades">
                        <div class="titulo">Indicadores</div>
                        <g:each in="${mies.Indicador.findAllByMarcoLogicoAndEstado(act,0)}" var="indicador"
                                status="i">
                            <div class="texto agregado ui-corner-all proposito" ml="1"
                                 style="min-height: 30px;">
                                ${indicador?.descripcion}
                            </div>
                        </g:each>
                    </div>

                    <div class="matriz ui-corner-all campo3 cmp">
                        <div class="titulo">Supuestos</div>

                        <div class="texto" style=" min-height: 115px;">
                            <g:each in="${mies.Supuesto.findAllByMarcoLogicoAndEstado(act,0)}" var="su">
                                <div class="agregado ui-corner-all proposito varios">${su.descripcion}</div>
                            </g:each>
                        </div>
                    </div>

                </fieldset>
            </g:each>
            <g:set var="tc" value="${tc.toDouble()+total}"></g:set>
            <div style="width: 970px;height: 40px;float: left;margin-top: 15px;border: 1px red solid;line-height: 40px;padding-left: 20px;"
                 class="ui-corner-all"><b>Subtotal:&nbsp;&nbsp;
            $<g:formatNumber number="${total}" format="###,##0"
                             minFractionDigits="2" maxFractionDigits="2"/>
            </b></div>
        </div>

    </g:each>

</div>

<div class="accordion_metas">
    <table width="790px" class="ui-corner-all">
        <tbody>
        <g:set var="totalMetas" value="0"></g:set>
        <g:set var="totalInversion" value="0"></g:set>
        <g:each in="${componentes}" var="comp" status="k">
            <tr>
                <th colspan="6" style="background: #EFB64F">
                    Componente ${k + 1} : ${(comp?.objeto.length() > 70) ? comp?.objeto.substring(0, 70) + "..." : comp.objeto}
                </th>
            </tr>
            <g:each in="${mies.MarcoLogico.findAllByMarcoLogicoAndEstado(comp,0,[sort:'id'])}" var="act" status="p">

                <tr>
                    <th colspan="6" style="background: #8FBF5C">
                        Actividad ${p + 1} : ${(act?.objeto.length() > 70) ? act?.objeto.substring(0, 70) + "..." : act.objeto}
                    </th>
                </tr>
                <tr style="background: #72B9D7">
                    <th style="width: 300px;">
                        Ubicación
                    </th>
                    <th>
                        Año
                    </th>
                    <th>
                        Indicador
                    </th>
                    <th>
                        Unidad
                    </th>
                    <th>
                        Meta
                    </th>
                    <th style="width: 100px">
                        Inversión
                    </th>
                    <th>Mapa</th>
                </tr>



                <g:each in="${mies.Meta.findAllByMarcoLogicoAndEstado(act,0)}" var="meta" status="l">
                    <tr>
                        <td style="width: 300px;">${""+meta.parroquia+" (Provincia:"+meta.parroquia.canton.provincia+", Canton "+meta.parroquia.canton})</td>
                        <td>${meta.anio}</td>
                        <td>${meta.tipoMeta}</td>
                        <td>${meta.unidad}</td>
                        <td style="text-align: right">${meta.indicador}</td>
                        <td style="width: 100px;text-align: right">
                            <g:formatNumber number="${meta.inversion}"
                                            format="###,##0"
                                            minFractionDigits="2" maxFractionDigits="2"/>
                            <g:set var="totalMetas" value="${totalMetas.toDouble()+meta.indicador}"></g:set>
                            <g:set var="totalInversion" value="${totalInversion.toDouble()+meta.inversion}"></g:set>
                        </td>
                        <td>
                            <a href="${g.createLink(controller: 'marcoLogico',action: 'mapaMeta')}/${meta.id}" class="mapa">Mapa</a>
                        </td>
                    </tr>
                </g:each>
            </g:each>
        </g:each>
        <tr>
            <td>
               <b> TOTAL</b>
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td style="text-align: right">
                <g:formatNumber number="${totalMetas}"
                                format="###,##0"
                                minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td style="text-align: right">
                <g:formatNumber number="${totalInversion}"
                                format="###,##0"
                                minFractionDigits="2" maxFractionDigits="2"/>
            </td>
        </tr>
        </tbody>
    </table>

</div>

<div style="width: 970px;height: 40px;float: left;margin-top: 15px;border: 1px red solid;line-height: 40px;padding-left: 20px;margin-left: 28px"
     id="total" class="ui-corner-all"><b>Total:&nbsp;&nbsp;
$<g:formatNumber number="${tc}" format="###,##0"
                 minFractionDigits="2" maxFractionDigits="2"/>
</b></div>
<script type="text/javascript">

    $("#breadCrumb").jBreadCrumb({
        beginingElementsToLeaveOpen:10
    });

    function reajustar() {
        var tam = 215
        $.each($(".campo"), function () {
            if ($(this).height() * 1 > tam)
                tam = $(this).height() * 1
        });
        $(".boton").button()
        $(".campo").css("min-height", tam)
        $("#div_fin").css("min-height", tam - 60)

        tam = 100
        var div = new Array()
        $.each($(".fl"), function () {
            $.each($(this).find(".campo2"), function () {
                if ($(this).height() * 1 > tam)
                    tam = $(this).height() * 1
            });
            $(this).find(".campo2").css("min-height", tam)
            $(this).find(".campo2").find(".comp").css("min-height", tam - 60)
            tam = 100
        });


        tam = 215
        $.each($(".campoProp"), function () {
            if ($(this).height() * 1 > tam)
                tam = $(this).height() * 1
        });
        $(".campoProp").css("min-height", tam)
        $("#div_prop").css("min-height", tam - 60)
        $.each($(".fila"), function () {
            tam = 0
//            $.each($(this).find(".der").children(),function(){
//                //console.log("div de la izq "+$(this).css("display"))
//                if($(this).css("display")!="none")
//                tam += $(this).height()+7
//            });

            if ($(this).find(".izq").height() < $(this).find(".der").height())
                $(this).find(".izq").children().height($(this).find(".der").height() - 10)


        });
    }
    $(function () {
        reajustar();
        $(".btn").button();
        $(".mapa").button({icons:{ primary:"ui-icon-map"},text:false});
        $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});
        $("#tabs").tabs();
        $(".accordion").accordion({ collapsible:true, autoHeight:false, active:-1 });
//        $(".accordion_metas").accordion({ collapsible:true, autoHeight:false, active:-1 });
        $("#tabs").tabs("option", "selected", 0);
        $("#tabs-4").append($(".accordion"));
        $("#tabs-5").append($(".accordion_metas"));
        $("#tabs-4").append($("#total"));
    });
</script>
</body>
</html>