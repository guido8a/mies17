<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Ver solicitud</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hotkeys.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.jstree.js')}"></script>

    </head>

    <body>
        <div>
            <table width="100%" class="ui-widget-content ui-corner-all">
                <thead>
                    <tr>
                        <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                            Detalle de solicitud
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <tr class="prop ${hasErrors(bean: modificacion, field: 'tipoModificacion', 'error')}">

                        <td class="label">
                            <g:message code="modificacionProyecto.tipoModificacion.label"
                                       default="Tipo Modificacion"/>
                        </td>
                        <td class="campo">
                            ${modificacion?.tipoModificacion?.descripcion}
                        </td> <!-- campo -->
                        <td class="label">
                            <g:message code="modificacionProyecto.valor.label"
                                       default="Valor"/>
                        </td>
                        <td class="campo">
                            ${fieldValue(bean: modificacion, field: "valor")}
                        </td> <!-- campo -->
                    </tr>
                    <tr class="prop ${hasErrors(bean: modificacion, field: 'descripcion', 'error')}">
                        <td class="label">
                            <g:message code="modificacionProyecto.fecha.label"
                                       default="Fecha"/>
                        </td>
                        <td class="campo">
                            <g:formatDate date="${modificacion?.fecha}" format="dd-MM-yyyy"/>
                        </td> <!-- campo -->
                        <td class="label">
                            Estado
                        </td>
                        <td class="campo">
                            ${modificacion.estado}
                        </td> <!-- campo -->
                    </tr>
                    <tr class="prop ${hasErrors(bean: modificacion, field: 'fechaAprobacion', 'error')}">

                        <td class="label">
                            <g:message code="modificacionProyecto.fechaAprobacion.label"
                                       default="Fecha Aprobacion"/>
                        </td>
                        <td class="campo">
                            ${modificacion.fechaAprobacion?.format("dd/MM/yyyy")}
                        </td> <!-- campo -->
                    </tr>
                    <tr>
                        <td class="label">
                            <g:message code="modificacionProyecto.descripcion.label"
                                       default="Descripcion"/>
                        </td>
                        <td class="campo">
                            ${fieldValue(bean: modificacion, field: "descripcion")}
                        </td> <!-- campo -->
                    </tr>
                    <tr class="prop ${hasErrors(bean: modificacion, field: 'observaciones', 'error')}">
                        <td class="label">
                            <g:message code="modificacionProyecto.observaciones.label"
                                       default="Observaciones"/>
                        </td>
                        <td class="campo">
                            ${fieldValue(bean: modificacion, field: "observaciones")}
                        </td> <!-- campo -->
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="buttons" style="text-align: right;">

                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <fieldset class="ui-corner-all" style="width: 97.5%;">
            <legend>Informe</legend>

            <p><b>Explicación:</b> ${modificacion.informe.avance}</p>

            <p><b>Dificultades:</b> ${modificacion.informe.dificultades}</p>

            <p><b>Link:</b>${modificacion.informe.link}</p>

        </fieldset>

        <a href="#" mod="${modificacion.id}" tipo="${modificacion.tipoModificacion.id}" class="btn aprobar"
           style="margin: 10px;">Aprobar</a>
        <a href="#" mod="${modificacion.id}" class="btn negar" style="margin: 10px;">Negar</a>

        <div id="auth">
            <input type="hidden" id="iden">
            <input type="hidden" id="oper">
            Ingrese su clave de aprobación <br>
            <input type="password" id="pass">
            <input type="hidden" id="data">
        </div>

        <div id="arbol">
            <div id="tree"></div>

        </div>

        <script type="text/javascript">

            function initTree() {
                $("#tree").jstree({
                    "plugins" : ["themes", "html_data", "ui", "hotkeys", "cookies"],
//            open_parents : false,
                    "themes" : {
                        "theme" : "default"
                    },
                    "ui" : {
                        "select_limit" : 1
                    }
                });//js tree


            } //init tree

            function armarDatos() {
                var data = ""
                $.each($(".chk"), function() {
                    if (!$(this).hasClass("padre")) {
                        if ($(this).attr("checked") == "checked") {
                            data += $(this).attr("tipo") + ":" + $(this).attr("value") + "X"
                        }
                    }
                });
                $("#data").val(data)
            }

            $(".btn").button()
            $(".aprobar").click(function() {
                if ($(this).attr("tipo") != "1") {
                    $("#oper").val("a")
                    $("#iden").val($(".aprobar").attr("mod"))
                    $("#auth").dialog({title:"Aprobación"})
                    $("#auth").dialog("open")
                } else {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(action:'arbolMarco')}",
                        data: {
                            mod:$(this).attr("mod")
                        },
                        success: function(msg) {
                            $("#tree").html(msg);
                            initTree();

                            $("#arbol").dialog("open")
                        }
                    });
                }

            });
            $(".negar").click(function() {
                $("#oper").val("n")
                $("#iden").val($(".negar").attr("mod"))
                $("#auth").dialog({title:"Negación"})
                $("#auth").dialog("open")

            });

            $("#arbol").dialog({
                autoOpen:false,
                modal:true,
                position:[30,15],
                width:700,
                height:800,
                title:"Aprobación",
                resizable:false,
                buttons:{
                    "Aprobar":function() {
                        armarDatos()
                        $("#oper").val("a")
                        $("#iden").val($(".aprobar").attr("mod"))
                        $("#auth").dialog({title:"Aprobación"})
                        $("#auth").dialog("open")
                    }
                }
            });

            $("#auth").dialog({
                autoOpen:false,
                modal:true,
                position:"center",
                width:250,
                height:150,
                title:"Aprobación",
                resizable:false,
                buttons:{
                    "Aprobar":function() {
                        $.ajax({
                            type: "POST",
                            url: "${createLink(action:'aprobarModificacion')}",
                            data: {
                                ssap:$("#pass").val(),
                                mod:$("#iden").val(),
                                tipo:$("#oper").val(),
                                data:$("#data").val()
                            },
                            success: function(msg) {
                                if (msg != "no") {
                                    if ($("#oper").val() == "a")
                                        alert("Modificación aprobada")
                                    else
                                        alert("Modificación negada")
                                    window.location.href = "${createLink(action:'listaSolicitudes')}"

                                } else {
                                    alert("Clave no valida")
                                }
                            }
                        });
                    }
                }
            });

        </script>
    </body>
</html>