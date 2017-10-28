<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 6/20/11
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.Proyecto" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'proyecto.label', default: 'Proyecto')}"/>
    <title>Proyecto</title>

    <style type="text/css">
    #tabs {
        /*height     : 600px;*/
        margin-top: 10px;
        width: 100%;
    }

    .ui-tabs-panel {
        max-height: 400px;
        overflow: auto;
    }
    </style>

</head>

<body>

<div class="dialog" title="Proyecto">
    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <a class="button home" href="${createLinkTo(dir: '')}">
            <g:message code="home" default="Home"/>
        </a>
        <g:link class="button create" action="create">
            <g:message code="default.new.label" args="[entityName]"/>
        </g:link>
    </div> <!-- toolbar -->

    <div class="body">

        <div id="tabs">
            <ul>
                <li><a href="#tab-pry">Proyecto</a></li>
                <li><a href="#tab-cmp">Componente</a></li>
                <li><a href="#tab-mac">Macro actividad</a></li>
                <li><a href="#tab-act">Actividad</a></li>
            </ul>

            <div id="tab-pry">

            </div>

            <div id="tab-cmp">
            </div>

            <div id="tab-mac">
            </div>

            <div id="tab-act">
            </div>

        </div>

    </div> <!-- body -->
</div> <!-- dialog -->

<script type="text/javascript">
    $(function() {

        $("#tabs").tabs();
//                $(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *")
//                        .removeClass("ui-corner-all ui-corner-top")
//                        .addClass("ui-corner-bottom");


        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".create").button("option", "icons", {primary:'ui-icon-document'});

        $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
