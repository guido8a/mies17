<%@ page import="mies.Politica; mies.ObjetivoGobiernoResultado; mies.ObjetivoEstrategicoProyecto; com.sun.jndi.ldap.Obj; mies.EjeProgramatico; mies.PresupuestoUnidad; mies.Anio" %>

<g:set var="anio" value="${new Date().format('yyyy')}"/>
<g:set var="anioObj" value="${Anio.findByAnio(anio)}"/>
<g:set var="presupuesto" value="${PresupuestoUnidad.findByAnioAndUnidad(anioObj, unidad)}"/>
<style type="text/css">
#selObjetivoGob-button {
    height : 50px !important;
}
</style>

<g:form action="save" class="frm_editar" method="post">
    <g:hiddenField name="unidad" value="${unidad?.id}"/>
    <g:hiddenField name="esUsuario" value="2"/>
    <g:hiddenField name="presId" value="${presupuesto?.id}"/>
    <table width="100%">
        <tbody>
        <tr class="prop">
            <td class="label">A&ntilde;o</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td colspan="4">
                <g:select from="${Anio.list([sort:'anio'])}" name="anio.id" id="selAnio" optionKey="id" optionValue="anio"
                          value="${anioObj.id}" class="ui-widget-content ui-corner-all" style="width: 80px;"/>
            </td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Max. Inversi&oacute;n:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td>
                %{--<input type="number" name="maxInversion" class="ui-widget-content ui-corner-all" id="maxInversion"--}%
                       %{--value="${presupuesto ? g.formatNumber(number: presupuesto.maxInversion, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>--}%
                <g:textField name="maxInversion" class="ui-widget-content ui-corner-all validacionNumeroSinPuntos" id="maxInversion"
                             value="${presupuesto ? g.formatNumber(number: presupuesto.maxInversion, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>
            </td> <!-- campo -->

            <td class="label">Max. Corrientes:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td>
                <g:if test="${presupuesto}">
                    <g:if test="${presupuesto.aprobadoCorrientes==0}">
                        %{--<input type="number" name="maxCorrientes" class="ui-widget-content ui-corner-all" id="maxCorrientes"--}%
                               %{--value="${presupuesto ? g.formatNumber(number: presupuesto.maxCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>--}%
                        <g:textField name="maxCorrientes" class="ui-widget-content ui-corner-all validacionNumeroSinPuntos" id="maxCorrientes"
                                     value="${presupuesto ? g.formatNumber(number: presupuesto.maxCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>
                    </g:if>
                    <g:else>
                       ${g.formatNumber(number: presupuesto.maxCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2)}
                    </g:else>
                </g:if>
                <g:else>
                    <g:textField name="maxCorrientes" class="ui-widget-content ui-corner-all validacionNumeroSinPuntos" id="maxCorrientes"  value="${0.00}"/>
                    %{--<input type="number" name="maxCorrientes" class="ui-widget-content ui-corner-all" id="maxCorrientes"  value=""/>--}%
                </g:else>
            </td> <!-- campo -->
        </tr>
        <tr class="prop">
            <td class="label">Original inversión:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td>
                %{--<input type="number" name="originalInversion" class="ui-widget-content ui-corner-all" id="orgInversion"--}%
                       %{--value="${presupuesto ? g.formatNumber(number: presupuesto.originalCorrientes, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>--}%
                <g:textField name="originalInversion" class="ui-widget-content ui-corner-all validacionNumeroSinPuntos" id="orgInversion"
                             value="${presupuesto ? g.formatNumber(number: presupuesto.originalCorrientes, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>
            </td> <!-- campo -->

            <td class="label">Original corrientes:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td>
                %{--<input type="number" name="originalCorrientes" class="ui-widget-content ui-corner-all" id="orgCorrientes"--}%
                       %{--value="${presupuesto ? g.formatNumber(number: presupuesto.originalCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>--}%
                <g:textField name="originalCorrientes" class="ui-widget-content ui-corner-all validacionNumeroSinPuntos" id="orgCorrientes"
                             value="${presupuesto ? g.formatNumber(number: presupuesto.originalCorrientes, format: "###,##0", maxFractionDigits: 2, minFractionDigits: 2) : ''}"/>
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">Objetivo gobierno resultado:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td colspan="4">
                <g:select from="${ObjetivoGobiernoResultado.list([sort:'descripcion'])}" name="objetivoGobiernoResultado.id" id="selObjetivoGob" optionKey="id" optionValue="descripcion"
                          value="${presupuesto?.objetivoGobiernoResultado?.id}" class="ui-widget-content ui-corner-all combo" style="width: 550px;"/>
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">Objetivo estrat&eacute;gico:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td colspan="4">
                <g:select from="${ObjetivoEstrategicoProyecto.list([sort:'descripcion'])}" name="objetivoEstrategico.id" id="selObjetivoEst" optionKey="id" optionValue="descripcion"
                          value="${presupuesto?.objetivoEstrategico?.id}" class="ui-widget-content ui-corner-all" style="width: 550px"/>
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">Eje program&aacute;tico:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td colspan="4">
                <g:select from="${EjeProgramatico.list([sort:'descripcion'])}" name="ejeProgramatico.id" id="selEje" optionKey="id" optionValue="descripcion"
                          value="${presupuesto?.ejeProgramatico?.id}" class="ui-widget-content ui-corner-all" style="width: 550px"/>
            </td> <!-- campo -->

        </tr>

        <tr>
            <td class="label">Pol&iacute;tica MIES:</td>

            <td class="indicator">
                &nbsp;
            </td>

            <td colspan="4">
                <g:select from="${Politica.list([sort:'descripcion'])}" name="politica.id" id="selPolitica" optionKey="id" optionValue="descripcion"
                          value="${presupuesto?.politica?.id}" class="ui-widget-content ui-corner-all" style="width: 550px"/>
            </td> <!-- campo -->
        </tr>

        </tbody>
    </table>

</g:form>


<script type="text/javascript">




    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 188);
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });


    function reload() {

        var anioId = $("#selAnio").val();
        var unidadId = ${unidad.id};

        $.ajax({
            type:"POST",
            url:"${createLink(action: 'getPresupuestoAnio')}",
            data:{
                anio:anioId,
                unidad:unidadId
            },
            success:function (msg) {
                var parts = msg.split("_");

                $("#presId").val(parts[0]);
                $("#maxCorrientes").val(parts[1]);
                $("#maxInversion").val(parts[2]);
                $("#orgCorrientes").val(parts[7]);
                $("#orgInversion").val(parts[8]);
//                $("#selEje").selectmenu("value", parts[3]);
//                $("#selObjetivoEst").selectmenu("value", parts[4]);
//                $("#selObjetivoGob").selectmenu("value", parts[5]);
//                $("#selPolitica").selectmenu("value", parts[6]);
                $("#selEje").val(parts[3]);
                $("#selObjetivoEst").val(parts[4]);
                $("#selObjetivoGob").val(parts[5]);
                $("#selPolitica").val(parts[6]);
            }
        });
    }

    $(function () {
        reload();
//        $("#selAnio").selectmenu({width:80});
//        $("#selEje").selectmenu({width:540});
//        $("#selObjetivoEst").selectmenu({width:540});
//        $("#selObjetivoGob").selectmenu({width:540});
//        $("#selPolitica").selectmenu({width:540});

        $("#selAnio").change(function () {
            reload();
        });
    });
</script>
