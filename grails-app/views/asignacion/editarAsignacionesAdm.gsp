<%@ page import="mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones de la unidad: ${unidad}</title>

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
    Año: <g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}" style="margin-right: 10px;"/>
    <g:link class="btn_arbol" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
</div>
<fieldset class="ui-corner-all" style="">
    <legend>Asignaciones corrientes de la unidad ${unidad}</legend>
    <g:if test="${corrientes}">
        <table width="1000px;">
            <thead>
            <th style="width: 220px">Programa</th>
            <th style="width: 240px">Actividad</th>
            <th style="width: 60px;">Partida</th>
            <th style="width: 200px">Desc. Presupuestaria</th>

            <th>Fuente</th>
            <th>Presupuesto</th>
            <th></th>
            <th></th>
            </thead>
            <tbody>
            <g:set var="total" value="${0}"></g:set>
            <g:each in="${corrientes}" var="asg">
                <tr  id="det_${i}">

                    <td class="programa">
                        <div style="position: relative;width: 100%;">
                            ${asg.programa.descripcion}
                            <g:if test="${actual.estado == 0}">
                                <a href="#" class="btnCambiarPrograma" id="btn_${asg.id}" style="position: absolute;right: 2px;bottom: 0px;" prog="${asg.programa.id}">Cambiar</a>
                            </g:if>
                        </div>
                    </td>


                    <td class="actividad">
                        ${asg.actividad}
                    </td>

                    <td class="prsp" style="text-align: center">
                        ${asg.presupuesto.numero}
                    </td>

                    <td class="desc" style="width: 200">
                        ${asg.presupuesto.descripcion}
                    </td>

                    <td class="fuente">
                        <g:select from="${fuentes}" name="fuente" value="${asg.fuente.id}" optionKey="id" optionValue="descripcion" style="width: 160px;" class="fuente"></g:select>

                    </td>

                    <td class="valor" style="text-align: right">
                        <input type="text" class="valor" style="text-align: right;width: 100px;" value='${g.formatNumber(number:asg.planificado,format:"###,##0",minFractionDigits:"2",maxFractionDigits:"2")}'>

                        <g:set var="total" value="${total.toDouble().round(2)+((asg.redistribucion==0)?asg.planificado.toDouble().round(2):asg.redistribucion.toDouble().round(2))}"></g:set>
                    </td>


                    <td style="text-align: center">

                        <a href="#" class="btn guardar ajax" iden="${asg.id}" ico="ico_${asg.id}" progra="proga_${asg.id}">Guardar</a>

                    </td>

                    <td class="ui-state-active">
                        <span class="" id="ico_${asg.id}" title="asignado" style="display: none">
                            <span class="ui-icon ui-icon-check"></span>
                        </span>
                    </td>
                    <td class="ui-state-active">
                        <a href="#" class="btn progra ajax" iden="${asg.id}" id="proga_${asg.id}" style="display: none;" >Programacion</a>
                    </td>

                </tr>

            </g:each>
            </tbody>
        </table>

    </g:if>
</fieldset>
<div id="dlgProg">
    <form id="frmCmbPrg">
        <input type="hidden" id="idAsg" name="idAsg"/>

        <p id="pTexto">
            Seleccione el nuevo programa
        </p>
        <g:select from="${mies.ProgramaPresupuestario.list()}" name="progs" optionKey="id" value="" id="progs"/>
    </form>
</div>
<div id="programacion">


</div>
<script type="text/javascript">
    $(".btn_arbol").button({icons:{ primary:"ui-icon-bullet"}})
    $("#progs").selectmenu({width:380, height:50})
    $("#anio_asg").change(function () {
        location.href = "${createLink(controller:'asignacion',action:'editarAsignacionesAdm')}?id=${unidad.id}&anio=" + $("#anio_asg").val();
    });

    $(".guardar").button({icons:{ primary:"ui-icon-disk"},text:false}).click(function(){
        if(confirm("Esta seguro de editar esta asignación? La programación volvera a ser calculada")){
            var valor = $(this).parent().parent().find(".valor").find(".valor").val()
            valor = str_replace(".", "", valor);
            valor = str_replace(",", ".", valor);
            var fuente = $(this).parent().parent().find(".fuente").find(".fuente").val()
            var ico = $(this).attr("ico")
            var progra = $(this).attr("progra")
            $.ajax({
                type:"POST",
                url:"${createLink(action:'guardarDatosEdicionAdm')}",
                data:{
                    id:$(this).attr("iden"),
                    planificado:valor,
                    "fuente.id":fuente
                },
                success:function (msg) {
                    if (msg == "0") {
                        alert("Ha ocurrido un error.")
                    }else{
                        $("#"+ico).show("pulsate")
                        $("#"+progra).show("slide")
                    }
                }
            });
        }

    });
    $(".progra").button({icons:{ primary:"ui-icon-bullet"},text:false}).click(function(){
        $.ajax({
            type:"POST",
            url:"${createLink(action:'programacionEditarAdm')}",
            data:{
                id:$(this).attr("iden")
            },
            success:function (msg) {
                $("#programacion").html(msg)
                $("#programacion").dialog("open")
            }
        });



    });

    $(".btnCambiarPrograma").button({
        icons:{
            primary:"ui-icon-shuffle"
        },
        text:false
    }).click(function () {
                var id = $(this).attr("id");
                var parts = id.split("_");
                var act = $(this).parents("tr").find(".actividad").text().trim();
                $("#idAsg").val(parts[1]);
                $("#pTexto").html("Seleccione el nuevo programa para la asignación:<br/> <b>" + act + "</b>");
                $("#progs").val($(this).attr("prog"));
                $('select#progs').selectmenu("value", $(this).attr("prog"));
                $("#dlgProg").dialog("open");
                return false;
            });

    $("#dlgProg").dialog({
        width:430,
        modal:true,
        title:"Cambiar el programa",
        autoOpen:false,
        open:function (event, ui) {

        },
        buttons:{
            "Aceptar":function () {
                var data = $("#frmCmbPrg").serialize();
                var url = "${createLink(action: 'cambiarProgramaEditar')}?" + data + "&anio=${actual.id}&id=${unidad.id}";
//                            console.log(url);
                location.href = url;
            },
            "Cancelar":function () {
                $(this).dialog("close");
            }
        }
    });
    $("#programacion").dialog({
        width:1100,
        height:270,
        modal:true,
        title:"Programación",
        autoOpen:false,
        open:function (event, ui) {

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