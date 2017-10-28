<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Solicitudes de modificación aprobadas</title>
    </head>

    <body>

        <g:if test="${flash.message}">
            <div class="${flash.clase}">${flash.message}</div>
        </g:if>

        <div class="list" style="width: 800px;">
            <g:if test="${mods}">
                <table style="width: 800px;">
                    <thead>
                        <tr>
                            <td class="ui-state-default" style="width: 90px;">Fecha</td>
                            <td class="ui-state-default">Proyecto</td>
                            <td class="ui-state-default">Tipo</td>
                            <td class="ui-state-default" style="width: 200px;">Descripcion</td>
                            <td class="ui-state-default" style="width: 40px;">Ver</td>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${mods}" status="i" var="mod">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td style="width: 90px;">${mod?.fechaAprobacion?.format("dd/MM/yyyy")}</td>
                                <td title="${mod?.informe?.responsableProyecto?.proyecto?.nombre}"
                                    style="width: 200px;">${mod?.informe?.responsableProyecto?.proyecto?.codigoProyecto}</td>
                                <td>${mod.tipoModificacion.descripcion}</td>
                                <td>${mod?.descripcion}</td>
                                <td style="text-align: center;width: 40px;">
                                    <g:link action="usarModificacion" id="${mod?.id}" class="btn">
                                        Usar
                                    </g:link>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:else>
                No hay solicitudes aprobadas
            </g:else>
        </div>
        <script type="text/javascript">
            $(".btn").button()
        </script>
    </body>
</html>