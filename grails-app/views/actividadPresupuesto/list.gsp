<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 01/03/18
  Time: 15:33
--%>


<%@ page import="mies.ActividadPresupuesto" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName"
           value="${message(code: 'actividadPresupuesto.label', default: 'Actividad')}" />
    <title>Lista de Actividades</title>
</head>

<body>

<div class="dialog" >
    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <g:link class="button create" action="create">
            Nueva Actividad
        </g:link>
    </div> <!-- toolbar -->

    <div class="body">
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <div class="list" style="width: 600px;">
            <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
            </div>
            <table style="width: 600px;">
                <thead>
                <tr>
                    <tdn:sortableColumn property="programaPresupuestario.descripcion" class="ui-state-default"
                                        title="${message(code: 'actividadPresupuesto.programaPresupuestario.descripcion.label', default: 'Programa')}" />
                    <tdn:sortableColumn property="codigo" class="ui-state-default"
                                        title="${message(code: 'actividadPresupuesto.codigo.label', default: 'Código')}" />
                    <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                        title="${message(code: 'actividadPresupuesto.descripcion.label', default: 'Descripcion')}" />
                </tr>
                </thead>
                <tbody>
                <g:each in="${actividadPresupuestoInstanceList}" status="i" var="actividadInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td>${actividadInstance?.programaPresupuestario?.descripcion}</td>
                        <td>${fieldValue(bean: actividadInstance, field: "codigo")}</td>
                        <td><g:link action="show" id="${actividadInstance.id}">${fieldValue(bean: actividadInstance, field: "descripcion")}</g:link></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
            <tdn:paginate total="${actividadPresupuestoInstanceTotal}" />
        </div>
    </div> <!-- body -->
</div> <!-- dialog -->

<script type="text/javascript">
    $(function() {
        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".create").button("option", "icons", {primary:'ui-icon-document'});

        $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Está seguro de borrar esta actividad?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
