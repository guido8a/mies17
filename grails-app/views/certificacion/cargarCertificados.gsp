<g:if test="${aprobados.size()+negados.size()+solicitados.size()>0}">
<table style="width: 380px;">
    <thead>
    <th>Estado</th>
    <th>Fecha revisión</th>
    <th>Monto</th>
    </thead>
    <tbody>
    <g:set var="total" value="${0}"></g:set>
    <g:if test="${aprobados}">
        <tr><td colspan="3"><b>Aprobados</b></td></tr>
        <g:each in="${aprobados}" var="cer">
            <g:set var="total" value="${total.toDouble()+cer.monto}"></g:set>
          <tr>
              <td>Aprobado</td>
              <td>${cer.fechaRevision.format("dd/MM/yyyy")}</td>
              <td><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
              <td><a href="#" class="desc" cer="${cer.id}">PDF</a></td>
          </tr>  
        </g:each>
        <tr>

            <td>Total</td>
            <td></td>
            <td><g:formatNumber number="${total}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
        </tr>
    </g:if>
    <g:if test="${solicitados}">
        <tr><td colspan="3"><b>Solicitados</b></td></tr>
        <g:each in="${solicitados}" var="cer">
            <g:set var="total" value="${total.toDouble()+cer.monto}"></g:set>
            <tr>
                <td>Solicitado</td>
                <td>${cer?.fechaRevision?.format("dd/MM/yyyy")}</td>
                <td><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
        </g:each>
    </g:if>
    <g:if test="${negados}">
        <tr><td colspan="3"><b>Negados</b></td></tr>
        <g:each in="${negados}" var="cer">
            <tr>
                <td>Negado</td>
                <td>${cer.fechaRevision.format("dd/MM/yyyy")}</td>
                <td><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
        </g:each>
    </g:if>
    <input type="hidden" id="certificado" value="${total}">
    
    </tbody>
</table>
</g:if>
<g:else>
    La asignación no tiene certificaciones
    <input type="hidden" id="certificado" value="0">
</g:else>
<script type="text/javascript">
    $(".desc").button().click(function(){
        location.href = "${createLink(controller:'certificacion',action:'descargaDocumento')}/"+$(this).attr("cer")
    });
</script>