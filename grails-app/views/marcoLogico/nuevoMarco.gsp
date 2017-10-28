<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Marco logico</title>
    <style type="text/css">
    .campo{
        width: 235px;
        margin: 5px;
        min-height: 415px;
        border: 1px solid black;
        float: left;
        padding: 5px;
        position: relative;
    }
    .titulo{
        width: 90%;
        margin: 5%;
        margin-top: 2px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        font-family: fantasy;
        font-style: italic;
        border-bottom: 1px solid black;

    }
    .filaCombo{
        width: 90%;
        margin: 5%;
        margin-top: -10px;
        height: 40px;
        line-height: 40px;
        text-align: center;
        font-family: fantasy;
        font-style: italic;
        border-bottom: 1px solid black;
    }
    .texto {
        width: 90%;
        min-height: 300px;
        margin: 5%;
    }
    textarea{
        width: 93%;
        padding: 5px;
        min-height: 300px;
        resize: vertical;
    }
    .agregado{
        border: 1px solid black;
        width: 95%;
        margin: 1.5%;
        text-align: justify;
        padding: 4px;
        min-height: 20px;
        word-wrap: break-word;
        background: rgba(145, 192, 95,0.2)
    }
    </style>
</head>
<body>

<div class="body">
    <g:form action="guardarMarco" class="marcoLogico">
        <div id="divSubmit">
            <input type="hidden" name="proyecto" value="${proyecto.id}">
        </div>
        <div class="dialog" title="MATRIZ DE MARCO LOGICO DEL PROYECTO" >
            <div class="matriz ui-corner-all campo">
                %{--<input type="hidden" name="fin" value="1">--}%
                <div class="titulo">Fin</div>
                <div class="filaCombo"><a href="#" id="btnFin" class="btn">Agregar</a></div>
                <div class="texto" style="" id="div_fin">
                    <textarea name="fin" id="txt_fin" >${fin?.objetivo}</textarea>
                </div>

            </div>
            <div class="matriz ui-corner-all campo">
                <div class="titulo">Indicadores</div>
                <div class="filaCombo"><a href="#" id="btnIndi" class="btn">Agregar</a></div>
                <div class="texto" style="" id="div_indicador">
                    <textarea name="indicador" id="txt_indi" >${fin?.objetivo}</textarea>
                </div>
            </div>
            <div class="matriz ui-corner-all campo" id="cp">
                <div class="titulo">Medios de Verificacion</div>
                <div class="filaCombo"><a href="#" id="btn_agregarMedio" class="btn">Agregar</a></div>
                <div class="texto" id="medios">
                </div>
            </div>
            <div class="matriz ui-corner-all campo">
                <div class="titulo">Supuesto</div>
                <div class="filaCombo">
                    <a href="#" id="btn_agregarSup" class="btn">Agregar</a>

                </div>
                <div class="texto" style=" min-height: 285px;" id="supuestos">
                </div>
            </div>
            <div class="buttons" style="float: left;clear: both;">
                <a href="#" id="btn_submit" class="btn">Guardar</a>
            </div>
        </div>

        <div id="dlg_medios" title="Agregar medio de verificacion">
            <div class="texto" style="">
                <textarea name="mdo" id="mdo" ></textarea>
            </div>
        </div>
        <div id="dlg_sup">
            <g:select from="" name="tipo" optionKey="id" optionValue="descripcion" style="margin-left: 15px"/>
            <a href="#"  id="btnAgregar">Agregar</a>
            <div class="texto" style="">
                <textarea name="mdo" id="spt" ></textarea>
            </div>

        </div>

    </g:form>
</div>
<script type="text/javascript">

    function reajustar(){
        // alert(t)
        var tam = 415
        $.each($(".campo"),function(){
            if($(this).height()*1>tam)
                tam=$(this).height()*1
        });
        $(".campo").css("min-height",tam)
    }


    $("#btn_submit").click(function(){
        $(".marcoLogico").submit();
        return false;
    });

    $(".save").button();
    $(".btn").button();
    $("#btn_agregarMedio").click(function(){
        $("#dlg_medios").dialog("open")
    });
    $("#btn_agregarSup").click(function(){
        $("#dlg_sup").dialog("open")
    });
    $("#btnFin").click(function(){
        if($("#txt_fin").val()!="" && $("#txt_fin").val()!=" "){
            var d = $("<div>")
            var h = $("<input type='hidden' class='sub' name='fin'>")
            d.addClass("agregado ui-corner-all")
            d.html($("#txt_fin").val())
            h.val($("#txt_fin").val())
            $("#txt_fin").val("")
            $("#txt_fin").hide()
            $("#div_fin").append(d)
            $("#div_fin").append(h)
            $("#btnFin").hide()
            $("#divSubmit").append(h);
            reajustar()
        }
    });

    $("#btnIndi").click(function(){
        if($("#txt_indi").val()!="" && $("#txt_indi").val()!=" "){
            var d = $("<div>")
            var h = $("<input type='hidden' class='sub' name='indicador'>")
            d.addClass("agregado ui-corner-all")
            d.html($("#txt_indi").val())
            h.val($("#txt_indi").val())
            $("#txt_indi").val("")
            $("#txt_indi").hide()
            $("#div_indicador").append(d)
            $("#div_indicador").append(h)
            $("#btnIndi").hide()
            $("#divSubmit").append(h);

            reajustar()
        }
    });

    $("#dlg_medios").dialog( {
                width:300,
                height:440,
                position:"center",
                modal:true,
                autoOpen:false,
                buttons:{
                    "Aceptar":function(){
                        if($("#mdo").val()!="" && $("#mdo").val()!=" "){
                            var d = $("<div>")
                            var h = $("<input type='hidden' class='sub' name='medios'>")
                            d.addClass("agregado ui-corner-all")
                            d.html($("#mdo").val())
                            h.val($("#mdo").val())
                            $("#mdo").val("")
                            $("#medios").append(d)
                            $("#medios").append(h)

            $("#divSubmit").append(h);
                            reajustar()
                            $(this).dialog("close")
                        }
                    }
                }
            });
    $("#dlg_sup").dialog( {
                width:300,
                height:440,
                position:"center",
                modal:true,
                autoOpen:false,
                buttons:{
                    "Aceptar":function(){
                        if($("#spt").val()!="" && $("#spt").val()!=" "){
                            var d = $("<div>")
                            var h = $("<input type='hidden' class='sub' name='supuestos'>")
                            d.addClass("agregado ui-corner-all")
                            d.html($("#spt").val())
                            h.val($("#spt").val())
                            $("#spt").val("")
                            $("#supuestos").append(d)
                            $("#supuestos").append(h)

            $("#divSubmit").append(h);
                            reajustar()
                            $(this).dialog("close")
                        }
                    }
                }
            });
    $("#btnAgregar").button({
                icons: {
                    primary: "ui-icon-plus"
                },
                text:false
            });
</script>
</body>
</html>