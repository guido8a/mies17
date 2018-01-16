<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails"/></title>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'forms.css')}"/>
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'logo_mies.jpg')}" type="image/x-icon"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.16.custom.min.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'date-es-EC.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/start', file: 'jquery-ui-1.8.16.custom.css')}"/>


        <!-- el timer para cerrar la sesion -->
        <script src="${resource(dir: 'js/jquery/plugins/jquery.countdown', file: 'jquery.countdown.min.js')}"></script>
        <link href="${resource(dir: 'js/jquery/plugins/jquery.countdown', file: 'jquery.countdown.css')}" rel="stylesheet">

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
             style="width: 160px;height: 30px;position: absolute;top:3px;left: 860px;font-size: 11px;line-height: 15px;">
            Tiempo aproximado hasta que termine su sesión</div>

        <div id="countdown" style="width: 70px;height: 30px;position: absolute;top:-10px;left: 1015px;border: none; font-size: 24px"></div>


    <div id="countdown2"
             style="width: 70px;height: 30px;position: absolute;top:3px;left: 1015px;border: none;display: none"></div>

        <div class="ui-dialog ui-widget ui-widget-content ui-corner-all"
             style="height: 740px;  width: 1300px; margin-left:10px; position: absolute; left: 20px; top:37px;overflow-y: hidden">
            <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"
                 style="text-align: center;">
                <span class="ui-dialog-title" style="float: none;"><g:layoutTitle default=""/></span>
            </div>

            <div class="ui-dialog-content ui-widget-content" style="height: 690px;">
                <g:layoutBody/>
            </div>
        </div>
    <script type="text/javascript">
        var ot = document.title;

        //    openLoader()
        //    openLoader("Con mensaje")

        function resetTimer() {
            var ahora = new Date();
            var fin = ahora.clone().add(20).minute();
            $("#countdown").countdown('option', {
                until : fin
            });
            $(".countdown_amount").removeClass("highlight");
            document.title = ot;
        }

        function validarSesion() {
            $.ajax({
                url     : '${createLink(controller: "login", action: "validarSesion")}',
                success : function (msg) {
                    if (msg == "NO") {
                        location.href = "${g.createLink(controller: 'login', action: 'login')}";
                    } else {
                        resetTimer();
                    }
                }
            });
        }

        function highlight(periods) {
            if ((periods[5] == 5 && periods[6] == 0) || (periods[5] < 5)) {
                document.title = "Fin de sesión en " + (periods[5].toString().lpad('0', 2)) + ":" + (periods[6].toString().lpad('0', 2)) + " - " + ot;
                $(".countdown_amount").addClass("highlight");
            }
        }

        $(function () {
            var ahora = new Date();
            var fin = ahora.clone().add(20).minute();

            $('#countdown').countdown({
                until    : fin,
                format   : 'MS',
                compact  : true,
                onExpiry : validarSesion,
                onTick   : highlight
            });

            $(".btn-ajax").click(function () {
                resetTimer();
            });
        });

    </script>

    </body>

</html>