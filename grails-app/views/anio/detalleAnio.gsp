<legend>Detalle</legend>
<input type="hidden" value="${anio.id}" id="anio">
<table style="width: 850px;">
    <thead>
    <tr>
        <th style="background: white"></th>
        <th colspan="4" style="background: #FFAB48">Proyectos</th>
        <th colspan="4" style="background: #FFE7AD">Corrientes</th>

    </tr>
    <tr>
        <th style="background: white;width: 260px;">Unidad ejecutora</th>
        <th  style="background: #FFAB48">Asignaciones</th>
        <th style="background: #FFAB48">Total</th>
        <th style="background: #FFAB48">P.A.C.</th>
        <th style="background: #FFAB48">Total</th>
        <th style="background: #FFE7AD">Asignaciones</th>
        <th style="background: #FFE7AD">Total</th>
        <th style="background: #FFE7AD">P.A.C.</th>
        <th style="background: #FFE7AD">Total</th>
    </tr>
    </thead>
    <tbody>
    <g:set var="totCantProy" value="0"></g:set>
    <g:set var="totProy" value="0"></g:set>
    <g:set var="totCantCor" value="0"></g:set>
    <g:set var="totCor" value="0"></g:set>
    <g:set var="totCantObraProy" value="0"></g:set>
    <g:set var="totObraProy" value="0"></g:set>
    <g:set var="totCantObraCor" value="0"></g:set>
    <g:set var="totObraCor" value="0"></g:set>
    <g:each in="${datos}" var="dato" status="i">
        <g:set var="totCantProy" value="${totCantProy.toInteger()+dato.value.get(1)}"></g:set>
        <g:set var="totProy" value="${totProy.toDouble()+dato.value.get(0)}"></g:set>
        <g:set var="totCantCor" value="${totCantCor.toInteger()+dato.value.get(5)}"></g:set>
        <g:set var="totCor" value="${totCor.toDouble()+dato.value.get(4)}"></g:set>
        <g:set var="totCantObraProy" value="${totCantObraProy.toInteger()+dato.value.get(3)}"></g:set>
        <g:set var="totObraProy" value="${totObraProy.toDouble()+dato.value.get(2)}"></g:set>
        <g:set var="totCantObraCor" value="${totCantObraCor.toInteger()+dato.value.get(7)}"></g:set>
        <g:set var="totObraCor" value="${totObraCor.toDouble()+dato.value.get(6)}"></g:set>
        <tr style="background: white">
            <td style="background: white;width: 260px;">${dato.key}</td>
            <td style="background: #FFAB48">${dato.value.get(1)}</td>
            <td style="background: #FFAB48">${dato.value.get(0)}</td>
            <td style="background: #FFAB48">${dato.value.get(3)}</td>
            <td style="background: #FFAB48">${dato.value.get(2)}</td>
            <td  style="background: #FFE7AD">${dato.value.get(5)}</td>
            <td  style="background: #FFE7AD">${dato.value.get(4)}</td>
            <td  style="background: #FFE7AD">${dato.value.get(7)}</td>
            <td  style="background: #FFE7AD">${dato.value.get(6)}</td>
        </tr>
    </g:each>
    <tr>
        <td style="background: white"><b>Total</b></td>
        <td style="background: #FFAB48">${totCantProy}</td>
        <td style="background: #FFAB48">${totProy.toFloat().round(2)}</td>
        <td style="background: #FFAB48">${totCantObraProy}</td>
        <td style="background: #FFAB48" style="background: #FFAB48">${totObraProy.toFloat().round(2)}</td>
        <td style="background: #FFE7AD">${totCantCor}</td>
        <td style="background: #FFE7AD" >${totCor.toFloat().round(2)}</td>
        <td style="background: #FFE7AD">${totCantObraCor}</td>
        <td style="background: #FFE7AD">${totObraCor.toFloat().round(2)}</td>

    </tr>
    </tbody>

</table>
<div id="aprob">
    <input type="hidden" id="iden">
    Ingrese su clave de aprobación <br>
    <input type="password" id="pass">
</div>
<g:if test="${anio.estado==0}">
    <a href="#" style="margin-top: 15px;" class="boton" id="aprobar">Aprobar</a>
</g:if>
<g:else>
    Las asignaciones ya han sido aprobadas para este año
</g:else>
<script type="text/javascript">
    $(".boton").button()
    $("#aprob").dialog({
        autoOpen:false,
        modal:true,
        position:"center",
        width:250,
        height:150,
        title:"Aprobación",
        resizable:false,
        buttons:{
            "Aprobar":function(){
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'aprobarAnio')}",
                    data: {
                        ssap:$("#pass").val(),
                        anio:$("#anio").val()
                    },
                    success: function(msg) {
                        if(msg!="no"){
                            alert("Anio aprobado")
                            window.location.href="${createLink(action:'vistaAprobarAño')}"

                        }else{
                            alert("Clave no valida")
                        }
                    }
                });
            }
        }
    });
    $("#aprobar").click(function(){
        $("#aprob").dialog("open")
    });
</script>