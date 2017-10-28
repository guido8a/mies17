<%@ page import="mies.Zona" %>
<table>
    <tbody>

        <tr>
            <td class="label">
                <g:message code="zona.numero.label"
                           default="Numero"/>
            </td>
            <td class="campo">
                ${fieldValue(bean: zonaInstance, field: "numero")}
            </td> <!-- campo -->

        </tr>

        <tr>
            <td class="label">
                <g:message code="zona.nombre.label"
                           default="Nombre"/>
            </td>
            <td class="campo">
                ${fieldValue(bean: zonaInstance, field: "nombre")}
            </td> <!-- campo -->
        </tr>

    </tbody>
</table>