v<%@ page import="mies.ObjetivoEspecifico" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="layout" content="main"/>
	<g:set var="entityName"
		   value="${message(code: 'objetivoEspecifico.label', default: 'Objetivo Específico')}"/>
	<title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">

	<div class="body">

		<div id="" class="toolbar ui-widget-header ui-corner-all">
			<g:link class="button list" action="list">
				<g:message code="objetivoEspecifico.list" default="Lista de Objetivos Específico" />
			</g:link>
			<g:link class="button create" action="create">Nuevo Objetivo Específico
			</g:link>
		</div> <!-- toolbar -->

		<g:if test="${flash.message}">
			<div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
		</g:if>

		<div>
			<fieldset class="ui-corner-all">
				<legend class="ui-widget ui-widget-header ui-corner-all">
					<g:message code="objetivoEspecifico.show.legend"
							   default="Objetivo Operativo"/>
				</legend>

				<div class="prop">
					<label>
						<g:message code="objetivoEspecifico.id.label"
								   default="Id"/>
					</label>

					<div class="campo">
						${fieldValue(bean: objetivoEspecificoInstance, field: "id")}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="prop">
					<label>
						<g:message code="objetivoEspecifico.objetivoInstitucional.label"
								   default="Objetivo Institucional"/>
					</label>

					<div class="campo">
						${fieldValue(bean: objetivoEspecificoInstance, field: "objetivoInstitucional.descripcion")}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="prop">
					<label>
						<g:message code="objetivoEspecifico.codigo.label"
								   default="Código"/>
					</label>

					<div class="campo">
						${fieldValue(bean: objetivoEspecificoInstance, field: "codigo")}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="prop">
					<label>
						<g:message code="objetivoEspecifico.descripcion.label"
								   default="Descripción"/>
					</label>

					<div class="campo">
						${fieldValue(bean: objetivoEspecificoInstance, field: "descripcion")}
					</div> <!-- campo -->
				</div> <!-- prop -->


				<div class="buttons">
					<g:link class="button edit" action="edit" id="${objetivoEspecificoInstance?.id}">
						<g:message code="default.button.update.label" default="Edit"/>
					</g:link>
					<a href="#" class="button delete" id="btnBorrar">
						<g:message code="default.button.delete.label" default="Delete"/>
					</a>
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
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'});
        $("#btnBorrar").click(function() {
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'está seguro?')}")) {
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'objetivoEspecifico', action: 'delete')}',
                    data:{
                        id: '${objetivoEspecificoInstance?.id}'
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            location.href="${createLink(controller: 'objetivoEspecifico', action: 'list')}"
                        }else{
                            location.href="${createLink(controller: 'objetivoEspecifico', action: 'list')}"
                        }
                    }
                });
            }
        });
    });
</script>

</body>
</html>
