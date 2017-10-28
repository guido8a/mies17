<table class="ui-widget-content ui-corner-all" width="580px">
    <thead>
    <th>Número</th>
    <th>Descripcion</th>
    <th></th>
    </thead>
    <tbody>
    <g:each in="${ccps}" var="p" status="i">
        <tr class="${(i%2==0)?'even':'odd'}">
            <td>${p.numero}</td>
            <td>${p.descripcion}</td>
            <td><a href="#" class="mas" ccp="${p.id}" nombre="${p.numero}">Añadir</a></td>
        </tr>
    </g:each>
    </tbody>
</table>
<script type="text/javascript">
    $(".mas").button().click(function(){
        $("#ccp").val($(this).attr("ccp"))
        $("#txt_buscar").val($(this).attr("nombre"))
        $("#buscar").dialog("close")
        $("#"+$("#id_txt").val()).val($(this).attr("nombre"))
            //console.log($("#"+$("#id_txt").val()))
        $("#"+$("#id_txt").val()).parent().find(".cpac").val($(this).attr("ccp"))
    });
</script>