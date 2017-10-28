<table>
    <tbody>
    <th>Provincia</th>
    <th>Canton</th>
    <th>Parroquia</th>
    <th>Número</th>


    <th></th>
    </tbody>
    <tbody>
    <g:each in="${parroquias}" var="parr" status="i">
        <tr>
            <td>${parr.canton.provincia}</td>
            <td>${parr.canton}</td>
            <td>${parr.nombre}</td>
            <td>${parr.numero}</td>

            <td><a href="#" class="btn_bscar_edit" parr="${parr.id}" nombre="${parr.nombre}">Añadir</a></td>
        </tr>
    </g:each>
    </tbody>
</table>
<script type="text/javascript">
    $(".btn_bscar_edit").button().click(function(){
        $("#form_par_id").val($(this).attr("parr"))
        $("#txt_parr").val($(this).attr("nombre"))
        $("#dlg_buscar_edit").dialog("close")

    });
</script>