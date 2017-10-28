<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/30/11
  Time: 4:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Modificaciones</title>

    <style type="text/css">
    .dim {
        border : solid 1px #DDDDDD;
    }

    .lbl {
        font-weight : bold;
    }
    </style>

</head>

<body>

<div id="" class="toolbar ui-widget-header ui-corner-all" style="margin-bottom: 10px;">
    <g:link action="" class="button cancel">
        Cancelar
    </g:link>
    <a href="#" class="button save">
        Guardar
    </a>
</div> <!-- toolbar -->

<g:set var="cols" value="100"/>
<g:set var="rows" value="5"/>

<g:form action="guardarModificacion" name="frmModif">
    <g:each in="${objs}" var="obj" status="i">
        <g:set var="tipo" value="${obj.tipo}"/>
        <g:set var="elem" value="${obj.obj}"/>

        <div style="min-height: 100px;">

            <g:if test="${tipo == 1}">
                <div class="lbl">Fin:</div>
                <g:textArea name="fin.objeto" rows="${rows}" cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.objeto}</g:textArea>
            </g:if>

            <g:if test="${tipo == 2}">
                <div class="lbl">Prop&oacute;sito:</div>
                <g:textArea name="prp.objeto" rows="${rows}" cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.objeto}</g:textArea>
            </g:if>

            <g:if test="${tipo == 3}">
                <div class="lbl">Indicador:</div>
                <g:textArea name="ind.descripcion" rows="${rows}"
                            cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.descripcion}</g:textArea>
            </g:if>

            <g:if test="${tipo == 4}">
                <div class="lbl">Meta:</div>
            </g:if>

            <g:if test="${tipo == 5}">
                <div class="lbl">Supuesto:</div>
                <g:textArea name="sps" rows="${rows}" cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.descripcion}</g:textArea>
            </g:if>

            <g:if test="${tipo == 6}">
                <div class="lbl">Actividad:</div>
                <g:textArea name="act.objeto" rows="${rows}" cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.objeto}</g:textArea>
            </g:if>

            <g:if test="${tipo == 7}">
                <div class="lbl">Medio de verificaci&oacute;n:</div>
                <g:textArea name="mdv.descripcion" rows="${rows}"
                            cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.descripcion}</g:textArea>
            </g:if>

            <g:if test="${tipo == 8}">
                <div class="lbl">Componente:</div>
                <g:textArea name="cmp.objeto" rows="${rows}" cols="${cols}"  class="ta"  tipo="${tipo}" iden="${elem.id}">${elem.objeto}</g:textArea>
            </g:if>

        </div>

        <hr class="dim"/>
    </g:each>
</g:form>

<div id="dlgAlert" title="Alerta">
    <div style="padding: 0 .7em;" class="ui-state-error ui-corner-all">
        <p>
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
            <strong>Alerta:</strong>
            Si termina esta modificación no podrá hacer más cambios sin otra solicitud aprobada.
        </p>
    </div>
</div>

<script type="text/javascript">
    $(function() {

        $("#dlgAlert").dialog({
            resizable: false,
            modal: true,
            autoOpen: false,
            buttons: {
                "Aceptar": function() {
                    var data = ""
                    var paso = ""
                    $.each($(".ta"),function(){
                        paso =$(this).attr("tipo")+"XYZ"+$(this).attr("iden")+"XYZ"+$(this).val()+"ZXY"
                        paso+=data
                        data = paso
                    });

                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'guardarModificacion')}",
                        data: {
                            datos:data
                        },
                        success: function(msg) {
                            if(msg=="ok"){
                                alert("Los cambios han sido procesados. ")
                                location.href = "${g.createLink(controller:'proyecto',action:'show',params:[id:session.proyecto.id])}"
                            }else{
                                if(msg!="noSession")
                                    alert(msg)
                                else{
                                    alert("Su sesion ha terminado. Por favor escoja una modificación de la lista de modificaciones aprobadas")
                                    location.href="${g.createLink(controller:'modificacionProyecto',action:'listaAprobadas')}"
                                }
                            }
                        }
                    });


                    $(this).dialog("close");
                },
                "Cancelar": function() {
                    $(this).dialog("close");
                }
            }
        });

        $(".cancel").button({
            icons: {
                primary: "ui-icon-closethick"
            }
        });

        $(".save").button({
            icons: {
                primary: "ui-icon-disk"
            }
        }).click(function() {
                    $("#dlgAlert").dialog("open");
                });
    });
</script>

</body>
</html>