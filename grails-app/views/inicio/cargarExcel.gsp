<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Cargar archivo excel para asignaciones</title>
    <meta name="layout" content="main"/>

</head>

<body>

<g:if test="${flash.message}">
    <div class="ui-corner-all" style="background-color: #f5e0e0; height: 30px; vertical-align: middle; text-align: center">
        ${flash.message}
    </div>
</g:if>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="uploadFile" method="post" name="frmUpload" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Archivo PAPP en Excel:</b> <input type="file" class="ui-corner-all" name="file" id="file" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right" id="btnSubirPAPP">Subir</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subeEsigef" method="post" name="frmEsigef" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Programas y actividades eSIGEF:</b> <input type="file" class="ui-corner-all" name="file" id="file01" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirEsigef">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subePlig" method="post" name="frmPlig" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Políticas de igualdad:</b>
            <input type="file" class="ui-corner-all" name="file" id="file02" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirPlig">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subeObei" method="post" name="frmObei" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Objetivo estratégico (OBEI):</b>
            <input type="file" class="ui-corner-all" name="file" id="file03" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirObei">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subeObep" method="post" name="frmObep" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Objetivo específico (OBEP):</b>
            <input type="file" class="ui-corner-all" name="file" id="file04" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirObep">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subeObop" method="post" name="frmObop" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Objetivo operativo (OBOP):</b>
            <input type="file" class="ui-corner-all" name="file" id="file05" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirObop">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subePrsp" method="post" name="frmPrsp" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Cuentas presupuestarias (PRSP):</b>
            <input type="file" class="ui-corner-all" name="file" id="file06" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirPrsp">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="subeFnte" method="post" name="frmFnte" id="${''}">
        <div class="row-fluid span6" role="main" style="margin: 10px 0 0 0; display: inline">
        <div class="span6" role="main" style="margin: 10px 0 0 0;">

           <b> Fuentes de financiamiento (FNTE):</b>
            <input type="file" class="ui-corner-all" name="file" id="file07" size="70" width="600px"/>

                <a href="#" class="btn button btn-success pull-right"
                   id="btnSubirFnte">Subir Archivo</a>
            </div>
        </div>
    </g:uploadForm>
</div>

<script type="text/javascript">

    $(".button").button();

    $("#btnSubirPAPP").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmUpload").submit();
    });

    $("#btnSubirEsigef").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmEsigef").submit();
    });

    $("#btnSubirPlig").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmPlig").submit();
    });

    $("#btnSubirObei").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmObei").submit();
    });

    $("#btnSubirObep").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmObep").submit();
    });

    $("#btnSubirObop").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmObop").submit();
    });

    $("#btnSubirPrsp").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmPrsp").submit();
    });

    $("#btnSubirFnte").click(function () {
//            $(this).replaceWith(spinner);
            $("#frmFnte").submit();
    });

</script>

</body>
</html>