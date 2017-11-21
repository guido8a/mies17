<%@ page import="mies.ProgramacionAsignacion; mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones de inversión de la unidad: ${unidad}</title>

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
    .valor{
        width: 60px;
        text-align: center;
        margin: 0px;
        color: #000000;
    }
    </style>
</head>

<body>

<div style="margin-left: 10px;">
    <g:link class="btn_arbol" controller="asignacion" action="asinacionesInversion" id="${unidad.id}">Asignaciones</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades Ejecutoras</g:link>
    &nbsp;&nbsp;&nbsp;<b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
</div>

<div id="accordion" style="width:1300px;margin-top: 5px;font-size: 11px;">

    <ul>
        <li><a href="#tabs-1">Inversión</a></li>
    </ul>


    <div id="tabs-1">
        <table style="width: 1200px;">
            <thead>
            <th style="width: 70px;">Enero</th>
            <th style="width: 70px;">Feb.</th>
            <th style="width: 70px;">Marzo</th>
            <th style="width: 70px;">Abril</th>
            <th style="width: 70px;">Mayo</th>
            <th style="width: 70px;">Junio</th>
            <th style="width: 70px;">Julio</th>
            <th style="width: 70px;">Agos.</th>
            <th style="width: 70px;">Sept.</th>
            <th style="width: 70px;">Oct.</th>
            <th style="width: 70px;">Nov.</th>
            <th style="width: 70px;">Dic.</th>
            <th style="width: 80px;">Total</th>
            <th></th>
            <th></th>
            </thead>
            <tbody>
            <g:set var="ene" value="${0}"></g:set>
            <g:set var="feb" value="${0}"></g:set>
            <g:set var="mar" value="${0}"></g:set>
            <g:set var="abr" value="${0}"></g:set>
            <g:set var="may" value="${0}"></g:set>
            <g:set var="jun" value="${0}"></g:set>
            <g:set var="jul" value="${0}"></g:set>
            <g:set var="ago" value="${0}"></g:set>
            <g:set var="sep" value="${0}"></g:set>
            <g:set var="oct" value="${0}"></g:set>
            <g:set var="nov" value="${0}"></g:set>
            <g:set var="dic" value="${0}"></g:set>
            <g:set var="asignado" value="0"></g:set>


            <g:each in="${inversiones}" var="asg" status="i">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td colspan="15"><b>Asignación#${i+1} </b>${asg}</td>
                </tr>
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <g:each in="${meses}" var="mes" status="j">
                        <g:if test="${ProgramacionAsignacion.findAll('from ProgramacionAsignacion where asignacion = '+asg.id+' and mes = '+mes+' and padre is null').size()>0}" >
                            <g:set var="progra" value="${ProgramacionAsignacion.findAll('from ProgramacionAsignacion where asignacion = '+asg.id+' and mes = '+mes+' and padre is null')?.pop()}"></g:set>
                            <td class="${mes}" style="width: 70px;">
                                <input type="text" class="${mes} valor asg_cor_${asg.id}" mes="${mes}"  ${(actual.estado!=0)?"disabled":""} value="${g.formatNumber(number:progra?.valor, format:'###,##0', minFractionDigits:'2',maxFractionDigits:'2')}">

                                <g:if test="${mes.toInteger()==1}">
                                    <g:set var="ene" value="${ene.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==2}">
                                    <g:set var="feb" value="${feb.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==3}">
                                    <g:set var="mar" value="${mar.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==4}">
                                    <g:set var="abr" value="${abr.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==5}">
                                    <g:set var="may" value="${may.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==6}">
                                    <g:set var="jun" value="${jun.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==7}">
                                    <g:set var="jul" value="${jul.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==8}">
                                    <g:set var="ago" value="${ago.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==9}">
                                    <g:set var="sep" value="${sep.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==10}">
                                    <g:set var="oct" value="${oct.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==11}">
                                    <g:set var="nov" value="${nov.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                                <g:if test="${mes.toInteger()==12}">
                                    <g:set var="dic" value="${dic.toDouble()+progra?.valor}"></g:set>
                                </g:if>
                            </td>
                        </g:if>
                        <g:else>
                            <td class="${mes}" style="width: 70px;">
                                <input type="text" class="${mes} valor asg_cor_${asg.id}" mes="${mes}"  ${(actual.estado!=0)?"disabled":""} value="0,00">
                            </td>
                        </g:else>
                    </g:each>

                    <td class="total" id="total_cor_${asg.id}" style="width: 80px;">
                        <g:formatNumber number="${(asg.redistribucion==0)?asg.planificado:asg.redistribucion}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                    <g:if test="${actual.estado==0}">
                        <td class="">
                            <a href="#" class="btn guardar ajax" asg="${asg.id}"   icono="ico_cor_${i}" max="${(asg.redistribucion==0)?asg.planificado:asg.redistribucion}" clase="asg_cor_${asg.id}" total="total_cor_${asg.id}">Guardar</a>
                        </td>
                    </g:if>
                    <td class="ui-state-active"><span class="" id="ico_cor_${i}" title="Guardado" style="display: none"><span class="ui-icon ui-icon-check"></span></span></td>
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
                <td style="text-align: center"><g:formatNumber number="${ene.toDouble()+feb.toDouble()+mar.toDouble()+abr.toDouble()+may.toDouble()+jun.toDouble()+jul.toDouble()+ago.toDouble()+sep.toDouble()+oct.toDouble()+nov.toDouble()+dic.toDouble()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
            </tbody>
        </table>

    </div>






</div>



<script type="text/javascript">
    $("#accordion").tabs();
    $("[name=programa]").selectmenu({width: 180});
    $(".btn_arbol").button({icons: { primary: "ui-icon-bullet"}})
    $(".btn").button()
    $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

    $(".guardar").button({
        icons:{
            primary:"ui-icon-disk"
        },
        text:false
    })
    $("#anio_asg").change(function(){
        location.href="${createLink(controller:'asignacion',action:'programacionInversion')}?id=${unidad.id}&anio="+$(this).val()
    });

    $(".guardar").click(function() {
        var icono = $("#" + $(this).attr("icono"))
        var total = 0
        var max = $(this).attr("max")*1
        var datos =""
        $.each($("."+$(this).attr("clase")),function(){
            var val = $(this).val()
            val = str_replace(".","",val)
            val = str_replace(",",".",val)
            val=val*1
            total+= val
            datos+=$(this).attr("mes")+":"+val+";"
        });
        total =parseFloat(total).toFixed(2);
        if(total!=max){
            alert("El total programado ("+total+") es diferente al monto de la asignación "+max)
            $("#"+$(this).attr("total")).html(total).css("color","red").show("pulsate")
        }else{
            $("#"+$(this).attr("total")).html(total).css("color","black")
            if($(this).attr("tipo")!="dist"){
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'guardarProgramacion',controller:'asignacion')}",
                    data: "asignacion="+$(this).attr("asg")+"&datos="+datos ,
                    success: function(msg) {
                        if(msg=="ok"){
                            icono.show("pulsate")
                            window.location.reload(true)
                        }
                    }
                });
            }else{
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'guardarProgramacionDistribucion',controller:'asignacion')}",
                    data: "asignacion="+$(this).attr("asg")+"&datos="+datos+"&unidad=${unidad.id}" ,
                    success: function(msg) {
                        if(msg=="ok"){
                            icono.show("pulsate")
                            window.location.reload(true)
                        }
                    }
                });
            }
        }

    });


</script>

</body>
</html>