<%@ page import="mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones de la unidad: ${unidad}</title>

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



<div style="margin-left: 10px;">
    <g:if test="${actual.estado!=0}">
        <g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad" params="${[unidad:proyecto.unidadEjecutora.id,anio:actual.id]}" >Solicitar modificación</g:link>
    </g:if>
    <g:link class="btn" controller="asignacion" action="programacionAsignaciones" id="${proyecto.unidadEjecutora.id}">Programación</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    &nbsp;&nbsp;&nbsp;<b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>

</div>
<div id="accordion" style="width:1030px">
    <fieldset class="ui-corner-all" style="border:1px solid #46A3CA">
        <legend>Proyecto : ${proyecto.nombre}</legend>
        <g:set var="programa" value="${proyecto.programaPresupuestario}"></g:set>
        <g:set var="unidadEjec" value="${proyecto.unidadEjecutora}"></g:set>
        <b>Programa:</b> ${programa.descripcion}
        <g:each in="${mies.MarcoLogico.findAll('from MarcoLogico where proyecto='+proyecto.id+' and tipoElemento=2 and estado = 0 order by id')}" var="comp" status="k">

            <g:set var="acts" value="${MarcoLogico.findAllByMarcoLogicoAndEstado(comp,0)}"></g:set>
            <g:if test="${acts.size()>0}">

                <fieldset class="ui-corner-all">
                    <legend>Componente ${k + 1}: ${(comp?.objeto.length() > 40) ? comp?.objeto.substring(0, 40) + "..." : comp.objeto}</legend>
                    <g:each in="${acts}" var="act" status="i">
                        <g:set var="anios" value=""></g:set>
                        <g:set var="asignado" value="${0}"></g:set>
                        <table style="width: 900px;">
                            <thead>
                            <th style="width: 200px;">Actividad</th>
                            <th>Fuente</th>
                            <th>Año</th>
                            <th>Presupuesto</th>
                            <th>Valor</th>
                            <th></th>
                            </thead>
                            <tbody>
                            <g:each in="${fuentes}" var="fuente" status="m">

                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    <td style="width: 200px;">${act.toString()}</td>
                                    <td>${fuente}</td>
                                %{--TODO cambiar para que valga con los valores de redistribucion--}%
                                    <g:set var="asgs" value='${mies.Asignacion.findAll("from Asignacion where marcoLogico = "+act.id+" and fuente= "+fuente.id+" and unidad = "+proyecto.unidadEjecutora)}'></g:set>
                                    <g:each in="${asgs}" var="ag">
                                        <g:set var="asignado" value="${asignado.toDouble()+ag.planificado}"></g:set>
                                        <g:if test="${!anios.contains(ag.anio.anio)}">
                                            <g:set var="anios" value="${anios+ag.anio.anio+','}"></g:set>
                                        </g:if>
                                        <g:if test="${ag.anio==actual}">
                                            <g:set var="asg" value="${ag}"></g:set>
                                        </g:if>
                                        <g:else>
                                            <input type="hidden" class="act_${act.id}" value="${ag.planificado}">
                                        </g:else>

                                    </g:each>

                                    <g:if test="${asg}">
                                        <td class="anio">
                                            %{--<g:select--}%
                                            %{--from="${mies.Anio.list([sort:'anio',order:'desc'])}" name="anio"--}%
                                            %{--value="${asg.anio.id}" optionKey="id" optionValue="anio"/>--}%
                                            ${actual}
                                            <input type="hidden" name="anio" value="${asg.anio.id}">
                                        </td>
                                        <td class="prsp">
                                            <input type="hidden" class="prsp" value="${asg.presupuesto.id}">
                                            <input type="text" id="prsp_${k}${i}${m}" style="width: 120px;color: black"
                                                ${(actual.estado==0)?'class="buscar"':'disabled'} value="${asg.presupuesto.numero}">
                                        </td>

                                        <td class="valor"><input type="text" style="width: 80px;color: black"
                                                                 class="valor act_${act.id}"
                                                                 value="${asg.planificado.toFloat().round(2)}" ${(actual.estado==0)?'':'disabled'}></td>
                                        <td>
                                            <g:if test="${actual.estado==0}">
                                                <a href="#" class="btn guardar ajax" ml="${act.id}" fuente="${fuente.id}"
                                                   iden="${asg.id}" icono="ico_${k}${i}${m}" max="${act.monto}"
                                                   clase="act_${act.id}" asg="asignado_${act.id}" programa="${programa.id}" unidad="${unidadEjec.id}">Guardar</a>
                                            </g:if>
                                            <g:else>
                                                Las asignaciones para este año ya han sido aprobadas.
                                            </g:else>
                                        </td>
                                        <td class="ui-state-active"><span class="" id="ico_${k}${i}${m}"
                                                                          title="asignado"><span
                                                    class="ui-icon ui-icon-check"></span></span></td>
                                        <g:set var="asg" value="${null}"></g:set>
                                    </g:if>
                                    <g:else>
                                        <g:if test="${actual.estado==0}">
                                            <td class="anio">
                                                %{--<g:select from="${mies.Anio.list([sort:'anio',order:'desc'])}" name="anio"--}%
                                                %{--value="${anio}" optionKey="id" optionValue="anio"/>--}%
                                                ${actual}
                                                <input type="hidden" name="anio" value="${actual.id}">
                                            </td>
                                            <td class="prsp">
                                                <input type="hidden" class="prsp" value="nan">
                                                <input type="text" id="prsp_${k}${i}${m}" style="width: 120px;"
                                                       class="buscar">
                                            </td>
                                            <td class="tipo">
                                                <g:select from="${mies.TipoGasto.list([sort:'descripcion'])}"
                                                          name="tipoGasto" optionKey="id" optionValue="descripcion"/>
                                            </td>
                                            <td class="valor">
                                                <input type="text" style="width: 80px;"
                                                       class="valor act_${act.id}" value="0">

                                            </td>
                                            <td>
                                                <g:if test="${actual.estado==0}">
                                                    <a href="#" class="btn guardar ajax" ml="${act.id}" fuente="${fuente.id}"
                                                       icono="ico_${k}${i}${m}" max="${act.monto}" clase="act_${act.id}"
                                                       asg="asignado_${act.id}" programa="${programa.id}" unidad="${unidadEjec.id}">Guardar</a>
                                                </g:if><g:else>
                                                Las asignaciones para este año ya han sido aprobadas
                                            </g:else>
                                            </td>
                                            <td class="ui-state-active">
                                                <span style="display: none;" id="ico_${k}${i}${m}" title="asignado">
                                                    <span class="ui-icon ui-icon-check"></span>
                                                </span>
                                            </td>
                                        </g:if><g:else>
                                        <td colspan="6">No asignado</td>
                                    </g:else>
                                    </g:else>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>

                        <div class="ui-corner-all" style="height: 15px;margin-top: 5px;font-size: 11px;">
                            <div style="width: 150px;float: left"><b>Monto:</b> ${act.monto}</div>

                            <div style="width: 90px;float: left;margin-left: 10px;"><b>Por asignar:</b></div>

                            <div id="asignado_${act.id}" class="asignado" style="width: 100px;float: left" monto="${act.monto}">${(act.monto - asignado.toDouble()).toFloat().round(2)}</div>
                            <g:if test="${anios.size()>0}">
                                <div style="width: 260px;float: left;margin-left: 10px;"><b>La actividad tiene asignaciones en los años:</b></div>
                                <div style="width: 200px;float: left" >${anios.substring(0,anios.size()-1)}</div><br>
                            </g:if>
                        </div>

                    </g:each>
                </fieldset>
            </g:if>
        </g:each>
    </fieldset>

</div>


<div id="buscar">
    <input type="hidden" id="id_txt">

    <div>
        Buscar por:
        <select id="tipo">
            <option value="1">Número</option>
            <option value="2">Descripción</option>
        </select>
        <input type="text" id="par" style="width: 160px;"><a href="#" class="btn" id="btn_buscar">Buscar</a>
    </div>

    <div id="resultado" style="width: 450px;margin-top: 10px;" class="ui-corner-all"></div>
</div>
%{--TODO validar al rato de guardar, poner en disabled los campos despues de guardar--}%

<script type="text/javascript">
    $(".btn_arbol").button({icons: { primary: "ui-icon-bullet"}})
    $(".btn").button()
    $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

    $("#breadCrumb").jBreadCrumb({
        beginingElementsToLeaveOpen: 10
    });


    $("#anio_asg").change(function(){
        location.href="${createLink(controller:'asignacion',action:'asignacionProyecto')}?id=${proyecto.unidadEjecutora.id}&anio="+$(this).val()
    });

    $(".guardar").click(function() {
        var band = true
        var mensaje = ""
        var error
        var max = $(this).attr("max") * 1
        var asignado = 0
        var padre = $(this).parent().parent()
        var boton = $(this)
        var programa = boton.attr("programa")
        var unidadEjec = boton.attr("unidad")
        var valorTxt = padre.find(".valor").children()
        valorTxt.removeClass("error")
        var valor = valorTxt.val()
        if (isNaN(valor)) {
            mensaje = "Error: El valor de la asignacion debe ser un número"
            band = false
            error = valorTxt
        } else {
            $.each($("." + $(this).attr("clase")), function() {
                ////console.log($(this))
                asignado += $(this).val() * 1

            });
            if (asignado > max) {
                mensaje = "Error: La suma de las asignaciones no puede ser mayor al monto de la actividad"
                band = false
                error = valorTxt
            }
        }
        var tipoCombo = padre.find(".tipo").children()
        var tipo = tipoCombo.val()
        var anioCombo = padre.find(".anio").children()
        var anio = anioCombo.val()
        var psrpTxt = padre.find(".prsp").find(".buscar")
        psrpTxt.removeClass("error")
        var prsp = padre.find(".prsp").find(".prsp").val()
        if (isNaN(prsp)) {
            mensaje = "Error: Seleccione una cuenta presupuestaria"
            band = false
            error = psrpTxt
        }
        var ml = $(this).attr("ml")
        var fuente = $(this).attr("fuente")
        var icono = $("#" + $(this).attr("icono"))
        if (band) {
            $.ajax({
                type: "POST",
                url: "${createLink(action:'guardarAsignacion',controller:'asignacion')}",
                data:"anio.id=" + anio+"&unidad.id="+unidadEjec+ "&fuente.id=" + fuente +"&programa.id="+programa +"&planificado=" + valor + "&tipoGasto.id=" + tipo + "&presupuesto.id=" + prsp + "&marcoLogico.id=" + ml + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                success: function(msg) {
                    if (msg*1>=1) {
                        $("#" + boton.attr("asg")).html(max - asignado)
                        boton.attr("iden",msg)
                        icono.show("pulsate")
                    } else {
                        alert("Error al guardar los datos")
                    }

                }
            });
        } else {
            alert(mensaje)
            error.addClass("error").show("pulsate")
        }

    });

    $(".buscar").click(function() {
        $("#id_txt").val($(this).attr("id"))
        $("#buscar").dialog("open")
    });
    $("#btn_buscar").click(function() {
        $.ajax({
            type: "POST",
            url: "${createLink(action:'buscarPresupuesto',controller:'asignacion')}",
            data: "parametro=" + $("#par").val() + "&tipo=" + $("#tipo").val(),
            success: function(msg) {
                $("#resultado").html(msg)
            }
        });
    });
    $("#buscar").dialog({
        title:"Cuentas presupuestarias",
        width:480,
        height:500,
        autoOpen:false,
        modal:true
    })
</script>

</body>
</html>