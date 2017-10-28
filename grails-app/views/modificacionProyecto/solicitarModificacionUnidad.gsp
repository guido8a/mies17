<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="mies.ModificacionProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Modificaciones</title>

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

        <div class="body" style="font-size: 11px">
            <div class="dialog">

                <div class="breadCrumbHolder module">
                    <div id="breadCrumb" class="breadCrumb module">
                        <ul>
                            <li>
                                <g:link class="bc" controller="asignacion" action="asignacionesProyecto"
                                        id="${unidad.id}">
                                    Inversiones
                                </g:link>
                            </li>
                            <li>
                                <g:link class="bc" controller="asignacion" action="asignacionesCorrientes"
                                        id="${unidad.id}">
                                    Corrientes
                                </g:link>
                            </li>
                            <li>
                                Solicitud de modificaci&oacute;n
                            </li>
                        </ul>
                    </div>
                </div>

                <g:if test="${msn}">
                    <div class="message ui-state-highlight ui-corner-all" style="margin: 10px;">${msn}</div>
                </g:if>
                <g:form action="guardarSolicitudUnidad" class="frmModificacionProyecto" method="post">
                    <g:hiddenField name="id" value="${modificacionProyectoInstance?.id}"/>
                    <g:hiddenField name="version" value="${modificacionProyectoInstance?.version}"/>

                    <table width="500px" class="ui-widget-content ui-corner-all">
                        <thead>
                            <tr>
                                <td colspan="6" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                    Solicitud de modificación
                                </td>
                            </tr>
                        </thead>
                        <tbody>

                            <tr class="prop ${hasErrors(bean: moficacion, field: 'tipo', 'error')}">

                                <td class="label " valign="middle">
                                    Tipo
                                    %{----}%
                                </td>
                                <td class="indicator">
                                    &nbsp;
                                </td>
                                <td class="campo" valign="middle" colspan="6">
                                    Modificación presupuestaria
                                    <input type="hidden" name="tipoModificacion.id" value="4">
                                    %{----}%
                                </td>

                            </tr>

                            <tr class="prop ${hasErrors(bean: moficacion, field: 'descripcion', 'error')}">

                                <td class="label " valign="middle">
                                    Descripción
                                    %{----}%
                                </td>
                                <td class="indicator">
                                    &nbsp;
                                </td>
                                <td colspan="4" valign="middle">
                                    <g:textArea id="desc" class="field ui-widget-content ui-corner-all" minLenght="1"
                                                maxLenght="1023" name="descripcion"
                                                title="${ModificacionProyecto.constraints.descripcion.attributes.mensaje}"
                                                cols="100" rows="5" value="${modificacion?.descripcion}"
                                                style="width: 100%"/>
                                    %{----}%
                                </td>

                            </tr>

                            <tr>
                                <td class="label " valign="middle">
                                    Observaciones
                                </td>
                                <td class="indicator">
                                    &nbsp;
                                </td>
                                <td valign="middle" colspan="4">
                                    <g:textField name="observaciones" id="observaciones"
                                                 title="${ModificacionProyecto.constraints.observaciones.attributes.mensaje}"
                                                 class="field ui-widget-content ui-corner-all" minLenght="1"
                                                 maxLenght="127" value="${modificacion?.observaciones}"
                                                 style="width: 100%"/>
                                    %{----}%
                                </td>

                            </tr>
                        </tbody>
                    </table>
                    <a href="#" class="btn" style="margin-top: 10px;">Siguiente</a>
                </g:form>
                <script type="text/javascript">

                    $("#breadCrumb").jBreadCrumb({
                        beginingElementsToLeaveOpen: 10
                    });

                    $(".btn").button().click(function() {
                        if ($("#desc").val() != "")
                            $(".frmModificacionProyecto").submit()
                    });
                </script>
            </div>
        </div>
    </body>
</html>