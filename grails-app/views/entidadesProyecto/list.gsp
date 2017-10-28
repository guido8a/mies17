
<%@ page import="mies.EntidadesProyecto" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'entidadesProyecto.label', default: 'EntidadesProyecto')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'entidadesProyecto.id.label', default: 'Id')}" />
                        
                            <th><g:message code="entidadesProyecto.entidad.label" default="Entidad" /></th>
                        
                            <th><g:message code="entidadesProyecto.tipoParticipacion.label" default="Tipo Participacion" /></th>
                        
                            <th><g:message code="entidadesProyecto.proyecto.label" default="Proyecto" /></th>
                        
                            <g:sortableColumn property="monto" title="${message(code: 'entidadesProyecto.monto.label', default: 'Monto')}" />
                        
                            <g:sortableColumn property="rol" title="${message(code: 'entidadesProyecto.rol.label', default: 'Rol')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${entidadesProyectoInstanceList}" status="i" var="entidadesProyectoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${entidadesProyectoInstance.id}">${fieldValue(bean: entidadesProyectoInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: entidadesProyectoInstance, field: "entidad")}</td>
                        
                            <td>${fieldValue(bean: entidadesProyectoInstance, field: "tipoParticipacion")}</td>
                        
                            <td>${fieldValue(bean: entidadesProyectoInstance, field: "proyecto")}</td>
                        
                            <td>${fieldValue(bean: entidadesProyectoInstance, field: "monto")}</td>
                        
                            <td>${fieldValue(bean: entidadesProyectoInstance, field: "rol")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${entidadesProyectoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
