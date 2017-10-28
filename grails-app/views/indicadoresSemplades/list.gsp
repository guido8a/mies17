
<%@ page import="mies.IndicadoresSenplades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'indicadoresSemplades.label', default: 'IndicadoresSemplades')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'indicadoresSemplades.id.label', default: 'Id')}" />
                        
                            <th><g:message code="indicadoresSemplades.proyecto.label" default="Proyecto" /></th>
                        
                            <g:sortableColumn property="tasaAnalisisFinanciero" title="${message(code: 'indicadoresSemplades.tasaAnalisisFinanciero.label', default: 'Tasa Analisis Financiero')}" />
                        
                            <g:sortableColumn property="valorActualNeto" title="${message(code: 'indicadoresSemplades.valorActualNeto.label', default: 'Valor Actual Neto')}" />
                        
                            <g:sortableColumn property="tasaInternaDeRetorno" title="${message(code: 'indicadoresSemplades.tasaInternaDeRetorno.label', default: 'Tasa Interna De Retorno')}" />
                        
                            <g:sortableColumn property="tasaAnalisisEconomico" title="${message(code: 'indicadoresSemplades.tasaAnalisisEconomico.label', default: 'Tasa Analisis Economico')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${indicadoresSempladesInstanceList}" status="i" var="indicadoresSempladesInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${indicadoresSempladesInstance.id}">${fieldValue(bean: indicadoresSempladesInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: indicadoresSempladesInstance, field: "proyecto")}</td>
                        
                            <td>${fieldValue(bean: indicadoresSempladesInstance, field: "tasaAnalisisFinanciero")}</td>
                        
                            <td>${fieldValue(bean: indicadoresSempladesInstance, field: "valorActualNeto")}</td>
                        
                            <td>${fieldValue(bean: indicadoresSempladesInstance, field: "tasaInternaDeRetorno")}</td>
                        
                            <td>${fieldValue(bean: indicadoresSempladesInstance, field: "tasaAnalisisEconomico")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${indicadoresSempladesInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
