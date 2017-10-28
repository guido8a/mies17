<%@ page import="mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Modificaciones al POA de la unidad: ${unidad}</title>

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
<g:if test="${msg}">
    <div style="width: 800px;margin-top: 10px;background: rgba(14,83,143,0.2);height: 30px;line-height: 30px;padding-left: 10px;font-size: 14px;margin-bottom: 10px;"  class="ui-corner-all" id="estado">
        <b>${msn}</b>
    </div>
</g:if>
<div style="margin-left: 10px;">
    <g:if test="${actual.estado!=0}">
        <g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad" params="${[unidad:unidad.id,anio:actual.id]}">Solicitar modificación</g:link>
    </g:if>
    <g:link class="btn" controller="modificacion" action="programacionAsignacionesMod" id="${unidad.id}">Programación</g:link>
    <a href="${createLink(controller: 'modificacion', action: 'poaCorrientesMod')}?id=${unidad.id}&anio=${actual.id}&todo=1" class="btn">Ver todas</a>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    <g:link class="btn" controller="modificacion" action="poaCorrientesMod" id="${unidad.id}">Resetear</g:link>
    <g:link class="btn" controller="modificacion" action="verModificacionesPoa" params="[id:unidad.id,anio:actual.id]">Ver modificaciones</g:link>
    <g:link class="btn" controller="modificacion" action="poaInversionesMod" params="[id:unidad.id,anio:actual.id]">Asignaciones de inversión</g:link>
    <div style="margin-top: 15px;">
        <b>Año:</b>
        <g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
        &nbsp;&nbsp;&nbsp;
        <b>Programa:</b>
        <g:select from="${programas}" id="programa" optionKey="id" name="programa" class="programa" value="${programa.id}"/>
    </div>
</div>
<input type="hidden" id="id_origen">
<input type="hidden" id="id_destino">
<fieldset class="ui-corner-all" style="min-height: 110px;font-size: 11px;">
    <legend>
        Asignacion de origen
    </legend>
    <table style="width: 1000px;margin-bottom: 10px;">
        <thead>

        <th style="width: 280px">Programa</th>
        <th>Actividad</th>
        <th style="width: 60px;">Partida</th>
        <th style="width: 240px">Desc. Presupuestaria</th>

        <th>Fuente</th>
        <th>Presupuesto</th>

        </thead>
        <tbody>

        <tr class="odd" id="tr_origen">
            <td class="programa_org">

            </td>

            <td class="actividad_org">

            </td>

            <td class="prsp_org" style="text-align: center">

            </td>

            <td class="desc_org" style="width: 240">

            </td>

            <td class="fuente_org">

            </td>

            <td class="valor_org" style="text-align: right">

            </td>


        </tr>
        </tbody>
    </table>

</fieldset>
<fieldset class="ui-corner-all" style="min-height: 110px;font-size: 11px;">
    <legend>
        Asignacion de destino
    </legend>
    <table style="width: 1000px;margin-bottom: 10px;">
        <thead>

        <th style="width: 280px">Programa</th>
        <th>Actividad</th>
        <th style="width: 60px;">Partida</th>
        <th style="width: 240px">Desc. Presupuestaria</th>

        <th>Fuente</th>
        <th>Presupuesto</th>

        </thead>
        <tbody>

        <tr class="odd" id="tr_dest">
            <td class="programa_dest" id="">

            </td>

            <td class="actividad_dest">

            </td>

            <td class="prsp_dest" style="text-align: center">

            </td>

            <td class="desc_dest" style="width: 240">

            </td>

            <td class="fuente_dest">

            </td>

            <td class="valor_dest" style="text-align: right">

            </td>


        </tr>
        </tbody>
    </table>
</fieldset>

<a href="#" class="btn" id="modificar">Modificar</a>
<a href="#" class="btn" id="buscarAsg">Buscar Asignación</a>
<a href="${g.createLink(action: 'nuevaAsignacionCorrienteMod',controller: 'modificacion',id: unidad.id)}" class="btn" id="crearNueva">Crear Nueva</a>

<fieldset class="ui-corner-all" style="min-height: 100px;font-size: 11px">
    <legend>
        Detalle
    </legend>
    <g:set var="total" value="0"></g:set>
    <table style="width: 1000px;margin-bottom: 10px;">
        <thead>
        <th>Id</th>
        <th style="width: 280px">Programa</th>
        <th>Actividad</th>
        <th style="width: 60px;">Partida</th>
        <th style="width: 240px">Desc. Presupuestaria</th>

        <th>Fuente</th>
        <th>Presupuesto</th>
        <th></th>
        </thead>
        <tbody>
        <g:each in="${asignaciones}" var="asg" status="i">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="det_${i}">
                <td>${asg.id}</td>
                <td class="programa">
                    ${asg.programa.descripcion}
                </td>

                <td class="actividad">
                    ${asg.actividad}
                </td>

                <td class="prsp" style="text-align: center">
                    ${asg.presupuesto.numero}
                </td>

                <td class="desc" style="width: 240">
                    ${asg.presupuesto.descripcion}
                </td>

                <td class="fuente">
                    ${asg.fuente.descripcion}
                </td>

                <td class="valor" style="text-align: right">
                    <g:formatNumber number="${(asg.redistribucion==0)?asg.planificado.toFloat():asg.redistribucion.toFloat()}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                    <g:set var="total" value="${total.toDouble()+((asg.redistribucion==0)?asg.planificado.toDouble():asg.redistribucion.toDouble())}"></g:set>
                </td>

                <td style="text-align: center">

                    <a href="#" class="btn origen ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}" prog="${asg.programa}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}" fuente="${asg.fuente}" valor="${(asg.redistribucion == 0) ? asg.planificado.toFloat().round(2) : asg.redistribucion.toFloat().round(2)}" actv="${asg.actividad}">
                        Reducción
                    </a>
                    <a href="#" class="btn destino ajax" iden="${asg.id}" icono="ico_001" clase="act_" band="0" tr="#det_${i}" prog="${asg.programa}" prsp_id="${asg.presupuesto.id}" prsp_num="${asg.presupuesto.numero}" desc="${asg.presupuesto.descripcion}" fuente="${asg.fuente}" valor="${(asg.redistribucion == 0) ? asg.planificado.toFloat().round(2) : asg.redistribucion.toFloat().round(2)}" actv="${asg.actividad}">
                        Incremento
                    </a>
                </td>
                <td class="agr">
                    <g:if test="${actual.estado==0}">
                        <a href="#" class="btn_agregar" asgn="${asg.id}" anio="${actual.id}">Dividir en dos partidas</a>
                    %{--<g:if test="${asg.padre != null}">--}%
                    %{--<a href="#" class="btn_borrar" asgn="${asg.id}">Eliminar la Asignación</a>--}%
                    %{--</g:if>--}%
                    </g:if>
                </td>
            </tr>

        </g:each>
        </tbody>
    </table>

    <div style="position: absolute;top:5px;right:10px;font-size: 15px;">
        <b>Total programa actual:</b>
        <g:formatNumber number="${total.toFloat()}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:25px;right:10px;font-size: 15px;">
        <b>Total Unidad:</b>
        <g:formatNumber number="${totalUnidad}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:45px;right:10px;font-size: 15px;">
        <b>M&aacute;ximo Corrientes:</b>
        <g:formatNumber number="${maxUnidad}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:65px;right:10px;font-size: 17px;">
        <b>Restante:</b>
        <input type="hidden" id="restante" value="${(maxUnidad - totalUnidad).toFloat().round(2)}">
        <g:formatNumber number="${maxUnidad - totalUnidad}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

</fieldset>


<div id="modificar_dlg">
    <g:form action="guardarReasignacion" class="frm_modpoa" enctype="multipart/form-data">
        <input type="hidden" id="h_origen" name="origen">
        <input type="hidden" id="h_destino" name="destino">
        <input type="hidden" id="unidad" name="unidad" value="${unidad.id}">
        <div style="height: 40px">
            <div style="width: 170px;height: 35px;float: left"><b>Monto de la reasignación:</b></div> <input type="text" style="width: 100px;" id="monto" name="monto"> Máximo:<span id="max"></span>
        </div>

        %{--<div id="div_sel_unidad" class="ui-corner-all" style="margin-top: 5px;margin-bottom: 15px">--}%

            %{--<b>Enviar a:</b> <g:select from="${mies.UnidadEjecutora.list([sort:'nombre'])}" optionKey="id" optionValue="nombre" name="unidadInv" id="unidadInv" ></g:select> <br>--}%
            %{--El valor de la reasignación se incrementara al techo de inversión de la unidad ejecutora seleccionada--}%

        %{--</div>--}%
        <div style="margin-top: 10px;">
            <div style="width: 170px;height: 35px;float: left"><b> Autorización:</b></div> <input type="file" name="archivo" id="archivo">
        </div>
    </g:form>

    <div style="width: 95%;height: 45px;background: rgba(255,0,0,0.3);margin-top: 10px;padding-left: 5px;text-align: left" class="ui-corner-all">
        <b>Recuerde que despues de cada modificación las asignaciones de origen y destino deben REPROGRAMARSE</b>
    </div>

</div>


<div id="ajx_asgn" style="width:520px;"></div>
<div id="buscarAsg_dlg">


    <div style="margin-bottom: 10px">
        <b>Unidad:</b><g:select from="${mies.UnidadEjecutora.list([sort:'nombre'])}" optionKey="id" optionValue="nombre" name="unidad" id="unidadAsg" noSelection="['-1':'Todas']"></g:select><br><br>
        <b>Partida:</b>  <input type="hidden" class="prsp" value="${asignacionInstance?.presupuesto?.id}" id="prsp2" name="presupuesto.id">
        <input type="text" id="prsp_desc2" desc="desc2" style="width: 100px;border: 1px solid black;text-align: center" class="buscar ui-corner-all">
        <span style="font-size: smaller;">Haga clic para consultar</span><br>



    </div>
    <a href="#" class="btn" id="btn_buscarAsg">Buscar</a>
    <div id="resultadoAsg" style="width: 450px;margin-top: 10px;" class="ui-corner-all"></div>
</div>

<div id="buscar">
    <input type="hidden" id="id_txt">

    <div>
        Buscar por:
        <select id="tipo">
            <option value="1">Número</option>
            <option value="2">Descripción</option>
        </select>

        <input type="text" id="par" style="width: 160px;">

        <a href="#" class="btn" id="btn_buscar">Buscar</a>
    </div>

    <div id="resultado" style="width: 450px;margin-top: 10px;" class="ui-corner-all"></div>
</div>
<div id="load">
    <img src="${g.resource(dir:'images',file: 'loading.gif')}" alt="Procesando">
    Procesando
</div>


<script type="text/javascript">



    $(function () {
        $("#h_origen").val("")
        $("#h_destino").val("")
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


        $(".origen").button({icons:{ primary:"ui-icon-arrowrefresh-1-n"},text:false}).click(function(){
            if($("#id_destino").val()!=$(this).attr("iden")){
                $(".programa_org").html($(this).attr("prog"))
                $(".fuente_org").html($(this).attr("fuente"))
                $(".valor_org").html(number_format($(this).attr("valor")*1, 2, ",", "."))
                $(".valor_org").attr("valor",$(this).attr("valor"))
                $(".prsp_org").html($(this).attr("prsp_num"))
                $(".desc_org").html($(this).attr("desc"))
                $("#id_origen").val($(this).attr("iden"))
                $(".actividad_org").html($(this).attr("actv"))
            }else{
                alert("La asignaciones de origen y destino no pueden ser la misma")
            }
        });
        $(".destino").button({icons:{ primary:"ui-icon-arrowrefresh-1-s"},text:false}).click(function(){
            if($("#id_origen").val()!=$(this).attr("iden")){
                $(".programa_dest").html($(this).attr("prog"))
                $(".fuente_dest").html($(this).attr("fuente"))
                $(".valor_dest").html(number_format($(this).attr("valor")*1, 2, ",", "."))
                $(".valor_dest").attr("valor",$(this).attr("valor"))
                $(".prsp_dest").html($(this).attr("prsp_num"))
                $(".desc_dest").html($(this).attr("desc"))
                $("#id_destino").val($(this).attr("iden"))
                $(".actividad_dest").html($(this).attr("actv"))
            } else{
                alert("La asignaciones de origen y destino no pueden ser la misma")
            }
        });

        $("[name=programa]").selectmenu({width:550, height:50})
        $("#programa-button").css("height", "40px")
        $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
        $(".btn").button()
        $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

        $("#breadCrumb").jBreadCrumb({
            beginingElementsToLeaveOpen:10
        });

        $(".editar").click(function () {
            $("#programa").selectmenu("value", $(this).attr("prog"))
            $("#fuente").val($(this).attr("fuente"))
            $("#valor_txt").val($(this).attr("valor"))
            $("#prsp_id").val($(this).attr("prsp_id"))
            $("#prsp_num").val($(this).attr("prsp_num"))
            $("#desc").html($(this).attr("desc"))
            $("#guardar_btn").attr("iden", $(this).attr("iden"))
            $("#actv").val($(this).attr("actv"))
        });

        $("#anio_asg, #programa").change(function () {
            location.href = "${createLink(controller:'modificacion',action:'poaCorrientesMod')}?id=${unidad.id}&anio=" + $("#anio_asg").val() + "&programa=" + $("#programa").val();
        });


        $("#modificar").click(function(){
            $("#div_sel_unidad").hide()
            $("#h_origen").val($("#id_origen").val())
            if($("#h_origen").val()==""){
                alert("Seleccione una asignación de origen")
            }else{
                $("#h_destino").val($("#id_destino").val())
                if( $("#h_destino").val()==""){
                    alert("Seleccione una asignación de destino")
                   // $("#div_sel_unidad").show("slide")
                }else{
                    $("#modificar_dlg").dialog("open")
                    $("#max").html(number_format($(".valor_org").attr("valor")*1, 2, ",", "."))
                    $("#max").attr("valor",$(".valor_org").attr("valor"))
                }
            }

        });


        $("#modificar_dlg").dialog({
            title:"Modificaciones POA",
            width:580,
            height:330,
            autoOpen:false,
            modal:true,
            buttons:{
                "Cancelar":function(){
                    $("#modificar_dlg").dialog("close")
                },"Aceptar":function(){
                    if(confirm("Esta seguro que desea modificar la asignación")){

                        var monto = $("#monto").val()
                        var max = $("#max").attr("valor")*1
                        monto = str_replace(".","",monto)
                        monto = str_replace(",",".",monto)
                        if(isNaN(monto)){
                            alert("El monto debe ser un número")
                        }else{
                            monto = monto*1
                            if(monto>max){
                                alert("El monto debe ser menor a "+number_format(max, 2, ",", "."))
                            }else{
                                if(monto>0){
                                    if($("#archivo").val()!=""){
                                        $("#load").dialog("open")
                                        $("#monto").val(monto)
                                        $(".frm_modpoa").submit()
                                    } else{
                                        alert("El archivo de autorización es obligatorio.")
                                    }

                                }else
                                    alert("El monto debe ser mayor a cero")
                            }
                        }


                    }

                }
            }
        })


        $(".btn_agregar").button({
            icons:{
                primary:"ui-icon-carat-2-n-s"
            },
            text:false
        }).click(function () {
                    //alert ("id:" +$(this).attr("asgn"))
                    if (confirm("Dividir esta asignación con otra partida")) {
                        $.ajax({
                            type:"POST", url:"${createLink(action:'agregaAsignacionMod', controller: 'asignacion')}",
                            data:"id=" + $(this).attr("asgn") + "&proy=" + $(this).attr("proy") + "&anio=" + $(this).attr("anio")+"&unidad=${unidad.id}",
                            success:function (msg) {
                                $("#ajx_asgn").dialog("option", "title", "Dividir la asignación para ..")
                                $("#ajx_asgn").html(msg).show("puff", 100)
                            }
                        });
                        $("#ajx_asgn").dialog("open");
                    }
                });

        $(".btn_borrar").button({
            icons:{
                primary:"ui-icon-trash"
            },
            text:false
        }).click(function () {
                    //alert ("id:" +$(this).attr("asgn"))
                    if (confirm("Eliminar esta asignación: \n Su valor se sumará a su asignación original y\n la programación deberá revisarse")) {
                        $.ajax({
                            type:"POST", url:"${createLink(action:'borrarAsignacion', controller: 'asignacion')}",
                            data:"id=" + $(this).attr("asgn"),
                            success:function (msg) {
                                location.reload(true);
                            }
                        });
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
            open:function (event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            buttons:{
                "Grabar":function () {
                    var asgn = $('#padre').val()
                    var mxmo = parseFloat($('#maximo').val());
                    var valor = str_replace(".", "", $('#vlor').val());
                    valor = str_replace(",", ".", valor);
                    valor = parseFloat(valor);
                    $('#vlor').val(valor)
                    //alert("Valores: maximo " + mxmo + " valor: " + valor);
                    if (valor >= mxmo) {
                        alert("La nueva asignación debe ser menor a " + mxmo);
                    } else {
                        var partida = $('#prsp2').val()
                        var fuente = $('#fuente').val();
                        $(this).dialog("close");
                        $(".frmModAsignaciones").submit()
                    }
                },
                "Cancelar":function () {
                    $(this).dialog("close");
                }
            }
        });



        ////////////////////////////////////**********BUSCADOR************////////////////////////////
        $("#buscarAsg").click(function () {

            $("#buscarAsg_dlg").dialog("open")
        });
        $("#btn_buscarAsg").click(function () {
            $.ajax({
                type:"POST",
                url:"${createLink(action:'buscarAsignacion',controller:'modificacion')}",
                data:"unidad=" + $("#unidadAsg").val() + "&partida=" + $("#prsp2").val()+"&anio=${actual.id}",
                success:function (msg) {
                    $("#resultadoAsg").html(msg)
                }
            });
        });
        $("#buscarAsg_dlg").dialog({
            title:"Busqueda de asignaciones",
            width:900,
            height:600,
            autoOpen:false,
            modal:true
        })


    });


    $(".buscar").click(function () {
        $("#id_txt").val($(this).attr("id"))
        $("#buscar").dialog("open")
    });

    $("#btn_buscar").click(function () {
        $.ajax({
            type:"POST",
            url:"${createLink(action:'buscarPresupuesto',controller:'asignacion')}",
            data:"parametro=" + $("#par").val() + "&tipo=" + $("#tipo").val(),
            success:function (msg) {
                $("#resultado").html(msg)
            }
        });
    });
    $("#buscar").dialog({
        title:"Cuentas presupuestarias",
        width:520,
        height:500,
        autoOpen:false,
        modal:true
    })





</script>

</body>
</html>