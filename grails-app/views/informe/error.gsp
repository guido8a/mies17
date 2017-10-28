<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/16/11
  Time: 11:12 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Ha ocurrido un error</title>
    </head>

    <body>

        <div style="padding: 0 .7em;" class="ui-state-error ui-corner-all">
            <p><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                <strong>Alerta:</strong> El usuario <strong>${params.usuario}</strong> no es responsable de ning&uacute;n proyecto.
            </p>

            <p>No puede crear informes.</p>
        </div>

    </body>
</html>