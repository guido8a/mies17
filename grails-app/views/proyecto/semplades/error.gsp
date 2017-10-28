<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 6/28/11
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.Fuente" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>

    <title>
        Error
    </title>
</head>

<body>

<div class="dialog" title="Error!">

    <div style="padding: 15px; font-size: 16px;" class="ui-state-error ui-corner-all">
        <p>
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
            <strong>Alerta:</strong> Ha ocurrido un error.
            No se encontr&oacute; un proyecto para mostrar datos de la Semplades.
        </p>
    </div>

</div>


<script type="text/javascript">
    $(function() {

        $(".button").button();

        $(".back").button("option", "icons", {primary:'ui-icon-arrowthick-1-w'});

    });
</script>

</body>
</html>