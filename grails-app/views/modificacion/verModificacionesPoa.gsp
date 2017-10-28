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

<div style="margin-left: 10px;">

    <div style="margin-top: 15px;">
        <b>Año:</b>
        <g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}"/>
        <g:link class="btn" controller="entidad" action="arbol_asg">Unidades ejecutoras</g:link>
        <g:link class="btn" controller="modificacion" action="poaCorrientesMod" id="${unidad.id}">Modificaciones POA</g:link>
        <g:link class="btn"  controller="pdf" action="pdfLink" params="[url:g.createLink(controller:'reportes',action:'modificacionesPoa',id:unidad.id),filename:'Modificaciones_poa_'+unidad.id+'.pdf']" >Reporte</g:link>


    </div>
    <g:each in="${res}" var="mod" status="i">
        <table width="1020px;" style="margin-top: 20px;font-size: 11px">
            <thead>
            <th class="ui-state-default"><b># ${i+1}</b></th>
            <th style="width: 160px;" class="ui-state-default">Unidad</th>
            <th style="width: 200px;" class="ui-state-default">Programa</th>
            <th style="width: 250px;" class="ui-state-default">Actividad</th>
            <th class="ui-state-default">Partida</th>
            <th style="width: 150px" class="ui-state-default">Desc. partida</th>
            <th class="ui-state-default">Fuente</th>
            <th class="ui-state-default">Presupuesto</th>
            </thead>
            <tbody>

            <tr>
                <td>
                    <b>Desde:</b>
                </td>
                <td class="unidad">
                    ${mod.desde.unidad}
                </td>
                <td class="programa">
                    ${(mod.desde.marcoLogico)?mod.desde.marcoLogico.proyecto.programa.descripcion:mod.desde.programa.descripcion}
                </td>

                <td class="actividad">
                    ${(mod.desde.marcoLogico)?mod.desde.marcoLogico:mod.desde.actividad}
                </td>

                <td class="prsp" style="text-align: center">
                    ${mod.desde.presupuesto.numero}
                </td>

                <td class="desc">
                    ${mod.desde.presupuesto.descripcion}
                </td>

                <td class="fuente">
                    ${mod.desde.fuente.descripcion}
                </td>

                <td class="valor" style="text-align: right">
                    <g:formatNumber number="${(mod.desde.redistribucion==0)?mod.desde.planificado.toFloat():mod.desde.redistribucion.toFloat()}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>

                </td>
            </tr>
            <tr>
                <td>
                    <b> Hasta: </b>
                </td>
                <g:if test="${mod.recibe}">
                    <td class="programa">
                        ${mod.recibe.unidad}
                    </td>
                    <td class="programa">
                        ${(mod.recibe.marcoLogico)?mod.recibe.marcoLogico.proyecto.programa.descripcion:mod.recibe.programa.descripcion}
                    </td>

                    <td class="actividad">
                        ${(mod.recibe.marcoLogico)?mod.recibe.marcoLogico:mod.recibe.actividad}
                    </td>

                    <td class="prsp" style="text-align: center">
                        ${mod.recibe.presupuesto.numero}
                    </td>

                    <td class="desc">
                        ${mod.recibe.presupuesto.descripcion}
                    </td>

                    <td class="fuente">
                        ${mod.recibe.fuente.descripcion}
                    </td>

                    <td class="valor" style="text-align: right">
                        <g:formatNumber number="${mod.recibe.planificado}"
                                        format="###,##0"
                                        minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                </g:if>
                <g:else>
                    <g:if test="${mod.unidad}">
                        <td colspan="6">Unidad ejecutora: ${mod.unidad}</td>
                    </g:if>
                    <g:else>
                        <td colspan="6">
                            Nueva asginación
                        </td>
                    </g:else>
                </g:else>

            </tr>
            <tr>
                <td>
                    <b>Valor:</b>
                </td>
                <td>
                    <g:formatNumber number="${mod.valor}"
                                    format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
            <tr>
                <td>
                    <b> Fecha:</b>
                </td>
                <td>
                    ${mod.fecha?.format("dd/MM/yyyy")}
                </td>
                <td>
                    Transacción:(${mod.id})
                </td>
            </tr>
            <g:if test="${mod.pdf}">
                <tr>
                    <td>
                        <b>Autorización</b>
                    </td>
                    <td>
                        <a href="#" class="btn pdf" iden="${mod.id}">PDF</a>
                    </td>
                </tr>
            </g:if>
            </tbody>
        </table>

    </g:each>

</div>

<div id="load">
    <img src="${g.resource(dir:'images',file: 'loading.gif')}" alt="Procesando">
    Procesando
</div>
<script type="text/javascript">
    $("#anio_asg, #programa").change(function () {
        location.href = "${createLink(controller:'modificacion',action:'verModificacionesPoa')}?id=${unidad.id}&anio=" + $("#anio_asg").val() + "&programa=" + $("#programa").val();
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
    $(".btn").button()
    $(".pdf").click(function(){
        location.href = "${createLink(controller:'modificacion',action:'descargaDocumento')}/"+$(this).attr("iden")
    });
</script>


</body>
</html>