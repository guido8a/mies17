<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 09/03/18
  Time: 12:54
--%>

<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}" type="text/css"/>

<script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.easing.1.3.js')}" type="text/javascript" charset="" language="JavaScript"></script>
<script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}" type="text/javascript" language="JavaScript"></script>
<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

<link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>

<g:select from="${mies.ObjetivoInstitucional.list()}" id="institucional" optionKey="id" optionValue="descripcion" name="institucional_name" value="${institucional?.id}"/>

<script type="text/javascript">
    $("#institucional").selectmenu({width:250, height:50});
    $("#institucional-button").css("height", "35px");

    cargarObjEspecifico($("#institucional").val(), null, null);

    $("#institucional").change(function () {
        var objetivo = $(this).val();
        cargarObjEspecifico(objetivo, null, null)
    });

</script>