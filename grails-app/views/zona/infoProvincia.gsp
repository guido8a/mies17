<%@ page import="mies.Provincia" %>
<table>
    <tbody>

        <tr>
            <td class="label">
                <g:message code="provincia.zona.label"
                           default="Zona"/>
            </td>
            <td class="campo">
                <g:link class="linkArbol" tipo="zona_${provinciaInstance.zona.id}" controller="zona" action="show"
                        id="${provinciaInstance?.zona?.id}">
                    ${provinciaInstance?.zona?.encodeAsHTML()}
                </g:link>
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">
                <g:message code="provincia.region.label"
                           default="Region"/>
            </td>
            <td class="campo">
                ${provinciaInstance?.region?.encodeAsHTML()}
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">
                <g:message code="provincia.numero.label"
                           default="Numero"/>
            </td>
            <td class="campo">
                ${fieldValue(bean: provinciaInstance, field: "numero")}
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">
                <g:message code="provincia.nombre.label"
                           default="Nombre"/>
            </td>
            <td class="campo">
                ${fieldValue(bean: provinciaInstance, field: "nombre")}
            </td> <!-- campo -->
        </tr>

    </tbody>
</table>