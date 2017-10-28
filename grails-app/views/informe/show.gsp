<%@ page import="mies.Informe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName"
               value="${message(code: 'informe.label', default: 'Informe')}"/>
        <title><g:message code="default.show.label" args="[entityName]"/></title>

        <style type="text/css">
        .noPad ol, .noPad ul {
            margin       : 5px 0 5px 0;
            padding-left : 30px;
        }
        </style>

    </head>

    <body>

        <div class="dialog">
            %{--<div id="" class="toolbar ui-widget-header ui-corner-all">--}%
            %{--<a class="button home" href="${createLinkTo(dir: '')}">--}%
            %{--<g:message code="home" default="Home" />--}%
            %{--</a>--}%
            %{--<g:link class="button list" action="list">--}%
            %{--<g:message code="informe.list" default="Informe List" />--}%
            %{--</g:link>--}%
            %{--<g:link class="button create" action="create">--}%
            %{--<g:message code="default.new.label" args="[entityName]" />--}%
            %{--</g:link>--}%
            %{--</div> <!-- toolbar -->--}%

            <div class="body">
                <g:if test="${flash.message}">
                    <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
                </g:if>
                <div>

                    <table width="1050" class="show ui-widget-content ui-corner-all">

                        <thead>
                            <tr>
                                <td colspan="4" class="ui-widget ui-widget-header ui-corner-all" style="padding: 3px;">
                                    <g:message code="default.show.legend" args="${['Informe']}"
                                               default="Show Informe details"/>
                                </td>
                            </tr>
                        </thead>
                        <tbody>

                            <tr class="prop ${hasErrors(bean: informeInstance, field: 'responsableProyecto', 'error')}">

                                <td class="label">
                                    <g:message code="informe.responsableProyecto.label"
                                               default="Responsable Proyecto"/>
                                </td>

                                <td class="">
                                    ${informeInstance?.responsableProyecto?.encodeAsHTML()}
                                </td> <!-- campo -->




                                <td class="label">
                                    <g:message code="informe.tipo.label"
                                               default="Tipo"/>
                                </td>

                                <td class="">
                                    ${informeInstance?.tipo?.encodeAsHTML()}
                                </td> <!-- campo -->

                            </tr>




                            <tr class="prop ${hasErrors(bean: informeInstance, field: 'fecha', 'error')}">

                                <td class="label">
                                    <g:message code="informe.fecha.label"
                                               default="Fecha"/>
                                </td>

                                <td class="">

                                    <g:formatDate date="${informeInstance?.fecha}" format="dd-MM-yyyy"/>

                                </td> <!-- campo -->


                                <td class="label">
                                    <g:message code="informe.porcentaje.label"
                                               default="Porcentaje"/>
                                </td>

                                <td class="">

                                    ${fieldValue(bean: informeInstance, field: "porcentaje")}%

                                </td> <!-- campo -->

                            </tr>

                            <tr class="prop ${hasErrors(bean: informeInstance, field: 'link', 'error')}">

                                <td class="label">
                                    <g:message code="informe.link.label"
                                               default="Link"/>
                                </td>

                                <td class="" colspan="4">

                                    ${fieldValue(bean: informeInstance, field: "link")}

                                </td> <!-- campo -->
                            </tr>


                            <tr class="prop ${hasErrors(bean: informeInstance, field: 'dificultades', 'error')}">

                                <td class="label">
                                    <g:message code="informe.dificultades.label"
                                               default="Dificultades"/>
                                </td>

                                <td class="noPad" colspan="4">

                                    ${informeInstance.dificultades.decodeHTML()}

                                </td> <!-- campo -->

                            </tr>

                            <tr>
                                <td class="label">
                                    <g:message code="informe.avance.label"
                                               default="Avance"/>
                                </td>

                                <td class="noPad" colspan="4">

                                    ${informeInstance.avance.decodeHTML()}

                                </td> <!-- campo -->

                            </tr>

                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="buttons" style="text-align: right;">
                                    <g:link class="button edit" action="edit" id="${informeInstance?.id}">
                                        <g:message code="default.button.update.label" default="Edit"/>
                                    </g:link>
                                    <g:link class="button delete" action="delete" id="${informeInstance?.id}">
                                        <g:message code="default.button.delete.label" default="Delete"/>
                                    </g:link>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <script type="text/javascript">
            $(function() {
                $(".button").button();
                $(".home").button("option", "icons", {primary:'ui-icon-home'});
                $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
                $(".create").button("option", "icons", {primary:'ui-icon-document'});

                $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
                $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
                    if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
