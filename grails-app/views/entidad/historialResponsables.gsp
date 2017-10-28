<style type="text/css">
.activo {
    background : #CCDCEA !important;
}

.pasado {
    background : #DBC3C3 !important;
}

.futuro {
    background : #EADADA !important;
}

.selected {
    background : #ECEFC9 !important;
}
</style>

<script type="text/javascript"
        src="${resource(dir: 'js/jquery/plugins/jquery.fixheadertable-2.0', file: 'jquery.fixheadertable.min.js')}"></script>

<script type="text/javascript"
        src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.min.js')}"></script>

<link rel="stylesheet" type="text/css"
      href="${resource(dir: 'js/jquery/plugins/jquery.fixheadertable-2.0', file: 'base.css')}"/>

<g:set var="width" value="750"/>

<div style="width: ${width}px;">
    <div class="list" style="width: ${width}px;">
        <div style="margin-bottom: 10px;" >
            <label for="txtSearch">Filtrar:</label> <input type="text" id="txtSearch" class="ui-widget-content ui-corner-all"/>
        </div>
        <table style="width: ${width}px;" id='tabla'>
            <thead>
                <tr>
                    <th>Responsable</th>
                    <th>Desde</th>
                    <th>Hasta</th>
                    <th>Tipo</th>
                    <th>Observaciones</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <g:if test="${responsableProyectoInstanceList.size() > 0}">
                    <g:each in="${responsableProyectoInstanceList}" status="i" var="responsableProyectoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'} ${responsableProyectoInstance.clase}">
                            <td data_tipo="responsable">${responsableProyectoInstance.obj?.responsable.persona.nombre} ${responsableProyectoInstance.obj?.responsable.persona.apellido}</td>
                            <td data_tipo="desde"><g:formatDate date="${responsableProyectoInstance.obj?.desde}"
                                                                format="dd-MM-yyyy"/></td>
                            <td data_tipo="hasta"><g:formatDate date="${responsableProyectoInstance.obj?.hasta}"
                                                                format="dd-MM-yyyy"/></td>
                            <td data_tipo="tipo">${responsableProyectoInstance.obj?.tipo}</td>
                            <td data_tipo="observaciones">${responsableProyectoInstance.obj?.observaciones}</td>
                            <td data_tipo="estado">${responsableProyectoInstance?.estado?.capitalize()}</td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr>
                        <td colspan="6" style="text-align: center; font-size: 16px; color: #1482B4; font-weight: bold;">
                            No se encontraron responsables para esta unidad ejecutora
                        </td>
                    </tr>
                </g:else>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">
    $(function() {

        $("#txtSearch").keyup(function(evt) {
            var txt = $(this).val();
            if (txt != "") {
                $("#tabla tr").hide();
                $("#tabla tr td").removeClass("selected");
                $("#tabla tr td:icontains('" + txt + "')").addClass("selected").parent().show();
            } else {
                $("#tabla tr").show();
                $("#tabla tr td").removeClass("selected");
            }
        });

        $('#tabla').fixheadertable({
            colratio    : [250,80,80,90,165,60],
            height      : 300
        });
    });
</script>