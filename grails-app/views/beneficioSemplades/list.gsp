
<%@ page import="mies.BeneficioSenplades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'beneficioSemplades.label', default: 'BeneficioSenplades')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'beneficioSenplades.id.label', default: 'Id')}" />
                        
                            <th><g:message code="beneficioSenplades.proyecto.label" default="Proyecto" /></th>
                        
                            <g:sortableColumn property="beneficiariosDirectosHombres" title="${message(code: 'beneficioSenplades.beneficiariosDirectosHombres.label', default: 'Beneficiarios Directos Hombres')}" />
                        
                            <g:sortableColumn property="beneficiariosDirectosMujeres" title="${message(code: 'beneficioSenplades.beneficiariosDirectosMujeres.label', default: 'Beneficiarios Directos Mujeres')}" />
                        
                            <g:sortableColumn property="beneficiariosIndirectosHombres" title="${message(code: 'beneficioSenplades.beneficiariosIndirectosHombres.label', default: 'Beneficiarios Indirectos Hombres')}" />
                        
                            <g:sortableColumn property="beneficiariosIndirectosMujeres" title="${message(code: 'beneficioSenplades.beneficiariosIndirectosMujeres.label', default: 'Beneficiarios Indirectos Mujeres')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${beneficioSempladesInstanceList}" status="i" var="beneficioSempladesInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${beneficioSempladesInstance.id}">${fieldValue(bean: beneficioSempladesInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: beneficioSempladesInstance, field: "proyecto")}</td>
                        
                            <td>${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosDirectosHombres")}</td>
                        
                            <td>${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosDirectosMujeres")}</td>
                        
                            <td>${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosIndirectosHombres")}</td>
                        
                            <td>${fieldValue(bean: beneficioSempladesInstance, field: "beneficiariosIndirectosMujeres")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${beneficioSempladesInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
