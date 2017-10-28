<%@ page import="mies.Asignacion" %>
<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${asignacionInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${asignacionInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form action="creaHijoMod" class="frmModAsignaciones" method="post" enctype="multipart/form-data">
    <g:hiddenField name="id" value="${asignacionInstance?.id}"/>
    <g:hiddenField name="unidad" value="${unidad?.id}"/>
    <g:hiddenField name="maximo" value="${asignacionInstance?.getValorReal()?.toFloat()?.round(2)}"/>

    <table style="width: 400px;" class="show ui-widget-content ui-corner-all">
        <tr><td colspan="6" class="blanco">&nbsp;</td></tr>
        <tr>
            <td class="label " valign="middle">
                <g:message code="asignacion.fuente.label" default="Fuente"/>:
                %{----}%
            </td>
            <td class="indicator">&nbsp;</td>
            <td class="" valign="middle">
                <g:select class="field ui-widget-content ui-corner-all" name="fuente"
                          title="Fuente de financiamiento" from="${fuentes}" optionKey="id"
                          value="${asignacionInstance?.fuente?.id}" noSelection="['null': '']"/>
                %{----}%
            </td>

        </tr>
        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'presupuesto', 'error')}">

            <td class="label " valign="middle">
                <g:message code="asignacion.presupuesto.label" default="Presupuesto"/>:
                %{----}%
            </td>
            <td class="indicator">
                &nbsp;
            </td>
            <td class="" valign="middle">
                <input type="hidden" class="prsp" value="${asignacionInstance?.presupuesto?.id}" id="prsp2" name="presupuesto.id">
                <input type="text" id="prsp_desc2" desc="desc2" style="width: 100px;border: 1px solid black" class="buscarAgr ui-corner-all">
                <span style="font-size: smaller;">Haga clic para consultar</span>
                <div id="desc2" style="width: 300px;font-size: 10px;text-align: left"></div>
                %{--<g:select class="field ui-widget-content ui-corner-all" name=""--}%
                %{--title="Partida presupuestaria" from="${mies.Presupuesto.list()}" optionKey="id"--}%
                %{--noSelection="['null': '']"/>--}%
                %{----}%
            </td>

        </tr>

        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'planificado', 'error')}">

            <td class="label  mandatory" valign="middle">
                <g:message code="asignacion.planificado.label" default="Valor"/>:
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class=" mandatory" valign="middle">
                <g:textField class="field number required ui-widget-content ui-corner-all" name="valor"
                             title="Planificado" id="vlor"
                             value='${formatNumber(number:asignacionInstance.getValorReal(),format:"###,##0",minFractionDigits:2,maxFractionDigits:2)}'/>
            </td>

        </tr>

        <tr class="prop ">

            <td class="label  mandatory" valign="middle">
                Autorización
            </td>
            <td class="indicator mandatory">
                <span class="indicator">*</span>
            </td>
            <td class=" mandatory" valign="middle">
                <input type="file" name="archivo">
            </td>

        </tr>


        <tr>
            <td colspan="6" class="blanco">&nbsp;</td>
        </tr>
    </table>
    <div id="buscarAgr">
        <input type="hidden" id="id_txt">
        <input type="hidden" id="id_desc">
        <div>
            Buscar por:
            <select id="tipo">
                <option value="1">Número</option>
                <option value="2">Descripción</option>
            </select>
            <input type="text" id="par2" style="width: 160px;"><a href="#" class="btn" id="btn_buscarAgr">Buscar</a>
        </div>

        <div id="resultadoAgr" style="width: 480px;margin-top: 10px;" class="ui-corner-all"></div>
    </div>
    <script type="text/javascript">
        $(".btn").button()
        $(".buscarAgr").click(function() {
            $("#id_txt").val($(this).attr("id"))
            $("#id_desc").val($(this).attr("desc"))
            $("#buscarAgr").dialog("open")
        });
        $("#btn_buscarAgr").click(function() {
            $.ajax({
                type: "POST",
                url: "${createLink(action:'buscarPresupuesto',controller:'asignacion')}",
                data: "parametro=" + $("#par2").val() + "&tipo=" + $("#tipo").val(),
                success: function(msg) {
                    $("#resultadoAgr").html(msg)
                }
            });
        });
        $("#buscarAgr").dialog({
            title:"Cuentas presupuestarias",
            width:520,
            height:480,
            autoOpen:false,
            modal:true
        })
    </script>
</g:form>
