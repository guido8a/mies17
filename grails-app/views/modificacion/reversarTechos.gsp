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
        POA
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

<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <a href="#" id="reversar">Reversar</a>
</div>


<div class="hoja">
    <h2>Reversar Transacciones de Modificiónde techos de gatos Corrientes</h2>
    <table border="1" width="100%">
        <thead>
        <tr>
            <th width="3%">
                Rv
            </th>
            <th width="3%">
                id
            </th>
            <th width="32%">
                Desde
            </th>
            <th width="32%">
                Hasta
            </th>
            <th width="10%">
                Valor
            </th>
            <th width="10%">
                Fecha
            </th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${resultado}" var="r">
            <g:if test="${r.valor > 0}">
            <tr>
                <td><input type="checkbox" name="cdgo" class="asgn" value="${r.id}"></td>
                <td>
                    ${r.id}
                </td>

                <td>
                    ${r.desde.unidad}
                </td>

                <td>
                    ${r.recibe.unidad}
                </td>
                <td>
                    ${r.valor}
                </td>
                <td>
                    ${r.fecha}
                </td>
            </tr>
            </g:if>
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
            if (confirm("Reversar la modificación en los Techos de Corrientes?")) {
                $.ajax({
                    type: "POST", url: "${createLink(controller:'modificacion', action:'reversaTechosCorr')}",
                    data: "&ids=" + data,
                    success: function(msg) {
                        alert(msg)
                    }
                });
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

        $("#aceptaAJX").livequery(function() {
            $(this).click(function() {
                if (confirm("Eliminar las acciones seleccionadas de este módulo??")) {
                    var data = armarAccn();
                    alert('datos armados:' + data);
                    $.ajax({
                        type: "POST", url: "${createLink(controller:'acciones', action:'sacarAccn')}",
                        data: "&ids=" + data + "&mdlo=" + $('#mdlo__id').val() + "&tipo=" + tipo(),
                        success: function(msg) {
                            $("#ajx").html(msg)
                        }
                    });
                }
            });
        });


    });

</script>

</body>
</html>