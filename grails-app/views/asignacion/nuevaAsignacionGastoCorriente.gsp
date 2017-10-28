<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Nueva asignación de gasto corriente</title>
</head>
<body>
<div class="body">
    <div class="dialog" >
        <g:form action="guardarAsignacionGastoCorriente" controller="asignacion" class="frm_asg" >
            <table width="430px" class="ui-widget-content ui-corner-all">
                <tbody>
                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'anio', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="asignacion.anio.label" default="Anio"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="anio.id" title="anio"
                                  from="${mies.Anio.list()}" optionKey="id" value="${asignacionInstance?.anio?.id}"
                                  noSelection="['null': '']" id="anio"/>
                        %{----}%
                    </td>
                </tr>
                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="asignacion.fuente.label" default="Fuente"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="fuente.id" title="fuente"
                                  from="${mies.Fuente.list()}" optionKey="id" value="${asignacionInstance?.fuente?.id}"
                                  noSelection="['null': '']"/>
                        %{----}%
                    </td>
                </tr>
                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                    <td class="label " valign="middle">
                        Actividad de gasto corriente
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="actividad.id" title="actividad"
                                  from="${mies.Actividad.list()}" optionKey="id"
                                  value="${asignacionInstance?.actividad?.id}" noSelection="['null': '']"/>
                        %{----}%
                    </td>
                </tr>
                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'presupuesto', 'error')}">

                    <td class="label " valign="middle">
                        <g:message code="asignacion.presupuesto.label" default="Presupuesto"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <input type="text" id="txt_buscar" value="">
                        <a href="#" id="buscar_prsp">Buscar</a>
                        <input type="hidden" name="presupuesto.id" id="presupuesto">
                        %{----}%
                    </td>
                </tr>
                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                    <td class="label " valign="middle">
                        <g:message code="asignacion.tipoGasto.label" default="Tipo Gasto"/>
                        %{----}%
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <g:select class="field ui-widget-content ui-corner-all" name="tipoGasto.id" title="tipoGasto"
                                  from="${mies.TipoGasto.list()}" optionKey="id"
                                  value="${asignacionInstance?.tipoGasto?.id}" noSelection="['null': '']"/>
                        %{----}%
                    </td>
                </tr>
                <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'planificado', 'error')}">

                    <td class="label  mandatory" valign="middle">
                        Valor planificado
                        %{--<span class="indicator">*</span>--}%
                    </td>
                    <td class="indicator mandatory">
                        <span class="indicator">*</span>
                    </td>
                    <td class="campo mandatory" valign="middle">
                        <g:textField class="field number required ui-widget-content ui-corner-all" name="planificado" title="Valor planificado, mayor a cero"
                                     id="valor" value="${fieldValue(bean: asignacionInstance, field: 'planificado')}"/>
                        %{--<span class="indicator">*</span>--}%
                    </td>
                </tr>
                </tbody>

            </table>
            <g:submitButton name="btn" value="Guardar" class="btn" style="margin-top: 10px;margin-left: 340px;"/>
        </g:form>
        <fieldset style="width: 405px;height: 300px;overflow-y: auto;"  class="ui-corner-all">
            <legend>Resultado</legend>
            <div id="resultado"></div>
        </fieldset>
    </div>
</div>
<script type="text/javascript">
    $("#buscar_prsp").button().click(function(){
        $.ajax({
            type: "POST",
            url: "${createLink(action:'buscarPresupuesto',controller:'asignacion')}",
            data: "parametro="+$("#txt_buscar").val(),
            success: function(msg) {
                $("#resultado").html(msg)
            }
        });
    });
    $(".btn").button()
</script>
</body>
</html>