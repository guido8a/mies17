<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Solicitud de certificación -- Unidad:${unidad}</title>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}" type="text/css"/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}" type="text/css"/>

        <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript" language="JavaScript"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}" type="text/javascript" language="JavaScript"></script>


        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.highlight-3.js')}"></script>

        <style type="text/css">
        .highlight {
            background-color : yellow
        }
        </style>
    </head>

    <body>
        <g:link class="btn_arbol" controller="entidad" action="arbol_asg" style="margin: 10px;">Unidades ejecutoras</g:link>
        <div id="tabs" style="width: 850px;">
            <ul>
                <li><a href="#tabs-1">Corrientes</a></li>
                <li><a href="#tabs-2">Inversión</a></li>
            </ul>

            <div id="tabs-1">
                <g:if test="${corrientes}">

                    <div>
                        <span style="font-weight: bold;">Buscar</span>
                        <input type="search" id="txt_Corrientes" class="search ui-widget-content ui-corner-all"/>
                        <span style="font-weight: bold;">en</span>
                        <select id="sel_Corrientes" class="sel ui-widget-content ui-corner-all">
                            <option value="programa actividad partida">Cualquiera</option>
                            <option value="programa">Programa</option>
                            <option value="actividad">Actividad</option>
                            <option value="partida">Partida</option>
                        </select>
                    </div>

                    <table>
                        <thead>
                            <th>Programa</th>
                            <th>Actividad</th>
                            <th>Partida</th>
                            <th>Monto</th>
                            <th>Certificaciones</th>
                        </thead>
                        <tbody>
                            <g:each in="${corrientes}" var="asg">
                                <tr class="Corrientes">
                                    <td class="programaCorrientes">${asg.programa}</td>
                                    <td class="actividadCorrientes">${asg.actividad}</td>
                                    <td class="partidaCorrientes">${asg.presupuesto}</td>
                                    <td><g:formatNumber number="${asg.planificado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td style="text-align: center"><a href="#" class=" btn_sol cor" id="${asg.id}" monto="${asg.planificado}">Solicitar</a>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    La unidad ejecutora seleccionada no tiene asignaciones corrientes para el año ${actual}.
                </g:else>
            </div>

            <div id="tabs-2">
                <g:if test="${inversion}">
                    <table>
                        <thead>
                            <th>Proyecto</th>
                            <th>Actividad</th>
                            <th>Partida</th>
                            <th>Monto</th>
                            <th>Certificaciones</th>
                        </thead>
                        <tbody>
                            <g:each in="${inversion}" var="asg">
                                <tr>
                                    <td class="proyecto">${asg.marcoLogico.proyecto}</td>
                                    <td class="actividad">${asg.marcoLogico}</td>
                                    <td class="partida">${asg.presupuesto}</td>
                                    <td><g:formatNumber number="${asg.planificado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td style="text-align: center"><a href="#" class="btn_sol inv" id="${asg.id}" monto="${asg.planificado}">Solicitar</a>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    La unidad ejecutora seleccionada no tiene asignaciones de inversión para el año ${actual}.
                </g:else>
            </div>

        </div>

        <div id="ventana">
            <fieldset style="width: 400px;height: 200px;overflow: hidden" class="ui-corner-all">
                <legend>Certificaciones</legend>

                <div id="tabla_cer" style="overflow: auto;height: 170px"></div>
            </fieldset>

            <input type="hidden" id="asg">
            <input type="hidden" id="maxVal">
            <a href="#" id="solicitar" class="btn">Solicitar</a>
            <fieldset id="datos" style="display: none;width: 400px;margin-top:5px" class="ui-corner-all">
                <legend>Solicitud</legend>

                <div style="width: 100%;margin-top: 5px;">
                    Monto: <input type="text" id="monto" style="width: 110px;margin-left: 30px;margin-right: 30px;"> Disponible:<div id="maxTxt" style="width: 100px;float: right;text-align: left"></div>
                </div>

                <div style="width: 100%;margin-top: 5px;height: 40px">
                    <div style="width: 75px;float: left">Memorando No:</div>

                    <div style="float: left;width: 300px;height: 30px;margin-top: 10px"><input type="text" id="memo" style="width: 110px;margin-right: 10px;">
                    </div>
                </div>

                <div style="width: 100%;margin-top: 5px;">
                    Concepto: <textarea rows="3" cols="30" id="concepto" style="margin-left: 10px;resize: none;"></textarea>
                </div>

                <div style="width: 100%;margin-top: 5px;background: rgba(255,0,0,0.5);height: 20px;line-height: 20px;padding-left: 10px;display: none" class="ui-corner-all" id="error">

                </div>
                <a href="#" id="enviar" class="btn" style="margin-top: 10px">Enviar</a>

            </fieldset>

            <div style="width: 400px;margin-top: 10px;background: rgba(24,111,255,0.48);height: 20px;line-height: 20px;padding-left: 10px;display: none" class="ui-corner-all" id="estado">

            </div>
        </div>

        <script>
            function reset() {
                $(".search").val("");
                $("td").removeHighlight();
                $(".Corrientes").show();
            }

            function search(tipo) {
                var elm = $("#txt_" + tipo);
                var txt = elm.val();
                var col = $("#sel_" + tipo).val();
                var cols = col.split(" ");

                var f = false;
                $("." + tipo).hide();
                $("td").removeHighlight();
                for (var i = 0; i < cols.length; i++) {
                    var c = cols[i] + tipo;
                    if (trim(txt) != "") {
                        $("." + c + ":icontains('" + txt + "')").parents("tr").show();
                        $("." + c).highlight(txt);
                        f = true;
                    }
                }
                if (!f) {
                    reset();
                }
            }

            $(function () {

                reset();

                $(".sel").change(function () {
                    var elm = $(this);
                    var tipo = elm.attr("id");
                    var parts = tipo.split("_");
                    search(parts[1]);
                });

                $(".search").keyup(function (evt) {
                    var elm = $(this);
                    var tipo = elm.attr("id");
                    var parts = tipo.split("_");
                    search(parts[1]);
                });

                $(".btn_arbol").button({icons : { primary : "ui-icon-bullet"}})
                $("#tabs").tabs();
                $(".btn_sol").button({icons : { primary : "ui-icon-disk"}, text : false}).click(function () {
                    $("#asg").val($(this).attr("id"))
                    $("#solicitar").show("slide")
                    $("#datos").hide("slide")
                    $("#error").hide("slide")
                    $("#estado").hide()
                    $("#monto").val("")
                    $("#concepto").val("")
                    $("#memo").val("")
                    var monto = $(this).attr("monto") * 1
                    $.ajax({
                        type    : "POST", url : "${createLink(action:'cargarCertificados', controller: 'certificacion')}",
                        data    : "id=" + $(this).attr("id"),
                        success : function (msg) {
                            $("#tabla_cer").html(msg)
                            var max = $("#certificado").val() * 1
                            max = monto - max
                            $("#maxVal").val(max)
                            $("#maxTxt").html(number_format(max, 2, ",", "."))

                        }
                    });
                    $("#ventana").dialog("open")
                });
                $(".btn").button()
                $("#solicitar").click(function () {
                    $("#datos").show("slide")
                    $(this).hide("slide")
                });
                $("#ventana").dialog({
                    autoOpen  : false,
                    resizable : false,
                    title     : 'Certificaciones',
                    modal     : true,
                    draggable : true,
                    width     : 500,
                    height    : 600,
                    position  : 'center',
                    open      : function (event, ui) {
                        $(".ui-dialog-titlebar-close").hide();
                    },
                    buttons   : {
                        "Cerrar" : function () {
                            $("#ventana").dialog("close")
                        }
                    }
                });

                $("#enviar").click(function () {
                    var monto = $("#monto").val()
                    monto = str_replace(".", "", monto)
                    monto = str_replace(",", ".", monto)
                    monto = monto * 1
                    var band = false
                    var max = $("#maxVal").val() * 1
                    if (isNaN(monto)) {
                        monto = 0
                    } else {
                        monto = monto * 1
                    }
                    if (monto > max) {
                        $("#error").html("El monto no puede ser mayor a " + max)
                        band = true
                    }
                    var concepto = $("#concepto").val()
                    if (concepto.length > 254) {
                        $("#error").html("El campo concepto debe tener un máximo de 255 caracteres. Actual: " + concepto.length)
                        band = true
                    }
                    var memo = $("#memo").val()
                    if (memo.length > 254) {
                        $("#error").html("El campo memorando debe tener un máximo de 40 caracteres. Actual: " + memo.length)
                        band = true
                    }

                    if (memo == "" || concepto == "") {
                        $("#error").html("Los campos memorando y concepto son obligatorios")
                        band = true
                    }

                    if (monto < 1) {
                        $("#error").html("El monto deber ser un número mayor a cero")
                        band = true
                    }
                    if (!band) {
                        $.ajax({
                            type    : "POST", url : "${createLink(action:'guardarSolicitud', controller: 'certificacion')}",
                            data    : "asgn=" + $("#asg").val() + "&monto=" + monto + "&concepto=" + concepto + "&memorando=" + memo,
                            success : function (msg) {
                                $("#estado").html(msg)
                                $("#estado").show("slide")
                                $("#datos").hide("explode")
                                $.ajax({
                                    type    : "POST", url : "${createLink(action:'cargarCertificados', controller: 'certificacion')}",
                                    data    : "id=" + $("#asg").val(),
                                    success : function (msg) {
                                        $("#tabla_cer").html(msg)
                                        var max = $("#certificado").val() * 1
                                        max = monto - max
                                        $("#maxVal").val(max)
                                        $("#maxTxt").html(number_format(max, 2, ",", "."))

                                    }
                                });
                            }
                        });
                    } else {
                        $("#error").show("pulsate")
                    }
                });
            });
        </script>

    </body>
</html>