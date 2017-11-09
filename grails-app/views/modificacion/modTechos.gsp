<%@ page import="mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Modificaciones al presupuesto de la unidad: '${unidad}'</title>

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

    <g:link class="btn_arbol" controller="entidad" action="arbol">Unidades ejecutoras</g:link>

    <fieldset style="" class="ui-corner-all">
        <legend>Gastos correintes</legend>
        <g:if test="${techo.aprobadoCorrientes==1}">

            Presupuesto de gasto corrientes: <input type="text" style="width: 120px;text-align: right" class="ui-corner-all" id="maxCor" value="${formatNumber(number:techo.maxCorrientes,format:"###,##0",minFractionDigits:2,maxFractionDigits:2)}">
            <a href="#" id="btn_cor" iden="${techo.id}">Modificar</a>

        </g:if>
        <g:else>
            El presupuesto para la unidad '${unidad}' de gastos corrientes del año '${actual}' aun no ha sido aprobado.
        </g:else>
    </fieldset>
    <fieldset class="ui-corner-all">
        <legend>Inversiones</legend>

        Presupuesto de inversiones: <input type="text" style="width: 120px;;text-align: right;margin-left: 25px" id="maxInv" class="ui-corner-all" value="${formatNumber(number:techo.maxInversion,format:"###,##0",minFractionDigits:2,maxFractionDigits:2)}">
        <a href="#" id="btn_inv" iden="${techo.id}">Modificar</a>

        %{--<g:else>--}%
        %{--El presupuesto para la unidad ${unidad} de inversiones del año ${actual} aun no ha sido aprobado.--}%
        %{--</g:else>--}%
    </fieldset>
    <div style="width: 800px;height: 35px;background: rgba(255,0,0,0.2);display: none;padding: 10px;font-weight: bold;" class="ui-corner-all" id="error"></div>

    <script type="text/javascript">

        $(".btn_arbol").button()
        $("#btn_cor").button().click(function(){
            if(confirm("Está seguro de modificar el presupuesto?")){
                var val = $("#maxCor").val()
                val = str_replace(".","",val)
                val = str_replace(",",".",val)
                val=val*1
                if(isNaN(val)){
                    $("#error").html("El presupuesto debe ser un valor numérico mayor o igual a cero").show("pulsate")
                }else{
                    if(val>-1){
                        $.ajax({
                            "type"    : "POST",
                            "url"     : "${createLink(action: 'modTechoCorreintes')}",
                            "data"    : {
                                "valor" : val,
                                "id"   : "${techo.id}"
                            },
                            "success" : function (msg) {
                                location.reload(true)
                            }
                        });
                    }else{
                        $("#error").html("El presupuesto debe ser un valor numérico mayor o igual a cero").show("pulsate")
                    }
                }
            }

        });
        $("#btn_inv").button().click(function(){
            if(confirm("Está seguro de modificar el presupuesto?")){

                var val = $("#maxInv").val()
                val = str_replace(".","",val)
                val = str_replace(",",".",val)
                val=val*1
                if(isNaN(val)){
                    $("#error").html("El presupuesto debe ser un valor numérico mayor o igual a cero").show("pulsate")
                }else{
                    if(val>-1){
                        $.ajax({
                            "type"    : "POST",
                            "url"     : "${createLink(action: 'modTechoInversiones')}",
                            "data"    : {
                                "valor" : val,
                                "id"   : "${techo.id}"
                            },
                            "success" : function (msg) {
                                location.reload(true)
                            }
                        });
                    }else{
                        $("#error").html("El presupuesto debe ser un valor numérico mayor o igual a cero").show("pulsate")
                    }
                }
            }
        });
    </script>
</div>
</body>
</html>