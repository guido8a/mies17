<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/11/17
  Time: 11:57
--%>


<%@ page import="mies.MetaBuenVivir" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

    <title>Lista de Políticas del Buen Vivir</title>
</head>

<body>

<div class="dialog">

    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <g:link class="button list" action="list">
            Lista de Políticas del Buen Vivir
        </g:link>
        <g:link class="button create" action="create">Nueva Política del Buen Vivir
        </g:link>
    </div> <!-- toolbar -->


    <div class="body">
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <div class="list" style="width: 600px;">
            %{--<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">--}%
            %{--</div>--}%
            <table style="width: 1050px;">
                <thead>
                <tr>


                    <th class="ui-state-default">Id</th>
                    <th class="ui-state-default">Objetivo</th>
                    <th class="ui-state-default">Código</th>
                    <th class="ui-state-default">Descripción</th>

                    %{--<tdn:sortableColumn property="codigo" class="ui-state-default"--}%
                                        %{--title="${message(code: 'metaBuenVivir.codigo.label', default: 'Codigo')}" />--}%

                    %{--<tdn:sortableColumn property="descripcion" class="ui-state-default"--}%
                                        %{--title="${message(code: 'metaBuenVivir.descripcion.label', default: 'Descripcion')}" />--}%

                </tr>
                </thead>
                <tbody>
                <g:each in="${politicaInstanceList}" status="i" var="politica">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td><g:link action="show"
                                    id="${politica.id}">${fieldValue(bean: politica, field: "id")}</g:link></td>

                        <td>${fieldValue(bean: politica, field: "objetivo")}</td>

                        <td>${fieldValue(bean: politica, field: "codigo")}</td>

                        <td>${fieldValue(bean: politica, field: "descripcion")}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
            <tdn:paginate total="${politicaInstanceTotal}" />
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
            if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
