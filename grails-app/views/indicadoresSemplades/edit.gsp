

<%@ page import="mies.IndicadoresSenplades" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'indicadoresSemplades.label', default: 'IndicadoresSemplades')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${indicadoresSempladesInstance}">
            <div class="errors">
                <g:renderErrors bean="${indicadoresSempladesInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${indicadoresSempladesInstance?.id}" />
                <g:hiddenField name="version" value="${indicadoresSempladesInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="proyecto"><g:message code="indicadoresSemplades.proyecto.label" default="Proyecto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'proyecto', 'errors')}">
                                    <g:select class="field ui-widget-content ui-corner-all" name="proyecto.id" title="proyecto" from="${mies.Proyecto.list()}" optionKey="id" value="${indicadoresSempladesInstance?.proyecto?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tasaAnalisisFinanciero"><g:message code="indicadoresSemplades.tasaAnalisisFinanciero.label" default="Tasa Analisis Financiero" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaAnalisisFinanciero', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="tasaAnalisisFinanciero" title="tasaAnalisisFinanciero" id="tasaAnalisisFinanciero" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaAnalisisFinanciero')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valorActualNeto"><g:message code="indicadoresSemplades.valorActualNeto.label" default="Valor Actual Neto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'valorActualNeto', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="valorActualNeto" title="valorActualNeto" id="valorActualNeto" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'valorActualNeto')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tasaInternaDeRetorno"><g:message code="indicadoresSemplades.tasaInternaDeRetorno.label" default="Tasa Interna De Retorno" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetorno', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="tasaInternaDeRetorno" title="tasaInternaDeRetorno" id="tasaInternaDeRetorno" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetorno')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tasaAnalisisEconomico"><g:message code="indicadoresSemplades.tasaAnalisisEconomico.label" default="Tasa Analisis Economico" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaAnalisisEconomico', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="tasaAnalisisEconomico" title="tasaAnalisisEconomico" id="tasaAnalisisEconomico" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaAnalisisEconomico')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valorActualNetoEconomico"><g:message code="indicadoresSemplades.valorActualNetoEconomico.label" default="Valor Actual Neto Economico" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'valorActualNetoEconomico', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="valorActualNetoEconomico" title="valorActualNetoEconomico" id="valorActualNetoEconomico" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'valorActualNetoEconomico')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tasaInternaDeRetornoEconomico"><g:message code="indicadoresSemplades.tasaInternaDeRetornoEconomico.label" default="Tasa Interna De Retorno Economico" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetornoEconomico', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="tasaInternaDeRetornoEconomico" title="tasaInternaDeRetornoEconomico" id="tasaInternaDeRetornoEconomico" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'tasaInternaDeRetornoEconomico')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="costoBeneficio"><g:message code="indicadoresSemplades.costoBeneficio.label" default="Costo Beneficio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'costoBeneficio', 'errors')}">
                                    <g:textField class="field required ui-widget-content ui-corner-all" name="costoBeneficio" title="costoBeneficio" id="costoBeneficio" value="${fieldValue(bean: indicadoresSempladesInstance, field: 'costoBeneficio')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="pierdePais"><g:message code="indicadoresSemplades.pierdePais.label" default="Pierde Pais" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'pierdePais', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="pierdePais" id="pierdePais" title="pierdePais" cols="40" rows="5" value="${indicadoresSempladesInstance?.pierdePais}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="impactos"><g:message code="indicadoresSemplades.impactos.label" default="Impactos" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'impactos', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="impactos" id="impactos" title="impactos" cols="40" rows="5" value="${indicadoresSempladesInstance?.impactos}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="metodologia"><g:message code="indicadoresSemplades.metodologia.label" default="Metodologia" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'metodologia', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="metodologia" id="metodologia" title="metodologia" cols="40" rows="5" value="${indicadoresSempladesInstance?.metodologia}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="observaciones"><g:message code="indicadoresSemplades.observaciones.label" default="Observaciones" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: indicadoresSempladesInstance, field: 'observaciones', 'errors')}">
                                    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="1023" name="observaciones" id="observaciones" title="observaciones" cols="40" rows="5" value="${indicadoresSempladesInstance?.observaciones}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
