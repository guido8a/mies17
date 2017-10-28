<%--
  Created by IntelliJ IDEA.
  User: svt
  Date: 1/16/12
  Time: 1:06 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Aprobar asignaciones corrientes de la unidad: ${unidad}</title>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}" style="" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}" type="text/css"/>

    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript" charset="" language="JavaScript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}" type="text/javascript" language="JavaScript"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>
    <style type="text/css">
    .btnCambiarPrograma {
        width  : 16px;
        height : 16px;
    }
    </style>
</head>
<body>

<div style="margin-left: 10px;">
    <g:if test="${actual.estado!=0}">
        <g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad" params="${[unidad:unidad.id,anio:actual.id]}">Solicitar modificación</g:link>
    </g:if>
    <g:link class="btn" controller="asignacion" action="programacionAsignaciones" params="[id:unidad.id,anio:actual.id]">Programación</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    <a href="${createLink(controller: 'asignacion', action: 'asignacionesCorrientesv2')}?id=${unidad.id}&anio=${actual.id}&todo=1" class="btn">Ver todas</a>

    <a href="#" id="btnReporte">Reporte</a>

    <div style="margin-top: 15px;">

        <table width="600">
            <tr>
                <th>Año</th>
                <th>Programa</th>
                <th>Componente</th>
            </tr>

            <tr>
                <td><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/></td>


            </tr>
        </table>

    </div>
</div>

</body>
</html>