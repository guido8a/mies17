<table>
    <thead>
    <th class="ui-state-default" style="width: 250px;">Unidad</th>
    <th class="ui-state-default" style="width: 110px">Monto</th>
    <th></th>
    </thead>
    <tbody>
    <g:set var="tot" value="${0}"></g:set>
    <g:each in="${dist}" var="d">
        <tr>
            <td>${d.unidadEjecutora}</td>
            <td style="text-align: right">${formatNumber(number:d.valor,format:"###,##0",minFractionDigits:2,maxFractionDigits:2)}</td>
            <td>
                <a href="#" class="borrar" iden="${d.id}">Borrar</a>
            </td>
            <g:set var="tot" value="${tot+d.valor}"></g:set>
        </tr>
    </g:each>
    </tbody>
</table>

<input type="hidden" id="dist" value="${tot.toFloat().round(2)}">
<script type="text/javascript">
    $(".borrar").button({icons:{ primary:"ui-icon-trash"},text:false}).click(function(){
        if (confirm("Esta seguro de elminar este registro?")) {
            $.ajax({
                type:"POST", url:"${createLink(action:'eliminarDistribucion', controller: 'asignacion')}",
                data:"id=" + $(this).attr("iden"),
                success:function (msg) {
                    $("#detalle").html(msg).show("slide")
                    $("#lbl_max").html(number_format($("#max").val()*1, 2, ",", "."))

                }
            });

        }
    });


</script>