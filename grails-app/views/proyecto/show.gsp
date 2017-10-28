<%@ page import="mies.Proyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/fg-menu', file: 'fg.menu.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/fg-menu', file: 'fg.menu.css')}"/>


        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>

        <g:set var="entityName"
               value="${message(code: 'proyecto.label', default: 'Proyecto')}"/>
        <title><g:message code="default.show.label" args="[entityName]"/></title>

        <style type="text/css">
        .fg-button {
            padding-left : 13px !important;
        }

        .fg-button .ui-icon {
            position    : absolute;
            /*top: 50%;*/
            margin-top  : -3px;
            /*left: 50%;*/
            margin-left : -15px;
        }

        table.show td {
            padding-left  : 5px;
            padding-right : 5px;
        }

        .label {
            background  : white;
            font-weight : bold;
        }

        .sectionHeader {
            padding : 5px;
            cursor  : pointer;
        }

        .list {
            margin-top : 0;
        }

        .head {
            background : #d8d8e7;
        }

        .box_input {
            text-align : center;
        }
        </style>

    </head>

    <body>

        <div class="dialog">

            <div id="" class="toolbar ui-widget-header ui-corner-all">

                %{--<g:link class="button list" action="list">--}%
                %{--Lista de proyectos--}%
                %{--</g:link>--}%

                <!-- FLYOUT MENU PROYECTO -->
                <a tabindex="0" href="#" id="menuProyecto">
                    Proyecto
                </a>

                <div id="items-menuProyecto" class="hidden">
                    <ul id="ul-menuProyecto">
                        <li>
                            <g:link class="button semplades fg-button" action="verIndicadoresSenplades"
                                    id="${proyectoInstance.id}">
                                <span class="ui-icon ui-icon-folder-open"></span>
                                Indicadores financieros
                            </g:link>
                        </li>

                        <li>
                            <g:link class="button semplades fg-button" action="verEntidades"
                                    id="${proyectoInstance.id}">
                                <span class="ui-icon ui-icon-copy"></span>
                                Entidades participantes
                            </g:link>
                        </li>

                        <li>
                            <g:link class="button financiamiento fg-button" action="verFinanciamiento"
                                    id="${proyectoInstance.id}">
                                <span class="ui-icon ui-icon-calculator"></span>
                                Presupuesto/Fuentes
                            </g:link>
                        </li>

                        <li>
                            <g:link class="button documentos fg-button" action="documentos" id="${proyectoInstance.id}">
                                <span class="ui-icon ui-icon-document"></span>
                                Documentos del proyecto
                            </g:link>
                        </li>

                        <li>
                            <a href="#" class="button responsable fg-button" function="showResponsable">
                                <span class="ui-icon ui-icon-person"></span>
                                Responsables
                            </a>

                        </li>
                        %{--
                                                <li>
                                                    <g:link controller="asignacion" action="asignacionProyecto" id="${proyectoInstance.id}"
                                                            class="button  fg-button">
                                                        <span class="ui-icon ui-icon-cart"></span>
                                                        Asignaciones de inversión
                                                    </g:link>
                                                </li>
                        --}%
                        %{--<li>--}%
                        %{--<g:link controller="asignacion" action="asignacionesProyecto" id="${proyectoInstance.id}"--}%
                        %{--class="button  fg-button">--}%
                        %{--<span class="ui-icon ui-icon-cart"></span>--}%
                        %{--Asignaciones--}%
                        %{--</g:link>--}%

                        %{--</li>--}%
                        %{--<li>--}%
                        %{--<g:link controller="obra" action="pacProyecto" id="${proyectoInstance.id}"--}%
                        %{--class="button  fg-button">--}%
                        %{--<span class="ui-icon ui-icon-cart"></span>--}%
                        %{--P.A.C.--}%
                        %{--</g:link>--}%
                        %{--</li>--}%
                        %{--<li>--}%
                        %{--<a href="#" class="button responsables fg-button" function="showHistorial">--}%
                        %{--<span class="ui-icon ui-icon-clock"></span>--}%
                        %{--Historial Responsables--}%
                        %{--</a>--}%
                        %{--</li>--}%
                        %{--<li>--}%
                        %{--<a href="#" class="button estado fg-button" function="showEstado">--}%
                        %{--<span class="ui-icon ui-icon-radio-off"></span>--}%
                        %{--Estado--}%
                        %{--</a>--}%
                        %{--</li>--}%
                    </ul>
                </div>

                <!-- FIN FLYOUT MENU PROYECTO -->

                <!-- FLYOUT MENU MARCO -->
                <a tabindex="0" href="#" id="menuMarco">
                    Marco lógico
                </a>

                <div id="items-menuMarco" class="hidden">
                    <ul id="ul-menuMarco">
                        <g:if test="${proyectoInstance.aprobado!='a'}">
                            <li>
                                <g:link action="nuevoMarco" controller="marcoLogico" id="${proyectoInstance.id}"
                                        class="button fg-button">
                                    Crear/Editar Marco Lógico
                                </g:link>
                            </li>
                        </g:if>
                        <li>
                            <g:link action="verMarcoCompleto" controller="marcoLogico" id="${proyectoInstance.id}"
                                    class="button fg-button">
                                Ver Marco Lógico
                            </g:link>
                        </li>
                    </ul>
                </div>
                <!-- FIN FLYOUT MENU MARCO -->

                <a tabindex="0" href="#" id="menuCronograma">
                    Cronograma
                </a>

                <div id="items-menuCronograma" class="hidden">
                    <ul id="ul-menuCronograma">
                        <g:if test="${proyectoInstance.aprobado!='a'}">
                            <li>
                                <g:link action="nuevoCronograma" controller="cronograma" id="${proyectoInstance.id}"
                                        class="button fg-button">
                                    Crear/Editar cronograma
                                </g:link>
                            </li>
                        </g:if>
                        <li>
                            <g:link action="verCronograma" controller="cronograma" id="${proyectoInstance.id}"
                                    class="button fg-button">
                                Ver Cronograma
                            </g:link>
                        </li>
                    </ul>
                </div>
                <!-- FIN FLYOUT MENU MARCO -->



                <g:link controller="obra" action="pacProyecto" id="${proyectoInstance.id}" class="button pac">
                    P.A.C.
                </g:link>

                <a href="#" class="button estado">
                    Estado
                </a>

                <g:if test="${proyectoInstance.aprobado=='a'}">
                    <g:link class="button list" action="solicitarModificacion" controller="modificacionProyecto"
                            id="${proyectoInstance.id}">
                        Solicitar modificación
                    </g:link>
                </g:if>
                <g:else>
                    <g:link class="button edit" action="nuevoProyecto" id="${proyectoInstance?.id}">
                        Editar
                    </g:link>
                </g:else>


                <g:link class="button delete" action="deleteProyecto" id="${proyectoInstance?.id}">
                    Eliminar
                </g:link>

            </div> <!-- toolbar -->

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>

                <div style="width: 1040px;float: left; margin-top: 15px;">
                    <div class="sectionHeader ui-widget-header ui-corner-top" title="Ocultar" data-object="detalles">
                        Detalles del proyecto
                        <span class="ui-icon ui-icon-triangle-1-n" style="float: right;"></span>
                    </div>
                    <table width="1040px" class="ui-widget-content ui-corner-bottom" id="detalles">
                        <tbody>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.nombre.label" default="Nombre"/>
                                </td>

                                <td class="" colspan="3">
                                    ${fieldValue(bean: proyectoInstance, field: "nombre")}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="label">
                                    <g:message code="proyecto.codigoProyecto.label" default="Código del Proyecto"/>
                                </td>

                                <td class="">
                                    ${fieldValue(bean: proyectoInstance, field: "codigoProyecto")}
                                </td> <!-- campo -->
                                <td class="label">
                                    Aprobado
                                </td>

                                <td class="">
                                    ${(proyectoInstance.aprobado == "a") ? "Si" : "No"}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.unidadEjecutora.label" default="Unidad Ejecutora"/>
                                </td>

                                <td class="">
                                    ${proyectoInstance?.unidadEjecutora?.encodeAsHTML()}
                                </td> <!-- campo -->

                                <td class="labelshow">
                                    Programa presupuestario
                                </td>

                                <td class="">
                                    ${fieldValue(bean: proyectoInstance, field: "programaPresupuestario")}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.monto.label" default="Monto"/>
                                </td>

                                <td class="">
                                    <g:formatNumber number="${proyectoInstance.monto}"
                                                    format="###,##0"
                                                    minFractionDigits="2" maxFractionDigits="2"/>
                                </td> <!-- campo -->

                                <td class="labelshow">
                                    <g:message code="proyecto.codigoEsigef.label"
                                               default="Código eSIGEF"/>
                                </td>

                                <td class="">
                                    ${fieldValue(bean: proyectoInstance, field: "codigoEsigef")}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.fechaInicioPlanificada.label"
                                               default="Fecha inicio planificada"/>
                                </td>

                                <td class="">
                                    <g:formatDate date="${proyectoInstance?.fechaInicioPlanificada}"
                                                  format="dd-MM-yyyy"/>
                                </td> <!-- campo -->

                                <td class="labelshow">
                                    <g:message code="proyecto.fechaInicio.label" default="Fecha Inicio"/>
                                </td>

                                <td class="">
                                    <g:formatDate date="${proyectoInstance?.fechaInicio}" format="dd-MM-yyyy"/>
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.fechaFinPlanificada.label"
                                               default="Fecha fin planificada"/>
                                </td>

                                <td class="">
                                    <g:formatDate date="${proyectoInstance?.fechaFinPlanificada}" format="dd-MM-yyyy"/>
                                </td> <!-- campo -->

                                <td class="labelshow">
                                    <g:message code="proyecto.fechafin?.label" default="Fecha Fin"/>
                                </td>

                                <td class="">
                                    <g:formatDate date="${proyectoInstance?.fechaFin}" format="dd-MM-yyyy"/>
                                </td> <!-- campo -->
                            </tr>

                            <tr>
                                <td class="labelshow">
                                    <g:message code="proyecto.ejeProgramatico.label"
                                               default="Eje Programático"/>
                                </td>

                                <td class="">
                                    ${fieldValue(bean: proyectoInstance, field: "ejeProgramatico")}
                                </td> <!-- campo -->

                                <td class="labelshow">
                                    <g:message code="proyecto.cobertura.label" default="Cobertura"/>
                                </td>

                                <td class="">
                                    ${proyectoInstance?.cobertura?.encodeAsHTML()}

                                </td> <!-- campo -->

                            </tr>

                            <tr>
                                <td class="labelshow">
                                    <g:message code="proyecto.descripcion.label" default="Descripción"/>
                                </td>

                                <td class="" colspan="3">
                                    ${fieldValue(bean: proyectoInstance, field: "descripcion")}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.problema.label" default="Problema"/>
                                </td>

                                <td class="" colspan="3">
                                    ${fieldValue(bean: proyectoInstance, field: "problema")}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.linea.label" default="Lineamiento Senplades"/>
                                </td>

                                <td class="" colspan="3">
                                    ${proyectoInstance?.linea?.encodeAsHTML()}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.poblacionObjetivo.label" default="Población Objetivo"/>
                                </td>

                                <td class="" colspan="3">
                                    ${proyectoInstance?.poblacionObjetivo?.encodeAsHTML()}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.objetivoEstrategico.label"
                                               default="Objetivo Estratégico"/>
                                </td>

                                <td class="" colspan="3">
                                    ${proyectoInstance?.objetivoEstrategico?.encodeAsHTML()}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    Objetivos de gobierno por resultado
                                </td>

                                <td class="" colspan="3">
                                    ${proyectoInstance?.objetivoGobiernoResultado?.descripcion?.encodeAsHTML()}
                                </td> <!-- campo -->
                            </tr>

                            <tr class="prop">
                                <td class="labelshow">
                                    <g:message code="proyecto.programa.label" default="Programa"/>
                                </td>

                                <td class="" colspan="3">
                                    ${proyectoInstance?.programa?.encodeAsHTML()}
                                </td> <!-- campo -->
                            </tr>

                        </tbody>
                    </table>
                </div>

                <div style="width: 1040px;float: left; margin-top: 5px;">
                    <div class="sectionHeader ui-widget-header ui-corner-all" title="Mostrar"
                         data-object="buenVivir">
                        Buen Vivir
                        <span class="ui-icon ui-icon-triangle-1-s" style="float: right;"></span>
                    </div>
                    <table width="1040px" class="ui-widget-content ui-corner-bottom ui-helper-hidden" id="buenVivir">
                        <thead>
                            <tr style="padding: 5px;">
                                <th style="padding: 5px;" class="head ui-corner-tl" width="310px;">
                                    Objetivo
                                </th>
                                <th style="padding: 5px;" class="head " width="310px;">
                                    Pol&iacute;tica
                                </th>
                                <th style="padding: 5px;" class="head ui-corner-tr" width="310px;">
                                    Meta
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="suma" value="${0}"/>
                            <g:set var="prct" value="${0}"/>
                            <g:each in="${metas}" status="i" var="meta">
                                <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                    <td>
                                        ${meta.metaBuenVivir.politica.objetivo.descripcion}
                                    </td>

                                    <td>
                                        ${meta.metaBuenVivir.politica.descripcion}
                                    </td>

                                    <td>
                                        ${meta.metaBuenVivir.descripcion}
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div style="width: 1040px;float: left; margin-top: 5px;">
                    <div class="sectionHeader ui-widget-header ui-corner-all" title="Mostrar" data-object="politicasAS">
                        Pol&iacute;ticas de agenda social
                        <span class="ui-icon ui-icon-triangle-1-s" style="float: right;"></span>
                    </div>
                    <table width="1040px" class="ui-widget-content ui-corner-bottom ui-helper-hidden" id="politicasAS">
                        <tbody>
                            <g:each in="${plas}" status="i" var="plas">
                                <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                    <td>
                                        ${plas.politicaAgendaSocial.descripcion}
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div style="width: 1040px;float: left; margin-top: 5px;">
                    <div class="sectionHeader ui-widget-header ui-corner-all" title="Mostrar" data-object="politicas">
                        Pol&iacute;ticas MIES
                        <span class="ui-icon ui-icon-triangle-1-s" style="float: right;"></span>
                    </div>
                    <table width="1040px" class="ui-widget-content ui-corner-bottom ui-helper-hidden" id="politicas">
                        <tbody>
                            <g:each in="${politicas}" status="i" var="pol">
                                <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                    <td>
                                        ${pol.politica.descripcion}
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div style="width: 1040px;float: left; margin-top: 5px;">
                    <div class="sectionHeader ui-widget-header ui-corner-all" title="Mostrar"
                         data-object="financiamiento">
                        Presupuesto/Fuentes
                        <span class="ui-icon ui-icon-triangle-1-s" style="float: right;"></span>
                    </div>
                    <table width="1040px" class="ui-widget-content ui-corner-bottom ui-helper-hidden"
                           id="financiamiento">
                        <thead>
                            <tr style="padding: 5px;">
                                <th style="padding: 5px;" class="head ui-corner-tl" width="320px;">
                                    Fuente
                                </th>
                                <th style="padding: 5px;" class="head " width="120px;">
                                    Monto
                                </th>
                                <th style="padding: 5px;" class="head" width="120px;">
                                    Porcentaje
                                </th>
                                <th style="padding: 5px;" class="head ui-corner-tr" width="120px;">
                                    A&ntilde;o
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="suma" value="${0}"/>
                            <g:set var="prct" value="${0}"/>
                            <g:each in="${financiamientos}" status="i" var="fin">
                                <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                    <td fuente="${fin?.fuente.id}" tipo="descripcion">
                                        ${fin?.fuente.descripcion}
                                    </td>

                                    <td style="text-align: right;" fuente="${fin?.fuente.id}" tipo="monto">

                                        <g:formatNumber number="${fin?.monto}" format="###,##0"
                                                        minFractionDigits="2" maxFractionDigits="2"/>

                                        <g:set var="suma" value="${suma + fin?.monto}"/>
                                    </td>

                                    <td style="text-align: right;" fuente="${fin?.fuente.id}" tipo="porcentaje">

                                        <g:set var="finPorcentaje"
                                               value="${(fin?.monto * 100) / proyectoInstance?.monto}"/>
                                        <g:formatNumber number="${finPorcentaje/100}" type="percent"
                                                        minFractionDigits="2"
                                                        maxFractionDigits="2"/>

                                        <g:set var="prct" value="${prct+ finPorcentaje}"/>
                                    </td>

                                    <td>
                                        ${fin.anio?.anio}
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th class="ui-state-active ui-corner-bl" style="font-weight: bold;">
                                    TOTAL
                                </th>
                                <th class="ui-state-active" style="text-align: right; font-weight: bold;">
                                    <span id="spanSuma">
                                        <g:formatNumber number="${suma}" format="###,##0"
                                                        minFractionDigits="2" maxFractionDigits="2"/>
                                    </span>
                                </th>
                                <th class="ui-state-active" style="text-align: right; font-weight: bold;">
                                    <span id="spanPrct">
                                        <g:formatNumber number="${prct/100}" type="percent" minFractionDigits="2"
                                                        maxFractionDigits="2"/>
                                    </span>
                                </th>
                                <th class="ui-state-active ui-corner-br"></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div style="width: 1040px;float: left; margin-top: 5px;">
                    <div class="sectionHeader ui-widget-header ui-corner-all" title="Mostrar" data-object="entidades">
                        Entidades participantes
                        <span class="ui-icon ui-icon-triangle-1-s" style="float: right;"></span>
                    </div>
                    <table class="ui-widget-content ui-corner-bottom ui-helper-hidden" width="100%"
                           style="font-size: 13px;"
                           id="entidades">
                        <thead>
                            <tr>
                                <th class="head ui-corner-tl">Unidad ejecutora</th>
                                <th class="head">Tipo participaci&oacute;n</th>
                                <th class="head">Monto</th>
                                <th class="head ui-corner-tr">Rol</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:if test="${entidades.size() == 0}">
                                <tr>
                                    <td colspan="4"
                                        class="ui-state-active ui-corner-bottom"
                                        style="font-weight: bold; padding: 5px; font-size: larger; text-align: center;">
                                        No se encontraron Entidades de Proyecto para este proyecto
                                    </td>
                                </tr>
                            </g:if>
                            <g:else>
                                <g:each in="${entidades}" var="elem" status="i">
                                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                        <td>
                                            ${elem.unidad}
                                        </td>

                                        <td>
                                            ${elem.tipoPartisipacion}
                                        </td>

                                        <td>
                                            <g:formatNumber number="${elem.monto}"
                                                            format="###,##0"
                                                            minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>

                                        <td>
                                            ${elem.rol}
                                        </td>
                                    </tr>
                                </g:each>
                            </g:else>
                        </tbody>
                    </table>
                </div>

            </div> <!-- body -->
        </div> <!-- dialog -->


        <div id="dlg_responsable"><div id="dlg_contenido"></div></div>

        <script type="text/javascript">

            var botonesSave = {
                "Cerrar":function () {
                    $("#dlg_responsable").dialog("close");
                }/*,
                 "Guardar": function() {
                 var data = $(".frmResponsableProyecto").serialize();
                 var url = $(".frmResponsableProyecto").attr("action");
                 $.ajax({
                 type: "POST",
                 url: url,
                 data: data,
                 success: function(msg) {
                 if (msg == "OK") {
                 $("#dlg_responsable").dialog("close");
                 } else {
                 alert("Ha ocurrido un error al guardar");
                 }
                 }
                 });
                 }*/
            };

            var botonesCerrar = {
                "Cerrar":function () {
                    $("#dlg_responsable").dialog("close");
                }
            };

            var loading = $("<div style='width: 100%; height: 100px; margin-top: 50px; text-align: center;'>");
            var img = $("<img src='" + "${resource(dir:'images', file:'spinner.gif')}" + "' alt='cargando...'/>");
            loading.append(img);

            function showResponsable() {
                $("#dlg_contenido").html(loading);
                $("#dlg_responsable").dialog("open");

                $("#dlg_responsable").dialog("option", "title", 'Asignar responsable del proyecto ${proyectoInstance.nombre}');
                $("#dlg_responsable").dialog("option", "width", 745);
                $("#dlg_responsable").dialog("option", "buttons", botonesSave);
                $("#dlg_responsable").dialog("option", "position", [330, 250]);

            %{--var url = "${createLink(action:'responsable', id:proyectoInstance.id)}";--}%
                var url = "${createLink(action:'responsables', id:proyectoInstance.id)}";

                $.ajax({
                    type:"POST",
                    url:url,
                    success:function (msg) {
                        $("#dlg_contenido").html(msg);
                    }
                });
            }

            function showHistorial() {
                $("#dlg_contenido").html(loading);
                $("#dlg_responsable").dialog("open");

                $("#dlg_responsable").dialog("option", "title", 'Historial de responsables del proyecto ${proyectoInstance.nombre}');
                $("#dlg_responsable").dialog("option", "width", 645);
                $("#dlg_responsable").dialog("option", "buttons", botonesCerrar);
                $("#dlg_responsable").dialog("option", "position", [395, 250]);

                var url = "${createLink(action:'historialResponsables', id:proyectoInstance.id)}";

                $.ajax({
                    type:"POST",
                    url:url,
                    success:function (msg) {
                        $("#dlg_contenido").html(msg);
                    }
                });
            }

            function showEstado() {
                $("#dlg_contenido").html(loading);
                $("#dlg_responsable").dialog("open");

                $("#dlg_responsable").dialog("option", "title", 'Estado del proyecto ${proyectoInstance.nombre}');
                $("#dlg_responsable").dialog("option", "width", 380);
                $("#dlg_responsable").dialog("option", "buttons", botonesCerrar);
                $("#dlg_responsable").dialog("option", "position", [455, 200]);

                var url = "${createLink(action:'estadoProyecto', id:proyectoInstance.id)}";

                $.ajax({
                    type:"POST",
                    url:url,
                    success:function (msg) {
                        $("#dlg_contenido").html(msg);
                    }
                });
            }

            $(function () {
                /******* PARA LOS PANELES COLAPSABLES ****************/
                $(".sectionHeader").click(function () {
                    var cur = $(this);
                    var elem = cur.attr("data-object");
                    var cont = $("#" + elem);
                    if (cont.is(":visible")) {
                        cont.hide("blind", "slow", function () {
                            cur.removeClass("ui-corner-top").addClass("ui-corner-all");
                            cur.children(".ui-icon").removeClass("ui-icon-triangle-1-n").addClass("ui-icon-triangle-1-s");
                            cur.attr("title", "Mostrar");
                        });
                    } else {
                        cur.removeClass("ui-corner-all").addClass("ui-corner-top");
                        cur.children(".ui-icon").removeClass("ui-icon-triangle-1-s").addClass("ui-icon-triangle-1-n");
                        cur.attr("title", "Ocultar");
                        cont.show("blind", "slow");
                    }
                });

                /********** PARA LOS FLYOUT MENU *************************/
                $("#menuProyecto").button({
                    icons:{
                        primary:"ui-icon-clipboard",
                        secondary:"ui-icon-triangle-1-s"
                    }
                }).click(function () {
                            return false;
                        });
                $('#menuProyecto').menu({
                    content:$('#items-menuProyecto').html(),
                    flyOut:true
                });


                $("#menuMarco").button({
                    icons:{
                        primary:"ui-icon-comment",
                        secondary:"ui-icon-triangle-1-s"
                    }
                }).click(function () {
                            return false;
                        });
                $('#menuMarco').menu({
                    content:$('#items-menuMarco').html(),
                    flyOut:true
                });

                $("#menuCronograma").button({
                    icons:{
                        primary:"ui-icon-comment",
                        secondary:"ui-icon-triangle-1-s"
                    }
                }).click(function () {
                            return false;
                        });
                $('#menuCronograma').menu({
                    content:$('#items-menuCronograma').html(),
                    flyOut:true
                });


                /********** FIN FLYOUT MENU *************************/

                $("#dlg_responsable").dialog({
                    autoOpen:false,
                    modal:true,
                    resizable:false,
                    position:[225, 75]
                });

                $(".button").button();

                $(".estado").button("option", "icons", {primary:'ui-icon-radio-off'}).click(function () {
                    showEstado();
                });

                $(".pac").button("option", "icons", {primary:'ui-icon-cart'});

                $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
                $(".semplades").button("option", "icons", {primary:'ui-icon-folder-open'});

                $("#showResponsable").click(function (event) {

                    $("#dlg_responsable").dialog("option", "title", 'Asignar responsable del proyecto ${proyectoInstance.nombre}');
                    $("#dlg_responsable").dialog("option", "buttons", botonesSave);

                    var url = "${createLink(action:'responsable', id:proyectoInstance.id)}";
                    $("#dlg_responsable").dialog("open");

                    $.ajax({
                        type:"POST",
                        url:url,
                        success:function (msg) {
                            $("#dlg_contenido").html(msg);
                        }
                    });
                    return false;
                });
                $(".responsables").button("option", "icons", {primary:'ui-icon-clock', secondary:'ui-icon-person'}).click(function () {

                    $("#dlg_responsable").dialog("option", "title", 'Historial de responsables del proyecto ${proyectoInstance.nombre}');
                    $("#dlg_responsable").dialog("option", "buttons", botonesSave);

                    var url = "${createLink(action:'historialResponsables', id:proyectoInstance.id)}";
                    $("#dlg_responsable").dialog("open");

                    $.ajax({
                        type:"POST",
                        url:url,
                        success:function (msg) {
                            $("#dlg_contenido").html(msg);
                        }
                    });
                    return false;
                });

                $(".documentos").button("option", "icons", {primary:'ui-icon-document'});

                $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
                $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function () {
//                    var n = prompt("Ingrese su clave de autorización");
                    var url = $(this).attr("href");
                    $.box({
                        input:"<input type='password' name='auth' id='auth'/>",
                        type:"prompt",
                        title:"Autorización",
                        imageClass:"box_wallet",
                        iconClose:false,
                        text:"Ingrese su clave de autorización",
                        dialog:{
                            resizable:false,
                            draggable:false,
                            buttons:{
                                "Cancelar": function() {},
                                "Aceptar":function (n) {
                                    $.ajax({
                                        type:"POST",
                                        url:"${createLink(action:'validarAutorizacion')}",
                                        data:{
                                            auth:n
                                        },
                                        success:function (msg) {
                                            if (msg == "OK") {
                                                $.box({
                                                    imageClass:"box_warning",
                                                    text:"Se eliminarán <strong>todos</strong> los datos asociados al proyecto, como marco lógico, cronograma, etc.<br/>" +
                                                            "<strong>Esta acción no puede deshacerse.</strong><br/>" +
                                                            "Continuar?",
                                                    title:"Atención",
                                                    iconClose:false,
                                                    dialog:{
                                                        resizable:false,
                                                        draggable:false,
                                                        buttons:{
                                                            "Aceptar":function () {
                                                                location.href = url;
                                                            },
                                                            "Cancelar":function () {
                                                            }
                                                        },
                                                        resizable:false
                                                    }
                                                });
                                            } else if (msg == "NO_1") {
//                                                alert("Usuario incorrecto");
                                                $.box({
                                                    imageClass:"box_error",
                                                    title:"Error",
                                                    text:"Usuario incorrecto",
                                                    iconClose:false,
                                                    dialog:{
                                                        resizable:false,
                                                        draggable:false,
                                                        buttons:{
                                                            "Aceptar":function () {
                                                            }
                                                        }
                                                    }
                                                });
                                            } else if (msg == "NO_2") {
//                                                alert("Autorización incorrecta");
                                                $.box({
                                                    imageClass:"box_error",
                                                    title:"Error",
                                                    text:"Autorización incorrecta",
                                                    iconClose:false,
                                                    dialog:{
                                                        resizable:false,
                                                        draggable:false,
                                                        buttons:{
                                                            "Aceptar":function () {
                                                            }
                                                        }
                                                    }
                                                });
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });

                    return false;
                });
            });
        </script>

    </body>
</html>
