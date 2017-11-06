<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones del proyecto: ${proyecto}</title>

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
        <g:link class="btn" controller="modificacionProyecto" action="solicitarModificacionUnidad"
                params="${[unidad:proyecto.unidadEjecutora.id,anio:actual.id]}">Solicitar modificación</g:link>
    </g:if>
    <g:link class="btn" controller="asignacion" action="programacionAsignacionesInversion" id="${proyecto.id}">Programación</g:link>
    <g:link class="btn" controller="reportes" action="poaInversionesReporteWeb" id="${proyecto.unidadEjecutora.id}" target="_blank">Reporte</g:link>
    <g:link class="btn" controller="cronograma" action="verCronograma" id="${proyecto.id}">Cronograma</g:link>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
    <g:link class="btn" controller="asignacion" action="agregarAsignacionInv" id="${proyecto.id}">Agregar asignaciones</g:link>
    &nbsp;&nbsp;&nbsp;<b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
</div>
<fieldset class="ui-corner-all" style="width: 98%;margin-top: 40px;">
    <legend>Asignaciones para el año ${actual}</legend>
    <table style="width: 1040px;">
        <thead>
        %{--<th>#</th>--}%
        <th>ID</th>
        <th style="width: 200px">Programa</th>
        <th style="width: 200px">Componente</th>
        <th style="width: 280px">Actividad</th>
        <th style="width: 60px;">Partida</th>
        <th style="width: 200px">Desc. Presupuestaria</th>
        <th>Fuente</th>
        <th>Presupuesto</th>
        <th></th>
        <th></th>
        </thead>
        <tbody>
        <g:set var="total" value="${0}"></g:set>
        <g:each in="${asignaciones}" var="asg" status="i">
            <g:if test="${asg.planificado>0}">
                <g:set var="total" value="${total.toDouble()+asg.getValorReal()}"></g:set>
            </g:if>
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}"  style='${(asg.reubicada=='S')?"background: #d5f0d4":""}'>

                %{--<td style="width: 30px;">${i+1}</td>--}%
                <td>${asg.id}</td>
                <td class="prog" style="width: 200px;"
                    title="">
                    ${asg.marcoLogico?.proyecto?.programaPresupuestario.descripcion}
                </td>
                <td class="dscr" style="width: 200px;"
                    title="${asg.marcoLogico.marcoLogico.toStringCompleto()}">${asg.marcoLogico.marcoLogico}
                </td>
                <td class="dscr" style="width: 200px;"
                    title="${asg.marcoLogico.toStringCompleto()}">${asg.marcoLogico}
                </td>
                <td>
                    ${asg.presupuesto.numero}
                </td>
                <td>
                    ${asg.presupuesto.descripcion}
                </td>
                <td>${asg.fuente}</td>
                <td class="valor" style="text-align: right">
                    <g:formatNumber number="${asg.getValorReal()}" format="###,##0" minFractionDigits="2"
                                    maxFractionDigits="2"/>
                </td>

                <td class="agr">
                    <g:if test="${actual.estado==0}">
                        <a href="#" class="btn_agregar" asgn="${asg.id}" proy="${proyecto.id}"
                           anio="${actual.id}">Dividir en dos partidas</a>
                        <g:if test="${asg.padre != null}">
                            <a href="#" class="btn_borrar" asgn="${asg.id}">Eliminar la Asignación</a>
                        </g:if>
                    </g:if>
                </td>
                <td>
                    <a href="#" id="env_${i}" class="btn_env" asgn="${asg.id}" proy="${proyecto.id}" anio="${actual.id}" valor="${asg.getValorReal()}">Enviar a unidad ejectura</a>
                </td>
            </tr>
        </g:each>
        <tr>
            <td></td>
            <td><b>TOTAL</b></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="valor" style="text-align: right; font-weight: bold;">
                <g:formatNumber number="${total}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
            </td>


        </tr>
        </tbody>
    </table>

    <div id="ajx_asgn" style="width:520px;"></div>

    <div style="position: absolute;top:5px;right:10px;font-size: 15px;">
        <b>Total invertido proyecto actual:</b>
        <g:formatNumber number="${total.toFloat()}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:25px;right:10px;font-size: 15px;">
        <b>Total Unidad:</b>
        <g:formatNumber number="${totalUnidad ?: 0}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:45px;right:10px;font-size: 15px;">
        <b>M&aacute;ximo Inversiones:</b>
        <g:formatNumber number="${maxInv ?: 0}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>

    <div style="position: absolute;top:65px;right:10px;font-size: 17px;">
        <b>Restante:</b>
        <g:formatNumber number="${(maxInv ?: 0) - (totalUnidad ?: 0)}"
                        format="###,##0"
                        minFractionDigits="2" maxFractionDigits="2"/>
    </div>
    <div id="dlg_env">
        <input type="hidden" id="env_id" value="">
        <input type="hidden" id="env_btn" value="">
        <input type="hidden" id="max" value="">
        <fieldset style="width: 450px;height: 160px;" class="ui-corner-all">
            <legend>Ingreso de datos</legend>
            Monto: <input type="text" id="monto_env" style="width: 100px;height: 20px;margin-left: 7px" class="ui-corner-all"> Máximo: <span id="lbl_max"></span><br> <br>
            Unidad: <g:select from="${mies.UnidadEjecutora.list([sort:'nombre'])}" id="cmb_env" name="unrb" optionKey="id" optionValue="nombre" noSelection="['-1':'Seleccione...']" style="width: 400px" class="ui-corner-all"></g:select>  <br><br>
            <a href="#" class="btn" id="env">Enviar</a>
        </fieldset>
        <fieldset style="width: 450px;height: 400px;" class="ui-corner-all">
            <legend>Detalle</legend>
            <div id="detalle" style="width: 430px;height:360px;overflow-y: auto;margin: auto "></div>
        </fieldset>


    </div>



</fieldset>
<div id="load">
    <img src="${g.resource(dir:'images',file: 'loading.gif')}" alt="Procesando">
    Procesando
</div>
<script type="text/javascript">
    $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
    $(".btn").button()
    $(".back").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'});

    $("#breadCrumb").jBreadCrumb({
        beginingElementsToLeaveOpen:10
    });



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
                var max = $("#max").val()*1
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
                    var dist = $("#max").val()*1-monto
                    $("#lbl_max").html(number_format(dist, 2, ",", "."))
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
                //console.log("max 1" +$("#max").val())
                $.ajax({
                    type:"POST", url:"${createLink(action:'enviarUnidad', controller: 'asignacion')}",
                    data:"id=" + $("#env_id").val(),
                    success:function (msg) {
                        $("#dlg_env").dialog("open")
                        $("#detalle").html(msg).show("slide")
                        $("#lbl_max").html(number_format($("#max").val()*1, 2, ",", "."))
                        //console.log("dis 1 " +$("#dist").val()*1)

                    }
                });

            });

    $("#anio_asg").change(function () {
        location.href = "${createLink(controller:'asignacion',action:'asignacionProyectov2')}?id=${proyecto.id}&anio=" + $(this).val()
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
                        data:"id=" + $(this).attr("asgn") + "&proy=" + $(this).attr("proy") + "&anio=" + $(this).attr("anio"),
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
                window.location.reload(true)
                $(this).dialog("close");
            }
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
                //alert("Valores: maximo " + mxmo + " valor: " + valor);
                if (valor >= mxmo) {
                    alert("La nueva asignación debe ser menor a " + mxmo);
                } else {
                    var partida = $('#prsp2').val()
                    var fuente = $('#fuente').val();
                    $(this).dialog("close");
                    $.ajax({
                        type:"POST", url:"${createLink(action:'creaHijo', controller: 'asignacion')}",
                        data:"id=" + asgn + "&fuente=" + fuente + "&partida=" + partida + "&valor=" + valor,
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


</script>
</body>
</html>