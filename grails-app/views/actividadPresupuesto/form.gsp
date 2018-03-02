<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 02/03/18
  Time: 9:55
--%>


<%@ page import="mies.Componente" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.css')}" />

    <title>${title}</title>
</head>

<body>
<div class="dialog" title="${title}">

  <div class="body">
        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">
                <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
            </div>
        </g:if>
        <g:hasErrors bean="${actividadPresupuestoInstance}">
            <div class="errors ui-state-error ui-corner-all">
                <g:renderErrors bean="${actividadPresupuestoInstance}" as="list" />
            </div>
        </g:hasErrors>
        <g:form action="save" class="frmActividad"
                method="post"  >
            <g:hiddenField name="id" value="${actividadPresupuestoInstance?.id}" />
            <g:hiddenField name="version" value="${actividadPresupuestoInstance?.version}" />
            <div>
                <fieldset class="ui-corner-all">
                    <legend class="ui-widget ui-widget-header ui-corner-all">
                        <g:if test="${source == 'edit'}">
                            <g:message code="actividadPresupuesto.edit.legend" default="Edite los datos de actividad"/>
                        </g:if>
                        <g:else>
                            <g:message code="actividadPresupuesto.create.legend" default="Ingrese los datos de actividad"/>
                        </g:else>
                    </legend>


                    <div class="prop mandatory ${hasErrors(bean: actividadPresupuestoInstance, field: 'programaPresupuestario', 'error')}">
                        <label for="programaPresupuestario">
                            <g:message code="actividadPresupuesto.programaPresupuestario.label" default="Programa Presupuestario" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo" >
                            <g:select style="width: 500px" from="${mies.ProgramaPresupuestario.list().sort{it.codigo}}" optionValue="descripcion" optionKey="id" class="required ui-widget-content ui-corner-all" name="programaPresupuestario" id="programaPresupuestario" title="Programa Presupuestario" />
                        </div>
                    </div>

                    <div class="prop mandatory ${hasErrors(bean: actividadPresupuestoInstance, field: 'codigo', 'error')}">
                        <label for="codigo">
                            <g:message code="actividadPresupuesto.codigo.label" default="Código" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="3" name="codigo" id="codigo" title="Código"  value="${actividadPresupuestoInstance?.codigo}" />
                        </div>
                    </div>

                    <div class="prop mandatory ${hasErrors(bean: actividadPresupuestoInstance, field: 'descripcion', 'error')}">
                        <label for="descripcion">
                            <g:message code="actividadPresupuesto.descripcion.label" default="Descripción" />
                            <span class="indicator">*</span>
                        </label>
                        <div class="campo">
                            <g:textField style="width: 500px" class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="255" name="descripcion" id="descripcion" title="Descripción" value="${actividadPresupuestoInstance?.descripcion}" />
                        </div>
                    </div>


                    <div class="buttons">
                        <g:if test="${source == 'edit'}">
                            <a href="#" class="button save">
                                <g:message code="update" default="Guardar" />
                            </a>
                            <g:link class="button delete" action="delete" id="${actividadPresupuestoInstance?.id}">
                                <g:message code="default.button.delete.label" default="Eliminar" />
                            </g:link>
                            <g:link class="button show" action="show" id="${actividadPresupuestoInstance?.id}">
                                <g:message code="default.button.show.label" default="Ver" />
                            </g:link>
                            <g:link class="button list" action="list">
                                <g:message code="default.button.list.label" default="Lista" />
                            </g:link>
                        </g:if>
                        <g:else>
                            <a href="#" class="button save">
                                <g:message code="create" default="Guardar" />
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
        var myForm = $(".frmActividad");

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



        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
        $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
        $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function() {
            myForm.submit();
            return false;
        });
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Está seguro?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>