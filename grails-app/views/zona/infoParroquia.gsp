<%@ page import="mies.Parroquia" %>
<table>
    <tbody>

        <tr>
            <td class="label">
                <g:message code="parroquia.canton.label" default="Cantón"/>
            </td>
            <td class="campo">
                <g:link class="linkArbol" tipo="canton_${parroquiaInstance.canton.id}" controller="canton" action="show"
                        id="${parroquiaInstance?.canton?.id}">
                    ${parroquiaInstance?.canton?.encodeAsHTML()}
                </g:link>
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">
                <g:message code="parroquia.numero.label" default="Número"/>
            </td>
            <td class="campo">
                ${fieldValue(bean: parroquiaInstance, field: "numero")}
            </td> <!-- campo -->
        </tr>

        <tr>
            <td class="label">
                <g:message code="parroquia.nombre.label"
                           default="Nombre"/>
            </td>
            <td class="campo">
                ${fieldValue(bean: parroquiaInstance, field: "nombre")}
            </td> <!-- campo -->

        </tr>
    <tr>
        <td class="label">
            <g:message code="parroquia.codigo.label"
                       default="Código"/>
        </td>
        <td class="campo">
            ${fieldValue(bean: parroquiaInstance, field: "codigo")}
        </td> <!-- campo -->

    </tr>

    </tbody>
</table>