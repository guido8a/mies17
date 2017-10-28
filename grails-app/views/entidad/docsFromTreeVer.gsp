<%@ page import="mies.Documento" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <g:set var="entityName"
               value="${message(code: 'documento.label', default: 'Documento')}"/>
        <title><g:message code="default.show.label" args="[entityName]"/></title>

        <style type="text/css">
        .label {
            width : auto;
        }
        </style>

    </head>

    <body>
        <div class="body">
            <g:if test="${flash.message}">
                <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
            </g:if>
            <div>

                <table width="750px;">
                    <tbody>
                        <tr class="prop ${hasErrors(bean: documentoInstance, field: 'id', 'error')}">
                            <td class="label" style="width: 20%;">
                                <g:message code="documento.unidadEjecutora.label"
                                           default="Unidad Ejecutora"/>
                            </td>

                            <td colspan="3">
                                ${documentoInstance?.unidadEjecutora?.nombre?.encodeAsHTML()}
                            </td> <!-- campo -->
                        </tr>

                        <tr class="prop ${hasErrors(bean: documentoInstance, field: 'grupoProcesos', 'error')}">
                            <td class="label" style="width: 20%;">
                                <g:message code="documento.descripcion.label"
                                           default="Descripcion"/>
                            </td>

                            <td style="width: 30%;">
                                ${fieldValue(bean: documentoInstance, field: "descripcion")}
                            </td> <!-- campo -->
                        </tr>

                        <tr class="prop ${hasErrors(bean: documentoInstance, field: 'clave', 'error')}">
                            <td class="label">
                                <g:message code="documento.clave.label"
                                           default="Clave"/>
                            </td>

                            <td>
                                ${fieldValue(bean: documentoInstance, field: "clave")}
                            </td> <!-- campo -->

                            <td class="label">
                                <g:message code="documento.resumen.label"
                                           default="Resumen"/>
                            </td>

                            <td>
                                ${fieldValue(bean: documentoInstance, field: "resumen")}
                            </td> <!-- campo -->
                        </tr>

                        <tr class="prop ${hasErrors(bean: documentoInstance, field: 'documento', 'error')}">
                            <td class="label">
                                <g:message code="documento.documento.label"
                                           default="Documento"/>
                            </td>

                            <td colspan="3">
                                <g:link action="docsFromTreeDownload" id="${documentoInstance.id}"
                                        class="button download" params="${[unidad:unidad.id]}">
                                    ${fieldValue(bean: documentoInstance, field: "documento")}
                                </g:link>
                            </td> <!-- campo -->
                    </tbody>
                </table>
            </div>
        </div> <!-- body -->

    </body>
</html>
