<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'presupuesto.label', default: 'Presupuesto')}"/>
        <title>Cuentas presupuestarias</title>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.min.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>

        <script type='text/javascript'
                src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.hotkeys.js')}'></script>
        <script type='text/javascript'
                src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}'></script>
        <script type='text/javascript'
                src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.jstree.js')}'></script>

        <style type="text/css">
        .btn_guardar > .ui-button-text {
            line-height : 0.5 !important;
        }
        </style>

    </head>

    <body>
        <div class="container entero ui-widget-content ui-corner-all">
            <div id="" class="toolbar ui-widget-header ui-corner-all">
                <g:link class="button list" action="list">
                    <g:message code="presupuesto.list" default="Lista de Partidas Presupuestarias"/>
                </g:link>
            </div> <!-- toolbar -->

            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div id="mensaje" class="message" style="display:none;"></div>

            <div id="tree">
                ${res}
            </div>

        </div>

        <div id="dlg_editar"></div>

        <div id="dlg_error">
            <div style="padding: 0 .7em;" class="ui-state-error ui-corner-all">
                <p>
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                    <span id="span_error"></span>
                </p>
            </div>
        </div>

        <script type="text/javascript">
            var icons = {
                add:"${resource(dir: 'images/ico', file:'Add.png')}",
                edit:"${resource(dir: 'images/ico', file:'Edit.png')}",
                remove:"${resource(dir: 'images/ico', file:'Delete.png')}",
                init:"${resource(dir:'images/ico', file:'FolderFilled.png')}",
                padre:"${resource(dir:'images/ico', file:'safe.png')}",
                hijo:"${resource(dir:'images/ico', file:'coins2.png')}"
            };

            function createContextmenu(node) {
                var textNode = trim(node.children("a").text());

                var strIdNode = node.attr("id");

                var parts = strIdNode.split("_");
                var idNode = parts[1];

                var tipoNode = node.attr("rel");

                var submenu;

                var nuevo = {
                    "label":"Crear hijo",
                    // The function to execute upon a click
                    "action":function (obj) {
                        var tipo = $(obj).attr("rel");
                        var str = $(obj).attr("id");
                        var parts = str.split("_");
                        var id = parts[1];
                        var lvl = $(obj).attr("level");
                        var url = "${createLink(controller: 'presupuesto', action: 'editPresupuesto')}";

                        $.ajax({
                            "type":"POST",
                            "url":url,
                            "data":{
                                "id":id,
                                "level":lvl,
                                "type":"create"
                            },
                            "success":function (msg) {
                                $("#dlg_editar").dialog("option", "title", "Crear presupuesto");
                                $("#dlg_editar").html(msg);
                                $("#dlg_editar").dialog("open");
                            }
                        });
                    },
                    "_disabled":false, // clicking the item won't do a thing
                    "_class":"class", // class is applied to the item LI node
                    "separator_before":false, // Insert a separator before the item
                    "separator_after":true, // Insert a separator after the item
                    "icon":icons.add,
                    "submenu":false //submenu
                };
                var items = {
                    "create":false,
                    "remove":false,
                    "rename":false,
                    "ccp":false,

                    "nuevo":nuevo //nuevo
                } //items

                if (tipoNode != "init") {
                    items.editar = {
                        // The item label
                        "label":"Editar",
                        // The function to execute upon a click
                        "action":function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var lvl = $(obj).attr("level");
                            var url = "${createLink(controller: 'presupuesto', action: 'editPresupuesto')}";

                            $.ajax({
                                "type":"POST",
                                "url":url,
                                "data":{
                                    "id":id,
                                    "level":lvl,
                                    "type":"edit"
                                },
                                "success":function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Editar presupuesto");
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            });
                        },
                        // All below are optional
                        "_disabled":false, // clicking the item won't do a thing
                        "_class":"class", // class is applied to the item LI node
                        "separator_before":false, // Insert a separator before the item
                        "separator_after":false, // Insert a separator after the item
                        // false or string - if does not contain `/` - used as classname
                        "icon":icons.edit
                    }; //editar

                    if (tipoNode == "hijo") {
                        items.eliminar = {
                            // The item label
                            "label":"Eliminar",
                            // The function to execute upon a click
                            "action":function (obj) {
                                var tipo = $(obj).attr("rel");
                                var str = "Está seguro de querer eliminar este presupuesto?\nEsta acción no se puede deshacer...";

                                if (confirm(str)) {
                                    var str = $(obj).attr("id");
                                    var parts = str.split("_");
                                    var id = parts[1];

                                    var url = "${createLink(action: 'deleteFromTree')}";
                                    $.ajax({
                                        "type":"POST",
                                        "url":url,
                                        "data":{
                                            tipo:tipo,
                                            id:id
                                        },
                                        "success":function (msg) {
                                            if (msg == "OK") {
                                                reloadTree();
                                            } else {
                                                $("#span_error").html("Este presupuesto tiene hijos, solo puede eliminar presupuestos vacíos.<br/>Elimine los hijos y después el padre");
                                                $("#dlg_error").dialog("open");
                                            }
                                        }
                                    });
                                }
                            },
                            // All below are optional
                            "_disabled":false, // clicking the item won't do a thing
                            "_class":"class", // class is applied to the item LI node
                            "separator_before":false, // Insert a separator before the item
                            "separator_after":false, // Insert a separator after the item
                            // false or string - if does not contain `/` - used as classname
                            "icon":icons.remove
                        }; //eliminar
                    }
                }
                return items;
            } //createContextmenu

            function initTree() {
                $("#tree").jstree({
                    "plugins":["themes", "html_data", "ui", "hotkeys", "cookies", "types", "contextmenu"],
                    "types":{
                        "valid_children":[ "root" ],
                        "types":{
                            "ini":{
                                "icon":{
                                    "image":icons.init
                                },
                                "valid_children":[ "padre", "hijo" ]
                            },
                            "padre":{
                                "icon":{
                                    "image":icons.padre
                                },
                                "valid_children":[ "padre", "hijo" ]
                            },
                            "hijo":{
                                "icon":{
                                    "image":icons.hijo
                                }
                            }
                        }
                    },
                    "themes":{
                        "theme":"apple"
                    },
                    "contextmenu":{
                        select_node:true,
                        "items":createContextmenu
                    } //contextmenu
                });
            } // initTree

            function reloadTree() {
                var url = "${createLink(controller: 'presupuesto', action: 'renderArbol')}";
                $.ajax({
                    "type":"POST",
                    "url":url,
                    "success":function (msg) {
                        $("#tree").html(msg);
                        initTree();
                    }
                });
            }

            $(function () {

                $(".list").button();

                $("#dlg_editar").dialog({
                    autoOpen:false,
                    modal:true,
                    width:700,
                    buttons:{
                        "Cancelar":function () {
                            $("#dlg_editar").dialog("close");
                        },
                        "Guardar":function () {
                            var url = "${createLink(action: 'saveFromTree')}";
                            if ($(".frm_editar").valid()) {
                                var data = $(".frm_editar").serialize();
                                $.ajax({
                                    "type":"POST",
                                    "url":url,
                                    "data":data,
                                    "success":function (msg) {
                                        if (msg == "OK") {
                                            reloadTree();
                                            $('.jstree-clicked').click();
                                            $("#dlg_editar").dialog("close");
                                            window.location.reload(true);
                                        } else {
                                            alert("Ha ocurrido un error al guardar");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    beforeClose:function () {
                        $(".ui-tooltip-rounded").hide();
                        return true;
                    }
                });

                $("#dlg_error").dialog({
                    autoOpen:false,
                    modal:true,
                    buttons:{
                        "Aceptar":function () {
                            $("#dlg_error").dialog("close");
                        }
                    }
                });

                initTree();

            });
        </script>

    </body>
</html>