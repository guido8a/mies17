<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>
        <title>Mapa</title>
        <style type="text/css">

        .pin {
            cursor   : pointer;
            position : absolute;
            z-index  : 50;
        }

        .remove {
            padding : 6px;
            width   : 28px;
            height  : 40px;
        }

        .area {
            width    : 755px;
            height   : 505px;
            position : relative;
        }

        .provincia {
            z-index : 1;
        }

        .leyenda {
            width      : 300px;
            background : #46A3CA;
        }
        </style>
    </head>

    <body>
        <div class="">
            <h1>Mapa del ecuador</h1>

            <div class="dialog" >
                <div class="area left">
                    <div class="remove left ui-corner-all" style="margin-right: 15px;">
                    </div>

                    <g:each in="${metas}" var="meta">
                        <img src="${resource(dir: 'images', file: meta.pin)}" class="pin" alt="Pin"
                             data-text="${meta.ttip}"
                             data-title="${meta.ttitle}"
                             style="${(meta.meta.cord_y > 0 && meta.meta.cord_x > 0) ? 'top: ' + meta.meta.cord_y + 'px; left: ' + meta.meta.cord_x + 'px;' : ''}"/>
                    </g:each>

                    <div class="provincia left">
                        <img src="${image}" alt="" width="680"/>
                    </div>
                </div>

                <div class="leyenda right ui-corner-all">
                    <div style="font-weight: bold; text-align: center; padding: 5px 0 5px 0; font-size: larger;">Proyectos</div>
                    <table>
                        <g:each in="${proyectos}" var="proyecto">
                            <tr>
                                <td>
                                    <img src="${resource(dir: 'images', file: proyecto.pin)}"/>
                                </td>
                                <td>
                                    ${proyecto.proy.nombre}
                                </td>
                            </tr>
                        </g:each>
                    </table>
                </div>

            </div>
        </div>
        <script type="text/javascript">

            $(function() {


                $('.pin').qtip({
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