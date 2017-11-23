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
<div id="tabs" style="width: 1050px;margin-top: 10px;">
    <ul>
        <li><a href="#lista">Solicitudes</a></li>
        <li><a href="#historial">Historial ${actual}</a></li>
    </ul>
    <div id="lista" style="width: 960px;">
        <g:if test="${msn}">

            <div style="width: 800px;margin-top: 10px;background: rgba(14,83,143,0.2);height: 30px;line-height: 30px;padding-left: 10px;font-size: 14px;"  class="ui-corner-all" id="estado">
                <b>${msn}</b>
            </div>
        </g:if>
        <g:if test="${mapa}">
            <g:each in="${mapa}" var="m">
                <fieldset class="ui-corner-all" style="border:1px solid #70B8D6">
                    <legend>${m.key}</legend>
                    <table style="width: 950px;border-bottom: 10px;">
                        <thead>
                        <th>Fecha</th>
                        <th style="width: 140px;">Solicitante</th>
                        <th style="width: 350px;">Concepto</th>
                        <th>Partida</th>
                        <th>Memorando</th>
                        <th>Monto</th>
                        <th>Acción</th>
                        </thead>
                        <tbody>
                        <g:each in="${m.value}" var="cer">
                            <tr>
                                <td>${cer.fecha.format("dd/MM/yyyy")}</td>
                                <td style="width: 160px;">${cer.usuario.persona.nombre+" "+cer.usuario.persona.apellido}</td>
                                <td style="width: 180px;">${cer.concepto}</td>
                                <td style="text-align: center">${cer.asignacion.presupuesto.numero}</td>
                                <td style="text-align: center">${cer.memorandoSolicitud}</td>
                                <td style="text-align: right"><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td style="text-align: center">
                                    <a href="#" class="aprobar inv" id="apr_${cer.id}" monto="${cer.monto}" cer="${cer.id}" memo="${cer.memorandoSolicitud}">Aprobar</a>
                                    <a href="#" class="negar inv" id="neg_${cer.id}" monto="${cer.monto}" cer="${cer.id}">Negar</a>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </fieldset>

            </g:each>
        </g:if>
        <g:else>
            No hay solicitudes pendientes
        </g:else>
    </div>
    <div id="historial"  style="width: 960px;">
        <g:if test="${mapa2}">
            <g:each in="${mapa2}" var="m">
                <fieldset class="ui-corner-all" style="border:1px solid #70B8D6">
                    <legend>${m.key}</legend>
                    <table style="width: 950px;border-bottom: 10px;">
                        <thead>
                        <th>Fecha</th>
                        <th style="width: 140px;">Solicitante</th>
                        <th style="width: 350px;">Concepto</th>
                        <th>Partida</th>
                        <th>Memorando</th>
                        <th>Monto</th>
                        <th>Estado</th>
                        </thead>
                        <tbody>
                        <g:each in="${m.value}" var="cer">
                            <tr>
                                <td>${cer.fecha.format("dd/MM/yyyy")}</td>
                                <td style="width: 160px;">${cer.usuario.persona.nombre+" "+cer.usuario.persona.apellido}</td>
                                <td style="width: 180px;">${cer.concepto}</td>
                                <td style="text-align: center">${cer.asignacion.presupuesto.numero}</td>
                                <td style="text-align: center">${cer.memorandoSolicitud}</td>
                                <td style="text-align: right"><g:formatNumber number="${cer.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <g:if test="${cer.estado==1}">
                                    <td  style="text-align: center;background: #d6eba9" >
                                        Aprobado
                                    </td>
                                </g:if>
                                <g:else>
                                    <td  style="text-align: center;background: #eba597" >
                                        Negado
                                    </td>
                                </g:else>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </fieldset>

            </g:each>
        </g:if>
        <g:else>
            No hay datos que reportar
        </g:else>
    </div>
</div>

<div id="aprobar">
    <g:form action="aprobarCertificacion" class="frmAprobar" enctype="multipart/form-data">
        <input type="hidden" id="cerAprob" name="id">
        <input type="hidden" id="memorando" name="memo">
        <input type="hidden" id="usu" name="usu" value="${session.usuario}">

        Acuerdo ministerial: <input type="text" style="width: 150px" id="acuerdo" value="00941">  </br>
        Memorando No: <input type="text" style="width: 150px;margin-left: 23px" id="memorandoCertificado" >  </br></br>
        Para descargar el formulario de click <a href="#"  id="descarga" style="margin-bottom: 15px;">Aquí</a> </br>
        Despues de llenar y firmar el documento de certificación subalo al sistema. </br> </br>
        <input type="file" id="archivo" name="archivo">
    </g:form>
</div>
<div id="negar">
    <input type="hidden" id="cerNeg">
    Esta seguro que desea negar esta solicitud de certificación?
</div>

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
            var url = "${createLink(controller: 'reportes', action: 'certificacion')}/?id="+$("#cerAprob").val()+
                    "Wacuerdo="+acuerdo+"Wmemo="+$("#memorandoCertificado").val()+"Wusu=${session.usuario.id}";
            location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url+
                    "&filename=certificacion_MIES-"+$("#memorandoCertificado").val()+".pdf"
        });

        $("#aprobar").dialog({
            autoOpen:false,
            resizable:false,
            title:'Aprobar certificación',
            modal:true,
            draggable:true,
            width:400,
            height:350,
            position:'center',
            open:function (event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            buttons:{
                "Cerrar":function () {
                    $("#aprobar").dialog("close")
                },"Aprobar":function(){
                    $(".frmAprobar").submit()
                }
            }
        });
        $("#negar").dialog({
            autoOpen:false,
            resizable:false,
            title:'Negar solicitud',
            modal:true,
            draggable:true,
            width:400,
            height:150,
            position:'center',
            open:function (event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            buttons:{
                "Cancelar":function () {
                    $("#negar").dialog("close")
                },"Negar":function(){
                    $.ajax({
                        type:"POST", url:"${createLink(action:'negarCertificacion', controller: 'certificacion')}",
                        data:"id=" + $("#cerNeg").val(),
                        success:function (msg) {
                            if(msg!="no")
                                location.href = "${createLink(controller:'certificacion',action:'listaSolicitudes')}"
                            else
                                location.href = "${createLink(controller:'certificacion',action:'listaSolicitudes')}/?msn=Usted no tiene los permisos para negar esta solicitud"

                        }
                    });
                }
            }
        });


    });
</script>

</body>
</html>