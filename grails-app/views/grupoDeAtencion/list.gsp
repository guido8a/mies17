
<%@ page import="mies.GrupoDeAtencion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'grupoDeAtencion.label', default: 'GrupoDeAtencion')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'grupoDeAtencion.id.label', default: 'Id')}" />
                        
                            <th><g:message code="grupoDeAtencion.tipoGrupo.label" default="Tipo Grupo" /></th>
                        
                            <th><g:message code="grupoDeAtencion.proyecto.label" default="Proyecto" /></th>
                        
                            <g:sortableColumn property="hombre" title="${message(code: 'grupoDeAtencion.hombre.label', default: 'Hombre')}" />
                        
                            <g:sortableColumn property="mujer" title="${message(code: 'grupoDeAtencion.mujer.label', default: 'Mujer')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${grupoDeAtencionInstanceList}" status="i" var="grupoDeAtencionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${grupoDeAtencionInstance.id}">${fieldValue(bean: grupoDeAtencionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: grupoDeAtencionInstance, field: "tipoGrupo")}</td>
                        
                            <td>${fieldValue(bean: grupoDeAtencionInstance, field: "proyecto")}</td>
                        
                            <td>${fieldValue(bean: grupoDeAtencionInstance, field: "hombre")}</td>
                        
                            <td>${fieldValue(bean: grupoDeAtencionInstance, field: "mujer")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${grupoDeAtencionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
