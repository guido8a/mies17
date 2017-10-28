<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'avance.label', default: 'Avance')}"/>
    <title>Aprobar gastos e inversiones</title>
</head>
<body>

<div style="width: 400px;">
    <b>Seleccione un año</b>
    <g:select from="${anios}" name="anios" optionKey="id" optionValue="anio" noSelection="[0:'Seleccione']" id="anio"/>
</div>


<fieldset id="detalle" class="ui-corner-all" style="display: none;padding: 10px;background: #E0EEF4">


</fieldset>

<script type="text/javascript">
    $("#anio").change(function(){
        if($(this).val()!="0"){
           $.ajax({
            type: "POST",
            url: "${createLink(action:'detalleAnio',controller:'anio')}",
            data: "anio=" + $(this).val(),
            success: function(msg) {
                $("#detalle").html(msg)
                $("#detalle").show("slide")
            }
        });
        }
    });
</script>
</body>
</html>