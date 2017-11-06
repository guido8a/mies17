<g:form method="post" enctype="multipart/form-data" class="frm_doc" action="uploadDoc">
    <g:hiddenField name="id" value="${proyecto.id}"/>
    <table width="100%" class="ui-widget-content ui-corner-all">

        <g:hiddenField name="doc" value="${documentoInstance?.id}"/>

        <tbody>
            <tr class="prop ${hasErrors(bean: documentoInstance, field: 'grupoProcesos', 'error')}">
                <td class="label " valign="middle">
                    %{--<g:message code="documento.grupoProcesos.label" default="Grupo Procesos"/>--}%
                    Grupo Procesos
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:select class="field ui-widget-content ui-corner-all" name="grupoProcesos.id"
                              title="grupoProcesos" from="${mies.GrupoProcesos.list()}" optionKey="id"
                              value="${documentoInstance?.grupoProcesos?.id}" noSelection="['null': '']"/>
                </td>
            </tr>
            <tr class="prop ${hasErrors(bean: documentoInstance, field: 'descripcion', 'error')}">
                <td class="label " valign="middle">
                    %{--<g:message code="documento.descripcion.label" default="Descripción"/>--}%
                    Descripción
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="descripcion" id="descripcion" title="descripcion"
                                 class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="63"
                                 value="${documentoInstance?.descripcion}"/>
                </td>
            </tr>
            <tr class="prop ${hasErrors(bean: documentoInstance, field: 'clave', 'error')}">
                <td class="label " valign="middle">
                    Palabras clave
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textField name="clave" id="clave" title="clave"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="63" value="${documentoInstance?.clave}"/>
                </td>
            </tr>
            <tr class="prop ${hasErrors(bean: documentoInstance, field: 'resumen', 'error')}">
                <td class="label " valign="middle">
                    %{--<g:message code="documento.resumen.label" default="Resumen"/>--}%
                    Resumen
                </td>
                <td class="indicator">
                    &nbsp;
                </td>
                <td class="campo" valign="middle">
                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1024"
                                name="resumen" id="resumen" title="resumen" cols="40" rows="5"
                                value="${documentoInstance?.resumen}" style="resize: none"/>
                </td>
            </tr>

            <g:if test="${!documentoInstance}">
                <tr class="prop ${hasErrors(bean: documentoInstance, field: 'documento', 'error')}">
                    <td class="label " valign="middle">
                        %{--<g:message code="documento.documento.label" default="Documento"/>--}%
                        Documento
                    </td>
                    <td class="indicator">
                        &nbsp;
                    </td>
                    <td class="campo" valign="middle">
                        <input type="file" id="fileUpload" name="fileUpload" title="documento"
                               class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255"/>
                    </td>
                </tr>
            </g:if>

        </tbody>
    </table>
</g:form>