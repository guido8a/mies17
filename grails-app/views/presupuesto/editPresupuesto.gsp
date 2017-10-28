<%@ page import="mies.Presupuesto" %>

<g:form action="save" class="frm_editar" method="post">
    <g:hiddenField name="id" value="${presupuestoInstance?.id}"/>
    <g:hiddenField name="version" value="${presupuestoInstance?.version}"/>

    <g:hiddenField name="presupuesto.id" value="${presupuestoPadre?.id}"/>
    <g:hiddenField name="nivel" value="${lvl}"/>

    <table class="show ui-widget-content ui-corner-all">
        <tbody>
            <tr class="prop ${hasErrors(bean: presupuestoInstance, field: 'presupuesto', 'error')}">
                <td class="label " valign="middle">
                    Padre:
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    ${presupuestoPadre}
                </td>
            </tr>

            <tr>
                <td class="label  mandatory" valign="middle">
                    Nivel:
                </td>

                <td class="indicator mandatory">
                    &nbsp;
                </td>

                <td class=" mandatory" valign="middle">
                    ${lvl}
                </td>
            </tr>

            <tr>
                <td class="label " valign="middle">
                    Número:
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">

                    <g:if test="${!presupuestoInstance.id}">
                        <g:textField name="numero" id="numero"
                                     title="${Presupuesto.constraints.numero.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="15"
                                     value="${presupuestoInstance?.numero}"/>
                    </g:if>
                    <g:else>
                        ${presupuestoInstance?.numero}
                    </g:else>
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: presupuestoInstance, field: 'descripcion', 'error')}">
                <td class="label " valign="middle">
                    Descripción:
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:textArea name="descripcion" id="descripcion" cols="5" rows="5"
                                title="${Presupuesto.constraints.descripcion.attributes.mensaje}"
                                class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255"
                                style="width: 500px; height: 40px;" value="${presupuestoInstance?.descripcion}"/>
                </td>
            </tr>

            <tr class="prop ${hasErrors(bean: presupuestoInstance, field: 'movimiento', 'error')}">
                <td class="label " valign="middle">
                    Movimiento:
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:if test="${hijos == 0}">
                        <select name='movimiento'>
                            <option value="0" ${(presupuestoInstance?.movimiento == 0) ? 'selected' : ''}>No</option>
                            <option value="1" ${(presupuestoInstance?.movimiento == 1) ? 'selected' : ''}>Si</option>
                        </select>
                    </g:if>
                    <g:else>
                        ${(presupuestoInstance?.movimiento == 0) ? 'NO' : ''}
                    </g:else>
                </td>
            </tr>

            <tr>
                <td colspan="6" class="blanco">&nbsp;</td>
            </tr>
        </tbody>
    </table>
</g:form>
