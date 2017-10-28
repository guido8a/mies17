<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/10/11
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        Ejecución Presupuestaria
    </title>

    <style type="text/css">
    @page {
        size: 29.7cm 21cm;  /*width height */
        margin: 2cm;
    }

    .hoja {
        width: 28cm;
    }

    .titulo {
        width: 25.7cm;
    }

    .hoja {
        /*background  : #e6e6fa;*/
        height: 17cm; /*29.7-(1.5*2)*/
        font-family: arial;
        font-size: 10pt;
    }

    th {
        background: #cccccc;
    }

    tbody tr:nth-child(2n+1) {
        background: none repeat scroll 0 0 #E1F1F7;
    }

    tbody tr:nth-child(2n) {
        background: none repeat scroll 0 0 #F5F5F5;
    }
    </style>
</head>

<body>

<div class="hoja">
    <h2>Comparación de valores asignados en el POA corrientes con el ESIGEF</h2>
    <table border="1" width="80%">
        <thead>

        <tr>
            <th width="30%">
                Partida
            </th>
            <th width="20%">
                Fuente
            </th>
            <th width="20%">
                Vigente
            </th>
            <th width="20%">
                Planificado
            </th>
            <th>
                Diferencia
            </th>
        </tr>
        </thead>
        <tbody>
        <g:set var="prog" value=""></g:set>
        <g:each in="${resultado}" var="r" status="i">
            <g:set var="dif" value="${0}"></g:set>
            <g:if test="${prog!=r.programa.toString()}">
                <tr>
                    <td width="10%" colspan="5">
                        <b>Programa: ${r.programa}</b>
                    </td>
                </tr>
            </g:if>
            <g:set var="prog" value="${r.programa.toString()}"></g:set>
            <tr>
                <td>
                    ${r.presupuesto}
                </td>

                <td>
                    ${r.fuente}
                </td>

                <td style="text-align: right">
                    <g:formatNumber number="${(r.vigente)}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>

                </td>
                <td style="text-align: right">
                    <g:if test="${datos[r.programa?.id?.toString()]}">

                        <g:if test="${datos[r.programa?.id?.toString()][r.presupuesto?.id?.toString()]}">
                            <g:formatNumber number="${datos[r.programa?.id?.toString()][r.presupuesto?.id?.toString()]}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                            <g:set var="dif" value="${datos[r.programa?.id?.toString()][r.presupuesto?.id?.toString()]}"></g:set>
                           %{----> ${r.programa?.id?.toString()} ${r.presupuesto.numero}--}%
                        </g:if>

                    %{-->--}%
                    </g:if>
                    <g:else>
                        %{--Buscando ${r.programa?.id} : ${r.presupuesto?.id} ==> ${datos[r.programa?.id]}--}%
                        Sin dato
                    </g:else>


                </td>
                <td style="text-align: right">
                    <g:formatNumber number="${r.vigente-dif.toDouble()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>

                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function() {

        $("#tipo").buttonset();
        $("#botones").buttonset();
        $("#aPrfl").button();

        $("#reversar").button().click(function() {
            var data = armar();
            if (confirm("Reversar la modificación en la asignación?")) {
                $.ajax({
                    type: "POST", url: "${createLink(controller:'modificacion', action:'reversaAsignacion')}",
                    data: "&ids=" + data,
                    success: function(msg) {
                        alert(msg)
                    }
                });
            }
        });



        $("#consultar").button().click(function() {
            if (confirm("Consultar?")) {
                $("#valores").submit()
            }
        });

        $("#cargaMdas").button().click(function() {
            //alert("crear un perfil");
            if (confirm("Cargar las Acciones desde Grails?")) {
                $.ajax({
                    type: "POST", url: "${createLink(controller:'modificacion', action:'reversar')}",
                    data: "",
                    success: function(msg) {
                        alert(msg)
                    }
                });
            }
        });


        function armar() {
            var datos = new Array()
            $('.asgn:checked').each(
                    function() {
                        datos.push($(this).val());
                    }
            )
            return datos
        };




    });

</script>

</body>
</html>