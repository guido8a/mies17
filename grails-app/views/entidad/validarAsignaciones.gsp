<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/6/12
  Time: 4:08 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.Anio; mies.Presupuesto; mies.MarcoLogico; mies.UnidadEjecutora" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>
            Validación de las asignaciones
        </title>
        <style type="text/css">
        table {
            border-collapse : collapse;
        }
        </style>
    </head>

    <body>
        <p>
            Se han encontrado errores en los siguientes registros de asignaciones. Por favos soluciónelos.
        </p>

        <table border="1" width="100%">
            <thead>
                <tr>
                    <th>
                        Unidad ejecutora
                    </th>
                    <th>
                        A&ntilde;o
                    </th>
                    <th>
                        Marco lógico
                    </th>
                    <th>
                        Plan presupuestario
                    </th>
                    <th>
                        Planificado
                    </th>
                    <th>
                        Sumatoria meses
                    </th>
                    <th>
                        Diferencia
                    </th>
                    <th>
                        Ir
                    </th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${res}" var="r" status="i">
                    <tr>
                        <td>
                            <g:if test="${r.unej}">
                                ${UnidadEjecutora.get(r.unej).nombre}
                            </g:if>
                        </td>

                        <td>
                            <g:if test="${r.anio}">
                                ${Anio.get(r.anio).anio}
                            </g:if>
                        </td>

                        <td>
                            <g:if test="${r.mrlg}">
                                ${MarcoLogico.get(r.mrlg).objeto}
                            </g:if>
                        </td>

                        <td>
                            <g:if test="${r.prsp}">
                                ${Presupuesto.get(r.prsp).numero} - ${Presupuesto.get(r.prsp).descripcion}
                            </g:if>
                        </td>

                        <td>
                            <g:formatNumber number="${r.plan}" format="###,##0" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>

                        <td>
                            <g:formatNumber number="${r.valor}" format="###,##0" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>

                        <td>
                            <g:formatNumber number="${r.resta}" format="###,##0" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>

                        <td>
                            <g:if test="${!r.mrlg}">
                                <g:link class="button" controller="asignacion" action="programacionAsignaciones" id="${r.unej}" params="${[anio:r.anio]}">Ir</g:link>
                            </g:if>
                            <g:else>
                            %{--
                            TODO: conseguir el id del proyecto para poder hacer el link
                            --}%
                            %{--<g:link controller="asignacion" action="programacionAsignacionesInversion" id="${r.unej}" params="${[anio:r.anio]}">Ir</g:link>--}%
                            </g:else>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <script type="text/javascript">
            $(function () {
                $(".button").button({
                    icons:{
                        primary:"ui-icon-arrowrefresh-1-s"
                    }
                });
            });
        </script>

    </body>
</html>