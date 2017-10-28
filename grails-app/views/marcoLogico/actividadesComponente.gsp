<%@ page import="mies.Supuesto; mies.Indicador" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>ACTIVIDADES DEL COMPONENTE: ${componente.objeto}</title>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
          type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
          type="text/css"/>

    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
            language="JavaScript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
            type="text/javascript" language="JavaScript"></script>
    <script src="${resource(dir: 'js/jquery/js', file: 'jquery.caret.1.02.min.js')}" type="text/javascript" language="JavaScript"></script>

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

    .linea {
        width  : 95%;
        margin : 1.5%;
        height : 1px;
        border : 1px solid black;
    }
    </style>
</head>

<body>

<div class="body">

<div class="breadCrumbHolder module">
    <div id="breadCrumb" class="breadCrumb module">
        <ul>
            <li>
                <g:link class="bc" controller="proyecto" action="show"
                        id="${componente.proyecto.id}">
                    Proyecto
                </g:link>
            </li>
            <li>
                <g:link class="bc" controller="marcoLogico" action="showMarco"
                        id="${componente.proyecto.id}">
                    Marco L&oacute;gico
                </g:link>
            </li>
            <li>
                <g:link class="bc" controller="marcoLogico" action="componentes"
                        id="${componente.proyecto.id}">
                    Componentes
                </g:link>
            </li>
            <li>
                Actividades
            </li>
        </ul>
    </div>
</div>

%{--<div id="" class="toolbar ui-widget-header ui-corner-all" style="margin-bottom: 5px;">--}%
%{--<g:link class="btn back" controller="proyecto" action="show" id="${componente.proyecto.id}">--}%
%{--Proyecto--}%
%{--</g:link>--}%
%{--<g:link class="btn back" controller="marcoLogico" action="showMarco" id="${componente.proyecto.id}">--}%
%{--Marco L&oacute;gico--}%
%{--</g:link>--}%
%{--<g:link class="btn back" controller="marcoLogico" action="componentes" id="${componente.proyecto.id}">--}%
%{--Componentes--}%
%{--</g:link>--}%
%{--</div> <!-- toolbar -->--}%

<div class="dialog" title="ACTIVIDADES DEL COMPONENTE: ${componente.objeto}">
    <input type="hidden" id="edicion" value="1">
    <input type="hidden" id="componente" value="${componente.id}">
    <div style="width: 90%;height: 30px;border:1px solid #A6C9E2;margin-bottom: 5px;line-height: 25px;padding-top: 5px;font-size: 11px;" class="ui-corner-all">
        <div style="width: 110px;height: 25px;;float: left;margin-left: 5px;text-align: right;font-weight: bolder;margin-right: 5px;">
            Total componente:
        </div>
        <div id="total_componente" style="width: 100px;height: 25px;;float: left">
            <g:formatNumber number="${totComp}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"  ></g:formatNumber>
        </div>
        <div style="width: 150px;height: 25px;;float: left;margin-left: 5px;text-align: right;font-weight: bold;margin-right: 5px;">
            Total otros componentes:
        </div>
        <div id="total_otros" style="width: 100px;height: 25px;;float: left">
            <g:formatNumber number="${totOtros}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"  ></g:formatNumber>
        </div>
        <div style="width: 110px;height: 25px;;float: left;text-align: right;font-weight: bold;margin-right: 5px;">
            Total financiamento:
        </div>
        <div id="total_finan" style="width: 100px;height: 25px;float: left">
            <g:formatNumber number="${totFin}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"  ></g:formatNumber>
        </div>
        <div style="width: 70px;height: 25px;;float: left;text-align: right;font-weight: bold;margin-right: 5px;">
            Sin Asignar:
        </div>
        <div id="total_sin" style="width: 100px;height: 25px;float: left">
            <g:formatNumber number="${totFin-(totComp+totOtros)}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"  ></g:formatNumber>
        </div>
        <input type="hidden" id="max" value="${totFin-(totComp+totOtros)}">
    </div>

    <div id="accordion" style="width:1030px">
        <g:each in="${actividades}" var="act" status="k">

            <h3><a href="#">Actividad ${k + 1} : ${(act?.objeto.length() > 40) ? act?.objeto.substring(0, 40) + "..." : act.objeto}</a>
            </h3>


            <div>


                <div class="matriz ui-corner-all campo cmp datos " ml="1" div="rn_${k}"
                     identificador="${act?.id}" style="margin-left: -10px;" tipo="1">
                    <div class="titulo">Actividad</div>

                    <div class="texto agregado ui-corner-all fin" ml="1" style="min-height: 115px;"
                         id="rn_${k}" identificador="${act?.id}" tipo="1">
                        ${act?.objeto}
                    </div>

                </div>
                %{--monto--}%
                <div class="matriz ui-corner-all campo cmp  ">
                    <div class="titulo">Monto($)</div>

                    <div class="texto agregado ui-corner-all fin varios monto" ml="5"
                         style="height: 40px;line-height: 40px;text-align: center" pref="mn_"
                         id="mn_${act?.id}" div="mn_${act?.id}" identificador="${act?.id}" tipo="5">
                        %{--${act?.monto}--}%
                        <g:formatNumber number="${act.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"  ></g:formatNumber>
                    </div>

                </div>
                %{--fin monto--}%
                %{--indicadores--}%
                <div class="matriz ui-corner-all campo cmp  ">
                    <div class="titulo">Indicadores</div>
                    <g:each in="${Indicador.findAllByMarcoLogico(act)}" var="indicador" status="i">
                        <div class="texto agregado ui-corner-all fin varios  " pref="ic_"
                             id="ic_${indicador.id}" ml="${act.id}" tipo="2" div="ic_${indicador.id}"
                             identificador="${indicador.id}" indicador="${act.id}">
                            ${indicador?.descripcion}
                        </div>
                    </g:each>
                    <div class="texto agregado ui-corner-all fin varios edicion  " pref="ic_" id="ic_00${k}"
                         ml="${act.id}" div="ic_00${k}" tipo="2" identificador="0" indicador="${act?.id}">
                        Agregar
                    </div>
                </div>
                %{--fin indicadores--}%

                <div class="matriz ui-corner-all campo cmp">
                    <div class="titulo">Supuestos</div>

                    <div class="texto" style=" min-height: 115px;" id="supuestos">
                        <g:each in="${Supuesto.findAllByMarcoLogico(act)}" var="su">
                            <div class="agregado ui-corner-all fin varios" id="sc_${su.id}" ml="${act.id}"
                                 div="sc_${su.id}" identificador="${su.id}" tipo="4"
                                 indicador="${act?.id}">${su.descripcion}</div>
                        </g:each>
                        <div class="agregado ui-corner-all md fin varios editar edicion" id="sc_00${k}"
                             ml="${act.id}" div="sc_00${k}" identificador="0" tipo="4"
                             indicador="${act?.id}">Agregar</div>
                    </div>
                </div>
                <div style="float: right;display: block;width: 90%;height: 35px">

                    <a href="${createLink(action: 'ingresoMetas')}/${act.id}" class="link" style="float: right">Agregar/Editar Metas</a>

                </div>
            </div>
        </g:each>
    %{--fin del each--}%
        <h3><a href="#">Agregar</a></h3>

        <div>
            <div class="matriz ui-corner-all campo cmp">
                <div class="titulo">Actividad</div>

                <div class="texto agregado ui-corner-all fin datos" style="min-height: 115px;" id="c_0"
                     identificador="0" tipo="1" ml="Componente">

                </div>

            </div>
            %{--monto--}%
            <div class="matriz ui-corner-all campo cmp  " ml="5" div="mn_${k}" identificador="${act?.id}"
                 style="margin-left: -10px;" tipo="5">
                <div class="titulo">Monto($)</div>

                <div class="texto agregado ui-corner-all fin" ml="5"
                     style="height: 40px;line-height: 40px;text-align: center">

                </div>

            </div>
            %{--fin monto--}%
            %{--indicadores--}%
            <div class="matriz ui-corner-all campo cmp datos " ml="5" div="mn_${k}"
                 identificador="${act?.id}" style="margin-left: -10px;" tipo="2">
                <div class="titulo">Indicadores</div>

                <div class="texto agregado ui-corner-all fin varios edicion  ">
                    Agregar
                </div>
            </div>
            %{--fin indicadores--}%
            <div class="matriz ui-corner-all campo cmp">
                <div class="titulo">Supuestos</div>

                <div class="texto" style=" min-height: 115px;">

                    <div class="agregado ui-corner-all md fin varios editar edicion">Agregar</div>
                </div>
            </div>
        </div>
    </div>
</div>

%{--<div style="float: left;width: 90%;height: 35px;display: block;margin-top: 10px;">--}%
%{--Componente: <g:select--}%
%{--from="${componentes}"--}%
%{--optionKey="id" id="cmb_comp" value="${componente.id}"/>--}%
%{--</div>--}%

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
    <div class="texto" style="min-height: 10px">
        <textarea name="txt_varios" id="txt_varios" style="min-height: 270px"></textarea>
        <input type="text" id="txt_num" style="text-align: right;margin-left: 40px">
    </div>

</div>

</div>
<script type="text/javascript">

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

    function formatear(numero){
        var num = numero
        var partes = num.split(",")
        if(!partes[1])
            partes[1]="00"
        if(partes[1]=="0")
            partes[1]="00"
        if(partes[1].length==1)
            partes[1]+="0"
        if(partes[1].length>2)
            partes[1]=partes[1].substr(0,2)
        if(!partes[0]){
            partes[0]="0"
            return("0,"+partes[1])
        }else{
            var a=new Array()
            var cont=0
            partes[0]=partes[0].replace(/\./g,"")
            var tam = partes[0].length
            for(i=tam;i>-1;i--){
                var digito=partes[0].charAt(i)
                if(digito!="0" && digito!=""){
                    a.push(partes[0].charAt(i))
                }else{
                    if(i!=0)
                        a.push(partes[0].charAt(i))
                }
                if(cont==3 && i!=0){
                    cont = 1
                    a.push(".")
                }else{
                    cont++
                }
            }
            return(a.reverse().toString().replace(/,/g,"")+","+partes[1])
        }
    }
    reajustar()
    var bandera=false
    var arr=["37",37,39,47,48,49,50,51,52,53,54,55,56,57,58,96,97,98,99,100,101,102,103,104,105,190,188,8,46,110]
    //    $('#txt_num').keydown(function(event) {
    //        var tecla = event.keyCode
    //        if($.inArray(tecla,arr)>0){
    //            bandera=true
    //            return true
    //        }else{
    //            bandera=false
    //            return false
    //        }
    //
    //    }).keyup(function(event){
    //                var pos =$("#txt_num").caret().start
    ////                if(event.keyCode=8)
    ////                    pos-1
    //                if(bandera){
    //                    var org = $('#txt_num').val().length
    //                    $('#txt_num').val(formatear($('#txt_num').val()))
    //                    var dif = $('#txt_num').val().length-org
    //                    $('#txt_num').caret({start:pos+dif,end:pos+dif})
    //                }
    //            })


    $(".link").button()
    $(".back").button({icons:{primary:'ui-icon-arrowreturnthick-1-w'}});

    $("#breadCrumb").jBreadCrumb({
        beginingElementsToLeaveOpen: 10
    });

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
                        alert("algo salio mal")
                    }
                }
            });
        }
    });

    $("#cmb_comp").change(function() {
        location.href = "${createLink(action:'actividadesComponente')}/" + $(this).val()
    });
    $(".datos").click(function() {
        if ($("#edicion").val() == "1") {
            $("#txt_datos").val("")
            $("#ml").val($(this).attr("tipo"))
            $("#div").val($(this).attr("div"))
            $("#iden").val($(this).attr("identificador"))
            if ($("#" + $(this).attr("div")).html())
                $("#txt_datos").val($("#" + $(this).attr("div")).html().trim())
            $("#dlg_datos").dialog({title:"Ingreso de datos"})
            $("#dlg_datos").dialog("open")
        }
    });

    $(".varios").click(function() {
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
            if ($("#" + $(this).attr("div")).html())
                $("#txt_varios").val($("#" + $(this).attr("div")).html().trim())
            if ($("#txt_varios").val() == "Agregar")
                $("#txt_varios").val("")
            $("#txt_num").val($("#" + $(this).attr("div")).html().trim())
            if($(this).attr("tipo")== "5"){
                $("#dlg_combo").dialog({
                    height:160
                }).dialog("open")
                $("#txt_num").show()

                $("#txt_varios").hide()
            }else{
                $("#dlg_combo").dialog({
                    height:460
                }).dialog("open")
                $("#txt_num").hide()
                $("#txt_varios").show()
            }

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

                if (confirm("Esta seguro que desea eliminar?. Esta acción es irreversible. La actividad no se eliminara si tiene metas o asignaciones asociadas")) {
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
                                alert("La actividad no se pudo eliminar, tiene metas o asignaciones asociadas")
                            }
                        }
                    });
                }
            },
            "Aceptar":function() {
                if ($("#txt_datos").val() != "" && $("#txt_datos").val() != " ") {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'guadarDatosActividades')}",
                        data: {
                            tipo:$("#ml").val(),
                            datos:$("#txt_datos").val(),
                            componente:$("#componente").val(),
                            id: $("#iden").val()
                        },
                        success: function(msg) {
                            if (msg != "no") {
                                window.location.reload(true)
                            } else {
                                alert("algo salio mal")
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
                if($("#c_tipo").val()!="5")
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
                else{
                    alert("Este campo no puede ser eliminado")
                }
            },
            "Aceptar":function() {
                var datos = $("#txt_num").val()
                var band = true
                var msg
                var max =$("#max").val()
                var total=0
                var dif = 0

                if($("#c_tipo").val()!=5){
                    datos = $("#txt_varios").val()
                    if(datos==""){
                        band=false
                        msg="El campo no puede quedar vacio"
                    }

                }
                if($("#c_tipo").val()==5){
                    var divOriginal =$("#" + $("#c_div").val())
                    var original = $("#" + $("#c_div").val()).html()
                    original = str_replace(".","",original)
                    original = str_replace(",",".",original)
                    original=original*1
                    var valor = datos
                    valor = str_replace(".","",valor)
                    valor = str_replace(",",".",valor)
                    valor=valor*1
                    dif = original-valor
                    $.each($(".monto"),function(){
                        if($(this).attr("id")!=divOriginal.attr("id")){
                            var tmp = $(this).html()
                            tmp = str_replace(".","",tmp)
                            tmp = str_replace(",",".",tmp)
                            tmp=tmp*1
                            total+=tmp
                        }
                    });
                    total+=valor
                    if(dif*-1>max*1){
                        msg="El valor ingresado ("+number_format(valor, 2, ",", ".")+") supera al valor restante por asignar en el proyecto("+number_format(max, 2, ",", ".")+")."
                        band=false
                    }


                }
                if (band) {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'guadarDatosActividades')}",
                        data: {
                            ml:$("#c_ml").val(),
                            datos:datos,
                            componente:$("#componente").val(),
                            id:$("#c_iden").val(),
                            indicador:$("#c_indi").val(),
                            tipo:$("#c_tipo").val()
                        },
                        success: function(msg) {
                            if (msg != "no") {
                                if(dif!=0){
                                    var totPorAsig=$("#total_sin").html()
                                    totPorAsig = str_replace(".","",totPorAsig)
                                    totPorAsig = str_replace(",",".",totPorAsig)
                                    totPorAsig=totPorAsig*1
                                    $("#total_sin").html(number_format(totPorAsig+dif, 2, ",", "."))
                                    $("#total_componente").html(number_format(total, 2, ",", "."))
                                }

                                if ($("#c_iden").val() == "0" && $("#c_tipo").val() * 1 == 2) {

                                    var d3 = $("<div>")
                                    d3.attr("indicador", "0")
                                    d3.html("Agregar")
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
                                    var num = Math.floor(Math.random() * 101)
                                    d3.addClass("texto agregado ui-corner-all fin varios edicion").attr("pref", "ic_").attr("id", "ic_000" + num).attr("ml", $("#c_ml").val()).attr("div", "ic_000" + num).attr("identificador", "0").attr("tipo", "2")
                                    $("#" + $("#c_div").val()).parent().append(d3)
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
                                    $("#" + $("#c_div").val()).html(datos)
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
                }else{
                    alert("Error:"+msg)
                }
            }
        }
    });

    $("#accordion").accordion({collapsible: true})
</script>
</body>
</html>