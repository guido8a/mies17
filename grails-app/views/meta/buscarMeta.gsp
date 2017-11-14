    <input type="hidden" value="${hql}" id="hql">
    <table style="width: 1000px;">
        <tbody>
        <th class="ui-state-default ">Proyecto</th>
        <th class="ui-state-default ">Actividad</th>
        <th class="ui-state-default order" order="asc" tipo="tipoMeta" title="Ordernar">Indicador</th>
        <th class="ui-state-default order" order="asc" tipo="provincia" title="Ordernar">Provincia</th>
        <th class="ui-state-default order" order="asc" tipo="canton" title="Ordernar">Canton</th>
        <th class="ui-state-default order" order="asc" tipo="parroquia" title="Ordernar">Parroquia</th>
        <th class="ui-state-default order" order="asc" tipo="indicador" title="Ordernar">Meta</th>
        <th class="ui-state-default order" order="asc" tipo="inversion" title="Ordernar">Inversión</th>
        <th class="ui-state-default " >Ver</th>
        <th class="ui-state-default " >Mapa</th>
        </tbody>
        <tbody>
        <g:each in="${metas}" var="meta" status="i">
            <tr>
                <td title="${meta?.marcoLogico?.proyecto?.toStringCompleto()}">${meta?.marcoLogico?.proyecto}</td>
                <td title="${meta?.marcoLogico?.toStringCompleto()}">${meta.marcoLogico}</td>
                <td>${meta.tipoMeta}</td>
                <td>${meta?.parroquia?.canton?.provincia}</td>
                <td>${meta?.parroquia?.canton}</td>
                <td>${meta?.parroquia}</td>
                <td style="text-align: right">
                    <g:formatNumber number="${meta?.indicador}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>
                <td style="text-align: right">
                    <g:formatNumber number="${meta?.inversion}"
                                                       format="###,##0"
                                                       minFractionDigits="2" maxFractionDigits="2"/>
                </td>
                <td><g:link controller="marcoLogico" action="ingresoMetas" params="${[id:meta?.marcoLogico?.id,meta:meta?.id]}" class="ver">Ver</g:link></td>
                <td><g:link controller="marcoLogico" action="mapaMeta" id="${meta?.id}" class="mapa">Mapa</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>
   <script type="text/javascript">
       $(".ver").button({icons:{ primary:"ui-icon-search"},text:false})
       $(".mapa").button({icons:{ primary:"ui-icon-pin-s"},text:false})
       $(".order").css("cursor","pointer").click(function(){
           $.ajax({
            type: "POST",
            url: "${createLink(action:'buscarMeta',controller:'meta')}",
            data:"hql="+$("#hql").val()+"&order="+$(this).attr("tipo"),
            success: function(msg) {
                $("#resultados").html(msg)

            }
        });
       });
   </script>