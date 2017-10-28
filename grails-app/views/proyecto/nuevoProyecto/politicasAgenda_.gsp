<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 6/22/11
  Time: 12:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.PoliticaAgendaSocial; mies.PoliticasAgendaProyecto; mies.MetaBuenVivir; mies.PoliticaBuenVivir; mies.Politica; mies.ObjetivoBuenVivir; mies.Fuente" contentType="text/html;charset=UTF-8" %>
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
            Pol&iacute;ticas de agenda social del proyecto ${proyecto.nombre}
        </title>
    </head>

    <body>

        <div class="dialog" title="Financiamiento del proyecto ${proyecto.nombre}">

            <div style="padding: 0.7em; margin: 0.7em;" class="ui-state-error ui-corner-all ui-helper-hidden"
                 id="divError">
                <p>
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                    <strong>Error:</strong>
                    <span id="spanError"></span>
                </p>
            </div>

            <g:set var="w" value="900"/>

            <mf:menuSemplades items='${items}' links="${links}"/>

            <div class="ui-widget-content ui-corner-all" style="padding: 3px; height: 30px;">
                <div style="float:left; margin-left: 5px;">
                    <strong>
                        Pol&iacute;ticas:
                    </strong>
                    <g:select from="${PoliticaAgendaSocial.list()}" name="plas" id="plas" optionKey="id"
                              optionValue="descripcion" style="width: ${w}px;"
                              noSelection="${['null':'..-- Seleccione una política --..']}"/>
                </div>

                <a href="#" id="btnAdd" class="button" style="margin-left: 5px;">Agregar</a>
            </div>


            <div class="ui-widget-content ui-corner-all" style="padding: 10px;">

            %{--
            TODO: esta hecho solo en el caso de la insercion, falta hacer en la modificacion
            --}%
                <g:form class="frmFinanciamiento" method="post" action="nuevoProyecto" event="savePoliticasAgenda">
                    <input type="hidden" name="deleted" id="deleted"/>
                    <table id="tblPlas" width="100%">
                        <thead>
                            <tr style="padding: 5px;">
                                <th style="padding: 5px;" class="ui-widget-header ui-corner-tl" width="310px;">
                                    Pol&iacute;tica
                                </th>
                                <th style="padding: 5px;" class="ui-widget-header ui-corner-tr" width="50px;">
                                    Eliminar
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${politicasAgenda}" status="i" var="plas">
                                <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                    <td>
                                        ${plas.politicaAgendaSocial.descripcion}
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="#" class="button del elim" id="plas_${plas.id}">Eliminar</a>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </g:form>

                <br/>

                <div class="botones">
                    <div class="botones right">
                        <g:link action="nuevoProyecto" event="buenVivir" class="button back"
                                title="A objetivos del buen vivir">
                            Atr&aacute;s
                        </g:link>
                        <a href="#" class="button continue" title="A políticas MIES">
                            Continuar
                        </a>
                    </div>

                    <div class="botones left">
                        <g:link action="nuevoProyecto" event="salir" class="button salir">Salir</g:link>
                    </div>
                </div>
            </div>

        </div>

        <div id="dialog-confirm" sid="" title="¿Eliminar?">
            <p>
                <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                ¿Est&aacute; seguro de querer eliminar esta pol&iacute;tica?
            </p>
        </div>


        <script type="text/javascript">
            $(function() {

                $("#objetivo").val("null");

                $('#plas').selectmenu({
                    width: ${w}
                });


                $("#dialog-confirm").dialog({
                    resizable: false,
                    height:150,
                    modal: true,
                    autoOpen: false,
                    buttons: {
                        "Sí, Eliminar": function() {
                            deleteRow($("#dialog-confirm").attr("sid"));
                            $(this).dialog("close");
                        },
                        "No, Cancelar": function() {
                            $(this).dialog("close");
                        }
                    }
                });

                function addRow() {

                    var polId = $("#plas").val();
                    var polTx = $("#plas option:selected").text();

                    if (polId != "null") {
                        if ($("td:icontains('" + polTx + "')").length == 0) {
                            var tr = $("<tr style='border: solid 1px #285589;'>");
                            var tdP = $("<td style='border-bottom: solid 1px #285589;'><input type='hidden' name='plas' value='" + polId + "'/>" + polTx + "</td>");
                            var tdD = $("<td style='border-bottom: solid 1px #285589; text-align: center;'>");

                            var btnDel = $("<a href='#' class='button del' id='plas_'" + polId + ">Eliminar</a>");

                            btnDel.button({
                                icons: {
                                    primary: "ui-icon-trash"
                                },
                                text: false
                            }).click(function() {
                                        $(this).parent().parent().remove();
                                    });

                            tdD.append(btnDel);

                            tr.append(tdP);
                            tr.append(tdD);

                            $("#tblPlas tbody").prepend(tr);
                        } else {
                            alert("Seleccione una política que no haya sido agregada aún");
                        }
                    } else {
                        alert("Seleccione una política para agregar");
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
                    icons: {
                        primary:'ui-icon-plusthick'
                    },
                    text: false
                }).click(function() {
                            addRow();
                            return false;
                        });

                $(".elim").button({
                    icons: {
                        primary: "ui-icon-trash"
                    },
                    text: false
                }).click(function() {
                            $("#dialog-confirm").attr("sid", $(this).attr("id"));
                            $("#dialog-confirm").dialog("open");
                        });

                var myForm = $(".frmFinanciamiento");

                $(".button").button();
                $(".continue").button("option", "icons", {secondary:'ui-icon-arrowthick-1-e'}).click(function() {
                    myForm.submit();
                    return false;
                });
                $(".back").button("option", "icons", {primary:'ui-icon-arrowthick-1-w'});
                $(".salir").button("option", "icons", {primary:'ui-icon-arrowreturnthick-1-w'}).click(function () {
                    if (confirm("Si sale perderá los cambios no guardados. Continuar?")) {
                        return true;
                    } else {
                        return false;
                    }
                });

                $("#selAll").click(function() {
                    $(".sel").attr("checked", $("#selAll").is(":checked"));
                });

            });
        </script>

    </body>
</html>