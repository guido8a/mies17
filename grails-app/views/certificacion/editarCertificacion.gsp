<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Solicitudes de certificación pendientes </title>

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


<div id="aprobar">
    <g:form action="aprobarCertificacion" class="frmAprobar" enctype="multipart/form-data">
        <input type="hidden" id="cerAprob" name="id" value="${cer.id}">
        <input type="hidden" id="cerAprob" name="tipo" value="editar">

        Acuerdo ministerial: <input type="text" style="width: 150px" id="acuerdo" value="${cer.acuerdo}">  </br>
        Memorando de solicitud No: <input type="text" style="width: 150px;margin-left: 23px" id="memoSol"  name="memo" value="${cer.memorandoSolicitud}">  </br>
        Memorando de aprobación No: <input type="text" style="width: 150px;margin-left: 23px" id="memorandoCertificado" value="${cer.memorandoCertificado}" >  </br></br>
        Para descargar el formulario de click <a href="#"  id="descarga" style="margin-bottom: 15px;">Aquí</a> </br>
        Despues de llenar y firmar el documento de certificación subalo al sistema. </br> </br>
        <input type="file" id="archivo" name="archivo" style="margin-bottom: 20px"><br>
        <a href="#" id="aceptar">Aceptar</a>
        <g:link controller="certificacion" action="listaCertificados" class="btn" id="${cer.asignacion.unidad.id}">Cancelar</g:link>
    </g:form>
</div>
<g:if test="${msn}">
    <div style="width: 400px;height: 40px;padding: 5px;line-height: 30px;margin-top: 10px;background: rgba(255,0,0,0.3);text-align: center" class="ui-corner-all">${msn}</div>
</g:if>

<script>
    $(function() {
        $("#tabs").tabs()

        $(".aprobar").button({icons:{ primary:"ui-icon-check"},text:false}).click(function(){
            $("#cerAprob").val($(this).attr("cer"))
            $("#memorando").val($(this).attr("memo"))
            $("#aprobar").dialog("open")
        });
        $(".negar").button({icons:{ primary:"ui-icon-close"},text:false}).click(function(){
            $("#cerNeg").val($(this).attr("cer"))
            $("#negar").dialog("open")
        });

        $("#descarga").button().click(function () {
            var acuerdo = $("#acuerdo").val()
            if(acuerdo==""){
                alert("Ingrese el número del acuerdo ministerial ")
            }
            var url = "${createLink(controller: 'reportes', action: 'certificacion')}/?id=${cer.id}Wacuerdo="+acuerdo+"Wmemo="+$("#memorandoCertificado").val()+"Wsolicitud="+$("#memoSol").val();
            location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url+"&filename=certificacion_MIES-"+$("#memorandoCertificado").val()+".pdf"
        });
        $("#aceptar").button().click(function(){

            if($("#archivo").val()!="" && $("#acuerdo").val()!="" && $("#memoSol").val()!="" && $("#memorandoCertificado").val()!="" ){
                $(".frmAprobar").submit()
            }else{
                alert("Llene todos los campos")
            }
        });
//
        $(".btn").button()
//        $("#aprobar").dialog({
//            autoOpen:false,
//            resizable:false,
//            title:'Aprobar certificación',
//            modal:true,
//            draggable:true,
//            width:400,
//            height:350,
//            position:'center',
//            open:function (event, ui) {
//                $(".ui-dialog-titlebar-close").hide();
//            },
//            buttons:{
//                "Cerrar":function () {
//                    $("#aprobar").dialog("close")
//                },"Aprobar":function(){
//                    $(".frmAprobar").submit()
//                }
//            }
//        });



    });
</script>

</body>
</html>