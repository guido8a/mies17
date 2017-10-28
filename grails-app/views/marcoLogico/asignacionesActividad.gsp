<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Asignaciones de la actividad: ${actividad.objeto}</title>

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
        <div class="body">

            <div class="breadCrumbHolder module">
                <div id="breadCrumb" class="breadCrumb module">
                    <ul>
                        <li>
                            <g:link class="bc" controller="proyecto" action="show"
                                    id="${actividad.proyecto.id}">
                                Proyecto
                            </g:link>
                        </li>
                        <li>
                            <g:link class="bc" controller="marcoLogico" action="showMarco"
                                    id="${actividad.proyecto.id}">
                                Marco L&oacute;gico
                            </g:link>
                        </li>
                        <li>
                            <g:link class="bc" controller="marcoLogico" action="componentes"
                                    id="${actividad.proyecto.id}">
                                Componentes
                            </g:link>
                        </li>
                        <li>
                            <g:link class="bc" controller="marcoLogico" action="actividadesComponente"
                                    id="${actividad.marcoLogico.id}">
                                Actividades
                            </g:link>
                        </li>
                        <li>
                            Asignaciones
                        </li>
                    </ul>
                </div>
            </div>

            %{--<div id="" class="toolbar ui-widget-header ui-corner-all" style="margin-bottom: 5px;">--}%
            %{--<g:link class="btn back" controller="proyecto" action="show" id="${actividad.proyecto.id}">--}%
            %{--Proyecto--}%
            %{--</g:link>--}%
            %{--<g:link class="btn back" controller="marcoLogico" action="showMarco" id="${actividad.proyecto.id}">--}%
            %{--Marco L&oacute;gico--}%
            %{--</g:link>--}%
            %{--<g:link class="btn back" controller="marcoLogico" action="componentes" id="${actividad.proyecto.id}">--}%
            %{--Componentes--}%
            %{--</g:link>--}%
            %{--<g:link class="btn back" controller="marcoLogico" action="actividadesComponente" id="${actividad.marcoLogico.id}">--}%
            %{--Actividades--}%
            %{--</g:link>--}%
            %{--</div> <!-- toolbar -->--}%

            <div class="dialog">
                <div id="accordion" style="width:1030px">

                    <g:if test="${asignaciones.size()<1}">
                        <h3><a href="#">Asiganciones</a></h3>

                        <div>La actividad no tiene asignaciones registradas</div>

                    </g:if>
                    <g:each in="${asignaciones}" var="asg" status="k">
                        <h3><a href="#">${asg.fuente}</a></h3>

                        <div>
                            <g:link action="obrasAsignacion" controller="obra" id="${asg.id}" class="btn"
                                    style="margin-bottom: 10px;">P.A.C.</g:link>

                            <table width="100%" class="ui-widget-content ui-corner-all">

                                <thead>
                                    <tr>
                                        <td colspan="4" class="ui-widget ui-widget-header ui-corner-all"
                                            style="padding: 3px;">
                                            Detalles de la asignación
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="prop ${hasErrors(bean: asg, field: 'id', 'error')}">

                                        <td class="label">
                                            <g:message code="asignacion.anio.label"
                                                       default="Anio"/>
                                        </td>
                                        <td class="campo">

                                                ${asg?.anio?.encodeAsHTML()}

                                        </td> <!-- campo -->
                                        <td class="label">
                                            <g:message code="asignacion.tipoGasto.label" default="Tipo Gasto"/>
                                        </td>
                                        <td class="campo">

                                                ${asg?.tipoGasto?.encodeAsHTML()}

                                        </td> <!-- campo -->
                                    </tr>
                                    <tr class="prop ${hasErrors(bean: asg, field: 'fuente', 'error')}">
                                        <td class="label">
                                            <g:message code="asignacion.fuente.label"
                                                       default="Fuente"/>
                                        </td>
                                        <td class="campo">

                                                ${asg?.fuente?.encodeAsHTML()}

                                        </td> <!-- campo -->
                                        <td class="label">
                                            <g:message code="asignacion.marcoLogico.label"
                                                       default="Marco Logico"/>
                                        </td>
                                        <td class="campo">

                                                ${asg?.marcoLogico?.encodeAsHTML()}

                                        </td> <!-- campo -->
                                    </tr>
                                    <tr class="prop ${hasErrors(bean: asg, field: 'actividad', 'error')}">

                                        <td class="label">
                                            <g:message code="asignacion.presupuesto.label"
                                                       default="Presupuesto"/>
                                        </td>
                                        <td class="campo">
                                                ${asg?.presupuesto?.encodeAsHTML()}

                                        </td> <!-- campo -->
                                    </tr>
                                    <tr class="prop ${hasErrors(bean: asg, field: 'tipoGasto', 'error')}">

                                        <td class="label">
                                            <g:message code="asignacion.plan.label"
                                                       default="Plan"/>
                                        </td>
                                        <td class="campo">
                                            ${fieldValue(bean: asg, field: "planificado")}
                                        </td> <!-- campo -->

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </g:each>
                </div>

                %{--<div style="float: left;width: 90%;height: 35px;display: block;margin-top: 10px;">--}%
                    %{--<a href="#" id="agregar" class="btn">Agregar</a>--}%
                %{--</div>--}%

                <div style="float: left;width: 90%;height: 35px;display: block;margin-top: 10px;">
                    Actividad: <g:select
                            from="${mies.MarcoLogico.findAll('From MarcoLogico where tipoElemento = 3 and proyecto='+actividad.proyecto.id+' and estado=0 order by id')}"
                            optionKey="id" id="cmb_comp" value="${actividad.id}"/>
                </div>
            </div>
        </div>

        <div id="dlg_agregar">
            <g:form action="guardarAsignacion" controller="meta" class="frm_asg">
                <table width="430px" class="ui-widget-content ui-corner-all">
                    <tbody>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'anio', 'error')}">
                            <td class="label " valign="middle">
                                <g:message code="asignacion.anio.label" default="Anio"/>
                                %{----}%
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:select class="field ui-widget-content ui-corner-all" name="anio.id" title="anio"
                                          from="${mies.Anio.list()}" optionKey="id"
                                          value="${asignacionInstance?.anio?.id}"
                                          noSelection="['null': '']" id="anio"/>
                                %{----}%
                            </td>
                        </tr>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                            <td class="label " valign="middle">
                                <g:message code="asignacion.fuente.label" default="Fuente"/>
                                %{----}%
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:select class="field ui-widget-content ui-corner-all" name="fuente.id" title="fuente"
                                          from="${fuentes}" optionKey="id" value="${asignacionInstance?.fuente?.id}"
                                          noSelection="['null': '']"/>
                                %{----}%
                            </td>
                        </tr>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                            <td class="label " valign="middle">
                                <g:message code="asignacion.marcoLogico.label" default="Marco Logico"/>
                                %{----}%
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                ${(actividad.objeto.length() > 25) ? actividad.objeto.substring(0, 25) + ".." : actividad.objeto}
                                <input type="hidden" name="marcoLogico.id" value="${actividad.id}">
                                %{----}%
                            </td>
                        </tr>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                            <td class="label " valign="middle">
                                Actividad de gasto corriente
                                %{----}%
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:select class="field ui-widget-content ui-corner-all" name="actividad.id"
                                          title="actividad"
                                          from="${mies.Actividad.list()}" optionKey="id"
                                          value="${asignacionInstance?.actividad?.id}" noSelection="['null': '']"/>
                                %{----}%
                            </td>
                        </tr>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'presupuesto', 'error')}">

                            <td class="label " valign="middle">
                                <g:message code="asignacion.presupuesto.label" default="Presupuesto"/>
                                %{----}%
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:select class="field ui-widget-content ui-corner-all" name="presupuesto.id"
                                          title="presupuesto"
                                          from="${mies.Presupuesto.list()}" optionKey="id"
                                          value="${asignacionInstance?.presupuesto?.id}" noSelection="['null': '']"/>
                                %{----}%
                            </td>
                        </tr>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'marcoLogico', 'error')}">
                            <td class="label " valign="middle">
                                <g:message code="asignacion.tipoGasto.label" default="Tipo Gasto"/>
                                %{----}%
                            </td>
                            <td class="indicator">
                                &nbsp;
                            </td>
                            <td class="campo" valign="middle">
                                <g:select class="field ui-widget-content ui-corner-all" name="tipoGasto.id"
                                          title="tipoGasto"
                                          from="${mies.TipoGasto.list()}" optionKey="id"
                                          value="${asignacionInstance?.tipoGasto?.id}" noSelection="['null': '']"/>
                                %{----}%
                            </td>
                        </tr>
                        <tr class="prop ${hasErrors(bean: asignacionInstance, field: 'planificado', 'error')}">

                            <td class="label  mandatory" valign="middle">
                                Valor planificado
                                %{--<span class="indicator">*</span>--}%
                            </td>
                            <td class="indicator mandatory">
                                <span class="indicator">*</span>
                            </td>
                            <td class="campo mandatory" valign="middle">
                                <g:textField class="field number required ui-widget-content ui-corner-all"
                                             name="planificado" title="Valor planificado, mayor a cero"
                                             id="valor"
                                             value="${fieldValue(bean: asignacionInstance, field: 'planificado')}"/>
                                %{--<span class="indicator">*</span>--}%
                            </td>
                        </tr>
                    </tbody>

                </table>
            </g:form>
        </div>
        <script type="text/javascript">
            $(".btn").button()
            $(".back").button({icons:{primary:'ui-icon-arrowreturnthick-1-w'}});

            $("#breadCrumb").jBreadCrumb({
                beginingElementsToLeaveOpen: 10
            });

            $("#agregar").click(function() {
                $("#valor").css("border", "1px solid #A6C9E2")
                $("#dlg_agregar").dialog("open")
            });
            $("#cmb_comp").change(function() {
                location.href = "${createLink(action:'asignacionesActividad')}/" + $(this).val()
            });
            $("#accordion").accordion({collapsible: true})
            $("#dlg_agregar").dialog({
                width:480,
                height:360,
                position:"center",
                modal:true,
                title:"Detalles de la asignacion",
                autoOpen:false,
                buttons:{
                    "Aceptar":function() {
                        var valor = $("#valor").val()
                        if (isNaN(valor))
                            valor = 0
                        if (valor > 0) {
                            $.ajax({
                                type: "POST",
                                url: "${createLink(action:'guardarAsignacion',controller:'asignacion')}",
                                data: $(".frm_asg").serialize(),
                                success: function(msg) {
                                    if (msg != "error") {
                                        window.location.reload(true)
                                    } else {
                                        alert("Existe un error. Revise que la actividad no tenga otras asignaciones en el año seleccionado")
                                    }
                                }
                            });
                        } else {
                            $("#valor").css("border", "1px solid red")
                            alert("Ingrese un valor numerico mayor a 0")
                            $("#valor").show("pulsate")
                        }
                    }
                }
            });
        </script>
    </body>
</html>