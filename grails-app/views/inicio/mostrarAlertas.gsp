<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main" />
    <title>Alertas</title>
    <style type="text/css">
    td{
        padding: 5px !important;
        padding-left: 15px !important;

    }
    th{
        padding: 5px !important;
        padding-left: 15px !important;
        border-top: #000000 1px solid
    }
    </style>
</head>
<body>
<div class="dialog">
    <div class="body">
        <g:if test="${alertas.size()>0}">
            <div style="margin-top: 15px;width: 850px;padding: 5px;" class="ui-corner-all ui-widget-content">
                <table style="width: 100%;">
                    <thead >
                    <tr style="background: white !important;font-weight: bolder !important; ">
                        <th style="border-left: #000000 1px solid;" class="ui-widget-header" >Fecha</th>
                        <th style="border-left: #000000 1px solid"  class="ui-widget-header">Mensaje</th>
                        <th style="border-left: #000000 1px solid"  class="ui-widget-header">Originador</th>
                        <th style="border-right: #000000 1px solid;border-left: #000000 1px solid"  class="ui-widget-header">Link</th>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each  in="${alertas}" var="ale" status="i">
                        <tr style="background: rgba(255,80,0,${((ale.fec_envio.minus(new Date())*(-1/30)).toInteger()>0.9)?'1':((ale.fec_envio.minus(new Date())*(-1/30))+0.1).toFloat().round(2)}) !important;font-family: fantasy !important;" class="ui-corner-all">
                            <td style="text-align: center;">${ale.fec_envio.format("dd/MM/yyyy")}</td>
                            <td>${ale.mensaje}</td>
                            <td style="text-align: center;">${ale.from}</td>
                            <td style="text-align: center;"><g:link action="showAlerta" id="${ale.id}" class="btn" >IR</g:link></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

            </div>
        </g:if>
    </div>
</div>
<script type="text/javascript">
    $(".btn").button()
</script>
</body>
</html>
