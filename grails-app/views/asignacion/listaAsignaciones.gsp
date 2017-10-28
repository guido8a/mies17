<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones</title>
</head>
<body>
<fieldset style="width: 690px;height: 55px;padding: 5px;" class="ui-corner-all">
    <legend>Busqueda</legend>
    <input type="text" id="txt_buscar" style="width: 200px;" class="ui-corner-all" value="${parametro}">
    <a href="#" id="buscar">Buscar</a>
</fieldset>
<div class="list" style="width: 700px;margin-top: 20px;margin-bottom: 20px;">
    <table style="width:700px;">
        <thead>
        <tr>

            <tdn:sortableColumn property="marcoLogico" class="ui-state-default sortable" title="Marco logico" />
            <th class="ui-state-default" >Proyecto</th>
            <tdn:sortableColumn property="actividad" class="ui-state-default sortable" title="Actividad gasto corriente" />
            <tdn:sortableColumn property="fuente" class="ui-state-default sortable" title="Fuente" />
            <tdn:sortableColumn property="tipoGasto" class="ui-state-default sortable" title="Tipo" />
            <tdn:sortableColumn property="planificado" class="ui-state-default sortable" title="Valor" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${asig}" status="i" var="asi">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show"  id="${asi.id}" title="Proyecto: ${asi.marcoLogico?.proyecto?.toStringCompleto()}">${asi.marcoLogico}</g:link></td>
                <td title="Proyecto: ${asi.marcoLogico?.proyecto?.toStringCompleto()}">${asi.marcoLogico?.proyecto?.codigoProyecto}</td>
                <td><g:link action="show" id="${asi.id}">${asi.actividad}</g:link></td>
                <td>${asi.fuente}</td>
                <td>${asi.tipoGasto}</td>
                <td>${asi.planificado}</td>

            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons" style="width: 700px;">
    <tdn:paginate total="${total}" />
</div>
<script type="text/javascript">
    $("#buscar").button().click(function(){
          window.location.href="${createLink(action:'listaAsignaciones')}/?parametro="+$("#txt_buscar").val()
    });
    $(".sortable").click(function(){

        $(this).children().attr("href",$(this).children().attr("href")+"&parametro="+$("#txt_buscar").val())


    });
</script>
</body>
</html>