
<%@ page import="mies.PoliticaBuenVivir" %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	<title>Detalles Política del Buen Vivir</title>
</head>

<body>

<div class="dialog">


	<div class="body">
		<g:if test="${flash.message}">
			<div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
		</g:if>
		<div>

			<fieldset class="ui-corner-all">
				<legend class="ui-widget ui-widget-header ui-corner-all">
				Política del Buen Vivir
				</legend>


				<div class="prop">
					<label>
					Objetivo
					</label>

					<div class="campo">
						${politicaBuenVivirInstance?.objetivo?.encodeAsHTML()}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="prop">
					<label>
						Código
					</label>

					<div class="campo">
						${politicaBuenVivirInstance?.codigo?.encodeAsHTML()}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="prop">
					<label>
						Descripción
					</label>

					<div class="campo">
						${politicaBuenVivirInstance?.descripcion?.encodeAsHTML()}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="buttons">
					<g:link class="button edit" action="edit" id="${politicaBuenVivirInstance?.id}">
						Editar
					</g:link>
					<g:link class="button delete" action="delete" id="${politicaBuenVivirInstance?.id}">
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
                if(confirm("está seguro de eliminar la Política del Buen Vivir?")) {
                    return true;
                }
                return false;
            });
        });
	</script>
	</body>
</html>
