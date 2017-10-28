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
    
<table width="100%" class="ui-widget-content ui-corner-all">
    <tbody>
        <tr>
            <td class="label  " valign="middle">
                <g:message code="persona.cedula.label" default="Cédula"/>
            </td>
            <td class=" " valign="middle">
                ${usuario.persona?.cedula}
            </td>

            <td class="label  " valign="middle">
                <g:message code="persona.nombre.label" default="Nombre"/>
            </td>
            <td class=" " valign="middle">
                ${usuario.persona?.nombre}
            </td>
        </tr>

        <tr>

            <td class="label  " valign="middle">
                <g:message code="persona.apellido.label" default="Apellido"/>
            </td>

            <td class=" " valign="middle">
                ${usuario.persona?.apellido}
            </td>

            <td class="label  " valign="middle">
                <g:message code="persona.sexo.label" default="Sexo"/>
            </td>

            <td class=" " valign="middle">
                ${usuario.persona?.sexo}
            </td>

        </tr>

        <tr>

            <td class="label " valign="middle">
                <g:message code="persona.discapacitado.label" default="Discapacitado"/>
            </td>

            <td class="" valign="middle">
                ${(usuario.persona?.discapacitado == 0 || usuario.persona?.discapacitado == "0") ? 'No' : 'Sí'}
            </td>

            <td class="label " valign="middle">
                <g:message code="persona.fechaNacimiento.label" default="Fecha Nacimiento"/>
            </td>

            <td class="" valign="middle">
                ${usuario.persona?.fechaNacimiento?.format('dd-MM-yyyy')}
            </td>

        </tr>

        <tr>

            <td class="label " valign="middle">
                <g:message code="persona.direccion.label" default="Dirección"/>
            </td>

            <td class="" valign="middle">
                ${usuario.persona?.direccion}
            </td>

            <td class="label " valign="middle">
                <g:message code="persona.telefono.label" default="Teléfono"/>
            </td>

            <td class="" valign="middle">
                ${usuario.persona?.telefono}
            </td>

        </tr>

        <tr>

            <td class="label " valign="middle">
                <g:message code="persona.mail.label" default="Mail"/>
            </td>

            <td class="" valign="middle">
                ${usuario.persona?.mail}
            </td>

            <td class="label " valign="middle">
                <g:message code="persona.fax.label" default="Fax"/>
            </td>

            <td class="" valign="middle">
                ${usuario.persona?.fax}
            </td>

        </tr>

        <tr>

            <td class="label " valign="middle">
                <g:message code="persona.observaciones.label" default="Observaciones"/>
            </td>

            <td class="" valign="middle" colspan="4">
                ${usuario.persona?.observaciones}
            </td>

        </tr>

    </tbody>
</table>

<table width="100%" class="ui-widget-content ui-corner-all">

    <tbody>

        <tr>

            <td class="label " valign="middle">
                <g:message code="usro.unidad.label" default="Unidad"/>
            </td>

            <td class="" valign="middle">
                <g:link class="linkArbol" tipo="unidad_${usuario.unidad.id}">
                    ${usuario?.unidad?.nombre}
                </g:link>
            </td>

            <td class="label " valign="middle">
                <g:message code="usro.cargoPersonal.label" default="Cargo Personal"/>
            </td>

            <td class="" valign="middle">
                ${usuario?.cargoPersonal?.id}
            </td>

        </tr>

        <tr>

            <td class="label  " valign="middle">
                <g:message code="usro.usroLogin.label" default="Usuario"/>
            </td>

            <td class=" " valign="middle">
                ${usuario?.usroLogin}
            </td>

        </tr>

        <tr>

            <td class="label  " valign="middle">
                <g:message code="usro.sigla.label" default="Sigla"/>
            </td>

            <td class=" " valign="middle">
                ${usuario?.sigla}
            </td>

            <td class="label  " valign="middle">
                <g:message code="usro.usroActivo.label" default="Activo"/>
            </td>

            <td class=" " valign="middle">
                ${(usuario?.usroActivo == 0 || usuario?.usroActivo == "0") ? 'No' : 'Sí'}
            </td>

        </tr>

        <tr>

            <td class="label " valign="middle">
                <g:message code="usro.fechaPass.label" default="Fecha cambio contraseña"/>
            </td>

            <td class="" valign="middle">
                ${usuario?.fechaPass?.format('dd-MM-yyyy')}
            </td>

        </tr>

        <tr>

            <td class="label " valign="middle">
                <g:message code="usro.observaciones.label" default="Observaciones"/>
            </td>

            <td class="" valign="middle" colspan="4">
                ${usuario?.observaciones}
            </td>

        </tr>

        <tr>
            <td class="label " valign="middle" rowspan="2">
                Perfiles
            </td>
        </tr>
        <tr>
            <td>
                <ul style="margin-top: 5px; margin-bottom: 5px; padding-left: 20px;">
                    <g:each in="${perfiles}" var="perfil">
                        <li>
                            ${perfil}
                        </li>
                    </g:each>
                </ul>
            </td>
        </tr>

    </tbody>
</table>