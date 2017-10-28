<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 7/7/11
  Time: 5:16 PM
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

    <title>&Aacute;rbol de entidades</title>

    <style type="text/css">
    .div {
        width      : 500px;
        height     : 680px;
        min-height : 150px;
        border     : solid 3px #70B8D6;
        padding    : 5px;
    }

    .info {
        margin-left : 15px;
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
    }

    #tree li > ins {
        vertical-align : top;
    }

    #tree .jstree-hovered, #demo4 .jstree-clicked {
        border : 0;
    }

    .label_arbol {
        max-width : 425px;
    }
    </style>

</head>

<body>

<div id="tree" class="div left ui-corner-all">
    ${tree}
</div>

<div id="info" class="div info left ui-corner-all">
    <div id="infoTitle"></div>

    <div id="infoCont"></div>
</div>

<div id="dlg_editar"></div>

<script type="text/javascript">
    $(function() {

        var icons = {
            add: "${resource(dir: 'images/ico', file:'Add.png')}",
            edit: "${resource(dir: 'images/ico', file:'Edit.png')}",
            remove: "${resource(dir: 'images/ico', file:'Delete.png')}",
            padre: "${resource(dir:'images/ico', file:'folder_rising_dragon.png')}",
            entidad: "${resource(dir:'images/ico', file:'e.png')}",
            subsecretaria: "${resource(dir:'images/ico', file:'s.png')}",
            unidad: "${resource(dir:'images/ico', file:'u.png')}",
            responsable: "${resource(dir:'images/ico', file:'r.png')}"
        };

        var lrg_icons = {
            add: "${resource(dir: 'images/ico', file:'Add.png')}",
            edit: "${resource(dir: 'images/ico', file:'Edit.png')}",
            remove: "${resource(dir: 'images/ico', file:'Delete.png')}",
            padre: "${resource(dir:'images/ico', file:'folder_rising_dragon.png')}",
            entidad: "${resource(dir:'images/ico', file:'e.png')}",
            subsecretaria: "${resource(dir:'images/ico', file:'s.png')}",
            unidad: "${resource(dir:'images/ico', file:'u.png')}",
            responsable: "${resource(dir:'images/ico', file:'r.png')}"
        };

        $("#dlg_editar").dialog({
            autoOpen: false,
            modal:true,
            width: 775,
            buttons: {
                "Cancelar": function() {
                    $("#dlg_editar").dialog("close");
                },
                "Guardar": function() {
                    var url = "${createLink(action: 'saveFromTree')}";
                    if ($(".frm_editar").valid()) {
                        var data = $(".frm_editar").serialize();
                        $.ajax({
                            "type": "POST",
                            "url": url,
                            "data": data,
                            "success": function(msg) {
                                if (msg == "OK") {
                                    reloadTree();
                                    $("#dlg_editar").dialog("close");
                                } else {
                                    alert("Ha ocurrido un error al guardar");
                                }
                            }
                        });
                    }
                }
            },
            beforeClose: function() {
                $(".ui-tooltip-rounded").hide();
                return true;
            }
        });

        initTree();

        function reloadTree() {
            var url = "${createLink(controller: 'entidad', action: 'renderArbol')}";
            $.ajax({
                "type": "POST",
                "url": url,
                "success": function(msg) {
                    $("#tree").html(msg);
                    initTree();
                }
            });
        }

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
                        "entidad" : {
                            "label": "Entidad",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "entidad",
                                        "crear": true
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear entidad");
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action entidad
                            "icon": icons.entidad
                        } //entidad
                    };
                    break;
                case "entidad":
                    submenu = {
                        "entidad" : {
                            "label": "Entidad",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "entidad",
                                        "crear": true
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear entidad");
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action entidad
                            "icon": icons.entidad
                        }, //entidad
                        "subsecretaria" : {
                            "label": "SubSecretaría",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "subsecretaria",
                                        "crear": true,
                                        "padre": idNode
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear subsecretaría de " + textNode);
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action subsecretaria
                            "icon": icons.subsecretaria
                        } //subsecretaria
                    };
                    break;
                case "subsecretaria":
                    submenu = {
                        "subsecretaria" : {
                            "label": "SubSecretaría",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "subsecretaria",
                                        "crear": true,
                                        "padre": idParent
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear subsecretaría de " + textParent);
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action subsecretaria
                            "icon": icons.subsecretaria
                        }, //subsecretaria
                        "unidad" : {
                            "label": "Unidad ejecutora",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "unidad",
                                        "crear": true,
                                        "padre": idNode
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear Unidad Ejecutora de " + textNode);
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action unidad
                            "icon": icons.unidad
                        } //unidad
                    };
                    break;
                case "unidad":
                    submenu = {
                        "unidad" : {
                            "label": "Unidad ejecutora",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "unidad",
                                        "crear": true,
                                        "padre": idParent
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear Unidad Ejecutora de " + textParent);
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action unidad
                            "icon": icons.unidad
                        }, //unidad
                        "responsable" : {
                            "label": "Responsable",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "responsable",
                                        "crear": true,
                                        "padre": idNode
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear Responsable de " + textNode);
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action responsable
                            "icon": icons.responsable
                        } //responsable
                    };
                    break;
                case "responsable":
                    submenu = {
                        "responsable" : {
                            "label": "Responsable",
                            "action": function (obj) {
                                var url = "${createLink(controller: 'entidad', action: 'editar')}";
                                $.ajax({
                                    "type": "POST",
                                    "url": url,
                                    "data": {
                                        "tipo": "responsable",
                                        "crear": true,
                                        "padre": idParent
                                    },
                                    "success": function(msg) {
                                        $("#dlg_editar").dialog("option", "title", "Crear Responsable de " + textParent);
                                        $("#dlg_editar").html(msg);
                                        $("#dlg_editar").dialog("open");
                                    }
                                }); //ajax
                            }, //action responsable
                            "icon": icons.responsable
                        } //responsable
                    };
                    break;
            }

            var nuevo = {
                "label": "Crear",
                "_disabled": false,        // clicking the item won't do a thing
                "_class": "class",    // class is applied to the item LI node
                "separator_before": false,    // Insert a separator before the item
                "separator_after": true,        // Insert a separator after the item
                "icon": icons.add,
                "submenu": submenu //submenu
            };
            var items = {
                "create": false,
                "remove": false,
                "rename": false,
                "ccp": false,

                "nuevo" : nuevo, //nuevo

                "editar" : {
                    // The item label
                    "label": "Editar",
                    // The function to execute upon a click
                    "action": function (obj) {
                        var tipo = $(obj).attr("rel");
                        var str = $(obj).attr("id");
                        var parts = str.split("_");
                        var id = parts[1];
                        var url = "${createLink(controller: 'entidad', action: 'editar')}";

                        $.ajax({
                            "type": "POST",
                            "url": url,
                            "data": {
                                "tipo": tipo,
                                "id": id
                            },
                            "success": function(msg) {
                                $("#dlg_editar").dialog("option", "title", "Editar " + tipo);
                                $("#dlg_editar").html(msg);
                                $("#dlg_editar").dialog("open");
                            }
                        });

                    },
                    // All below are optional
                    "_disabled": false,        // clicking the item won't do a thing
                    "_class": "class",    // class is applied to the item LI node
                    "separator_before": false,    // Insert a separator before the item
                    "separator_after": false,        // Insert a separator after the item
                    // false or string - if does not contain `/` - used as classname
                    "icon": icons.edit
                } //editar
            } //items

            var deleteable = true;
            if (tipoNode == "responsable") {
                deleteable = false;
            }

//            //console.log(node);

            if (deleteable) {
                items.eliminar = {
                    // The item label
                    "label": "Eliminar",
                    // The function to execute upon a click
                    "action": function (obj) {
                        var tipo = $(obj).attr("rel");
                        var str = "";
                        switch (tipo) {
                            case "entidad":
                                str = "esta entidad";
                                break;
                            case "subsecretaria":
                                str = "esta subsecretaría";
                                break;
                            case "unidad":
                                str = "esta unidad ejecutora";
                                break;
                            case "responsable":
                                str = "este responsable";
                                break;
                        }

                        if (confirm("Está seguro de eliminar " + str + "?")) {
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];

                            var url = "${createLink(action: 'deleteFromTree')}";
                            $.ajax({
                                "type": "POST",
                                "url": url,
                                "data": {
                                    tipo: tipo,
                                    id: id
                                },
                                "success": function(msg) {
                                    if (msg == "OK") {
                                        reloadTree();
                                    } else {
                                        alert("Ha ocurrido un error al eliminar");
                                    }
                                }
                            });
                        }
                    },
                    // All below are optional
                    "_disabled": false,        // clicking the item won't do a thing
                    "_class": "class",    // class is applied to the item LI node
                    "separator_before": false,    // Insert a separator before the item
                    "separator_after": false,        // Insert a separator after the item
                    // false or string - if does not contain `/` - used as classname
                    "icon": icons.remove
                }; //eliminar
            }

            return items;
        } //createContextmenu

        function initTree() {
            $("#tree").jstree({
                "plugins" : ["themes", "html_data", "ui", "hotkeys", "cookies", "types", "contextmenu"/*, "crrm", "wholerow"*/],
                "types" : {
                    "valid_children" : [ "root" ],
                    "types" : {
                        "padre" : {
                            "icon" : {
                                "image" : icons.padre
                            },
                            "valid_children" : [ "subsecretaria" ]
                        },
                        "entidad" : {
                            "icon" : {
                                "image" : icons.entidad
                            },
                            "valid_children" : [ "subsecretaria" ]
                        },
                        "subsecretaria" : {
                            "icon" : {
                                "image" : icons.subsecretaria
                            },
                            "valid_children" : [ "unidad" ]
                        },
                        "unidad" : {
                            "icon" : {
                                "image" : icons.unidad
                            },
                            "valid_children" : [ "responsable" ]
                        },
                        "responsable" : {
                            "icon" : {
                                "image" : icons.responsable
                            },
                            "valid_children" : []
                        }
                    }
                },
                "themes" : {
                    "theme" : "default"
                },
                "contextmenu" : {
                    select_node: true,
                    "items" : createContextmenu
                }, //contextmenu
                "ui" : {
                    "select_limit" : 1
                }
            })//js tree
                    .bind("select_node.jstree", function (event, data) {
                        // `data.rslt.obj` is the jquery extended node that was clicked
//                        //console.log(data.rslt.obj);
//                        //console.log(data.rslt.obj.attr("id"));
                        var obj = data.rslt.obj;
                        var title = obj.children("a").text();
                        var tipo = $(obj).attr("rel");
                        var str = $(obj).attr("id");
                        var parts = str.split("_");
                        var id = parts[1];

                        var img = "<img src='" + lrg_icons[tipo] + "' alt='" + tipo + "' />";
                        $("#infoTitle").html("<h2>" + img + "  " + title + "</h2>");

                        var h = $("#tree").height();
                        var h2 = $("#info").height();

                        $("#info").height(Math.max(h, h2));
                        $("#tree").height(Math.max(h, h2));

                        var url = "${createLink(action: 'infoForTree')}";
                        $.ajax({
                            "type": "POST",
                            "url": url,
                            "data": {
                                tipo: tipo,
                                id: id
                            },
                            "success": function(msg) {
                                $("#infoCont").html(msg);
                            },
                            "error": function() {
                                $("#infoCont").html("");
                            }
                        }); //ajax
                    }); //click en los nodos
        }

        $(".linkArbol").livequery(function() {
            $(this).click(function() {
                $("#link_" + $(this).attr("tipo")).click();
                return false;
            });
        });

    });
</script>

</body>
</html>
