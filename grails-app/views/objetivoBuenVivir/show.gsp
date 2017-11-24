
<%@ page import="mies.ObjetivoBuenVivir" %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	<title>Detalles Objetivo del Buen Vivir</title>
</head>

<body>

<div class="dialog">

	<div class="body">
		<g:if test="${flash.message}">
			<div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
		</g:if>
		<div>

			<fieldset class="ui-corner-all" style="width: 1000px">
				<legend class="ui-widget ui-widget-header ui-corner-all">
					Objetivo del Buen Vivir
				</legend>

				<div class="prop">
					<label>
						Código
					</label>

					<div class="campo">
						${objetivoBuenVivirInstance?.codigo?.encodeAsHTML()}
					</div> <!-- campo -->
				</div> <!-- prop -->

				<div class="prop">
					<label>
						Descripción
					</label>

					<div class="campo">
						${objetivoBuenVivirInstance?.descripcion?.encodeAsHTML()}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="buttons">
					<g:link class="button edit" action="edit" id="${objetivoBuenVivirInstance?.id}">
						Editar
					</g:link>
					<g:link class="button delete" controller="objetivoBuenVivir" action="delete_ajax" id="${objetivoBuenVivirInstance?.id}">
						Eliminar
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
            if(confirm("está seguro de eliminar el objetivo del Buen Vivir?")) {
                return true;
            }
            return false;
        });
    });
</script>
</body>
</html>
