<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 02/04/18
  Time: 15:06
--%>


<%@ page import="mies.ObjetivoEspecifico" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">

    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <g:link class="button list" action="list">
            <g:message code="objetivoEspecifico.list" default="Lista de Objetivos Específicos" />
        </g:link>
        <g:link class="button create" action="create">Nuevo Objetivo Específico
        </g:link>
    </div> <!-- toolbar -->

    <div class="body">
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <div class="list" style="width: 960px;">
            <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">

            </div>
            <table style="width: 960px;">
                <thead>
                <tr>
                    <tdn:sortableColumn property="id" class="ui-state-default"
                                        title="${message(code: 'objetivoEspecifico.id.label', default: 'Id')}"/>

                    <tdn:sortableColumn property="codigo" class="ui-state-default"
                                        title="${message(code: 'objetivoEspecifico.objetivoInstitucional.descripcion.label', default: 'Objetivo Específico')}"/>

                    <tdn:sortableColumn property="codigo" class="ui-state-default"
                                        title="${message(code: 'objetivoEspecifico.codigo.label', default: 'Código')}"/>

                    <tdn:sortableColumn property="descripcion" class="ui-state-default"
                                        title="${message(code: 'objetivoEspecifico.descripcion.label', default: 'Descripción')}"/>
                </tr>
                </thead>
                <tbody>
                <g:each in="${objetivoEspecificoInstanceList}" status="i" var="objetivoEspecificoInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td><g:link action="show"
                                    id="${objetivoEspecificoInstance.id}">${fieldValue(bean: objetivoEspecificoInstance, field: "id")}</g:link></td>

                        <td>${fieldValue(bean: objetivoEspecificoInstance, field: "objetivoInstitucional.descripcion")}</td>

                        <td>${fieldValue(bean: objetivoEspecificoInstance, field: "codigo")}</td>

                        <td>${fieldValue(bean: objetivoEspecificoInstance, field: "descripcion")}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
            <tdn:paginate total="${objetivoEspecificoInstanceTotal}"/>
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
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'está seguro?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
