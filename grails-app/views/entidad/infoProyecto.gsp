<%@ page import="mies.Persona" %>

<style type="text/css">
.label {
    width   : 90px !important;
    padding : 0;
}

td {
    width : 120px;
}
</style>

<table width="100%">
    <tbody>
        <tr>
            <td class="label  " valign="middle">
                Nombre
            </td>
            <td class=" " valign="middle">
                ${proyecto?.nombre}
            </td>
        </tr>

        <tr>
            <td class="label  " valign="middle">
                C&oacute;digo
            </td>
            <td class=" " valign="middle">
                ${proyecto.codigoProyecto}
            </td>
        </tr>

        <tr>
            <td class="label " valign="middle">
                C&oacute;digo eSIGEF
            </td>
            <td class="" valign="middle">
                ${proyecto.codigoEsigef}
            </td>
        </tr>

        <tr>
            <td class="label " valign="middle">
                Monto
            </td>
            <td class="" valign="middle">
                <g:formatNumber number="${proyecto.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"></g:formatNumber>

            </td>
        </tr>


        <tr>
            <td class="label " valign="middle">
                Programa presupuestario
            </td>
            <td class="" valign="middle">
                ${proyecto.programaPresupuestario.descripcion}
            </td>
        </tr>

    </tbody>
</table>