<%@ page import="mies.Certificacion" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Certificaciones PAC -- Unidad:${unidad}</title>

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
<b>Año:</b>
<g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
<br>
<div id="tabs" style="width: 1050px;margin-top: 10px;">
    <ul>
        <li><a href="#tabs-1">PAC</a></li>
    </ul>
    <div id="tabs-1">
        <table style="width: 1020px;">
            <thead>
            <th width="70">Fuente</th>
            <th width="75">Presupuesto</th>
            <th width="270">Descripci&oacute;n</th>
            <th width="100">Unidad</th>
            <th width="85">Codigo CPC</th>
            <th width="107">Tipo</th>
            <th width="48">Cant.</th>
            <th width="78">Costo</th>
            <th width="22">C1</th>
            <th width="22">C2</th>
            <th width="22">C3</th>
            <th></th>
            <th></th>
             <th></th>
            </thead>
            <tbody>
            <g:each in="${pac}" var="obra" status="i">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td class="fuente" style="font-size: 11px;">

                        ${(obra.asignacion.fuente.toString().size() > 40) ? obra.asignacion.fuente.toString().substring(0, 40) : obra.asignacion.fuente}

                    </td>

                    <td class="asg" style="font-size: 11px; text-align: right;">

                        <g:formatNumber number="${obra.asignacion.planificado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>

                    <td>
                        ${(obra.asignacion.actividad)?obra.asignacion.actividad:obra.asignacion.marcoLogico} (${obra.asignacion.presupuesto.numero})
                    </td>

                    <td class="unidad">
                        ${obra.unidad}

                    </td>

                    <td class="cp" style="text-align: center">
                        ${obra.codigoComprasPublicas.numero}
                    </td>

                    <td class="tipo">
                        ${obra.tipoCompra}
                    </td>

                    <td class="cantidad">
                        <g:formatNumber number="${obra.cantidad}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>

                    </td>

                    <td class="costo">
                        <g:formatNumber number="${obra.costo}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>

                    <td class="ctr1">
                        <input type="checkbox"
                               class="chk ctr1" ${(obra.cuatrimestre1 == "1") ? "checked" : ""}  disabled>
                    </td>

                    <td class="ctr2">
                        <input type="checkbox"
                               class="chk ctr2" ${(obra.cuatrimestre2 == "1") ? "checked" : ""} disabled>
                    </td>

                    <td class="ctr3">
                        <input type="checkbox"
                               class="chk ctr3" ${(obra.cuatrimestre3 == "1") ? "checked" : ""} disabled>
                    </td>


                    <td class="${(obra.certificado=='S')?'ui-state-active':''}" >
                        <g:if test="${obra.certificado!='S'}">
                            <a href="#" class="certificar" iden="${obra.id}" title="Certificar">Certificar</a>
                            <span class=""  id="ico_${obra.id}" title="Certificado" style="display: none">
                                <span class="ui-icon ui-icon-check"></span>
                            </span>
                        </g:if>
                        <g:else>
                            <span class="" id="ico_${obra.id}" title="Certificado" >
                                <span class="ui-icon ui-icon-check"></span>
                            </span>
                        </g:else>
                    </td>
                    <td  >
                        <g:if test="${obra.certificado=='S'}">
                           <a href="#" class="btnPdf" id="pdf_${obra.id}">PDF</a>
                        </g:if>
                    </td>

                </tr>

            </g:each>
            </tbody>
        </table>
    </div>


</div>



<script>

    function crearBoton(elemento){

        elemento.button({
            icons:{

                primary:"ui-icon-clipboard"

            },
            text:false


        }).click(function(){

                    var id=$(this).attr("id");

                    var parts=id.split("_")

                    var url = "${createLink(controller:'reportes' , action: 'certificacionPac')}?id="+parts[1];
                    location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url
                    return false;


                });



    }

    $(function() {

        crearBoton($(".btnPdf"))

        $( "#tabs" ).tabs();
        $(".certificar").button({icons:{primary:"ui-icon-check"},text:false}).click(function(){
            var boton = $(this)
            var iden = $(this).attr("iden")



            if(confirm("Esta seguro que desea certificar esta compra?")){
                $.ajax({
                    type:"POST",
                    url:"${createLink(action:'certificarObra',controller:'certificacion')}",
                    data:{
                        id:iden
                    },
                    success:function (msg) {
                        if (msg == "ok") {
                            $("#ico_"+iden).parent().addClass("ui-state-active")
                            $("#ico_"+iden).show("slide")

                            var contenedor = boton.parent().next()
                            var link = $("<a href='#' class='btnPdf' id='pdf_"+iden+"'>PDF</a>")

                            crearBoton(link)

                            contenedor.html(link)



                            boton.remove()

                        }
                    }
                });
            }
        });
        $("#anio_asg").change(function () {
            location.href = "${createLink(controller:'certificacion',action:'certificarPac')}?id=${unidad.id}&anio=" + $("#anio_asg").val();
        });
    });
</script>

</body>
</html>