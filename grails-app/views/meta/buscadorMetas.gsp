<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Bucador de metas</title>
</head>
<body>

<div class="body">
    <div class="dialog">
        <fieldset class="ui-corner-all" style="width: 1010px;height: 55px;">
            <legend>Parametros</legend>
            <b>Indicador:</b> <g:select from="${mies.TipoMeta.list()}" optionKey="id" optionValue="descripcion" name="tipo" id="indicador" style="width: 120px;" noSelection="['-1':'Todos']"/> &nbsp;&nbsp;
            <b>Parroquia:</b><input type="text" style="width: 120px;" id="parr_nombre_txt">&nbsp;&nbsp;
            <input type="hidden" id="parr_id" name="parroquia.id">
            <b>Meta:</b>
            <select id="tipoMeta">
                <option value="1">Igual</option>
                <option value="2">Mayor</option>
                <option value="3">Menor</option>
            </select>
            <input type="text" style="width: 85px;" id="meta"> &nbsp;&nbsp;
            <b>Inversión:</b>
            <select id="tipoInversion">
                <option value="1">Igual</option>
                <option value="2">Mayor</option>
                <option value="3">Menor</option>
            </select>
            <input type="text" style="width: 85px;" id="inversion">
            <a href="#" id="buscar_meta" class="btn">Buscar</a>
            <a href="#" onclick="window.location.reload(true)" id="" class="btn">Resetear</a>
        </fieldset>

    </div>
    <fieldset class="ui-corner-all" style="width: 1020px;min-height: 50px;">
        <legend>Resultados</legend>
        <div id="resultados" style="overflow-y: auto;width: 1010px;"></div>
    </fieldset>
</div>

<div id="dlg_buscar">
    <div style="width: 90%;height: 30px;">
        <input type="text" id="txt_buscar"><a href="#" id="buscar_dlg" class="btn">Buscar</a>
    </div>

    <div id="parrs"
         style="width: 95%;height: 340px;overflow-y: auto;margin: auto;margin-top: 10px;border: 1px solid black;"
         class="ui-corner-all"></div>
</div>
<div id="load">
    <img src="${g.resource(dir:'images',file: 'loading.gif')}" alt="Procesando">
    Procesando
</div>
<script type="text/javascript">
    $(".btn").button()
    $("#parr_nombre_txt").click(function() {
        $("#dlg_buscar").dialog("open")
    });
    $("#buscar_dlg").click(function() {
        $.ajax({
            type: "POST",
            url: "${createLink(action:'buscarParroquias',controller:'meta')}",
            data: "parametro=" + $("#txt_buscar").val(),
            success: function(msg) {
                $("#parrs").html(msg)

            }
        });
    });
    $("#dlg_buscar").dialog({
        width:630,
        height:500,
        position:"center",
        modal:true,
        autoOpen:false
    })
    $("#load").dialog({
        width:100,
        height:100,
        position:"center",
        title:"Procesando",
        modal:true,
        autoOpen:false,
        resizable:false,
        open: function(event, ui) {
            $(event.target).parent().find(".ui-dialog-titlebar-close").remove()
        }
    });
    $("#buscar_meta").click(function(){
        $("#load").dialog("open")
           $.ajax({
            type: "POST",
            url: "${createLink(action:'buscarMeta',controller:'meta')}",
            data:"indicador="+$("#indicador").val()+"&parroquia="+$("#parr_id").val()+"&meta="+$("#meta").val()+"&tipoMeta="+$("#tipoMeta").val()+"&inversion="+$("#inversion").val()+"&tipoInversion="+$("#tipoInversion").val(),
            success: function(msg) {
                $("#resultados").html(msg)
                $("#load").dialog("close");

            }
        });
    });

</script>
</body>
</html>