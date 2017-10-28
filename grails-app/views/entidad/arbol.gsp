<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/17/11
  Time: 11:01 AM
  To change this template use File | Settings | File Templates.
--%>

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

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.min.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.hotkeys.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.jstree.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>

        <title>&Aacute;rbol de entidades</title>


        <style type="text/css">
        .ui-dialog .ui-dialog-content {
            overflow : hidden !important;
        }

        .div {
            width      : 424px;
            min-height : 150px;
            border     : solid 3px #768CC1;
            padding    : 5px;
            background : #EAF2FF !important;
        }

        .info {
            margin-left : 15px;
            width       : 598px;
        }

        #infoCont {
            margin-top : 5px;
        }

        .label {
            padding     : 0 5px 0 15px;
            font-weight : bold;
        }

        #tree a {
            white-space : normal !important;
            height      : auto;
            padding     : 1px 2px;
            max-width   : 330px;
        }

        #tree li > ins {
            vertical-align : top;
        }

        #tree .jstree-hovered, #tree .jstree-clicked {
            border : 0;
        }
        </style>

    </head>

    <body>
        <div class="dialog" style="overflow: hidden;">

            <div class="body" style="overflow: hidden;">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>

                <div id="tree" class="div left ui-corner-all"
                     style="height:600px; width: 400px;overflow-y: auto;overflow-x: hidden;">

                </div>

                <div id="info" class="div info left ui-corner-all">
                    <div id="infoTitle"></div>

                    <div id="infoCont"></div>
                </div>

                <div id="dlg_editar"></div>

                <div id="dlg_responsable">

                </div>

            </div> <!-- body -->
        </div> <!-- dialog -->

        <script type="text/javascript">

            var loadedTipo = "", loadedId = "";

            var icons = {
                add               : "${resource(dir: 'images/ico', file:'Add.png')}",
                edit              : "${resource(dir: 'images/ico', file:'Edit.png')}",
                remove            : "${resource(dir: 'images/ico', file:'Delete.png')}",
                asignacion        : "${resource(dir: 'images/ico', file:'asignacion.png')}",
                addUser           : "${resource(dir: 'images/ico', file:'user-option-add.png')}",
                padre             : "${resource(dir: 'images/ico', file:'folder_rising_dragon.png')}",
                folder            : "${resource(dir:'images/ico', file:'companies.png')}",
                file              : "${resource(dir:'images/ico', file:'building-low.png')}",
                proyecto          : "${resource(dir:'images/ico', file:'project_open.png')}",
                corriente         : "${resource(dir:'images/ico', file:'money.png')}",
                usro              : "${resource(dir:'images/ico', file:'personal.png')}",
                responsable       : "${resource(dir:'images/ico', file:'responsable.png')}",
                presupuestoUnidad : "${resource(dir:'images/ico', file:'presupuestoUnidad.png')}",
                documentos        : "${resource(dir:'images/ico', file:'documents-stack.png')}"
            };

            var lrg_icons = {
                padre  : "${resource(dir: 'images/ico', file:'folder_rising_dragon.png')}",
                folder : "${resource(dir:'images/ico', file:'companies_32.png')}",
                file   : "${resource(dir:'images/ico', file:'building-low_32.png')}",
                usro   : "${resource(dir:'images/ico', file:'personal_32.png')}"
            };

            function createContextmenu(node) {

                var parent = node.parent().parent();

                var textNode = trim(node.children("a").text());
                var textParent = trim(parent.children("a").text());

                var strIdNode = node.attr("id");
                var strIdParent = parent.attr("id");

                var parts = strIdNode.split("_");
                var idNode = parts[1];
                parts = strIdParent.split("_");
                var idParent = parts[1];

                var tipoNode = node.attr("rel");
                var tipoParent = parent.attr("rel");

                var submenu;

                switch (tipoNode) {
                    case "padre":
                        submenu = {
                        };
                        break;
                }

                var items = {
                    "create" : false,
                    "remove" : false,
                    "rename" : false,
                    "ccp"    : false
                } //items


                if (tipoNode != "usro") {
                    items.nuevo = {
                        "label"            : "Agregar entidad",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "_class"           : "class", // class is applied to the item LI node
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.add,
                        // The function to execute upon a click
                        "action"           : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var url = "${createLink(action: 'editFromTree')}";

                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo" : "create",
                                    "id"   : id
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Crear Entidad");
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            });
                        }
                    }; //nuevo hijo
                    items.presupuesto = {
                        "label"            : "Presupuesto entidad",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "_class"           : "class", // class is applied to the item LI node
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.presupuestoUnidad,
                        // The function to execute upon a click
                        "action"           : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var url = "${createLink(action: 'presupuestoFromTree')}";

                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo" : "create",
                                    "id"   : id
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Presupuesto Entidad");
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            });
                        }
                    }; //presupuesto entidad
                    items.Modpresupuesto = {
                        "label"            : "Modificar presupuesto",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "_class"           : "class", // class is applied to the item LI node
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.presupuestoUnidad,
                        // The function to execute upon a click
                        "action"           : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var url = "${createLink(action: 'modTechos',controller: 'modificacion')}/"+id;
                            location.href = url;

                        }
                    };
                    items.documentos = {
                        "label"            : "Documentos entidad",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "_class"           : "class", // class is applied to the item LI node
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.documentos,
                        // The function to execute upon a click
                        "action"           : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var url = "${createLink(action: 'docsFromTree')}/" + id;
                            location.href = url;
                        }
                    }; //presupuesto entidad
                    if (tipoNode != "padre") {

                        var sep = true;
                        if (node.hasClass("hasUsers")) {
                            sep = false;
                        }

                        items.user = {
                            "label"            : "Agregar usuario",
                            "_disabled"        : false, // clicking the item won't do a thing
                            "_class"           : "class", // class is applied to the item LI node
                            "separator_before" : true, // Insert a separator before the item
                            "separator_after"  : sep, // Insert a separator after the item
                            "icon"             : icons.addUser,
                            // The function to execute upon a click
                            "action"           : function (obj) {
                                var tipo = $(obj).attr("rel");
                                var str = $(obj).attr("id");
                                var parts = str.split("_");
                                var id = parts[1];
                                var url = "${createLink(action: 'editUserFromTree')}";

                                $.ajax({
                                    "type"    : "POST",
                                    "url"     : url,
                                    "data"    : {
                                        "tipo" : "create",
                                        "id"   : id
                                    },
                                    "success" : function (msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear Usuario");
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                });
                            }
                        }; //nuevo usuario

                        if (node.hasClass("hasUsers")) {
                            items.responsable = {
                                // The item label
                                "label"            : "Responsables",
                                // The function to execute upon a click
                                "action"           : function (obj) {
                                    var tipo = $(obj).attr("rel");
                                    var str = $(obj).attr("id");
                                    var parts = str.split("_");
                                    var id = parts[1];
                                    var url = "${createLink(action: 'responsables')}";

                                    $.ajax({
                                        "type"    : "POST",
                                        "url"     : url,
                                        "data"    : {
                                            "tipo" : "create",
                                            "id"   : id
                                        },
                                        "success" : function (msg) {
                                            $("#dlg_responsable").dialog("option", "title", "Responsables de la entidad " + textNode);
                                            $("#dlg_responsable").html(msg);
                                            $("#dlg_responsable").dialog("open");
                                        }
                                    });
                                },
                                // All below are optional
                                "_disabled"        : false, // clicking the item won't do a thing
                                "_class"           : "class", // class is applied to the item LI node
                                "separator_before" : false, // Insert a separator before the item
                                "separator_after"  : true, // Insert a separator after the item
                                // false or string - if does not contain `/` - used as classname
                                "icon"             : icons.responsable
                            }; //responsable
                        }

                        items.editar = {
                            // The item label
                            "label"            : "Editar",
                            // The function to execute upon a click
                            "action"           : function (obj) {
                                var tipo = $(obj).attr("rel");
                                var str = $(obj).attr("id");
                                var parts = str.split("_");
                                var id = parts[1];
                                var url = "${createLink(action: 'editFromTree')}";

                                $.ajax({
                                    "type"    : "POST",
                                    "url"     : url,
                                    "data"    : {
                                        "tipo" : "edit",
                                        "id"   : id
                                    },
                                    "success" : function (msg) {
                                        $("#dlg_editar").dialog("option", "title", "Editar Entidad");
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                });
                            },
                            // All below are optional
                            "_disabled"        : false, // clicking the item won't do a thing
                            "_class"           : "class", // class is applied to the item LI node
                            "separator_before" : false, // Insert a separator before the item
                            "separator_after"  : false, // Insert a separator after the item
                            // false or string - if does not contain `/` - used as classname
                            "icon"             : icons.edit
                        }; //editar

                        if (tipoNode != "folder") {
                            if (!node.hasClass("hasUsers")) {
                                items.eliminar = {
                                    // The item label
                                    "label"            : "Eliminar",
                                    // The function to execute upon a click
                                    "action"           : function (obj) {
                                        var tipo = $(obj).attr("rel");
                                        var str = "Está seguro de querer eliminar esta entidad?\nEsta acción no se puede deshacer.";

                                        if (confirm(str)) {
                                            var str = $(obj).attr("id");
                                            var parts = str.split("_");
                                            var id = parts[1];

                                            var url = "${createLink(action: 'deleteFromTree')}";
                                            $.ajax({
                                                "type"    : "POST",
                                                "url"     : url,
                                                "data"    : {
                                                    tipo : tipo,
                                                    id   : id
                                                },
                                                "success" : function (msg) {
                                                    if (msg == "OK") {
                                                        $("#infoCont").html("");
                                                        $("#infoTitle").html("");
                                                        initTree();
                                                    } else {
                                                        alert(msg);
                                                    }
                                                }
                                            });
                                        }
                                    },
                                    // All below are optional
                                    "_disabled"        : false, // clicking the item won't do a thing
                                    "_class"           : "class", // class is applied to the item LI node
                                    "separator_before" : false, // Insert a separator before the item
                                    "separator_after"  : false, // Insert a separator after the item
                                    // false or string - if does not contain `/` - used as classname
                                    "icon"             : icons.remove
                                }; //eliminar
                            }
                        }
                    }
                } //!usro
                else {
                    items.editar = {
                        // The item label
                        "label"            : "Editar",
                        // The function to execute upon a click
                        "action"           : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var url = "${createLink(action: 'editUserFromTree')}";

                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "tipo" : "edit",
                                    "id"   : id
                                },
                                "success" : function (msg) {
                                    $("#dlg_editar").dialog("option", "title", "Editar Usuario");
                                    $("#dlg_editar").html(msg);
                                    $("#dlg_editar").dialog("open");
                                }
                            });
                        },
                        // All below are optional
                        "_disabled"        : false, // clicking the item won't do a thing
                        "_class"           : "class", // class is applied to the item LI node
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        // false or string - if does not contain `/` - used as classname
                        "icon"             : icons.edit
                    }; //editar

                %{--items.eliminar = {--}%
                %{--// The item label--}%
                %{--"label": "Eliminar",--}%
                %{--// The function to execute upon a click--}%
                %{--"action": function (obj) {--}%
                %{--var tipo = $(obj).attr("rel");--}%
                %{--var str = "Está seguro de querer eliminar este usuario?\nEsta acción no se puede deshacer.";--}%

                %{--if (confirm(str)) {--}%
                %{--var str = $(obj).attr("id");--}%
                %{--var parts = str.split("_");--}%
                %{--var id = parts[1];--}%

                %{--var url = "${createLink(action: 'deleteUserFromTree')}";--}%
                %{--$.ajax({--}%
                %{--"type": "POST",--}%
                %{--"url": url,--}%
                %{--"data": {--}%
                %{--tipo: tipo,--}%
                %{--id: id--}%
                %{--},--}%
                %{--"success": function(msg) {--}%
                %{--if (msg == "OK") {--}%
                %{--$("#infoCont").html("");--}%
                %{--$("#infoTitle").html("");--}%
                %{--initTree();--}%
                %{--} else {--}%
                %{--alert(msg);--}%
                %{--}--}%
                %{--}--}%
                %{--});--}%
                %{--}--}%
                %{--},--}%
                %{--// All below are optional--}%
                %{--"_disabled": false,        // clicking the item won't do a thing--}%
                %{--"_class": "class",    // class is applied to the item LI node--}%
                %{--"separator_before": false,    // Insert a separator before the item--}%
                %{--"separator_after": false,        // Insert a separator after the item--}%
                %{--// false or string - if does not contain `/` - used as classname--}%
                %{--"icon": icons.remove--}%
                %{--}; //eliminar--}%
                } //usro
                return items;
            } //createContextmenu

            function initTree() {
                $("#tree").jstree({
                    "plugins"     : ["themes", "html_data", "ui", "hotkeys", "cookies", "types", "contextmenu", "json_data", "search"/*, "crrm", "wholerow"*/],
                    open_parents  : false,
                    "html_data"   : {
                        "data" : "<ul type='padre'><li id='padre_' class='padre jstree-closed' rel='padre'><a href='#' class='label_arbol'>Entidades</a></ul>",
                        "ajax" : {
                            "url"   : "${createLink(action: 'loadTreePart')}",
                            "data"  : function (n) {
                                var obj = $(n);
                                var id = obj.attr("id");
                                var parts = id.split("_");
                                var tipo = parts[0];
                                var id = 0;
                                if (parts.length > 1) {
                                    id = parts[1]
                                }
                                return {tipo : tipo, id : id}
                            },
                            success : function (data) {

                            },
                            error   : function (data) {
                                ////console.log("error");
                                ////console.log(data);
                            }
                        }
                    },
                    "types"       : {
                        "valid_children" : [ "padre" ],
                        "types"          : {
                            "padre"  : {
                                "icon"           : {
                                    "image" : icons.padre
                                },
                                "valid_children" : [ "folder", "file", "usro" ]
                            },
                            "folder" : {
                                "icon"           : {
                                    "image" : icons.folder
                                },
                                "valid_children" : [ "folder", "file", "usro" ]
                            },
                            "file"   : {
                                "icon"           : {
                                    "image" : icons.file
                                },
                                "valid_children" : [ "" ]
                            },
                            "usro"   : {
                                "icon"           : {
                                    "image" : icons.usro
                                },
                                "valid_children" : [ "" ]
                            }
                        }
                    },
                    "themes"      : {
                        "theme" : "default"
                    },
                    "contextmenu" : {
                        select_node : true,
                        "items"     : createContextmenu
                    }, //contextmenu
                    "ui"          : {
                        "select_limit" : 1
                    }
                })//js tree
                        .bind("select_node.jstree", function (event, data) {
//                            //console.log("AQUIIIIIIIIIIIIII");
                            // `data.rslt.obj` is the jquery extended node that was clicked
//                        //console.log(data.rslt.obj);
//                        //console.log(data.rslt.obj.attr("id"));
                            var obj = data.rslt.obj;

                            obj.click();

//                            //console.log("#" + obj.attr("id"));
//                            //console.log(obj);

//                            $("#tree").jstree("toggle_node", "#" + obj.attr("id"));
//                            $("#tree").jstree("toggle_node", obj);

//                            alert(data.rslt.obj.attr("id"));
                            $("#tree").jstree("toggle_node", data.rslt.obj);

//                            $("#tree").jstree("select_node", data.rslt.obj);
//                            $("#tree").jstree("toggle_node", data.rslt.obj);
//                            $("#tree").jstree("deselect_node", data.rslt.obj);

                            var title = obj.children("a").text();
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];

                            if (loadedTipo != tipo || loadedId != id) {

                                loadedTipo = tipo;
                                loadedId = id;

                                var img = "<img src='" + lrg_icons[tipo] + "' alt='" + tipo + "' />";
                                $("#infoTitle").html("<h1>" + img + "  " + title + "</h1>");

                                var url = "${createLink(action: 'infoForTree')}";
                                $.ajax({
                                    "type"    : "POST",
                                    "url"     : url,
                                    "data"    : {
                                        tipo : tipo,
                                        id   : id
                                    },
                                    "success" : function (msg) {
                                        $("#infoCont").html(msg);
                                    },
                                    "error"   : function () {
                                        $("#infoCont").html("");
                                    }
                                }); //ajax
                            }
                        }); //click en los nodos

                var h = $("#tree").height();
                var h2 = $("#info").height();

                var extra = 0;

                $("#info").height(Math.max(h, h2) + extra);
                $("#tree").height(Math.max(h, h2) + extra);

            } //init tree

            $(function () {

                $("#dlg_responsable").dialog({
                    autoOpen    : false,
                    resizable   : false,
                    modal       : true,
                    width       : 800,
                    position    : [225, 75],
                    buttons     : {
                        "Cerrar" : function () {
                            $("#dlg_responsable").dialog("close");
                        }
                    },
                    beforeClose : function () {
                        $(".ui-tooltip-rounded").hide();
                        return true;
                    }
                });

                $("#dlg_editar").dialog({
                    autoOpen    : false,
                    modal       : true,
                    width       : 800,
                    buttons     : {
                        "Cancelar" : function () {
                            $("#dlg_editar").dialog("close");
                        },
                        "Guardar"  : function () {
                            var url = "${createLink(action: 'saveFromTree')}";
                            if ($(".frm_editar").valid()) {
                                var data = $(".frm_editar").serialize();
                                $.ajax({
                                    "type"    : "POST",
                                    "url"     : url,
                                    "data"    : data,
                                    "success" : function (msg) {
                                        ////console.log(msg);
                                        if (msg == "OK") {
                                            initTree();
                                            loadedId = -1;
                                            $('.jstree-clicked').click();
                                            $("#dlg_editar").dialog("close");
//                                            window.location.reload(true);
                                        } else {
                                            alert("Ha ocurrido un error al guardar");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    beforeClose : function () {
                        $(".ui-tooltip-rounded").hide();
                        return true;
                    }
                });

                initTree();

                $(".linkArbol").livequery(function () {
                    $(this).click(function () {
                        $("#link_" + $(this).attr("tipo")).click();
                        return false;
                    });
                });

            });
        </script>

    </body>
</html>