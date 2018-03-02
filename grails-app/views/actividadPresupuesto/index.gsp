
<%@ page import="mies.ActividadPresupuesto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'actividadPresupuesto.label', default: 'ActividadPresupuesto')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-actividadPresupuesto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-actividadPresupuesto" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'actividadPresupuesto.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'actividadPresupuesto.descripcion.label', default: 'Descripcion')}" />
					
						<th><g:message code="actividadPresupuesto.programaPresupuestario.label" default="Programa Presupuestario" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${actividadPresupuestoInstanceList}" status="i" var="actividadPresupuestoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${actividadPresupuestoInstance.id}">${fieldValue(bean: actividadPresupuestoInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: actividadPresupuestoInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: actividadPresupuestoInstance, field: "programaPresupuestario")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${actividadPresupuestoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
