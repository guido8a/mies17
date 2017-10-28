
<%@ page import="mies.Obra" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}" />

    <title>${title}</title>
</head>

<body>
<div class="dialog">


<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
    </div>
</g:if>
<g:hasErrors bean="${obraInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${obraInstance}" as="list" />
    </div>
</g:hasErrors>
<g:form action="guardarObraGCform" controller="obra" class="frmObra" >
<table width="430px" class="ui-widget-content ui-corner-all">
<tbody>
<tr>
    <td colspan="6" class="blanco">&nbsp;</td>
</tr>
<input type="hidden" name="id" value="${obraInstance?.id}"
<input type="hidden" name="asignacion.id" value="${obraInstance?.asignacion?.id}">
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
        <input type="hidden" id="ccp" name="codigoComprasPublicas.id" value="${obraInstance?.codigoComprasPublicas?.id}">
        <input type="text" id="txt_buscar" value="${obraInstance?.codigoComprasPublicas?.numero}">
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
        <g:textField class="field number required ui-widget-content ui-corner-all numero" name="cantidad" title="cantidad" id="cantidad" value="${obraInstance?.cantidad?.toFloat().round(2)}" />
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
        <g:textField class="field number required ui-widget-content ui-corner-all numero" name="costo" title="costo" id="costo" value="${obraInstance?.costo?.toFloat().round(2)}" />
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
        <input type="checkbox" name="cuatri" value="1" class="chk" ${(obraInstance?.cuatrimestre1=="1")?"checked":""}>
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
        <input type="checkbox" name="cuatri" class="chk" value="2" ${(obraInstance?.cuatrimestre2=="1")?"checked":""}>
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
        <input type="checkbox" name="cuatri" value="3" class="chk" ${(obraInstance?.cuatrimestre3=="1")?"checked":""}>
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
        <g:textField class="field number required ui-widget-content ui-corner-all numero" name="ejecucion" title="ejecucion" id="ejecucion" value="${obraInstance?.ejecucion?.toFloat().round(2)}" />
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
<a href="#" id="guardar" class="btn">Guardar</a>
</g:form>
</div>
<div id="buscar"></div>
<script type="text/javascript">
    $(function() {
        var myForm = $(".frmObra");

        // Tooltip de informacion para cada field (utiliza el atributo title del textfield)
        var elems = $('.field')
                .each(function(i) {
                    $.attr(this, 'oldtitle', $.attr(this, 'title'));
                })
                .removeAttr('title');
        $('<div />').qtip(
                {
                    content: ' ', // Can use any content here :)
                    position: {
                        target: 'event' // Use the triggering element as the positioning target
                    },
                    show: {
                        target: elems,
                        event: 'click mouseenter focus'
                    },
                    hide: {
                        target: elems
                    },
                    events: {
                        show: function(event, api) {
                            // Update the content of the tooltip on each show
                            var target = $(event.originalEvent.target);
                            api.set('content.text', target.attr('title'));
                        }
                    },
                    style: {
                        classes: 'ui-tooltip-rounded ui-tooltip-cream'
                    }
                });
        // fin del codigo para los tooltips

        // Validacion del formulario
        myForm.validate({
            errorClass: "errormessage",
            onkeyup: false,
            errorElement: "em",
            errorClass: 'error',
            validClass: 'valid',
            errorPlacement: function(error, element) {
                // Set positioning based on the elements position in the form
                var elem = $(element),
                        corners = ['right center', 'left center'],
                        flipIt = elem.parents('span.right').length > 0;

                // Check we have a valid error message
                if (!error.is(':empty')) {
                    // Apply the tooltip only if it isn't valid
                    elem.filter(':not(.valid)').qtip({
                        overwrite: false,
                        content: error,
                        position: {
                            my: corners[ flipIt ? 0 : 1 ],
                            at: corners[ flipIt ? 1 : 0 ],
                            viewport: $(window)
                        },
                        show: {
                            event: false,
                            ready:
                                    true
                        },
                        hide: false,
                        style: {
                            classes: 'ui-tooltip-rounded ui-tooltip-red' // Make it red... the classic error colour!
                        }
                    })

                        // If we have a tooltip on this element already, just update its content
                            .qtip('option', 'content.text', error);
                }

                // If the error is empty, remove the qTip
                else
                {
                    elem.qtip('destroy');
                }
            },
            success: $.noop // Odd workaround for errorPlacement not firing!
        })
                ;
        //fin de la validacion del formulario


        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
        $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
        $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
            myForm.submit();
            return false;
        });
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>
<script type="text/javascript">
    $(".btn").button()
//    $.each($(".numero"),function(){
//        //console.log($(this))
//        //console.log($(this).val())
//        $(this).val(str_replace('.', '', $(this).val()));
//        //console.log($(this).val())
//        $(this).val(str_replace(',', '.', $(this).val()));
//        //console.log($(this).val())
//
//    });
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

    $("#guardar").click(function(){

        var cont=0
        $.each($(".chk"),function(){
            if($(this).attr("checked")==true)
                cont++
        });
        $("#cant").val(cont)
        $(".frmObra").submit()

    });
</script>

</body>
</html>