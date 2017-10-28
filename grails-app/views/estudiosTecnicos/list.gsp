
<%@ page import="mies.EstudiosTecnicos" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'estudiosTecnicos.label', default: 'EstudiosTecnicos')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'estudiosTecnicos.id.label', default: 'Id')}" />
                        
                            <th><g:message code="estudiosTecnicos.proyecto.label" default="Proyecto" /></th>
                        
                            <g:sortableColumn property="resumen" title="${message(code: 'estudiosTecnicos.resumen.label', default: 'Resumen')}" />
                        
                            <g:sortableColumn property="documento" title="${message(code: 'estudiosTecnicos.documento.label', default: 'Documento')}" />
                        
                            <g:sortableColumn property="fecha" title="${message(code: 'estudiosTecnicos.fecha.label', default: 'Fecha')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${estudiosTecnicosInstanceList}" status="i" var="estudiosTecnicosInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${estudiosTecnicosInstance.id}">${fieldValue(bean: estudiosTecnicosInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: estudiosTecnicosInstance, field: "proyecto")}</td>
                        
                            <td>${fieldValue(bean: estudiosTecnicosInstance, field: "resumen")}</td>
                        
                            <td>${fieldValue(bean: estudiosTecnicosInstance, field: "documento")}</td>
                        
                            <td><g:formatDate date="${estudiosTecnicosInstance.fecha}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${estudiosTecnicosInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
