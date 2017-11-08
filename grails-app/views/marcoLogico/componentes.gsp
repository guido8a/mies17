<%@ page import="mies.MarcoLogico; mies.Supuesto; mies.Indicador" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Marco logico: Componentes</title>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
              type="text/css"/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
              type="text/css"/>

        <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
                language="JavaScript"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
                type="text/javascript" language="JavaScript"></script>

        <style type="text/css">
        .cmp {
            width      : 215px;
            margin     : 5px;
            min-height : 215px;
            /*border: 1px solid black;*/
            float      : left;
            padding    : 5px;
            position   : relative;

        }

        .cmpDoble {
            width      : 450px;
            margin     : 5px;
            min-height : 215px;
            /*border: 1px solid black;*/
            float      : left;
            padding    : 5px;
            position   : relative;
        }

        .fila {
            width      : 98%;
            margin     : 1%;
            min-height : 50px;
            float      : left;
            /*border: 1px solid black;*/
        }

        .filaMedio {
            width      : 47.5%;
            margin     : 1%;
            min-height : 50px;
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
            cursor     : pointer;
        }

        textarea {
            width      : 93%;
            padding    : 5px;
            min-height : 115px;
            resize     : vertical;
        }

        .agregado {
            width      : 90%;
            margin     : 1.5%;
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

        .linea {
            width  : 95%;
            margin : 1.5%;
            height : 1px;
            border : 1px solid black;
        }
        </style>
    </head>

    <body>

        <div class="body" style="overflow-y: hidden">

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
                            <g:link class="bc" controller="marcoLogico" action="showMarco"
                                    id="${proyecto.id}">
                                Marco L&oacute;gico
                            </g:link>
                        </li>
                        <li>
                            Componentes
                        </li>
                    </ul>
                </div>
            </div>

            <div class="dialog" title="MARCO LOGICO DEL PROYECTO - COMPONENTES DEL PROYECTO" style="overflow-y: hidden">
                <input type="hidden" id="edicion" value="1">
                <input type="hidden" id="proyecto" value="${proyecto.id}">

                <div id="accordion" style="width:1030px">
                    <g:set var="k" value="${0}"/>
                    <g:each in="${componentes}" var="comp">
                        <g:if test="${comp.estado == 0}">
                            <h3><a href="#">Componente ${k + 1} : ${(comp?.objeto.length() > 40) ? comp?.objeto.substring(0, 40) + "..." : comp.objeto}</a>
                            </h3>

                            <div>
                                <div style="float: right;display: block;width: 90%;height: 35px">
                                    <a href="${createLink(action: 'actividadesComponente')}/${comp.id}" style="float: right" class="link">Agregar/Editar Actividades</a>
                                    %{--<a href="${createLink(action: 'ingresoMetas')}/${comp.id}" class="link">Ver metas</a>--}%
                                </div>

                                <div class="matriz ui-corner-all campo cmp datos " ml="1" div="rn_${k}"
                                     identificador="${comp?.id}"
                                     style="margin-left: -10px;" tipo="1">
                                    <div class="titulo">Componente</div>

                                    <div class="texto agregado ui-corner-all fin" ml="1" style="min-height: 115px;"
                                         id="rn_${k}"
                                         identificador="${comp?.id}" tipo="1">
                                        ${comp?.objeto}
                                    </div>

                                </div>
                                %{--inicio de indicadores--}%
                                <div class="matriz ui-corner-all campo cmpDoble " id="div_indi_medios_fin">
                                    <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                                        <div class="titulo">Indicadores</div>
                                    </div>

                                    <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                                        <div class="titulo">Medios de Verificacion</div>
                                    </div>
                                    <g:set var="band" value="0"></g:set>
                                    <g:each in="${Indicador.findAllByMarcoLogico(comp)}" var="indicador" status="i">
                                        <g:set var="band" value="1"></g:set>
                                        <div class="matriz ui-corner-all  fila " id="ind"
                                             style="${(i == 0) ? 'margin-top:-10px;' : ''}">
                                            <div class="filaMedio izq ">
                                                <div class="texto agregado ui-corner-all fin varios  " pref="ic_"
                                                     id="ic_${indicador.id}" ml="${comp.id}" tipo="2"
                                                     div="ic_${indicador.id}"
                                                     identificador="${indicador.id}" indicador="${comp.id}">
                                                    ${indicador?.descripcion}
                                                </div>
                                            </div>

                                            <div class="filaMedio der">
                                                <g:each in="${mies.MedioVerificacion.findAllByIndicador(indicador)}"
                                                        var="med">
                                                    <div class="texto agregado ui-corner-all md fin varios" pref="mc_"
                                                         id="mc_${med.id}" ml="${comp.id}" tipo="3" div="mc_${med.id}"
                                                         indicador="${indicador.id}"
                                                         identificador="${med.id}">${med.descripcion}</div>
                                                </g:each>
                                                <div class=" texto agregado ui-corner-all md fin varios edicion"
                                                     pref="mc_"
                                                     id="mc_00${i + 1}${k}" ml="${comp.id}" div="mc_00${i + 1}${k}"
                                                     tipo="3"
                                                     indicador="${indicador.id}" identificador="0">Agregar</div>
                                            </div>
                                        </div>
                                    </g:each>

                                    <div class="matriz ui-corner-all  fila " id="ind"
                                         style="${(band.toInteger() == 0) ? 'margin-top:-10px;' : ''}">
                                        <div class="filaMedio izq ">
                                            <div class="texto agregado ui-corner-all fin varios edicion  " pref="ic_"
                                                 id="ic_00${k}"
                                                 ml="${comp.id}" div="ic_00${k}" tipo="2" identificador="0"
                                                 indicador="${comp?.id}">
                                                Agregar
                                            </div>
                                        </div>

                                        %{--<g:if test="${!mies.MedioVerificacion.findAllByIndicadorInList(Indicador.findAllByMarcoLogico(mies.MarcoLogico.get(comp?.id)))}">--}%
                                            <div class="filaMedio der">
                                                <div class=" texto agregado ui-corner-all md fin varios edicion" pref="mc_"
                                                     id="mc_00${k}" ml="${comp.id}" div="mc_00${k}" indicador="0" tipo="3"
                                                     identificador="0">Agregar</div>
                                            </div>
                                        %{--</g:if>--}%
                                    </div>

                                </div>%{--Fin de indicadores--}%
                                <div class="matriz ui-corner-all campo cmp">
                                    <div class="titulo">Supuestos</div>

                                    <div class="texto" style=" min-height: 115px;" id="supuestos">
                                        <g:each in="${Supuesto.findAllByMarcoLogico(comp)}" var="su">
                                            <div class="agregado ui-corner-all fin varios" id="sc_${su.id}"
                                                 ml="${comp.id}"
                                                 div="sc_${su.id}" identificador="${su.id}" tipo="4"
                                                 indicador="${comp?.id}">${su.descripcion}</div>
                                        </g:each>
                                        <div class="agregado ui-corner-all md fin varios editar edicion" id="sc_00${k}"
                                             ml="${comp.id}" div="sc_00${k}" identificador="0" tipo="4"
                                             indicador="${comp?.id}">Agregar</div>
                                    </div>
                                </div>
                            </div>
                            <g:set var="k" value="${k+1}"/>
                        </g:if>
                    </g:each>
                %{--fin del each--}%
                    <h3><a href="#">Agregar</a></h3>

                    <div>
                        <div class="matriz ui-corner-all campo cmp">
                            <div class="titulo">Componente</div>

                            <div class="texto agregado ui-corner-all fin datos" style="min-height: 115px;" id="c_0"
                                 identificador="0" tipo="1" ml="Componente">

                            </div>

                        </div>
                        %{--inicio de indicadores--}%
                        <div class="matriz ui-corner-all campo cmpDoble " id="div_indi_medios">
                            <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                                <div class="titulo">Indicadores</div>
                            </div>

                            <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                                <div class="titulo">Medios de Verificacion</div>
                            </div>
                            <g:set var="band" value="0"></g:set>
                            <div class="matriz ui-corner-all  fila " id="ind"
                                 style="${(band.toInteger() == 0) ? 'margin-top:-10px;' : ''}">
                                <div class="filaMedio izq ">
                                    <div class="texto agregado ui-corner-all fin varios edicion  ">
                                        Agregar
                                    </div>
                                </div>

                                <div class="filaMedio der">
                                    <div class=" texto agregado ui-corner-all md fin varios edicion">Agregar</div>
                                </div>
                            </div>

                        </div>%{--Fin de indicadores--}%
                        <div class="matriz ui-corner-all campo cmp">
                            <div class="titulo">Supuestos</div>

                            <div class="texto" style=" min-height: 115px;">

                                <div class="agregado ui-corner-all md fin varios editar edicion">Agregar</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="dlg_datos">
                <input type="hidden" id="ml">
                <input type="hidden" id="div">
                <input type="hidden" id="iden">

                <div class="texto" style="min-height: 270px">
                    <textarea name="mdo" id="txt_datos" style="min-height: 270px"></textarea>
                </div>
            </div>

            <div id="dlg_combo">
                <input type="hidden" id="c_ml">
                <input type="hidden" id="c_div">
                <input type="hidden" id="c_iden">
                <input type="hidden" id="c_indi">
                <input type="hidden" id="c_tipo">
                %{--<div id="filaCombo" style="display: none">--}%
                %{--<div id="combo" style="float:left">--}%
                %{--<g:select from="${mies.TipoSupuesto.list()}" name="tipo" optionKey="id" optionValue="descripcion" style="margin-left: 15px" id="tipoSupuesto" noSelection="${['-1':'Seleccione']}" />--}%
                %{--</div>--}%
                %{--<a href="#"  id="btnAgregar">Agregar</a>--}%
                %{--</div>--}%
                <div class="texto" style="min-height: 270px">
                    <textarea name="txt_varios" id="txt_varios" style="min-height: 270px"></textarea>
                </div>

            </div>

        </div>
        <script type="text/javascript">


            $("#breadCrumb").jBreadCrumb({
                beginingElementsToLeaveOpen: 10
            });

            function reajustar() {
                var tam = 215
                $.each($(".campo"), function() {
                    if ($(this).height() * 1 > tam)
                        tam = $(this).height() * 1
                });
                $(".campo").css("min-height", tam)
                $("#div_fin").css("min-height", tam - 60)
                tam = 215
                $.each($(".campoProp"), function() {
                    if ($(this).height() * 1 > tam)
                        tam = $(this).height() * 1
                });
                $(".campoProp").css("min-height", tam)
                $("#div_prop").css("min-height", tam - 60)
                $.each($(".fila"), function() {
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
            reajustar()
            $(".link").button()
            $(".back").button({icons:{primary:'ui-icon-arrowreturnthick-1-w'}});

            $("#btnAgregar").button().click(function() {
                if ($("").val() != "-1") {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'agregarSupuesto')}",
                        data: {
                            marco:$("#c_indi").val(),
                            id:$("#tipoSupuesto").val()
                        },
                        success: function(msg) {
                            if (msg != "no") {
                                var partes = msg.split("&&")
                                if ($("#c_iden").val() == "0") {
                                    var div = $("<div>")
                                    if ($("#c_ml").val() == "Proposito") {
                                        div.attr("ml", "Proposito").attr("id", "sp_0").attr("div", "sp_0").attr("identificador", "0").attr("tipo", "3").attr("indicador", $("#c_indi").val())
                                        div.addClass("agregado ui-corner-all proposito varios editar nuevo edicion")
                                    } else {
                                        div.attr("ml", "Fin").attr("id", "sf_0").attr("div", "sf_0").attr("identificador", "0").attr("tipo", "3").attr("indicador", $("#c_indi").val())
                                        div.addClass("agregado ui-corner-all fin varios editar nuevo edicion")
                                    }
                                    div.html("Agregar")
                                    $("#" + $("#c_div").val()).parent().append(div)
                                    div.bind("click", function() {
                                        $("#txt_varios").val("")
                                        $("#c_ml").val($(this).attr("ml"))
                                        $("#c_div").val($(this).attr("div"))
                                        $("#c_iden").val($(this).attr("identificador"))
                                        $("#c_indi").val($(this).attr("indicador"))
                                        $("#c_tipo").val($(this).attr("tipo"))
                                        if ($(this).attr("tipo") != "3")
                                            $("#filaCombo").hide()
                                        else
                                        if ($("#c_iden").val() == "0")
                                            $("#filaCombo").show()
                                        if ($("#" + $(this).attr("div")).html())
                                            $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
                                        if ($("#txt_varios").val() == "Agregar")
                                            $("#txt_varios").val("")
                                        $("#dlg_combo").dialog({title:$(this).attr("ml")})
                                        $("#dlg_combo").dialog("open")
                                    });
                                }


                                $("#" + $("#c_div").val()).html(partes[1])
                                $("#" + $("#c_div").val()).attr("identificador", partes[0])
                                $("#" + $("#c_div").val()).removeClass("nuevo")
                                $("#" + $("#c_div").val()).removeClass("edicion")
                                $("#" + $("#c_div").val()).attr("div", $("#" + $("#c_div").val()).attr("pref") + partes[0])
                                $("#" + $("#c_div").val()).attr("id", $("#" + $("#c_div").val()).attr("pref") + partes[0])

                                reajustar()
                                $("#dlg_combo").dialog("close")
                            } else {
                                alert("Error")
                            }
                        }
                    });
                }
            });

            $(".datos").click(function() {
                if ($("#edicion").val() == "1") {
                    $("#txt_datos").val("")
                    $("#ml").val($(this).attr("tipo"))
                    $("#div").val($(this).attr("div"))
                    $("#iden").val($(this).attr("identificador"))
                    /* TODO hay un trim aqui que no valdria en ie... cambiar por la funcion */
                    if ($("#" + $(this).attr("div")).html())
                        $("#txt_datos").val($("#" + $(this).attr("div")).html().trim())
                    $("#dlg_datos").dialog({title:"Ingreso de datos"})
                    $("#dlg_datos").dialog("open")
                }
            });

            $(".varios").click(function() {
                console.log(" ---- " +   $(this).attr("indicador"))
                if ($("#edicion").val() == "1") {
                    $("#txt_varios").val("")
                    $("#c_ml").val($(this).attr("ml"))
                    $("#c_div").val($(this).attr("div"))
                    $("#c_iden").val($(this).attr("identificador"))
                    $("#c_indi").val($(this).attr("indicador"))
                    $("#c_tipo").val($(this).attr("tipo"))
                    if ($(this).attr("tipo") != "4")
                        $("#filaCombo").hide()
                    else
                    if ($("#c_iden").val() == "0")
                        $("#filaCombo").show()
                    /* TODO hay un trim aqui que no valdria en ie... cambiar por la funcion */
                    if ($("#" + $(this).attr("div")).html())
                        $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
                    if ($("#txt_varios").val() == "Agregar")
                        $("#txt_varios").val("")

                    $("#dlg_combo").dialog("open")
                }
            });

            $("#dlg_datos").dialog({
                width:300,
                height:440,
                position:"center",
                modal:true,
                autoOpen:false,
                buttons:{
                    "Eliminar":function() {
                        if (confirm("Esta seguro que desea eliminar?. Esta acción es irreversible. El componente no se eliminara si tiene actividades asociadas")) {
                            $.ajax({
                                type: "POST",
                                url: "${createLink(action:'eliminarMarco')}",
                                data: {
                                    tipo:$("#ml").val(),
                                    datos:$("#txt_datos").val(),
                                    proyecto:$("#proyecto").val(),
                                    id:$("#iden").val()
                                },
                                success: function(msg) {
                                    if (msg == "ok") {
                                        window.location.reload(true)
                                    } else {
                                        alert("El componente no se pudo eliminar, tiene actividades asociadas")
                                    }
                                }
                            });
                        }
                    },
                    "Aceptar":function() {
                        if ($("#txt_datos").val() != "" && $("#txt_datos").val() != " ") {
                            $.ajax({
                                type: "POST",
                                url: "${createLink(action:'guadarDatosComponentes')}",
                                data: {
                                    tipo:$("#ml").val(),
                                    datos:$("#txt_datos").val(),
                                    proyecto:$("#proyecto").val(),
                                    id: $("#iden").val()
                                },
                                success: function(msg) {
                                    if (msg != "no") {
                                        window.location.reload(true)
                                    } else {
                                        alert("Error")
                                    }
                                }
                            });

                        }
                    }
                }
            });

            $("#dlg_combo").dialog({
                width:310,
                height:460,
                position:"center",
                modal:true,
                autoOpen:false,
                title:"Ingreso de datos",
                buttons:{
                    "Eliminar":function() {
                        if (confirm("Esta seguro que desea eliminar?. Esta acción es irreversible") && $("#c_iden").val() != "0") {
                            $.ajax({
                                type: "POST",
                                url: "${createLink(action:'eliminarIndiMedSupComponentes')}",
                                data: {
                                    ml:$("#c_ml").val(),
                                    datos:$("#txt_varios").val(),
                                    proyecto:$("#proyecto").val(),
                                    id:$("#c_iden").val(),
                                    indicador:$("#c_indi").val(),
                                    tipo:$("#c_tipo").val()
                                },
                                success: function(msg) {
                                    if (msg == "ok") {
                                        if ($("#c_tipo").val() == "2") {
                                            $.each($("#" + $("#c_div").val()).parent().parent().find(".der").children(), function() {
                                                if (!$(this).hasClass("edicion"))
                                                    $(this).remove()
                                                else
                                                    $(this).attr("indicador", "0")
                                            });
                                            $("#" + $("#c_div").val()).attr("iden", "0")
                                            $("#" + $("#c_div").val()).html("Agregar")
                                        } else {
                                            $("#" + $("#c_div").val()).remove()
                                        }
                                        $("#dlg_combo").dialog("close")

                                    } else {
                                        alert("algo salio mal")
                                    }
                                }
                            });
                        } else {
                            $("#dlg_combo").dialog("close")
                        }
                    },
                    "Aceptar":function() {
                        if ($("#txt_varios").val() != "" && $("#txt_varios").val() != " ") {
                            $.ajax({
                                type: "POST",
                                url: "${createLink(action:'guadarDatosComponentes')}",
                                data: {
                                    ml:$("#c_ml").val(),
                                    datos:$("#txt_varios").val(),
                                    proyecto:$("#proyecto").val(),
                                    id:$("#c_iden").val(),
                                    indicador:$("#c_indi").val(),
                                    tipo:$("#c_tipo").val()
                                },
                                success: function(msg) {
                                    if (msg != "no") {
                                        if ($("#c_iden").val() == "0" && $("#c_tipo").val() * 1 == 2) {
                                            var d1 = $("<div>")
                                            d1.addClass("matriz ui-corner-all  fila ")
                                            var d2 = $("<div>")
                                            d2.addClass("filaMedio")
                                            var d3 = $("<div>")
                                            d3.attr("indicador", "0")
                                            d3.html("Agregar")
                                            var d4 = $("<div>")
                                            d4.addClass("filaMedio der")
                                            var d5 = $("<div>")
                                            d5.attr("indicador", "0")
                                            d5.html("Agregar")
                                            d2.append(d3)
                                            d4.append(d5)
                                            d5.bind("click", function() {
                                                if ($("#edicion").val() == "1") {
                                                    $("#txt_varios").val("")
                                                    $("#c_ml").val($(this).attr("ml"))
                                                    $("#c_div").val($(this).attr("div"))
                                                    $("#c_iden").val($(this).attr("identificador"))
                                                    $("#c_indi").val($(this).attr("indicador"))
                                                    $("#c_tipo").val($(this).attr("tipo"))
                                                    if ($(this).attr("ml") != "Supuestos")
                                                        $("#filaCombo").hide()
                                                    else
                                                        $("#filaCombo").show()
                                                    /* TODO hay un trim aqui que no valdria en ie... cambiar por la funcion */
                                                    if ($("#" + $(this).attr("div")).html())
                                                        $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
                                                    if ($("#txt_varios").val() == "Agregar")
                                                        $("#txt_varios").val("")
                                                    $("#dlg_combo").dialog("open")
                                                }
                                            });
                                            d3.bind("click", function() {
                                                if ($("#edicion").val() == "1") {
                                                    $("#txt_varios").val("")
                                                    $("#c_ml").val($(this).attr("ml"))
                                                    $("#c_div").val($(this).attr("div"))
                                                    $("#c_iden").val($(this).attr("identificador"))
                                                    $("#c_indi").val($(this).attr("indicador"))
                                                    $("#c_tipo").val($(this).attr("tipo"))
                                                    if ($(this).attr("ml") != "Supuestos")
                                                        $("#filaCombo").hide()
                                                    else
                                                        $("#filaCombo").show()
                                                    /* TODO hay un trim aqui que no valdria en ie... cambiar por la funcion */
                                                    if ($("#" + $(this).attr("div")).html())
                                                        $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
                                                    if ($("#txt_varios").val() == "Agregar")
                                                        $("#txt_varios").val("")
                                                    $("#dlg_combo").dialog("open")
                                                }
                                            });
                                            d1.append(d2)
                                            d1.append(d4)
                                            var num = Math.floor(Math.random() * 101)
                                            d3.addClass("texto agregado ui-corner-all fin varios edicion").attr("pref", "ic_").attr("id", "ic_000" + num).attr("ml", $("#c_ml").val()).attr("div", "ic_000" + num).attr("identificador", "0").attr("tipo", "2")
                                            num = Math.floor(Math.random() * 101)
                                            d5.addClass(" texto agregado ui-corner-all md fin varios edicion").attr("pref", "mc_").attr("id", "mc_000" + num).attr("ml", $("#c_ml").val()).attr("div", "mc_000" + num).attr("identificador", "0").attr("tipo", "3")
//                                    $("#div_indi_medios_fin").append(d1)
                                            $("#" + $("#c_div").val()).parent().parent().parent().append(d1)
                                            $("#" + $("#c_div").val()).parent().parent().find(".der").children().attr("indicador", msg)
                                        }
                                        if ($("#c_iden").val() == "0" && $("#c_tipo").val() * 1 == 3) {
                                            var d1 = $("<div>")
                                            d1.html("Agregar")
                                            d1.addClass("texto agregado ui-corner-all md fin varios nuevo edicion")
                                            d1.attr("pref", "mc_").attr("div", $("#c_div").val()).attr("ml", $("#c_ml").val()).attr("tipo", "3").attr("indicador", $("#c_indi").val()).attr("identificador", "0")


                                            $("#" + $("#c_div").val()).parent().append(d1)
                                            d1.bind("click", function() {
                                                if ($("#edicion").val() == "1") {
                                                    $("#txt_varios").val("")
                                                    $("#c_ml").val($(this).attr("ml"))
                                                    $("#c_div").val($(this).attr("div"))
                                                    $("#c_iden").val($(this).attr("identificador"))
                                                    $("#c_indi").val($(this).attr("indicador"))
                                                    $("#c_tipo").val($(this).attr("tipo"))
                                                    if ($(this).attr("ml") != "Supuestos")
                                                        $("#filaCombo").hide()
                                                    else
                                                        $("#filaCombo").show()
                                                    /* TODO hay un trim aqui que no valdria en ie... cambiar por la funcion */
                                                    if ($("#" + $(this).attr("div")).html())
                                                        $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
                                                    if ($("#txt_varios").val() == "Agregar")
                                                        $("#txt_varios").val("")
                                                    $("#dlg_combo").dialog("open")
                                                }
                                            });
                                        }

                                        if ($("#c_iden").val() == "0" && $("#c_tipo").val() * 1 == 4) {
                                            var div = $("<div>")

                                            div.attr("ml", $("#c_ml").val()).attr("id", "sc_0").attr("div", "sc_0").attr("identificador", "0").attr("tipo", "4").attr("indicador", $("#c_indi").val())
                                            div.addClass("texto agregado ui-corner-all fin varios editar nuevo edicion")

                                            div.html("Agregar")
                                            $("#" + $("#c_div").val()).parent().append(div)
                                            div.bind("click", function() {
                                                if ($("#edicion").val() == "1") {
                                                    $("#txt_varios").val("")
                                                    $("#c_ml").val($(this).attr("ml"))
                                                    $("#c_div").val($(this).attr("div"))
                                                    $("#c_iden").val($(this).attr("identificador"))
                                                    $("#c_indi").val($(this).attr("indicador"))
                                                    $("#c_tipo").val($(this).attr("tipo"))
                                                    if ($(this).attr("tipo") != "3")
                                                        $("#filaCombo").hide()
                                                    else
                                                    if ($("#c_iden").val() == "0")
                                                        $("#filaCombo").show()
                                                    /* TODO hay un trim aqui que no valdria en ie... cambiar por la funcion */
                                                    if ($("#" + $(this).attr("div")).html())
                                                        $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
                                                    if ($("#txt_varios").val() == "Agregar")
                                                        $("#txt_varios").val("")
                                                    $("#dlg_combo").dialog("open")
                                                }
                                            });
                                        }

                                        if ($("#c_tipo").val() != "4") {
                                            var id = $("#c_div").val()
                                            var div = $("#" + $("#c_div").val())
                                            $("#" + $("#c_div").val()).removeClass("nuevo")
                                            $("#" + $("#c_div").val()).html($("#txt_varios").val())
                                            $("#" + $("#c_div").val()).attr("div", $("#" + $("#c_div").val()).attr("pref") + msg)
                                            $("#" + $("#c_div").val()).attr("identificador", msg)
                                            $("#" + $("#c_div").val()).removeClass("edicion")
                                            $("#" + $("#c_div").val()).attr("id", $("#" + $("#c_div").val()).attr("pref") + msg)
                                            if ($("#c_iden").val() == "0" && $("#c_tipo").val() * 1 == 3) {
                                                div.parent().find(".nuevo").attr("id", id)
                                            }
                                        } else {
                                            var partes = msg.split("&&")
                                            $("#" + $("#c_div").val()).html(partes[1])
                                            $("#" + $("#c_div").val()).attr("identificador", partes[0])
                                            $("#" + $("#c_div").val()).removeClass("edicion")
                                            $("#" + $("#c_div").val()).removeClass("nuevo")
                                            $("#" + $("#c_div").val()).attr("div", $("#" + $("#c_div").val()).attr("pref") + partes[0])
                                            $("#" + $("#c_div").val()).attr("id", $("#" + $("#c_div").val()).attr("pref") + partes[0])
                                        }
                                        reajustar()
                                        $("#dlg_combo").dialog("close")
                                    } else {
                                        $("#dlg_combo").dialog("close")
                                        alert("Error al guardar los datos")
                                    }
                                }
                            });
                        }
                    }
                }
            });

            $("#accordion").accordion({collapsible: true})
        </script>
    </body>
</html>