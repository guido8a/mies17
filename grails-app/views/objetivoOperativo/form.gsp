<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 28/03/18
  Time: 14:29
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 28/03/18
  Time: 10:58
--%>

<%@ page import="mies.ObjetivoOperativo" %>
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

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/select', file: 'jquery.ui.selectmenu.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"/>

    <title>${title}</title>
</head>

<body>
<div class="dialog" title="${title}">

    <div class="body">

        <div id="" class="toolbar ui-widget-header ui-corner-all">
            <g:link class="button list" action="list">
                <g:message code="objetivoOperativo.list" default="Lista de Objetivos Operativos" />
            </g:link>
        </div> <!-- toolbar -->

        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">
                <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
        </g:if>
        <g:hasErrors bean="${objetivoOperativoInstance}">
            <div class="errors ui-state-error ui-corner-all">
                <g:renderErrors bean="${objetivoOperativoInstance}" as="list"/>
            </div>
        </g:hasErrors>
        <g:form action="save" class="frmObjetivoOperativo" method="post">
            <g:hiddenField name="id" value="${objetivoOperativoInstance?.id}"/>
            <g:hiddenField name="version" value="${objetivoOperativoInstance?.version}"/>
            <div style="width: 800px">
                <fieldset class="ui-corner-all">
                    <legend class="ui-widget ui-widget-header ui-corner-all">
                        <g:if test="${source == 'edit'}">
                            <g:message code="objetivoOperativo.edit.legend"
                                       default="Editar Objetivo Operativo"/>
                        </g:if>
                        <g:else>
                            <g:message code="objetivoOperativo.create.legend"
                                       default="Ingresar Objetivo Operativo"/>
                        </g:else>
                    </legend>


                    <div class="fieldcontain ${hasErrors(bean: objetivoOperativoInstance, field: 'objetivoEspecifico', 'error')}">
                        <label for="objetivoEspecifico">
                            <g:message code="objetivoOperativo.objetivoEspecifico.label" default="Objetivo Especifico" />
                        </label>
                        <g:select id="objetivoEspecifico" name="objetivoEspecifico.id" from="${mies.ObjetivoEspecifico.list()}" optionKey="id" optionValue="descripcion" required="" value="${objetivoOperativoInstance?.objetivoEspecifico?.id}" class="many-to-one"/>

                    </div>

                    <div class="prop ${hasErrors(bean: objetivoOperativoInstance, field: 'codigo', 'error')}">
                        <label for="codigo">
                            <g:message code="objetivoOperativo.codigo.label" default="Código"/>
                        </label>

                        <div class="campo">
                            <g:textField name="codigo" id="codigo" title="Código del plan de desarrollo"
                                         class="field ui-widget-content ui-corner-all" value="${objetivoOperativoInstance?.codigo}" maxlength="2" minlength="1"/>
                        </div>
                    </div>

                    <div class="prop ${hasErrors(bean: objetivoOperativoInstance, field: 'descripcion', 'error')}">
                        <label for="descripcion">
                            <g:message code="objetivoOperativo.descripcion.label" default="Descripción"/>

                        </label>

                        <div class="campo">
                            <g:textArea name="descripcion" id="descripcion"
                                         title="Descripción corta del objetivo operativo"
                                         class="field ui-widget-content ui-corner-all" minlenght="1"
                                         value="${objetivoOperativoInstance?.descripcion}" style="width: 650px; resize: none"/>


                        </div>
                    </div>


                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="default.button.update.label" default="Update"/>
                            </a>
                            <a href="#" class="button delete" id="btnBorrar">
                                <g:message code="default.button.delete.label" default="Delete"/>
                            </a>
                            <g:link class="button show" action="show" id="${objetivoOperativoInstance?.id}">
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
        var myForm = $(".frmObjetivoOperativo");

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
                    url: '${createLink(controller: 'objetivoOperativo', action: 'delete')}',
                    data:{
                        id: '${objetivoOperativoInstance?.id}'
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            location.href="${createLink(controller: 'objetivoOperativo', action: 'list')}"
                        }else{
                            location.href="${createLink(controller: 'objetivoOperativo', action: 'list')}"
                        }
                    }
                });
            }
        });


        $("#objetivoEspecifico").selectmenu({width:650, height:40})

    });
</script>

</body>
</html>