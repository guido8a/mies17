
<%@ page import="mies.ActividadPresupuesto" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	<g:set var="entityName"
		   value="${message(code: 'actividadPresupuesto.label', default: 'Actividad')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<div class="dialog" title="${title}">
	<div class="body">
		<g:if test="${flash.message}">
			<div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
		</g:if>
		<div>

			<fieldset class="ui-corner-all">
				<legend class="ui-widget ui-widget-header ui-corner-all">
					<g:message code="actividadPresupuesto.show.legend"
							   default="Datos de Actividad" />
				</legend>

				<div class="prop">
					<label>
						<g:message code="actividadPresupuesto.programaPresupuestario.label"
								   default="Programa" />
					</label>

					<div class="campo">
						${fieldValue(bean: actividadPresupuestoInstance, field: "programaPresupuestario.descripcion")}
					</div> <!-- campo -->
				</div> <!-- prop -->

				<div class="prop">
					<label>
						<g:message code="actividadPresupuesto.codigo.label"
								   default="Código" />
					</label>

					<div class="campo">
						${fieldValue(bean: actividadPresupuestoInstance, field: "codigo")}
					</div> <!-- campo -->
				</div> <!-- prop -->

				<div class="prop">
					<label>
						<g:message code="actividadPresupuesto.descripcion.label"
								   default="Descripcion" />
					</label>

					<div class="campo">
						${fieldValue(bean: actividadPresupuestoInstance, field: "descripcion")}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="buttons">
					<g:link class="button edit" action="edit" id="${actividadPresupuestoInstance?.id}">
						<g:message code="default.button.update.label" default="Editar" />
					</g:link>
					<g:link class="button delete" action="delete" id="${actividadPresupuestoInstance?.id}">
						<g:message code="default.button.delete.label" default="Eliminar" />
					</g:link>
					<g:link class="button list" action="list">
						<g:message code="default.button.list.label" default="Lista" />
					</g:link>
				</div>

			</fieldset>
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
            if(confirm("${message(code: 'default.button.delete.confirm.message', default: 'Está seguro de borrar esta actividad?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
