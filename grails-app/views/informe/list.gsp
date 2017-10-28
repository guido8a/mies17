<%@ page import="mies.Informe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'informe.label', default: 'Informe')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>

    <body>

        <div class="dialog">

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <div class="list" style="width: 1050px;">
                    <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                        <div id="example_length" class="dataTables_length">
                            <div class="botones">
                                <div class="botones left" style="margin-left: 15px; font-weight: normal;">
                                    Mostrando 1 a ${informeInstanceList.size()} de ${informeInstanceTotal}
                                </div>

                                <div class="botones right">
                                    <g:form action="list" class="frm_busca">
                                        <input name="busca" id="busca" value="${params.busca}"
                                               class="ui-widget-content ui-corner-all busca" style="width: 80px;"/>
                                        <a href="#" class="button search">Buscar</a>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table style="width: 1050px;">
                        <thead>
                            <tr>

                                <th class="ui-state-default">#</th>

                                <th class="ui-state-default">Responsable</th>

                                <th class="ui-state-default">Proyecto</th>

                                <th class="ui-state-default"><g:message code="informe.tipo.label"
                                                                        default="Tipo"/></th>

                                <tdn:sortableColumn property="fecha" class="ui-state-default"
                                                    title="${message(code: 'informe.fecha.label', default: 'Fecha')}"/>

                                <tdn:sortableColumn property="avance" class="ui-state-default"
                                                    title="${message(code: 'informe.avance.label', default: 'Avance')}"/>

                                <tdn:sortableColumn property="dificultades" class="ui-state-default"
                                                    title="${message(code: 'informe.dificultades.label', default: 'Dificultades')}"/>

                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="chars" value="${100}"/>

                            <g:each in="${informeInstanceList}" status="i" var="informeInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                    <td>
                                        <g:link action="show" id="${informeInstance.id}">
                                            ${i + 1}
                                        </g:link>
                                    </td>

                                    <td>
                                        ${informeInstance.responsableProyecto?.responsable?.persona?.nombre} ${informeInstance.responsableProyecto?.responsable?.persona?.apellido}
                                    </td>

                                    <td>
                                        ${informeInstance.responsableProyecto?.proyecto}
                                    </td>

                                    <td>${fieldValue(bean: informeInstance, field: "tipo")}</td>

                                    <td><g:formatDate date="${informeInstance.fecha}" format="dd-MM-yyyy"/></td>

                                    <td>${(informeInstance.avance.size() < chars) ? informeInstance.avance.decodeHTML() : informeInstance.avance.decodeHTML().substring(0, chars) + "..."}</td>

                                    <td>${(informeInstance.dificultades.size() < chars) ? informeInstance.dificultades.decodeHTML() : informeInstance.dificultades.decodeHTML().substring(0, chars) + "..."}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="${informeInstanceTotal}"/>
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
                    if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });

                $(".busca").keypress(function(e) {
                    if (e.keyCode == 13) {
                        $(".frm_busca").submit();
                    }
                });
                $(".search").button("option", "icons", {primary:'ui-icon-search'}).click(function() {
                    $(".frm_busca").submit();
                    return false;
                });

            });
        </script>

    </body>
</html>
