<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 28/10/17
  Time: 11:51
--%>

<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 6/22/11
  Time: 12:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.MetaBuenVivir; mies.PoliticaBuenVivir; mies.Politica; mies.ObjetivoBuenVivir; mies.Fuente" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/menuSemplades', file: 'flow_menu_green.css')}"/>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/slider', file: 'selectToUISlider.jQuery.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/slider', file: 'ui.slider.extras.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

    <title>
        Metas del buen vivir del proyecto ${proyecto?.nombre}
    </title>
</head>

<body>

<div class="dialog" title="Financiamiento del proyecto ${proyecto?.nombre}">

    <div style="padding: 0.7em; margin: 0.7em;" class="ui-state-error ui-corner-all ui-helper-hidden"
         id="divError">
        <p>
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
            <strong>Error:</strong>
            <span id="spanError"></span>
        </p>
    </div>

    <g:set var="w" value="250"/>

    %{--<mf:menuSemplades items='${items}' links="${links}"/>--}%

    <div class="ui-widget-content ui-corner-all" style="padding: 3px; height: 30px;">
        <div style="float:left; margin-left: 5px;">
            <strong>
                Objetivo:
            </strong>
            <g:select from="${ObjetivoBuenVivir.list()}" name="objetivo" id="objetivo" optionKey="id"
                      style="width: ${w}px;" noSelection="${['null':'..-- Seleccione un objetivo --..']}"/>
        </div>

        <div style="float: left; margin-left: 5px;" id="pols" class="ui-helper-hidden">
            <strong>
                Pol&iacute;tica:
            </strong>
            <g:select from="${PoliticaBuenVivir.list()}" name="politica" id="politica" optionKey="id"
                      style="width: ${w}px;"/>
        </div>

        <div style="float: left; margin-left: 5px;" id="mets" class="ui-helper-hidden">
            <strong>
                Meta:
            </strong>
            <g:select from="${MetaBuenVivir.list()}" name="meta" id="meta" optionKey="id"
                      style="width: ${w}px;"/>
        </div>

        <a href="#" id="btnAdd" class="button" style="display: none; margin-left: 5px;">Agregar</a>
    </div>


    <div class="ui-widget-content ui-corner-all" style="padding: 10px;">

        %{--<g:form class="frmFinanciamiento" method="post" action="nuevoProyecto" event="saveMetas">--}%
        <g:form class="frmFinanciamiento" method="post" action="saveBuenVivir">
            <input type="hidden" name="goto" id="goto" value="politicasAgenda"/>
            <g:hiddenField name="proyecto" value="${proyecto?.id}"/>

            <input type="hidden" name="deleted" id="deleted"/>
            <table id="tblFinanciamiento">
                <thead>
                <tr style="padding: 5px;">
                    <th style="padding: 5px;" class="ui-widget-header ui-corner-tl" width="310px;">
                        Objetivo
                    </th>
                    <th style="padding: 5px;" class="ui-widget-header" width="310px;">
                        Pol&iacute;tica
                    </th>
                    <th style="padding: 5px;" class="ui-widget-header" width="310px;">
                        Meta
                    </th>
                    <th style="padding: 5px;" class="ui-widget-header ui-corner-tr" width="50px;">
                        Eliminar
                    </th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${metasProyecto}" status="i" var="meta">
                    <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                        <td>
                            ${meta?.metaBuenVivir?.politica?.objetivo}
                        </td>
                        <td>
                            ${meta?.metaBuenVivir?.politica}
                        </td>
                        <td>
                            ${meta?.metaBuenVivir}
                        </td>
                        <td style="text-align: center;">
                            <a href="#" class="button del elim" id="mtp_${meta.id}">Eliminar</a>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:form>

        <br/>

        <div class="botones">
            <div class="botones right">
                <a href="#" class="button saveOnly" title="Guardar los cambios">
                    Guardar
                </a>
                %{--<g:link action="nuevoProyecto" event="datos" class="button back"--}%
                        %{--title="A datos generales">--}%
                    %{--Atr&aacute;s--}%
                %{--</g:link>--}%
                %{--<a href="#" class="button continue" title="A políticas de agenda social">--}%
                    %{--Continuar--}%
                %{--</a>--}%
            </div>

            <div class="botones left">
                %{--<g:link action="nuevoProyecto" event="salir" class="button salir">Salir</g:link>--}%
                <a href="#" class="button" id="btnSalir" title="Regresar a proyecto">
                Salir
                </a>
            </div>
        </div>
    </div>

</div>

<div id="dialog-confirm" sid="" title="¿Eliminar?">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        ¿Est&aacute; seguro de querer eliminar esta meta?
    </p>
</div>


<div id="confirmar" title="Salir">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        ¿Si sale perderá los cambios no guardados. Continuar?
    </p>
</div>

<script type="text/javascript">

    $("#btnSalir").click(function () {
        $("#confirmar").dialog("open");
    });

    $("#confirmar").dialog({
        resizable:false,
        height:150,
        modal:true,
        autoOpen:false,
        buttons:{
            "Salir":function () {
                $(this).dialog("close");
                location.href='${createLink(controller: 'proyecto', action: 'show')}/' + '${proyecto?.id}'
            },
            "Cancelar":function () {
                $(this).dialog("close");
            }
        }
    });

    $(function () {

        $("#objetivo").val("null");

        $('#objetivo').selectmenu({
            width: ${w}
        }).change(function () {
            var obj = $(this).val();

            $.ajax({
                type:"POST",
                url:"${createLink(action:'loadCombo')}",
                data:{
                    tipo:"politica",
                    padre:obj
                },
                success:function (msg) {
                    $("#pols").html(msg).show();
                    $("#mets, #bntAdd").hide();
                }
            });
        });


        $("#dialog-confirm").dialog({
            resizable:false,
            height:150,
            modal:true,
            autoOpen:false,
            buttons:{
                "Sí, Eliminar":function () {
                    deleteRow($("#dialog-confirm").attr("sid"));
                    $(this).dialog("close");
                },
                "No, Cancelar":function () {
                    $(this).dialog("close");
                }
            }
        });

        function addRow() {

            var objId = $("#objetivo").val();
            var objTx = $("#objetivo option:selected").text();

            var polId = $("#politica").val();
            var polTx = $("#politica option:selected").text();

            var metId = $("#meta").val();
            var metTx = $("#meta option:selected").text();

            if (objId != "null" && polId != "null" && metId != "null") {
                if ($("td:icontains('" + metTx + "')").length == 0) {
                    var tr = $("<tr style='border: solid 1px #285589;'>");
                    var tdO = $("<td style='border-bottom: solid 1px #285589;'>" + objTx + "</td>");
                    var tdP = $("<td style='border-bottom: solid 1px #285589;'>" + polTx + "</td>");
                    var tdM = $("<td style='border-bottom: solid 1px #285589;'><input type='hidden' name='meta' value='" + metId + "'/>" + metTx + "</td>");
                    var tdD = $("<td style='border-bottom: solid 1px #285589; text-align: center;'>");

                    var btnDel = $("<a href='#' class='button del' id='fnm_'" + metId + ">Eliminar</a>");

                    btnDel.button({
                        icons:{
                            primary:"ui-icon-trash"
                        },
                        text:false
                    }).click(function () {
                        $(this).parent().parent().remove();
                    });

                    tdD.append(btnDel);

                    tr.append(tdO);
                    tr.append(tdP);
                    tr.append(tdM);
                    tr.append(tdD);

                    $("#tblFinanciamiento tbody").prepend(tr);
                } else {
                    alert("Seleccione una meta que no haya sido agregada aun");
                }
            } else {
                alert("Seleccione una meta para agregar");
            }
        }

        function deleteRow(sid) {

            var obj = $("#" + sid);

            obj.parent().parent().remove();

            var parts = sid.split("_");
            var id = parts[1];

            var del = $("#deleted").val();
            if (trim(del) == "") {
                del = "" + id;
            } else {
                del += "," + id;
            }
            $("#deleted").val(del);
        }

        $("#btnAdd").button({
            icons:{
                primary:'ui-icon-plusthick'
            },
            text:false
        }).click(function () {
            addRow();
            return false;
        });

        $(".elim").button({
            icons:{
                primary:"ui-icon-trash"
            },
            text:false
        }).click(function () {
            $("#dialog-confirm").attr("sid", $(this).attr("id"));
            $("#dialog-confirm").dialog("open");
        });

        var myForm = $(".frmFinanciamiento");

        $(".button").button();

        $(".saveOnly").button("option", "icons", {primary:'ui-icon-disk'}).click(function () {
            $("#goto").val("buenVivir");
            myForm.submit();
            return false;
        });
        $(".continue").button("option", "icons", {secondary:'ui-icon-arrowthick-1-e'}).click(function () {
            $("#goto").val("politicasAgenda");
            myForm.submit();
            return false;
        });
        $(".back").button("option", "icons", {primary:'ui-icon-arrowthick-1-w'}).click(function () {
            $("#goto").val("proyecto");
            myForm.submit();
            return false;
        });
        $(".salir").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'}).click(function () {
            if (confirm("Si sale perderá los cambios no guardados. Continuar?")) {
                return true;
            } else {
                return false;
            }
        });

        $("#selAll").click(function () {
            $(".sel").attr("checked", $("#selAll").is(":checked"));
        });

    });
</script>

</body>
</html>