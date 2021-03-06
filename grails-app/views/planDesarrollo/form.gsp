<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 28/03/18
  Time: 10:58
--%>

<%@ page import="mies.PlanDesarrollo" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}"/>

    <title>${title}</title>
</head>

<body>
<div class="dialog" title="${title}">

    <div class="body">

        <div id="" class="toolbar ui-widget-header ui-corner-all">
            <g:link class="button list" action="list">
                <g:message code="planDesarrollo.list" default="Lista de Planes de Desarrollo" />
            </g:link>
        </div> <!-- toolbar -->

        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">
                <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
        </g:if>
        <g:hasErrors bean="${planDesarrolloInstance}">
            <div class="errors ui-state-error ui-corner-all">
                <g:renderErrors bean="${planDesarrolloInstance}" as="list"/>
            </div>
        </g:hasErrors>
        <g:form action="save" class="frmPlanDesarrollo" method="post">
            <g:hiddenField name="id" value="${planDesarrolloInstance?.id}"/>
            <g:hiddenField name="version" value="${planDesarrolloInstance?.version}"/>
            <div>
                <fieldset class="ui-corner-all">
                    <legend class="ui-widget ui-widget-header ui-corner-all">
                        <g:if test="${source == 'edit'}">
                            <g:message code="planDesarrollo.edit.legend"
                                       default="Editar Plan de Desarrollo"/>
                        </g:if>
                        <g:else>
                            <g:message code="planDesarrollo.create.legend"
                                       default="Ingresar Plan de Desarrollo"/>
                        </g:else>
                    </legend>

                    <div class="prop ${hasErrors(bean: planDesarrolloInstance, field: 'codigo', 'error')}">
                        <label for="codigo">
                            <g:message code="planDesarrollo.codigo.label" default="Codigo"/>
                        </label>

                        <div class="campo">
                            <g:textField name="codigo" id="codigo" title="Código del plan de desarrollo"
                                         class="field ui-widget-content ui-corner-all" value="${planDesarrolloInstance?.codigo}" maxlength="1" minlength="1"/>
                        </div>
                    </div>

                    <div class="prop ${hasErrors(bean: planDesarrolloInstance, field: 'descripcion', 'error')}">
                        <label for="descripcion">
                            <g:message code="planDesarrollo.descripcion.label" default="Descripcion"/>

                        </label>

                        <div class="campo">
                            <g:textField name="descripcion" id="descripcion"
                                         title="Descripción corta del plan de desarrollo"
                                         class="field ui-widget-content ui-corner-all" minlenght="1" maxlenght="255"
                                         value="${planDesarrolloInstance?.descripcion}"/>
                        </div>
                    </div>


                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="default.button.update.label" default="Update"/>
                            </a>
                            %{--<g:link class="button delete" action="delete" id="${planDesarrolloInstance?.id}">--}%
                                %{--<g:message code="default.button.delete.label" default="Delete"/>--}%
                            %{--</g:link>--}%
                            <a href="#" class="button delete" id="btnBorrar">
                                <g:message code="default.button.delete.label" default="Delete"/>
                            </a>
                            <g:link class="button show" action="show" id="${planDesarrolloInstance?.id}">
                                <g:message code="default.button.show.label" default="Show"/>
                            </g:link>
                        </g:if>
                        <g:else>
                            <a href="#" class="button save">
                                <g:message code="create" default="Crear"/>
                            </a>
                        </g:else>
                    </div>

                </fieldset>
            </div>
        </g:form>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        var myForm = $(".frmPlanDesarrollo");

        // Tooltip de informacion para cada field (utiliza el atributo title del textfield)
        var elems = $('.field')
            .each(function(i) {
                $.attr(this, 'oldtitle', $.attr(this, 'title'));
            })
            .removeAttr('title');
        $('<div />').qtip(
            {
                content: ' ', // Can use any content here :)
                position: {
                    target: 'event' // Use the triggering element as the positioning target
                },
                show: {
                    target: elems,
                    event: 'click mouseenter focus'
                },
                hide: {
                    target: elems
                },
                events: {
                    show: function(event, api) {
                        // Update the content of the tooltip on each show
                        var target = $(event.originalEvent.target);
                        api.set('content.text', target.attr('title'));
                    }
                },
                style: {
                    classes: 'ui-tooltip-rounded ui-tooltip-cream'
                }
            });
        // fin del codigo para los tooltips

        // Validacion del formulario
        myForm.validate({
            errorClass: "errormessage",
            onkeyup: false,
            errorElement: "em",
            errorClass: 'error',
            validClass: 'valid',
            errorPlacement: function(error, element) {
                // Set positioning based on the elements position in the form
                var elem = $(element),
                    corners = ['right center', 'left center'],
                    flipIt = elem.parents('span.right').length > 0;

                // Check we have a valid error message
                if (!error.is(':empty')) {
                    // Apply the tooltip only if it isn't valid
                    elem.filter(':not(.valid)').qtip({
                        overwrite: false,
                        content: error,
                        position: {
                            my: corners[ flipIt ? 0 : 1 ],
                            at: corners[ flipIt ? 1 : 0 ],
                            viewport: $(window)
                        },
                        show: {
                            event: false,
                            ready:
                                true
                        },
                        hide: false,
                        style: {
                            classes: 'ui-tooltip-rounded ui-tooltip-red' // Make it red... the classic error colour!
                        }
                    })

                    // If we have a tooltip on this element already, just update its content
                        .qtip('option', 'content.text', error);
                }

                // If the error is empty, remove the qTip
                else {
                    elem.qtip('destroy');
                }
            },
            success: $.noop // Odd workaround for errorPlacement not firing!
        })
        ;
        //fin de la validacion del formulario


        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
        $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
        $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
            myForm.submit();
            return false;
        });
        %{--$(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {--}%
            %{--if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'está seguro?')}")) {--}%
                %{--return true;--}%
            %{--}--}%
            %{--return false;--}%
        %{--});--}%
        $("#btnBorrar").click(function() {
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'está seguro?')}")) {
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'planDesarrollo', action: 'delete')}',
                    data:{
                        id: '${planDesarrolloInstance?.id}'
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            location.href="${createLink(controller: 'planDesarrollo', action: 'list')}"
                        }else{
                            location.href="${createLink(controller: 'planDesarrollo', action: 'list')}"
                        }
                    }
                });
            }
        });
    });
</script>

</body>
</html>