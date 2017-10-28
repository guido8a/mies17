<g:form action="save" class="edit_meta"  method="post"  >
    <g:hiddenField name="id" value="${meta?.id}" id="id_form"/>
    <g:hiddenField name="version" value="${meta?.version}" />
    <div>
        <div class="prop mandatory ${hasErrors(bean: meta, field: 'anio', 'error')}">
            <label for="anio">
                <g:message code="meta.anio.label" default="Anio" />
                <span class="indicator">*</span>
            </label>
            <div class="campo">
                <g:select class="field required requiredCmb ui-widget-content ui-corner-all" name="anio.id" title="Anio"
                          from="${mies.Anio.list([sort: 'anio'])}" optionKey="id" value="${meta?.anio?.id}" style="width: 80px;" />
            </div>
        </div>
        <div class="prop ${hasErrors(bean: meta, field: 'tipoMeta', 'error')}">
            <label for="tipoMeta">
                Indicador

            </label>
            <div class="campo">
                <g:select class="field ui-widget-content ui-corner-all" name="tipoMeta.id" title="Tipo de Meta" from="${mies.TipoMeta.list()}" optionKey="id" value="${meta?.tipoMeta?.id}" noSelection="['null': '']" />
            </div>
        </div>
        <div class="prop ${hasErrors(bean: meta, field: 'unidad', 'error')}">
            <label for="unidad">
                <g:message code="meta.unidad.label" default="Unidad" />

            </label>
            <div class="campo">
                <g:select class="field ui-widget-content ui-corner-all" name="unidad.id" title="Unidad de medida" from="${mies.Unidad.list()}" optionKey="id" value="${meta?.unidad?.id}" noSelection="['null': '']" />
            </div>
        </div>

        <div class="prop mandatory ${hasErrors(bean: meta, field: 'indicador', 'error')}">
            <label for="indicador">
                Meta
                <span class="indicator">*</span>
            </label>
            <div class="campo">
                <g:textField class="field number required ui-widget-content ui-corner-all" name="indicador"
                             title="Indicador numérico de la meta" id="indicador" value="${meta.indicador.toFloat().round(2)}" style="width: 120px;" />
            </div>
        </div>
        <div class="prop mandatory">
            <label for="inversion">
                Parroquia
            </label>
            <div class="campo">
                <input type="text" id="txt_parr" value="${meta.parroquia.nombre}">
                <a href="#" id="buscar_edit">Buscar</a>
                <input type="hidden" id="form_par_id" name="parroquia.id" value="${meta.parroquia.id}">
            </div>
        </div>
        <div class="prop mandatory ${hasErrors(bean: meta, field: 'inversion', 'error')}">
            <label for="inversion">
                <g:message code="meta.inversion.label" default="Inversion" />
                <span class="indicator">*</span>
            </label>
            <div class="campo">
                <g:textField class="field number required ui-widget-content ui-corner-all" name="inversion" title="Inversion"
                             id="inversion_form" value='${g.formatNumber(number:meta.inversion,format:"###,##0",minFractionDigits:"2", maxFractionDigits:"2")}' style="width: 140px;"/>

            </div>
        </div>

    </div>
    <div style="width: 400px;height: 25px;display: none;margin-top: 10px;border: red 1px solid;background: rgba(255,0,0,0.5);padding: 5px" id="error" class="ui-corner-all"></div>
    <div id="dlg_buscar_edit">
        <div style="width: 90%;height: 30px;">
            <input type="text" id="txt_buscar_edit">

            <a href="#" id="buscar_edit_dlg" class="btn">Buscar</a>
        </div>

        <div id="parrs_edit"
             style="width: 95%;height: 340px;overflow-y: auto;margin: auto;margin-top: 10px;border: 1px solid black;"
             class="ui-corner-all"></div>
    </div>

    <div id="errorUpdate" style="width: 400px;height: 40px;padding: 5px;background: rgba(255,0,0,0.4);margin-top: 10px;display: none" class="ui-corner-all">

    </div>
    <script type="text/javascript">
        $("#buscar_edit").button().click(function () {
            $("#dlg_buscar_edit").dialog("open")
        });
        $("#buscar_edit_dlg").button().click(function () {
            $.ajax({
                type:"POST",
                url:"${createLink(action:'buscarParroquiasEditar',controller:'meta')}",
                data:"parametro=" + $("#txt_buscar_edit").val(),
                success:function (msg) {
                    $("#parrs_edit").html(msg)

                }
            });
        });
        $("#dlg_buscar_edit").dialog({
            width:630,
            height:500,
            position:"center",
            modal:true,
            autoOpen:false
        })
    </script>
</g:form>