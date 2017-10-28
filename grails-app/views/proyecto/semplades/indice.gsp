<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 6/22/11
  Time: 12:05 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.Fuente" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>

    <link rel="stylesheet" href="${resource(dir:'css/menuSemplades', file: 'flow_menu_green.css')}" />

    <title>
        Datos Semplades del proyecto ${proyecto.nombre}
    </title>
</head>

<body>

<div class="dialog" title="Datos Semplades del proyecto ${proyecto.nombre}">

    <mf:menuSemplades items='${items}'/>

</div>

</body>
</html>