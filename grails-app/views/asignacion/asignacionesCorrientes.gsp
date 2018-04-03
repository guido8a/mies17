<%@ page import="mies.Anio; mies.Actividad; mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
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
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>
</head>

<body>


<div style="margin-left: 10px;">
    <g:if test="${actual.estado!=0}">
        <g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad" params="${[unidad:unidad.id,anio:actual.id]}">Solicitar modificación</g:link>
    </g:if>
    <g:link class="btn" controller="asignacion" action="programacionAsignaciones" id="${unidad.id}">Programación</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    &nbsp;&nbsp;&nbsp;<b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>

</div>

<g:set var="anio" value="${mies.Anio.findByAnio(new Date().format('yyyy')).id}"></g:set>
<div id="accordion" style="width:1030px;margin-top: 5px;">
<ul>

    <li><a href="#tabs-1">GASTOS EN PERSONAL</a></li>
    <li><a href="#tabs-2">BIENES DE LARGA DURACION</a></li>
    <li><a href="#tabs-3">OTROS PASIVOS</a></li>

</ul>
<div id="tabs-1">
    <table style="width: 900px;">
        <thead>
        <th style="width: 200px;">Actividad</th>
        <th>Fuente</th>
        <th>Programa</th>
        <th>Año</th>
        <th>Presupuesto</th>
        <th>Tipo de gasto</th>
        <th>Valor</th>
        <th></th>
        </thead>
        <tbody>
        <g:set var="asignado" value="0"></g:set>
        <g:each in="${cinco}" var="act" status="i">
            %{--<g:set var="asg" value="${mies.Asignacion.findAll('from Asignacion where actividad='+act.id+ ' and unidad=' +unidad.id+ ' and anio=' +actual.id)}"/>--}%
            <g:set var="asg" value="${mies.Asignacion.findAllByActividadAndUnidadAndAnio(act, unidad, actual)}"/>

            <g:if test="${asg}">
                <g:set var="asg" value="${asg.pop()}"></g:set>
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td style="width: 200px;">${act.toString()}</td>

                    <td class="fuente">
                        <g:select from="${fuentes}" id="fuente_c${i}" optionKey="id" optionValue="descripcion" name="fuente" value="${asg.fuente.id}" class="fuente"  />
                    </td>
                    <td class="programa">
                        <g:select from="${programas}" id="programac_${i}" optionKey="id" optionValue="descripcion" name="programa" value="${asg.programa?.id}" class="programa"  />
                    </td>
                    <g:set var="asignado" value="${asignado.toDouble() + asg.planificado?.toDouble()}"/>
                    <td class="anio">
                        %{--<g:select--}%
                        %{--from="${mies.Anio.list([sort:'anio',order:'desc'])}" name="anio"--}%
                        %{--value="${asg.anio.id}" optionKey="id" optionValue="anio"/>--}%
                        ${actual.anio}
                        <input type="hidden" name="anio" value="${actual.id}">
                    </td>
                    <td class="prsp">
                        <input type="hidden" class="prsp" value="${asg.presupuesto.id}">
                        <input type="text" id="prsp_c${i}" style="width: 80px;color:black"
                            ${(actual.estado==0)?'class="buscar"':'disabled'} value="${asg.presupuesto.numero}">
                    </td>
                    <td class="tipo"><g:select
                            from="${tipoGastos}"
                            name="tipoGasto" optionKey="id" optionValue="descripcion"
                            value="${asg.tipoGasto.id}"/></td>
                    <td class="valor"><input type="text" style="width: 80px;color:black"
                                             class="valor act_${act.id} cinco save"
                                             value="${asg.planificado.toFloat().round(2)}" ${(actual.estado==0)?'':'disabled'}></td>
                    <td>
                        <g:if test="${actual.estado==0}">
                            <a href="#" class="btn guardar ajax" ml="${act.id}"
                               iden="${asg.id}" icono="ico_${i}"
                               clase="act_${act.id}" asg="asignado_${act.id}" divTotal="asignado_cinco" tipo="cinco" >Guardar</a>
                        </g:if>
                    </td>
                    <td class="ui-state-active"><span class="" id="ico_${i}"
                                                      title="asignado"><span
                                class="ui-icon ui-icon-check"></span></span></td>
                </tr>
            </g:if>
            <g:else>
                <g:if test="${actual.estado==0}">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td style="width: 200px;">${act.toString()}</td>
                        <td class="fuente">
                            <g:select from="${fuentes}" id="fuente_c${i}" optionKey="id" optionValue="descripcion" name="fuente" value="" class="fuente"  />
                        </td>
                        <td class="programa">
                            <g:select from="${programas}" id="programac_${i}" optionKey="id" optionValue="descripcion" name="programa"  class="programa"  />
                        </td>
                        <td class="anio">
                            ${actual.anio}
                            <input type="hidden" name="anio" value="${actual.id}">
                        </td>
                        <td class="prsp">
                            <input type="hidden" class="prsp" value="${mies.Presupuesto.findByNumero(act.codigo)?.id}">
                            <input type="text" id="prsp_c${i}" style="width: 80px;color:black"
                                ${(actual.estado==0)?'class="buscar"':'disabled'} value="${act.codigo}">
                        </td>
                        <td class="tipo">
                            <g:select from="${tipoGastos}"
                                      name="tipoGasto" optionKey="id" optionValue="descripcion"/>
                        </td>
                        <td class="valor">
                            <input type="text" style="width: 80px;color:black"
                                   class="valor act_${act.id} cinco " value="0">

                        </td>
                        <td>
                            <a href="#" class="btn guardar ajax" ml="${act.id}" fuente=""
                               icono="ico_${i}" max="" clase="act_${act.id}"
                               asg="asignado_${act.id}" divTotal="asignado_cinco" tipo="cinco">Guardar</a>
                        </td>
                        <td class="ui-state-active">
                            <span style="display: none;" id="ico_${i}" title="asignado">
                                <span class="ui-icon ui-icon-check"></span>
                            </span>
                        </td>
                    </tr>
                </g:if>
            </g:else>

        </g:each>
        </tbody>
    </table>
    <div class="ui-corner-all" style="height: 15px;margin-top: 20px;margin-bottom: 10px;margin-left: 10px;">
        <div style="width: 100px;float: left"><b>Asignado:</b> </div>
        <div id="asignado_cinco" class="asignado" style="width: 100px;float: left" >${asignado.toFloat().round(2)}</div>
        <g:if test="${actual.estado==0}">
            <div style="width: 310px;float: left;" >El total es calculado solo con los valores guardados (  </div> <div class="ui-state-active" style="width: 18px;float: left;height: 20px;margin-right: 2px;"><span  title="asignado">
            <span class="ui-icon ui-icon-check"></span>
        </span></div> )
            <br>
        </g:if>
        <g:else>
            <div style="width: 380px;float: left;" ><b>Las asignaciones para este año ya han sido aprobadas</b>  </div>
        </g:else>
    </div>
</div>

<div id="tabs-2">
    <table style="width: 900px;">
        <thead>
        <th style="width: 200px;">Actividad</th>
        <th>Fuente</th>
        <th>Programa</th>
        <th>Año</th>
        <th>Presupuesto</th>
        <th>Tipo de gasto</th>
        <th>Valor</th>
        <th></th>
        </thead>
        <tbody>
        <g:set var="asignado" value="0"></g:set>
        <g:each in="${ocho}" var="act" status="i">
            %{--<g:set var="asg" value="${mies.Asignacion.findAll('from Asignacion where actividad='+act.id+' and unidad= '+unidad.id+' and anio = '+actual.id)}"></g:set>--}%
            <g:set var="asg" value="${mies.Asignacion.findAllByActividadAndUnidadAndAnio(act, unidad, actual)}"/>

            <g:if test="${asg}">
                <g:set var="asg" value="${asg.pop()}"></g:set>
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td style="width: 200px;">${act.toString()}</td>
                    <td class="fuente">
                        <g:select from="${fuentes}" id="fuente_o${i}" optionKey="id" optionValue="descripcion" name="fuente" value="${asg.fuente.id}" class="fuente"  />
                    </td>
                    <td class="programa">
                        <g:select from="${programas}" id="programa_o${i}" optionKey="id" optionValue="descripcion" name="programa" value="${asg.programa?.id}" class="programa"  />
                    </td>
                    <g:set var="asignado"
                           value="${asignado.toDouble()+asg.planificado}"></g:set>
                    <td class="anio">
                        ${actual.anio}
                        <input type="hidden" name="anio" value="${actual.id}">

                    </td>
                    <td class="prsp">
                        <input type="hidden" class="prsp" value="${asg.presupuesto.id}">
                        <input type="text" id="prsp_o${i}" style="width: 80px;color:black"
                            ${(actual.estado==0)?'class="buscar"':'disabled'} value="${asg.presupuesto.numero}">
                    </td>
                    <td class="tipo"><g:select
                            from="${tipoGastos}"
                            name="tipoGasto" optionKey="id" optionValue="descripcion"
                            value="${asg.tipoGasto.id}"/></td>
                    <td class="valor"><input type="text" style="width: 80px;color:black"
                                             class="valor act_${act.id} ocho save"
                                             value="${asg.planificado.toFloat().round(2)}" ${(actual.estado==0)?'':'disabled'}></td>
                    <td>
                        <g:if test="${actual.estado==0}">
                            <a href="#" class="btn guardar ajax" ml="${act.id}"
                               iden="${asg.id}" icono="ico_o${i}"
                               clase="act_${act.id}" asg="asignado_${act.id}" divTotal="asignado_ocho" tipo="ocho">Guardar</a>
                        </g:if>
                    </td>
                    <td class="ui-state-active"><span class="" id="ico_o${i}"
                                                      title="asignado"><span
                                class="ui-icon ui-icon-check"></span></span></td>
                </tr>
            </g:if>
            <g:else>
                <g:if test="${actual.estado==0}">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td style="width: 200px;">${act.toString()}</td>
                        <td class="fuente">
                            <g:select from="${fuentes}" id="fuente_${i}" optionKey="id" optionValue="descripcion" name="fuente" value="" class="fuente"   />
                        </td>
                        <td class="programa">
                            <g:select from="${programas}" id="programac_o${i}" optionKey="id" optionValue="descripcion" name="programa" class="programa"  />
                        </td>
                        <td class="anio">
                            ${actual.anio}
                            <input type="hidden" name="anio" value="${actual.id}">
                        </td>
                        <td class="prsp">
                            <input type="hidden" class="prsp" value="${mies.Presupuesto.findByNumero(act.codigo)?.id}">
                            <input type="text" id="prsp_o${i}" style="width: 80px;color:black" ${(actual.estado==0)?'class="buscar"':'disabled'} value="${act.codigo}">
                        </td>
                        <td class="tipo">
                            <g:select from="${tipoGastos}"
                                      name="tipoGasto" optionKey="id" optionValue="descripcion"/>
                        </td>
                        <td class="valor">
                            <input type="text" style="width: 80px;color:black"
                                   class="valor act_${act.id} ocho" value="0">

                        </td>
                        <td>
                            <a href="#" class="btn guardar ajax" ml="${act.id}" fuente=""
                               icono="ico_o${i}" max="" clase="act_${act.id}"
                               asg="asignado_${act.id}" divTotal="asignado_ocho" tipo="ocho">Guardar</a>
                        </td>
                        <td class="ui-state-active">
                            <span style="display: none;" id="ico_o${i}" title="asignado">
                                <span class="ui-icon ui-icon-check"></span>
                            </span>
                        </td>
                    </tr>
                </g:if>
            </g:else>

        </g:each>
        </tbody>
    </table>
    <div class="ui-corner-all" style="height: 15px;margin-top: 20px;margin-bottom: 10px;margin-left: 10px;">
        <div style="width: 150px;float: left"><b>Asignado:</b> </div>
        <div id="asignado_ocho" class="asignado" style="width: 100px;float: left" >${asignado.toFloat().round(2)}</div>
        <g:if test="${actual.estado==0}">
            <div style="width: 310px;float: left;" >El total es calculado solo con los valores guardados (  </div> <div class="ui-state-active" style="width: 18px;float: left;height: 20px;margin-right: 2px;"><span  title="asignado">
            <span class="ui-icon ui-icon-check"></span>
        </span></div> )
            <br>
        </g:if>
        <g:else>
            <div style="width: 380px;float: left;" ><b>Las asignaciones para este año ya han sido aprobadas</b>  </div>
        </g:else>
    </div>
</div>
<div id="tabs-3">
    <table style="width: 900px;">
        <thead>
        <th style="width: 200px;">Actividad</th>
        <th>Fuente</th>
        <th>Programa</th>
        <th>Año</th>
        <th>Presupuesto</th>
        <th>Tipo de gasto</th>
        <th>Valor</th>
        <th></th>
        </thead>
        <tbody>
        <g:set var="asignado" value="0"></g:set>
        <g:each in="${nueve}" var="act" status="i">
            %{--<g:set var="asg" value="${mies.Asignacion.findAll('from Asignacion where actividad='+act.id+' and unidad= '+unidad.id+' and anio = '+actual.id)}"></g:set>--}%
            <g:set var="asg" value="${mies.Asignacion.findAllByActividadAndUnidadAndAnio(act, unidad, actual)}"/>
            <g:if test="${asg}">
                <g:set var="asg" value="${asg.pop()}"></g:set>
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td style="width: 200px;">${act.toString()}</td>
                    <td class="fuente">
                        <g:select from="${fuentes}" id="fuente_${i}" optionKey="id" optionValue="descripcion" name="fuente" value="${asg.fuente.id}" class="fuente"   />
                    </td>
                    <td class="programa">
                        <g:select from="${programas}" id="programa_n${i}" optionKey="id" optionValue="descripcion" name="programa" value="${asg.programa?.id}" class="programa"  />
                    </td>
                    <g:set var="asignado"
                           value="${asignado.toDouble()+asg.planificado}"/>
                    <td class="anio">
                        ${actual.anio}
                        <input type="hidden" name="anio" value="${actual.id}">
                    </td>
                    <td class="prsp">
                        <input type="hidden" class="prsp" value="${asg.presupuesto.id}">
                        <input type="text" id="prsp_n${i}" style="width: 80px;color:black"
                            ${(actual.estado==0)?'class="buscar"':'disabled'} value="${asg.presupuesto.numero}">
                    </td>
                    <td class="tipo"><g:select
                            from="${tipoGastos}"
                            name="tipoGasto" optionKey="id" optionValue="descripcion"
                            value="${asg.tipoGasto.id}"/></td>
                    <td class="valor">
                        <input type="text" style="width: 80px;color:black" class="valor act_${act.id} nueve save" value="${asg.planificado.toFloat().round(2)}" ${(actual.estado==0)?'':'disabled'}>
                    </td>
                    <td>
                        <g:if test="${actual.estado==0}">
                            <a href="#" class="btn guardar ajax" ml="${act.id}"
                               iden="${asg.id}" icono="ico_n${i}"
                               clase="act_${act.id}" asg="asignado_${act.id}" divTotal="asignado_nueve" tipo="nueve">Guardar</a>
                        </g:if>
                    </td>
                    <td class="ui-state-active"><span class="" id="ico_n${i}"
                                                      title="asignado"><span
                                class="ui-icon ui-icon-check"></span></span></td>
                </tr>
            </g:if>
            <g:else>
                <g:if test="${actual.estado==0}">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td style="width: 200px;">${act.toString()}</td>
                        <td class="fuente">
                            <g:select from="${fuentes}" id="fuente_${i}" optionKey="id" optionValue="descripcion" name="fuente" value="" class="fuente"  />
                        </td>
                        <td class="programa">
                            <g:select from="${programas}" id="programa_n${i}" optionKey="id" optionValue="descripcion" name="programa"  class="programa"  />
                        </td>
                        <td class="anio">
                            ${actual.anio}
                            <input type="hidden" name="anio" value="${actual.id}">
                        </td>
                        <td class="prsp">
                            <input type="hidden" class="prsp" value="${mies.Presupuesto.findByNumero(act.codigo)?.id}">
                            <input type="text" id="prsp_n${i}" style="width: 80px;color:black" ${(actual.estado==0)?'class="buscar"':'disabled'} value="${act.codigo}">
                        </td>
                        <td class="tipo">
                            <g:select from="${tipoGastos}"
                                      name="tipoGasto" optionKey="id" optionValue="descripcion"/>
                        </td>
                        <td class="valor">
                            <input type="text" style="width: 80px;color:black"
                                   class="valor act_${act.id} nueve" value="0">

                        </td>
                        <td>
                            <a href="#" class="btn guardar ajax" ml="${act.id}" fuente=""
                               icono="ico_n${i}"  clase="act_${act.id}"
                               asg="asignado_${act.id}" divTotal="asignado_nueve" tipo="nueve" >Guardar</a>
                        </td>
                        <td class="ui-state-active">
                            <span style="display: none;" id="ico_n${i}" title="asignado">
                                <span class="ui-icon ui-icon-check"></span>
                            </span>
                        </td>
                    </tr>
                </g:if>
            </g:else>

        </g:each>
        </tbody>
    </table>
    <div class="ui-corner-all" style="height: 15px;margin-top: 20px;margin-bottom: 10px;margin-left: 10px;">
        <div style="width: 150px;float: left"><b>Asignado:</b> </div>
        <div id="asignado_nueve" class="asignado" style="width: 100px;float: left" >${asignado.toFloat().round(2)}</div>
        <g:if test="${actual.estado==0}">
            <div style="width: 310px;float: left;" >El total es calculado solo con los valores guardados (  </div> <div class="ui-state-active" style="width: 18px;float: left;height: 20px;margin-right: 2px;"><span  title="asignado">
            <span class="ui-icon ui-icon-check"></span>
        </span></div> )
            <br>
        </g:if>
        <g:else>
            <div style="width: 380px;float: left;" ><b>Las asignaciones para este año ya han sido aprobadas</b>  </div>
        </g:else>
    </div>
</div>





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
    $("#accordion").tabs();
    $("[name=programa]").selectmenu({width: 180});
    $(".btn_arbol").button({icons: { primary: "ui-icon-bullet"}})
    $(".btn").button()
    $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

    $("#breadCrumb").jBreadCrumb({
        beginingElementsToLeaveOpen: 10
    });

    $("#anio_asg").change(function(){
        location.href="${createLink(controller:'asignacion',action:'asignacionesCorrientes')}?id=${unidad.id}&anio="+$(this).val()
    });

    $(".guardar").click(function() {
        var band = true
        var mensaje = ""
        var error
        var asignado = 0
        var padre = $(this).parent().parent()
        var boton = $(this)
        var valorTxt = padre.find(".valor").children()
        valorTxt.removeClass("error")
        var valor = valorTxt.val()
        if (isNaN(valor)) {
            mensaje = "Error: El valor de la asignacion debe ser un número"
            band = false
            error = valorTxt
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
        var fuente = padre.find(".fuente").find(".fuente").val()
        var programa= padre.find(".programa").find(".programa").val()
        var icono = $("#" + $(this).attr("icono"))
        var tipoDiv = $(this).attr("tipo")
        var divTotal=$(this).attr("divTotal")
        if (band) {
            $.ajax({
                type: "POST",
                url: "${createLink(action:'guardarAsignacion',controller:'asignacion')}",
                data:"anio.id=" + anio + "&fuente.id=" + fuente +"&programa.id="+programa+ "&planificado=" + valor + "&tipoGasto.id=" + tipo + "&presupuesto.id=" + prsp + "&actividad.id=" + ml+"&unidad.id=${unidad.id}" + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                success: function(msg) {
                    if (msg*1>=0) {
                        var total = 0
                        boton.attr("iden",msg)
                        valorTxt.addClass("save")
                        $.each($("."+tipoDiv),function(){
                            if($(this).hasClass("save"))
                                total+=$(this).val()*1
                        });
                        $("#"+divTotal).html(total)
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