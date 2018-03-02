<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 28/02/18
  Time: 10:12
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Cargar archivo excel para asignaciones</title>
    <meta name="layout" content="main"/>

</head>

<body>


<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:uploadForm action="uploadFile" method="post" name="frmUpload" id="${''}">
        <div id="list-grupo" class="span12" role="main" style="margin: 10px 0 0 0;">

           <b> Archivo Excel:</b> <input type="file" class="ui-corner-all" name="file" id="file" size="70"/>

        </div>

        <div class="row-fluid" style="margin-left: 80px;margin-top: 15px">
            <div class="span4">
                <a href="#" class="btn button btn-success" id="btnSubir">Subir</a>
            </div>
        </div>

    </g:uploadForm>
</div>

<script type="text/javascript">

    $(".button").button();

    $("#btnSubir").click(function () {
            $(this).replaceWith(spinner);
            $("#frmUpload").submit();
    });

</script>

</body>
</html>