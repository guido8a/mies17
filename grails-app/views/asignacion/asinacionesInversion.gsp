<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones de inversión de la unidad: ${unidad}, para el año ${actual}</title>
</head>
<body>
<div style="margin-left: 10px;">

    <g:link class="btn" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    <g:link class="btn" controller="asignacion" action="programacionInversion" id="${unidad.id}">Programación</g:link>
    <g:link class="btn" controller="reportes" action="distribuciones" params="[id:unidad.id,anio:actual.id]">Reporte Distribuciones</g:link>
    %{--<g:link class="btn" controller="asignacion" action="asignacionesInversionv2" params="[id:unidad.id,anio:actual.id]">Agregar/Editar</g:link>--}%
    %{--<a href="#" id="btnReporte">Reporte</a>--}%

</div>

<div class="message">Recuerde que para hacer uso de asignaciones enviadas por otra unidad debe primero dividirlas.</div>

<fieldset class="ui-corner-all" style="min-height: 100px;font-size: 11px">
    <legend>
        Asignaciones de inversión
    </legend>

    <table style="width: 100%; margin-bottom: 10px;">
        <thead>
        <th style="width: 20px" class="ui-state-default">ID</th>
        <th style="width: 150px" class="ui-state-default">Proyecto</th>
        <th style="width: 220px" class="ui-state-default">Programa</th>
        <th style="width: 120px" class="ui-state-default">Componente</th>
        <th style="width: 240px" class="ui-state-default">Actividad</th>
        <th style="width: 60px;" class="ui-state-default">Partida</th>
        <th style="width: 200px" class="ui-state-default">Desc. Presupuestaria</th>

        <th class="ui-state-default">Fuente</th>
        <th class="ui-state-default">Presupuesto</th>
        <th class="ui-state-default"></th>
        </thead>
        <tbody>
        <g:set var="total" value="${0}"></g:set>
        <g:each in="${asgs}" var="asg" status="i">

            <tr style="background: #b9e24b" id="det_${i}">
                <td></td>
                <td class="proyecto">
                    ${asg.marcoLogico.proyecto.nombre}

                </td>
                <td class="programa">
                    ${asg.marcoLogico.proyecto.programaPresupuestario}

                </td>

                <td>
                    ${asg.marcoLogico.marcoLogico.toStringCompleto()}
                </td>

                <td class="actividad">
                    ${asg.marcoLogico.toStringCompleto()}
                </td>

                <td class="prsp" style="text-align: center">
                    ${asg.presupuesto.numero}
                </td>

                <td class="desc" style="width: 200">
                    ${asg.presupuesto.descripcion}
                </td>

                <td class="fuente">
                    ${asg.fuente.descripcion}
                </td>

                <td class="valor" style="text-align: right">
                    <g:set var="dist" value="${mies.DistribucionAsignacion.findByAsignacionAndUnidadEjecutora(asg,unidad)}"></g:set>
                    <g:set var="valor"  value="${dist.getValorReal()}"></g:set>
                    <g:formatNumber number="${valor}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                    <g:set var="total" value="${total.toDouble()+valor}"></g:set>
                </td>
                <td class="agr">

                    <a href="#" class="btn_agregar" asgn="${asg.id}" proy="${asg.marcoLogico.proyecto.id}" dist="${dist.id}" anio="${actual.id}">Dividir en dos partidas</a>
                    <g:if test="${asg.padre != null}">
                        <a href="#" class="btn_borrar" asgn="${asg.id}">Eliminar la Asignación</a>
                    </g:if>

                </td>

            </tr>

        </g:each>
        <g:each in="${asgInv}" var="asg" status="i">
            <g:if test="${asg.planificado>0}">

            %{--<g:if test="${asg.padre.reubicada.trim()=='S'}">--}%
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="det_${i}" style='${(asg.reubicada=='S')?"background: #d5f0d4":""}'>
                    <td>${asg.id}</td>
                    <td class="proyecto">
                        ${asg.marcoLogico.proyecto.nombre}

                    </td>
                    <td class="programa">
                        ${asg.marcoLogico.proyecto.programaPresupuestario}

                    </td>

                    <td>
                        ${asg.marcoLogico.marcoLogico.toStringCompleto()}
                    </td>

                    <td class="actividad">
                        ${asg.marcoLogico.toStringCompleto()}
                    </td>

                    <td class="prsp" style="text-align: center">
                        ${asg.presupuesto.numero}
                    </td>

                    <td class="desc" style="width: 200">
                        ${asg.presupuesto.descripcion}
                    </td>

                    <td class="fuente">
                        ${asg.fuente.descripcion}
                    </td>

                    <td class="valor" style="text-align: right">
                        <g:set var="valor"  value="${asg.planificado}"></g:set>
                        <g:formatNumber number="${valor}"
                                        format="###,##0"
                                        minFractionDigits="2" maxFractionDigits="2"/>
                        <g:set var="total" value="${total.toDouble()+valor}"></g:set>
                    </td>

                    <td class="agr">

                        <a href="#" class="btn_agregar" asgn="${asg.id}" proy="${asg.marcoLogico.proyecto.id}"
                           anio="${actual.id}">Dividir en dos partidas</a>
                        <g:if test="${asg.padre != null}">
                            <a href="#" class="btn_borrar" asgn="${asg.id}">Eliminar la Asignación</a>
                        </g:if>

                    </td>



                </tr>
            </g:if>
        %{--</g:if>--}%

        </g:each>
        <tr>
            <td colspan="8">TOTAL</td>
            <td style="text-align: right"><g:formatNumber number="${total}"
                                                          format="###,##0"
                                                          minFractionDigits="2" maxFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>



</fieldset>

<div id="load">
    <img src="${g.resource(dir:'images',file: 'loading.gif')}" alt="Procesando">
    Procesando
</div>

<div id="ajx_asgn" style="width:520px;"></div>
<script type="text/javascript">
    $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
    $(".btn").button()
    $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

    $("#load").dialog({
        width:100,
        height:100,
        position:"center",
        title:"Procesando",
        modal:true,
        autoOpen:false,
        resizable:false,
        open: function(event, ui) {
            $(event.target).parent().find(".ui-dialog-titlebar-close").remove()
        }
    });


    $("#env").button().click(function(){
        var band = true
        if($("#cmb_env").val()=="-1"){
            alert("Seleccione una unidad ejecutora")
            band=false
        }else{

            var monto = $("#monto_env").val()
            monto = str_replace(".","",monto)
            monto = str_replace(",",".",monto)
            monto=monto*1
            if(isNaN(monto))
                monto=0
            if(monto<=0){
                alert("El monto deber ser un número mayor a 0")
                band=false
            }else{
                var max = $("#max").val()*1-$("#dist").val()*1
                if(monto>max){
                    alert("El monto deber ser menor a "+number_format(max, 2, ",", "."))
                    band = false
                }
            }
        }


        if(band){
            $.ajax({
                type:"POST", url:"${createLink(action:'enviarUnidad', controller: 'asignacion')}",
                data:"id=" + $("#env_id").val() + "&unidad=" +$("#cmb_env").val()+"&monto="+monto,
                success:function (msg) {

                    $("#detalle").html(msg).show("slide")
                    $("#lbl_max").html(number_format($("#max").val()*1-$("#dist").val()*1, 2, ",", "."))
                }
            });
        }

    }) ;

    $(".btn_env").button({
        icons:{
            primary:"ui-icon-refresh"
        },
        text:false
    }).click(function(){
                $("#monto_env").val("0,00")
                $("#env_id").val($(this).attr("asgn"))
                $("#cmb_env").val($(this).attr("env"))
                $("#env_btn").val($(this).attr("id"))
                $("#max").val($(this).attr("valor"))
                $.ajax({
                    type:"POST", url:"${createLink(action:'enviarUnidad', controller: 'asignacion')}",
                    data:"id=" + $("#env_id").val(),
                    success:function (msg) {
                        $("#dlg_env").dialog("open")
                        $("#detalle").html(msg).show("slide")
                        $("#lbl_max").html(number_format($("#max").val()*1-$("#dist").val()*1, 2, ",", "."))


                    }
                });

            });

    $("#anio_asg").change(function () {
        location.href = "${createLink(controller:'asignacion',action:'asinacionesInversion')}?id=${unidad.id}&anio=" + $(this).val()
    });
    $(".btn_agregar").button({
        icons:{
            primary:"ui-icon-carat-2-n-s"
        },
        text:false
    }).click(function () {
                //alert ("id:" +$(this).attr("asgn"))


                if (confirm("Dividir esta asignación con otra partida")) {
                    $.ajax({
                        type:"POST", url:"${createLink(action:'agregaAsignacion', controller: 'asignacion')}",
                        data:"id=" + $(this).attr("asgn") + "&proy=" + $(this).attr("proy") + "&anio=" + $(this).attr("anio")+"&dist="+$(this).attr("dist"),
                        success:function (msg) {

                            $("#ajx_asgn").dialog("option", "title", "Dividir la asignación para ..")
                            $("#ajx_asgn").html(msg)
                            $("#ajx_asgn").dialog("open");

                        }
                    });


                }
            });

    $(".btn_borrar").button({
        icons:{
            primary:"ui-icon-trash"
        },
        text:false
    }).click(function () {
                $("#load").dialog("open")
                if (confirm("Eliminar esta asignación: \n Su valor se sumará a su asignación original y\n la programación deberá revisarse. La asignación no se eliminara si tiene distribuciones derivadas")) {
                    $.ajax({
                        type:"POST", url:"${createLink(action:'borrarAsignacion', controller: 'asignacion')}",
                        data:"id=" + $(this).attr("asgn"),
                        success:function (msg) {
                            if(msg=="ok")
                                location.reload(true);
                            else{
                                $("#load").dialog("close")
                                alert("Error al eliminar la asignación. Asegurese que no tenga distribuciones ni asignaciones hijas")
                            }

                        }
                    });
                }else{
                    $("#load").dialog("close")
                }
            });

    $("#ajx_asgn").dialog({
        autoOpen:false,
        resizable:false,
        title:'Crear un Perfil',
        modal:true,
        draggable:true,
        width:480,
        height:300,
        position:'center',
        buttons:{
            "Grabar":function () {
                var asgn = $('#padre').val()
                var mxmo = parseFloat($('#maximo').val());
                mxmo = Math.round(mxmo*100)/100
                var valor = str_replace(".", "", $('#vlor').val());
                valor = str_replace(",", ".", valor);
                valor = parseFloat(valor);
                //alert("Valores: maximo " + mxmo + " valor: " + valor);

                if (valor > mxmo) {
                    alert("La nueva asignación debe ser menor a " + mxmo);
                } else {
                    var partida = $('#prsp2').val()
                    var fuente = $('#fuente').val();
                    $(this).dialog("close");
                    $.ajax({
                        type:"POST", url:"${createLink(action:'creaHijoInversion', controller: 'asignacion')}",
                        data:"id=" + asgn + "&fuente=" + fuente + "&partida=" + partida + "&valor=" + valor+"&unidad=${unidad.id}",
                        success:function (msg) {
                            //alert("se ha creado la asignación: " + msg)
                            location.reload(true);

                        }
                    });
                }
            },
            "Cancelar":function () {
                $(this).dialog("close");
            }
        }
    });


    $("#dlg_env").dialog({
        autoOpen:false,
        resizable:false,
        title:'Enviar esta asignación al P.O.A. de una unidad ejecutora',
        modal:true,
        draggable:true,
        width:520,
        height:750,
        position:'center',
        open:function (event, ui) {
            $(".ui-dialog-titlebar-close").hide();
        },
        buttons:{

            "Cerrar":function () {
                $(this).dialog("close");
            }
        }
    });


</script>
</body>
</html>