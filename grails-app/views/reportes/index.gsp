<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/15/11
  Time: 12:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Reportes</title>
    </head>

    <body>

        <table>
            <tr>
                <td>
                    <g:link class="boton" action="avanceGUI">Avance de proyectos con indicadores y metas</g:link>
                </td>

                <td>
                    <g:link class="boton" action="intervencionGUI">Intervenci&oacute;n e inversi&oacute;n del MIES</g:link>
                </td>

                <td>
                    <g:link class="boton" action="fichaProyectoGUI">Ficha de proyecto</g:link>
                </td>

                <td>
                    <g:link class="boton" action="fichaMarcoLogicoGUI">Ficha de marco l&oacute;gico de proyecto</g:link>
                </td>
            </tr>

            <tr>
                <td>
                    <g:link class="boton" action="marcoLogicoGUI">Marco l&oacute;gico de proyecto</g:link>
                </td>

                <td>
                    <g:link class="boton" action="metasGUI">Metas</g:link>
                </td>

                <td>
                    <g:link class="boton" action="modificacionesProyectoGUI">Modificaciones proyecto</g:link>
                </td>

                <td>
                    <g:link class="boton" action="poaGUI">P.O.A.</g:link>
                </td>
            </tr>

            <tr>
                <td>
                    <g:link class="boton" action="poaInversionesGUI">P.O.A. Inversiones</g:link>
                </td>

                <td>
                    <g:link class="boton" action="poaCorrientesGUI">P.O.A. Corrientes</g:link>
                </td>

                <td>
                    <g:link class="boton" action="ejecucionProyectosGUI">Ejecuci&oacute;n presupuestaria proyectos</g:link>
                </td>

                <td>
                    <g:link class="boton" action="componentesGUI">Componentes de proyectos</g:link>
                </td>
            </tr>

            <tr>
                <td>
                    <g:link class="boton" action="pacGUI">P.A.C.</g:link>
                </td>

                <td>
                    <g:link class="boton" controller="reportes2" action="usuariosGUI">Usuarios</g:link>
                </td>

                <td>
                    <g:link class="boton" controller="reportes2" action="techosGUI">Techos</g:link>
                </td>

                <td>
                    <g:link class="boton" controller="reportes" action="reasignacion" target="_blank">Reasignacion</g:link>
                    <g:link class="boton" controller="reportes" action="reasignacionXls">Excel</g:link>
                </td>
            </tr>

            <tr>
                <td>
                    <g:link class="boton" controller="reportes" action="reasignacionDetallado" target="_blank">Reasignacion detallado</g:link>
                    <g:link class="boton" controller="reportes" action="reasignacionDetalladoXls">Excel</g:link>
                </td>

                <td>
                    <g:link class="boton" controller="reportes" action="reasignacionAgrupado" target="_blank">Consolidado asignaciones</g:link>
                    <g:link class="boton" controller="reportes" action="reasignacionAgrupadoXls">Excel</g:link>
                </td>
                <td>
                    <g:link class="boton" controller="reportes" action="reporteCertificaciones" target="_blank">Certificaciones</g:link>
                    <g:link class="boton" controller="pdf" action="pdfLink" params="[url:g.createLink(action: 'reporteCertificaciones'),filename:'Certificaciones.pdf']">PDF</g:link>
                </td>
                <td>
                    <g:link class="boton" controller="reportes2" action="totales" target="_blank">Total asignaciones</g:link>
                    <g:link class="boton" controller="pdf" action="pdfLink" params="[url:g.createLink(action: 'totales',controller: 'reportes2'),filename:'totales.pdf']">PDF</g:link>
                </td>
            </tr>




        </table>

        <script type="text/javascript">
            $(".boton").button().css("margin", "3px");
        </script>
    </body>

</html>