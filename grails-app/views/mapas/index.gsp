<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>
        <title>Mapa</title></head>
    <body>
        <div class="body">
            <h1>Mapa del Ecuador</h1>

            <div class="dialog" title="Mapa del Ecuador" t>
                <div id="mapa" style="width: 950px;margin: 5px;">
                    <img src="${resource(dir: 'images/mapas', file: 'ecuador.png')}" width="100%" usemap="#map">
                    <map name="map">
                        ${map}
                    </map>
                </div>

            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {

                $('.area').qtip({
                    content: {
                        text: function(api) {
                            return $(this).attr('data-text');
                        },
                        title: {
                            text: function(api) {
                                return $(this).attr('data-title');
                            }
                        }
                    },
                    hide: {
                        delay : 0,
                        leave: false
                    },
                    position: {
                        my: 'top left',  // Position my top left...
                        at: 'bottom right' // at the bottom right of...
                    },
                    style: {
                        classes:'ui-tooltip-rounded ui-tooltip-tipped'
                    }
                });
            });
        </script>

    </body>
</html>