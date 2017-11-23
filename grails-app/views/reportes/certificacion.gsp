<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/16/11
  Time: 11:35 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Intervención e inversión del MIES en el año ${anio}</title>

    <style type="text/css">
    @page {
        size   : 21cm 29.7cm;  /*width height */
        margin : 2cm;
    }

    .hoja {
        width : 15cm;
    }

    .titulo {
        width : 15.5cm;
    }

    .hoja {
        /*background  : #e6e6fa;*/
        height      : 24.7cm; /*29.7-(1.5*2)*/
        font-family : arial;
        font-size   : 12pt;
    }

    .titulo {
        height        : 130px;
        font-size     : 12pt;
        /*font-weight   : bold;*/
        text-align    : center;
        margin-bottom : 5px;
        width: 95%;
    }

    .totales {
        font-weight : bold;
    }

    .num {
        text-align : right;
    }

    .header {
        background : #333333 !important;
        color      : #AAAAAA;
    }

    .total {
        background : #000000 !important;
        color      : #FFFFFF !important;
    }
    th {
        background : #cccccc;
    }

    tbody tr:nth-child(2n+1) {
        background : none repeat scroll 0 0 #E1F1F7;
    }

    tbody tr:nth-child(2n) {
        background : none repeat scroll 0 0 #F5F5F5;
    }
    </style>

</head>

<body>
<div class="hoja">
    <div style="width: 100%;float: left;display: block;height: 130px;">
        <div style="float:left;width:120px;height: 120px;  ">
            <img src="${g.resource(dir: "images",file:"logo_mies.jpg")}" alt="Mies" width="100%" height="100%;"/>
        </div>
    </div>
    <div class="titulo" style="text-align: right;float: right">
        <p><b>Direción de Planificación e Inversión</b></p>
        <p>Memorando No. MIES-CGP-DPI-${anio}-${cer.memorandoCertificado}-M </p>
        <p>Quito, DM, ${new Date().format("dd")} de ${mes} de ${anio} </p>
    </div>
    <div style="float: left;font-size: 12pt;">
        <p>PARA: ${cer.asignacion.unidad}</p>
        <p>ASUNTO: Certificación actividad PAPP 2012</p>
    </div>

    <div style="text-align: justify;float: left;font-size: 12pt;">
        <p>
            En atención al memorando No ${cer.memorandoSolicitud} de ${mes} de ${anio}, mediante el cual solicita certifcar que la(s) actividad(es):
            se encuentra(n) contemplada(s) en el Plan Anual de la Pólitica Pública ${anio}  aprobado de la unidad <b>${cer.asignacion.unidad}</b>.</p>
        <p>
            Al respecto me permito certificar que revisado el Plan Anual de la Pólitica Pública ${anio} de la unidad ${cer.asignacion.unidad} aprobado por la señora Ministra
            de Inclusión Econónica y Social Ing. Ximena Ponce mediante Acuerdo Ministerial No ${cer.acuerdo} de 11 enero de ${anio} consta(n) la(s) mencionada(s) actividad(es),
            <b>${((cer.asignacion.marcoLogico)?cer.asignacion.marcoLogico:cer.asignacion.actividad)}</b>, por el valor de <g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/> dolares.

        </p>
    </div>

    <div style="margin-top: 20px;float: left;width: 100%;height: 15px;font-size: 12pt;">
        Atentamente,
    </div>
    <g:if test="${usuario.id.toInteger()==3}">
        <div style="margin-top: 100px;float: left;font-size: 12pt;">
            <p>Mgs. Allison Berenice Quintanilla Izurieta</p>
            <p>
                <b>DIRECTORA DE PLANIFICACIÓN E INVERSIÓN</b>
            </p>
        </div>
    </g:if>
    <g:else>
        <div style="margin-top: 100px;float: left;font-size: 12pt;">
            <p>${usuario.persona.nombre+" "+usuario.persona.apellido}</p>
            <p>
                <b>RESPONSABLE DE PLANIFICACIÓN</b>
            </p>
        </div>
    </g:else>

</div>

</body>
</html>