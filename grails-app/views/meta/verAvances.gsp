<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Avances de la meta: ${meta.descripcion}</title>
</head>
<body>
<div class="body">
    <div class="dialog" >
        <div id="accordion" style="width:1030px">
            <g:if test="${avances.size()<1}">
                <h3><a href="#">Avances </a></h3>
                <div>La meta no tiene avances registrados</div>
            </g:if>
            <g:each in="${avances}" var="avc" status="k">
                <h3><a href="#">Avance #${k+1} </a></h3>
                <div>
                    <div style="width: 100%;float: left;margin-top: 10px;min-height: 75px;"><b>Descripcion:</b><br>${avc.descripcion}</div>
                    <div style="width: 100%;float: left;margin-top: 10px;"><b>Valor:</b>${avc.valor}</div>
                    <div style="width: 100%;float: left;margin-top: 10px;"><g:link action="show" controller="informe" id="${avc.informe.id}" class="btn">Ver informe</g:link></div>
                </div>
            </g:each>
        </div>
        <div style="float: left;width: 90%;height: 35px;display: block;margin-top: 10px;">
            <g:link controller="meta" action="registrarAvance" params="[meta:meta.id]" class="btn">Agregar</g:link>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(".btn").button()
    $("#accordion").accordion({collapsible: true})
    $("#cmb_comp").change(function(){
        location.href="${createLink(action:'verAvances')}/"+$(this).val()
    });
    %{--$("#agregar").click(function(){--}%
         %{--location.href="${createLink(action:'registrarAvance',params:[meta:meta.id])}"--}%
    %{--})--}%
</script>
</body>
</html>