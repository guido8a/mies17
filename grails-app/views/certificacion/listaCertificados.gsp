<%@ page import="mies.Certificacion" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Certificados aprobados -- Unidad:${unidad}</title>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
          type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
          type="text/css"/>

    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript"
            language="JavaScript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
            type="text/javascript" language="JavaScript"></script>
</head>

<body>
<b>Año:</b>
<g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
<br>
<div id="tabs" style="width: 1050px;margin-top: 10px;">
    <ul>
        <li><a href="#tabs-1">Corrientes</a></li>
        <li><a href="#tabs-2">Inversión</a></li>
    </ul>
    <div id="tabs-1">
        <table style="width: 1020px;">

            <tbody>
            <g:each in="${corrientes}" var="asg">
                <g:set var="certificaciones" value="${Certificacion.findAllByEstadoAndAsignacion(1,asg)}"></g:set>
                <g:if test="${certificaciones}">
                    <g:set var="total" value="${0}"></g:set>
                    <tr style="background-color: #d6eba9">
                        <td colspan="6"><b>Actividad: </b> ${asg.actividad} <br><b>Monto:</b> <g:formatNumber number="${asg.planificado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                    </tr>
                    <tr>
                        <th>Concepto</th>
                        <th>Fecha</th>
                        <th>Memorando</th>
                        <th>Monto</th>
                        <th>Ver</th>
                        <th>Editar</th>
                    </tr>
                    <g:each in="${certificaciones}" var="cer">
                        <g:set var="total" value="${total.toDouble()+cer.monto}"></g:set>
                        <tr>
                            <td style="width: 300px;">${cer.concepto}</td>
                            <td>${cer.fechaRevision.format("dd/MM/yyyy")}</td>
                            <td>${cer.memorandoCertificado}</td>
                            <td style="text-align: right"><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                            <td style="text-align: center"><a href="#" class="desc" cer="${cer.id}">PDF</a></td>
                            <td style="text-align: center"><a href="#" class="edit" cer="${cer.id}">Editar</a></td>
                        </tr>
                    </g:each>
                    <tr>
                        <td><b>Por asignar: </b><g:formatNumber number="${asg.planificado-total}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td></td>
                        <td><b>Total</b></td>
                        <td style="text-align: right"><g:formatNumber number="${total}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                    </tr>
                </g:if>

            </g:each>
            </tbody>
        </table>
    </div>
    <div id="tabs-2">
        <table>
            <thead>
            <th>Proyecto</th>
            <th>Actividad</th>
            <th>Partida</th>
            <th>Monto</th>
            <th>Certificaciones</th>
            </thead>
            <tbody>
            <g:each in="${inversion}" var="asg">
                <g:set var="certificaciones" value="${Certificacion.findAllByEstadoAndAsignacion(1,asg)}"></g:set>
                <g:if test="${certificaciones}">
                    <tr style="background-color: #d6eba9">
                        <td colspan="5"><b>Actividad: </b> ${asg.marcoLogico} <br><b>Monto:</b> <g:formatNumber number="${asg.planificado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                    </tr>
                    <tr>
                        <th>Concepto</th>
                        <th>Fecha</th>
                        <th>Memorando</th>
                        <th>Monto</th>
                        <th>Pdf</th>
                    </tr>
                    <g:each in="${certificaciones}" var="cer">
                        <tr>
                            <td>${cer.concepto}</td>
                            <td>${cer.fechaRevision.format("dd/MM/yyyy")}</td>
                            <td>${cer.memorandoCertificado}</td>
                            <td style="text-align: right"><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                            <td style="text-align: center"><a href="#" class="desc" cer="${cer.id}">PDF</a></td>
                        </tr>
                    </g:each>
                </g:if>
            </g:each>
            </tbody>
        </table>
    </div>

</div>



<script>
    $(function() {
        $( "#tabs" ).tabs();
        $("#anio_asg").change(function () {
            location.href = "${createLink(controller:'certificacion',action:'listaCertificados')}?id=${unidad.id}&anio=" + $("#anio_asg").val();
        });

        $(".desc").button().click(function(){
            location.href = "${createLink(controller:'certificacion',action:'descargaDocumento')}/"+$(this).attr("cer")
        });
        $(".edit").button().click(function(){
            location.href = "${createLink(controller:'certificacion',action:'editarCertificacion')}/"+$(this).attr("cer")
        });

    });
</script>

</body>
</html>