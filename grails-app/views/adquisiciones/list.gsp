
<%@ page import="mies.Adquisiciones" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'adquisiciones.label', default: 'Adquisiciones')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'adquisiciones.id.label', default: 'Id')}" />
                        
                            <th><g:message code="adquisiciones.TipoAdquisicion.label" default="Tipo Aquisicion" /></th>
                        
                            <th><g:message code="adquisiciones.proyecto.label" default="Proyecto" /></th>
                        
                            <th><g:message code="adquisiciones.tipoProcedencia.label" default="Tipo Procedencia" /></th>
                        
                            <g:sortableColumn property="descripcion" title="${message(code: 'adquisiciones.descripcion.label', default: 'Descripcion')}" />
                        
                            <g:sortableColumn property="valor" title="${message(code: 'adquisiciones.valor.label', default: 'Valor')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${adquisicionesInstanceList}" status="i" var="adquisicionesInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${adquisicionesInstance.id}">${fieldValue(bean: adquisicionesInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: adquisicionesInstance, field: "TipoAdquisicion")}</td>
                        
                            <td>${fieldValue(bean: adquisicionesInstance, field: "proyecto")}</td>
                        
                            <td>${fieldValue(bean: adquisicionesInstance, field: "tipoProcedencia")}</td>
                        
                            <td>${fieldValue(bean: adquisicionesInstance, field: "descripcion")}</td>
                        
                            <td>${fieldValue(bean: adquisicionesInstance, field: "valor")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${adquisicionesInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
