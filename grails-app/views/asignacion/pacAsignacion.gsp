<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Obras de la asignación ${asignacion.actividad} ($${asignacion.planificado})</title>
</head>
<body>
<div class="body">
<div class="dialog" >
<div id="accordion" style="width:1030px">

<g:if test="${obras.size()<1}">
    <h3><a href="#">Obras </a></h3>
    <div>La asignación no tiene obras registradas</div>

</g:if>
<g:each in="${obras}" var="obra" status="k">
<h3><a href="#">${obra.descripcion} </a></h3>
<div>

<g:link class="btn" controller="obra" action="edit" id="${obra.id}" style="margin-bottom: 5px;">Editar</g:link>
<table width="100%" class="ui-widget-content ui-corner-all">

<thead>
<tr>
    <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
        Detalles de la obra
    </td>
</tr>
</thead>
<tbody>

<tr>
    <td colspan="4" class="blanco">&nbsp;</td>
</tr>

<tr class="prop ${hasErrors(bean: obra, field: 'unidad', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.unidad.label"
                   default="unidad" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "unidad")}

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.codigoComprasPublicas.label"
                   default="Codigo de compras publicas" />:
    </td>

    <td class="">

        <g:link controller="codigoComprasPublicas" action="show"
                id="${obra?.codigoComprasPublicas?.id}">
            ${obra?.codigoComprasPublicas?.encodeAsHTML()}
        </g:link>

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'tipoCompra', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.tipoCompra.label"
                   default="Tipo Compra" />:
    </td>

    <td class="">

        <g:link controller="tipoCompra" action="show"
                id="${obra?.tipoCompra?.id}">
            ${obra?.tipoCompra?.encodeAsHTML()}
        </g:link>

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.asignacion.label"
                   default="Asignacion" />:
    </td>

    <td class="">

        <g:link controller="asignacion" action="show"
                id="${obra?.asignacion?.id}">
            ${obra?.asignacion?.encodeAsHTML()}
        </g:link>

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'obra', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.obra.label"
                   default="Obra" />:
    </td>

    <td class="">

        <g:link controller="obra" action="show"
                id="${obra?.obra?.id}">
            ${obra?.obra?.descripcion}
        </g:link>

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.modificacionProyecto.label"
                   default="Modificacion Proyecto" />:
    </td>

    <td class="">

        <g:link controller="modificacionProyecto" action="show"
                id="${obra?.modificacionProyecto?.id}">
            ${obra?.modificacionProyecto?.encodeAsHTML()}
        </g:link>

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'descripcion', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.descripcion.label"
                   default="Descripcion" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "descripcion")}

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.cantidad.label"
                   default="Cantidad" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "cantidad")}

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'costo', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.costo.label"
                   default="Costo" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "costo")}

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.cuatrimestre1.label"
                   default="Cuatrimestre 1" />:
    </td>

    <td class="">

        ${(obra.cuatrimestre1=="1")?"Si":"No"}

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'cuatrimestre2', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.cuatrimestre2.label"
                   default="Cuatrimestre 2" />:
    </td>

    <td class="">

        ${(obra.cuatrimestre2=="1")?"Si":"No"}

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.cuatrimestre3.label"
                   default="Cuatrimestre 3" />:
    </td>

    <td class="">

        ${(obra.cuatrimestre3=="1")?"Si":"No"}

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'ejecucion', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.ejecucion.label"
                   default="Ejecucion" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "ejecucion")}

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.estado.label"
                   default="Estado" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "estado")}

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'fechaInicio', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.fechaInicio.label"
                   default="Fecha Inicio" />:
    </td>

    <td class="">

        <g:formatDate date="${obra?.fechaInicio}" format="dd-MM-yyyy" />

    </td> <!-- campo -->




    <td class="label" style="width: 10em;">
        <g:message code="obra.fechaFin.label"
                   default="Fecha Fin" />:
    </td>

    <td class="">

        <g:formatDate date="${obra?.fechaFin}" format="dd-MM-yyyy" />

    </td> <!-- campo -->

</tr>




<tr class="prop ${hasErrors(bean: obra, field: 'observaciones', 'error')}">

    <td class="label" style="width: 10em;">
        <g:message code="obra.observaciones.label"
                   default="Observaciones" />:
    </td>

    <td class="">

        ${fieldValue(bean: obra, field: "observaciones")}

    </td> <!-- campo -->


<tr>
    <td colspan="4" class="label">&nbsp;</td>
</tr>
</tbody>

</table>
</div>
</g:each>
</div>
<div style="float: left;width: 90%;height: 35px;display: block;margin-top: 10px;">
    <a href="#" id="agregar" class="btn" >Agregar</a>
</div>

%{--<div style="float: left;width: 90%;height: 35px;display: block;margin-top: 10px;">--}%
%{--Asignacion: <g:select from="${mies.Obra.findAllBy(mies.TipoElemento.findByDescripcion('Actividad'),actividad.proyecto,[sort:'id'])}" optionKey="id"  id="cmb_comp" value="${actividad.id}"/>--}%
%{--</div>--}%
</div>
</div>
<div id="dlg_agregar">
<g:form action="guardarObra" controller="obra" class="frm_asg" >
<table width="430px" class="ui-widget-content ui-corner-all">
<tbody>
<tr>
    <td colspan="6" class="blanco">&nbsp;</td>
</tr>
<input type="hidden" name="asignacion.id" value="${asignacion.id}">
<input type="hidden" name="cant" id="cant">

<tr class="prop ${hasErrors(bean: obraInstance, field: 'tipoCompra', 'error')}">

    <td class="label " valign="middle">
        <g:message code="obra.tipoCompra.label" default="Tipo de Compra" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <g:select class="field ui-widget-content ui-corner-all" name="tipoCompra.id" title="tipoCompra" from="${mies.TipoCompra.list()}" optionKey="id" value="${obraInstance?.tipoCompra?.id}" noSelection="['null': '']" />
        %{----}%
    </td>
    <td class="label " valign="middle">
        <g:message code="obra.codigoComprasPublicas.label" default="Codigo de compras publicas" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        %{--<g:select class="field ui-widget-content ui-corner-all" name="codigoComprasPublicas.id" title="codigoComprasPublicas" from="${mies.CodigoComprasPublicas.list()}" optionKey="id" value="${obraInstance?.codigoComprasPublicas?.id}" noSelection="['null': '']" />--}%
        <input type="hidden" id="ccp" name="codigoComprasPublicas.id">
        <input type="text" id="txt_buscar">
        <a href="#" id="buscar_ccp">Buscar</a>
        %{----}%
    </td>
</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'obra', 'error')}">

    <td class="label " valign="middle">
        Padre
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <g:select class="field ui-widget-content ui-corner-all" name="obra.id" title="obra" from="${mies.Obra.list()}" optionKey="id" value="${obraInstance?.obra?.id}" noSelection="['null': '']" />
        %{----}%
    </td>

    <td class="label  mandatory" valign="middle">
        Unidad
        %{--<span class="indicator">*</span>--}%
    </td>
    <td class="indicator mandatory">
        <span class="indicator">*</span>
    </td>
    <td class=" mandatory" valign="middle">

        <g:select from="${mies.Unidad.list()}"  name="unidad.id" optionKey="id" optionValue="descripcion" />
        %{--<span class="indicator">*</span>--}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'descripcion', 'error')}">

    <td class="label " valign="middle">
        <g:message code="obra.descripcion.label" default="Descripcion" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <g:textField  name="descripcion" id="descripcion" title="descripcion" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" value="${obraInstance?.descripcion}" />
        %{----}%
    </td>



    <td class="label  mandatory" valign="middle">
        <g:message code="obra.cantidad.label" default="Cantidad" />:
        %{--<span class="indicator">*</span>--}%
    </td>
    <td class="indicator mandatory">
        <span class="indicator">*</span>
    </td>
    <td class=" mandatory" valign="middle">
        <g:textField class="field number required ui-widget-content ui-corner-all" name="cantidad" title="cantidad" id="cantidad" value="${fieldValue(bean: obraInstance, field: 'cantidad')}" />
        %{--<span class="indicator">*</span>--}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'costo', 'error')}">

    <td class="label  mandatory" valign="middle">
        <g:message code="obra.costo.label" default="Costo" />:
        %{--<span class="indicator">*</span>--}%
    </td>
    <td class="indicator mandatory">
        <span class="indicator">*</span>
    </td>
    <td class=" mandatory" valign="middle">
        <g:textField class="field number required ui-widget-content ui-corner-all" name="costo" title="costo" id="costo" value="${fieldValue(bean: obraInstance, field: 'costo')}" />
        %{--<span class="indicator">*</span>--}%
    </td>



    <td class="label " valign="middle">
        <g:message code="obra.cuatrimestre1.label" default="Cuatrimestre1" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <input type="checkbox" name="cuatri" value="1" class="chk">
        %{----}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'cuatrimestre2', 'error')}">

    <td class="label " valign="middle">
        <g:message code="obra.cuatrimestre2.label" default="Cuatrimestre2" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <input type="checkbox" name="cuatri" class="chk" value="2">
        %{----}%
    </td>



    <td class="label " valign="middle">
        <g:message code="obra.cuatrimestre3.label" default="Cuatrimestre3" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <input type="checkbox" name="cuatri" value="3" class="chk">
        %{----}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'ejecucion', 'error')}">

    <td class="label  mandatory" valign="middle">
        <g:message code="obra.ejecucion.label" default="Ejecucion" />:
        %{--<span class="indicator">*</span>--}%
    </td>
    <td class="indicator mandatory">
        <span class="indicator">*</span>
    </td>
    <td class=" mandatory" valign="middle">
        <g:textField class="field number required ui-widget-content ui-corner-all" name="ejecucion" title="ejecucion" id="ejecucion" value="${fieldValue(bean: obraInstance, field: 'ejecucion')}" />
        %{--<span class="indicator">*</span>--}%
    </td>



    <td class="label " valign="middle">
        <g:message code="obra.estado.label" default="Estado" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <g:textField  name="estado" id="estado" title="estado" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1" value="${obraInstance?.estado}" />
        %{----}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'fechaInicio', 'error')}">

    <td class="label " valign="middle">
        <g:message code="obra.fechaInicio.label" default="Fecha Inicio" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <input type="hidden" value="date.struct" name="fechaInicio">
        <input type="hidden" name="fechaInicio_day" id="fechaInicio_day"  value="${obraInstance?.fechaInicio?.format('dd')}" >
        <input type="hidden" name="fechaInicio_month" id="fechaInicio_month" value="${obraInstance?.fechaInicio?.format('MM')}">
        <input type="hidden" name="fechaInicio_year" id="fechaInicio_year" value="${obraInstance?.fechaInicio?.format('yyyy')}">
        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaInicio" title="fechaInicio" id="fechaInicio" value="${obraInstance?.fechaInicio?.format('dd-MM-yyyy')}" />
        <script type='text/javascript'>
            $('#fechaInicio').datepicker({
                changeMonth: true,
                changeYear:true,
                dateFormat: 'dd-mm-yy',
                onClose: function(dateText, inst) {
                    var date = $(this).datepicker('getDate');
                    var day, month, year;
                    if(date != null) {
                        day = date.getDate();
                        month = parseInt(date.getMonth()) + 1;
                        year = date.getFullYear();
                    } else {
                        day = '';
                        month = '';
                        year = '';
                    }
                    var id = $(this).attr('id');
                    $('#' + id + '_day').val(day);
                    $('#' + id + '_month').val(month);
                    $('#' + id + '_year').val(year);
                }
            });
        </script>
        %{----}%
    </td>



    <td class="label " valign="middle">
        <g:message code="obra.fechaFin.label" default="Fecha Fin" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle">
        <input type="hidden" value="date.struct" name="fechaFin">
        <input type="hidden" name="fechaFin_day" id="fechaFin_day"  value="${obraInstance?.fechaFin?.format('dd')}" >
        <input type="hidden" name="fechaFin_month" id="fechaFin_month" value="${obraInstance?.fechaFin?.format('MM')}">
        <input type="hidden" name="fechaFin_year" id="fechaFin_year" value="${obraInstance?.fechaFin?.format('yyyy')}">
        <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaFin" title="fechaFin" id="fechaFin" value="${obraInstance?.fechaFin?.format('dd-MM-yyyy')}" />
        <script type='text/javascript'>
            $('#fechaFin').datepicker({
                changeMonth: true,
                changeYear:true,
                dateFormat: 'dd-mm-yy',
                onClose: function(dateText, inst) {
                    var date = $(this).datepicker('getDate');
                    var day, month, year;
                    if(date != null) {
                        day = date.getDate();
                        month = parseInt(date.getMonth()) + 1;
                        year = date.getFullYear();
                    } else {
                        day = '';
                        month = '';
                        year = '';
                    }
                    var id = $(this).attr('id');
                    $('#' + id + '_day').val(day);
                    $('#' + id + '_month').val(month);
                    $('#' + id + '_year').val(year);
                }
            });
        </script>
        %{----}%
    </td>

</tr>



<tr class="prop ${hasErrors(bean: obraInstance, field: 'observaciones', 'error')}">

    <td class="label " valign="middle">
        <g:message code="obra.observaciones.label" default="Observaciones" />:
        %{----}%
    </td>
    <td class="indicator">
        &nbsp;
    </td>
    <td class="" valign="middle" colspan="4">
        <g:textArea  name="observaciones" id="observaciones" title="observaciones" class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" value="${obraInstance?.observaciones}" cols="50" rows="3" style="width: 630px;" />
        %{----}%
    </td>

</tr>


<tr>
    <td colspan="6" class="blanco">&nbsp;</td>
</tr>
</tbody>




</table>
</g:form>
</div>
<div id="buscar"></div>
<script type="text/javascript">
    $(".btn").button()
    $("#buscar_ccp").button().click(function(){
        $.ajax({
            type: "POST",
            url: "${createLink(action:'buscarCcp',controller:'asignacion')}",
            data: "parametro="+$("#txt_buscar").val(),
            success: function(msg) {
                $("#buscar").html(msg)
                $("#buscar").dialog("open")
            }

        });

    });
    $("#buscar").dialog({
        width:630,
        height:400,
        position:"center",
        modal:true,
        title:"Códigos de compras publicas",
        autoOpen:false
    });
    $("#agregar").click(function(){
        $("#valor").css("border","1px solid #A6C9E2")
        $("#dlg_agregar").dialog("open")
    });
    $("#cmb_comp").change(function(){
        location.href="${createLink(action:'asignacionesActividad')}/"+$(this).val()
    });
    $("#accordion").accordion({collapsible: true})
    $("#dlg_agregar").dialog( {
        width:800,
        height:400,
        position:"center",
        modal:true,
        title:"Detalles de la asignacion",
        autoOpen:false,
        buttons:{
            "Aceptar":function(){
                var cont=0
                $.each($(".chk"),function(){
                    if($(this).attr("checked")==true)
                        cont++
                });
                $("#cant").val(cont)
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'guardarObraGC',controller:'obra')}",
                    data: $(".frm_asg").serialize(),
                    success: function(msg) {
                        if(msg!="error"){
                            window.location.reload(true)
                        }else{
                            alert("Existe un error. Revise que la actividad no tenga otras asignaciones en el año seleccionado")
                        }
                    }
                });

            }
        }
    });
</script>
</body>
</html>