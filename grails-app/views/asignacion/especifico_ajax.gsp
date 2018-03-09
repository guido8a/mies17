<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 08/03/18
  Time: 14:58
--%>


<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}" style="" type="text/css"/>
<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}" type="text/css"/>

<script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript" charset="" language="JavaScript"></script>
<script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}" type="text/javascript" language="JavaScript"></script>
<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>

<g:select from="${objetivos}" id="objetivoEspecifico" optionKey="id" optionValue="descripcion" name="objetivoEsp_name" value="${especifico?.id}"/>

<script type="text/javascript">
    $("#objetivoEspecifico").selectmenu({width:250, height:50});
    $("#objetivoEspecifico-button").css("height", "35px");


    cargarObjOperativo($("#objetivoEspecifico").val(),null);

    $("#objetivoEspecifico").change(function () {
       var especifico = $(this).val();
        cargarObjOperativo(especifico, null);
    });

    function cargarObjOperativo (especifico, operativo) {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'asignacion', action: 'operativo_ajax')}',
            async: false,
            data:{
                especifico: especifico,
                operativo: operativo
            },
            success: function (msg) {
                $("#tdOperativo").html(msg)
            }
        });
    }






</script>