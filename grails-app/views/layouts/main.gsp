<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails"/></title>
        %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" />--}%
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'forms.css')}"/>
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'logo_mies.jpg')}" type="image/x-icon"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.16.custom.min.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'date-es-EC.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/start', file: 'jquery-ui-1.8.16.custom.css')}"/>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/countdown', file: 'jquery.countdown.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/countdown', file: 'jquery.countdown.css')}"/>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/js', file: 'jquery.ui.datepicker-es.js')}"></script>

        <g:layoutHead/>
        <g:javascript library="application"/>
    </head>

    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir: 'images', file: 'spinner.gif')}"
                 alt="${message(code: 'spinner.alt', default: 'Loading...')}"/>
        </div>

        <div style="height: 20px; background:none; margin-bottom: 5px; width: 100%;"></div>

        <div id="treeMenu"
             style="margin-left: 10px;margin-top: 0px;float: left; position: absolute; left:20px; top: 3px;">
            <g:generarMenuHorizontal/>
        </div>

        <div id="texto_count"
             style="width: 160px;height: 30px;position: absolute;top:3px;left: 860px;font-size: 11px;line-height: 15px;">Tiempo aproximado hasta que termine su sesión</div>

        <div id="countdown" style="width: 70px;height: 30px;position: absolute;top:3px;left: 1015px;border: none"></div>

        <div id="countdown2"
             style="width: 70px;height: 30px;position: absolute;top:3px;left: 1015px;border: none;display: none"></div>

        <div class="ui-dialog ui-widget ui-widget-content ui-corner-all"
             style="height: 740px;  width: 1100px; margin-left:10px; position: absolute; left: 20px; top:37px;overflow-y: hidden">
            <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"
                 style="text-align: center;">
                <span class="ui-dialog-title" style="float: none;"><g:layoutTitle default=""/></span>
            </div>

            <div class="ui-dialog-content ui-widget-content" style="height: 690px;">
                <g:layoutBody/>
            </div>
        </div>
        <script type="text/javascript">
            var fin = new Date()
            var check = new Date()
            check.addMinutes(15)
            fin.addMinutes(20)
            $('#countdown').countdown({until: fin, compact: true,format: 'MS', description: '',onExpiry: verificarSecion});
            $('#countdown2').countdown({until: check, compact: true,format: 'MS', description: '',onExpiry: alerta});

            function verificarSecion() {
                $.ajax({
                    type: "POST",
                    url: "${createLink(action:'verificarSession',controller:'inicio')}",
                    data: "",
                    success: function(msg) {
                        if (msg == "ok") {
                            fin.addMinutes(20)
                            check.addMinutes(15)
                            $('#countdown').countdown('change', {until: fin});
                            $("#countdown").css("color", "black")
                            $("#texto_count").css("color", "black")
                            $('#countdown2').countdown('change', {until: check});
                        } else
                            location.href = "${createLink(controller:'login',action:'logout')}"
                    }
                });
            }

            function alerta() {
                $("#texto_count").css("color", "red").show("pulsate")
                $("#countdown").css("color", "red")
            }

            $(".ajax").click(function() {
                fin = new Date()
                fin.addMinutes(20)
                check = new Date()
                check.addMinutes(15)
                $("#countdown").css("color", "black")
                $('#countdown').countdown('change', {until: fin});
                $("#texto_count").css("color", "black")
                $('#countdown2').countdown('change', {until: check});
            });


        </script>
    </body>

</html>