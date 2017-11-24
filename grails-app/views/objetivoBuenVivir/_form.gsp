<%@ page import="mies.ObjetivoBuenVivir" %>



<div class="fieldcontain ${hasErrors(bean: objetivoBuenVivirInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="objetivoBuenVivir.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="codigo" type="number" value="${objetivoBuenVivirInstance.codigo}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: objetivoBuenVivirInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="objetivoBuenVivir.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="127" value="${objetivoBuenVivirInstance?.descripcion}"/>

</div>

