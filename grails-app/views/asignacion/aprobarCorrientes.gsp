<%--
  Created by IntelliJ IDEA.
  User: svt
  Date: 1/16/12
  Time: 1:06 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Aprobar asignaciones corrientes de la unidad: ${unidad}</title>

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


    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    &nbsp;&nbsp;&nbsp;<b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio"
                                           optionKey="id" optionValue="anio" value="${actual.id}"/>

</div>
<fieldset class="ui-corner-all">
    <legend>Detalle</legend>
    <g:if test="${max}">
        <g:if test="${max.aprobadoCorrientes==1}">
            <div class="ui-corner-all" style="width: 400px;height: 20px;border: red 1px solid;margin: 10px;padding: 5px;line-height: 20px"><b>Periodo aprobado</b></div>
        </g:if>
        <div></div>
        <table>
            <tbody>
            <tr>
                <td><b>Unidad ejecutora</b></td>
                <td>${unidad.nombre}</td>
            </tr>
            <tr>
                <td><b>Prespuesto ${actual}:</b></td>
                <td style="">
                    <g:formatNumber number="${max.maxCorrientes}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
            <tr>
                <td>
                    <b>Asignado:</b>
                </td>
                <td>
                    <g:formatNumber number="${totCorrientes}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
            <tr>
                <td>
                    <b>Sin asignar</b>
                </td>
                <td>
                    <g:formatNumber number="${max.maxCorrientes-totCorrientes}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
            <tr>
                <td>
                    <b>Reporte</b>
                </td>
                <td>
                    <g:link class="btn" controller="reportes" action="poaCorrientesReporteWeb" id="${unidad.id}" target="_blank">Web</g:link>
                    <a class="btn" id="pdf"  target="_blank">Pdf</a>
                </td>
            </tr>
            </tbody>

        </table>
        <g:if test="${max.aprobadoCorrientes==0}">
            <a href="#" class="btn" style="margin: 10px" id="aprobar">Aprobar</a>
        </g:if>
    </g:if><g:else>
    La unidad no tiene asignado presupuesto para este año
    </g:else>
</fieldset>

<div id="aprob">
    <input type="hidden" id="iden">
    Ingrese su clave de aprobación <br>
    <input type="password" id="pass">
</div>
<script type="text/javascript">
    $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
    $(".btn").button()
    $("#anio_asg").change(function () {
        location.href = "${createLink(controller:'asignacion',action:'aprobarCorrientes')}?id=${unidad.id}&anio=" + $(this).val()
    });
    $("#pdf").click(function(){
        var url = "${createLink(controller: 'reportes', action: 'poaCorrientesReportePDF')}?id=" + ${unidad.id}+"Wanio=${actual.id}";
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url
    })
    $("#aprob").dialog({
        autoOpen:false,
        modal:true,
        position:"center",
        width:250,
        height:160,
        title:"Aprobación",
        resizable:false,
        buttons:{
            "Aprobar":function(){
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'aprobarAsgCorrientes')}",
                    data: {
                        ssap:$("#pass").val(),
                        anio:${actual.id},
                        unidad:${unidad.id}
                    },
                    success: function(msg) {

                        if(msg!="no"){
                            if(msg!="error"){
                                window.location.href="${createLink(controller:'asignacion',action:'aprobarCorrientes')}?id=${unidad.id}&anio=" + ${actual.id}
                            }else{
                                alert("Error: Ha ocurrido un error inesperado. ")
                            }

                        }else{
                            alert("Clave no valida")
                        }
                    }
                });
            }
        }
    });
    $("#aprobar").click(function(){
        $("#aprob").dialog("open")
    });
</script>

</body>
</html>