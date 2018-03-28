<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Mies - manager</title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'logo_mies.jpg')}" type="image/x-icon"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.5.1.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.13.custom.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/start', file: 'jquery-ui-1.8.13.custom.css')}"/>
    <style type="text/css">
    .esquinas {
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        border-radius: 10px;

    }

    input {
        height: 30px;
        background: #c7c7c7;
        width: 200px;
        float: left;
        margin-top: 0px;
        margin-left: 25px;
        color: #555;
        padding-left: 5px;
        /*font-family: fantasy;*/
        font-weight: bold;
        font-size: 13px
    }
    </style>
</head>

<body>

<div class="esquinas" style="width: 640px;height: 450px; margin: auto;margin-top:150px;background: #fff">

    <div style="margin-left: 0px;margin-top: 45px;float: left;width: 360px; height: 393px;" class="ui-corner-all">
        <img src="${resource(dir: 'images', file: 'mies_logo.png')}" alt="mies" width="338px" height="393px"></div>

    <div style=" width: 250px;height: 300px;margin-top: 25px;float: left;margin-left: 5px; ;background:#2191c0"
         class="esquinas">
        <div style="height: 125px;margin-top: 25px;margin-left:25px;width: 200px;color:#ccc;font-style:
             italic;text-align: center" class="ui-corner-all">
            <b>Sistema para el registro, control y seguimiento de proyectos.</b>
        </div>

        <div style="margin-top: 25px;float: left;position: relative">
            <g:form action="login" controller="login">
                <g:if test="${!session.usuario}">
                    <input type="text" class="ui-corner-all" id="usr" name="usuario" value="usuario">
                    <input type="password" style="margin-top: 10px" class="ui-corner-all" id="psw" name="password">

                    <div id="mascara"
                         style="position: absolute;left:25px;top:40px;width: 200px;height: 30px;line-height: 30px;padding-left: 5px;color: #555;font-size: 13px;">contraseña</div>
                    <g:submitButton name="entrar" value="Validar"
                                    style="height: 30px;margin-top: 15px;width: 70px;border: 1px solid black;float:right;margin-right:25px;"
                                    class="ui-corner-all"/>
                </g:if>
                <g:else>
                    <g:select from="${perfiles}" name="perfil" optionKey="id"
                              style="height: 25px;width: 200px;margin-top: 10px;background: #c7c7c7;margin-left: 25px"/>
                    <g:submitButton value="Entrar" name="entrar"
                                    style="height: 30px;margin-top: 15px;width: 70px;border: 1px solid black;float:right;margin-right:25px;"
                                    class="ui-corner-all"/>
                </g:else>
            </g:form>
        </div>
    </div>
    <p class="text-info pull-right" style="font-size: 10px; margin-top: 20px">
        Versión ${message(code: 'version', default: '1.1.0x')}
    </p>
</div>
<script>
    $(document).ready(function () {
        if ($("#psw").val() != "")
            $("#mascara").hide();
        $("#usr").focus(function () {
            $("#usr").val("")
        });
        $("#usr").blur(function () {
            if ($(this).val() == "")
                $("#usr").val("usuario")
        });

        $("#mascara").click(function () {
            $("#mascara").hide();
            $("#psw").focus();
        });
        $("#psw").focus(function () {
            $("#mascara").hide();
        });
        $("#psw").blur(function () {
            if ($(this).val() == "")
                $("#mascara").show();
        });


    });

</script>

</body>
</html>