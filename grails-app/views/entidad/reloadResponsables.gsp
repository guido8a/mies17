<table width="100%" class="ui-widget-content ui-corner-all">
    <thead>
        <tr>
            <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                Responsables actuales
            </td>
        </tr>
        <tr>
            <th>Responsable</th>
            <th>Tipo</th>
            <th>Desde</th>
            <th>Hasta</th>
            <th>Observaciones</th>
            <th width="35">&nbsp;</th>
        </tr>
    </thead>

    <tbody id="tbResponsables">
        <g:each in="${responsables}" var="res">
            <tr class="${res.tipo.id}_${res.responsable.id}" id="${res.id}">
                <td class="responsable" id="${res.responsable.id}">
                    ${res.responsable.persona.nombre} ${res.responsable.persona.apellido}
                </td>
                <td class="tipo" id="${res.tipo.descripcion}">
                    ${res.tipo.descripcion}
                </td>
                <td class="desde">
                    ${res.desde.format("dd-MM-yyyy")}
                </td>
                <td class="hasta">
                    ${res.hasta.format("dd-MM-yyyy")}
                </td>
                <td class="observaciones">
                    ${res.observaciones}
                </td>
                <td>
                    <a href="#" class="btnDeleteRes" id="dl_${res.id}">Dar de baja</a>
                    %{--<a href="#" class="btnUpdateRes" id="up_${res.id}">Editar</a>--}%
                </td>
            </tr>
        </g:each>
    </tbody>
</table>