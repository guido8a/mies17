<table class="ui-widget-content ui-corner-all" width="400px">
    <thead>
    <th>Número</th>
    <th>Descripcion</th>
    <th></th>
    </thead>
    <tbody>
    <g:each in="${acts}" var="p" status="i">
        <tr class="${(i%2==0)?'even':'odd'}">
            <td>${p.codigo}</td>
            <td>${p.descripcion}</td>
            <td><a href="#" class="mas" actv="${p.id}" nombre="${p.codigo}" desc="${p.descripcion}">Añadir</a></td>
        </tr>
    </g:each>
    </tbody>
</table>
<script type="text/javascript">
    $(".mas").button().click(function(){
        $("#actv__id").val($(this).attr("actv"))
        $("#actv_num").val($(this).attr("nombre"))
        $("#dlg_buscar_act").dialog("close")
    });
</script>