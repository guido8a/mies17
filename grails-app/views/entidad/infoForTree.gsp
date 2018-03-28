<%@ page import="mies.PresupuestoUnidad" %>

<style type="text/css">
.thead {
    cursor : pointer;
}

.show {
    background : #c0d1e0;
}
</style>

<g:set var="maxDir" value="max-height: 40px; margin: -10px 0;"/>
<g:set var="maxMis" value="max-height: 80px; margin: -10px 0;"/>
<g:set var="maxObs" value="max-height: 40px; margin: -10px 0;"/>
<g:set var="maxPre" value="max-height: 148px; margin: -10px 0;"/>

<table width="100%">
    <tbody>
        <tr class="prop">
            <td class="label">Orden</td>
            <td class="campo">${unidad?.orden}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Tipo de institución</td>

            <td class="campo">${unidad?.tipoInstitucion?.descripcion}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">C&oacute;digo eSIGEF</td>

            <td class="campo">${unidad?.codigo}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Nombre</td>

            <td class="campo">${unidad?.nombre}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Direcci&oacute;n</td>

            <td class="campo">
                <div style="${maxDir} overflow-y: auto;">
                    ${unidad?.direccion}
                </div>
            </td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Sigla</td>

            <td class="campo">${unidad?.sigla}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Misión</td>

            <td class="campo">
                <div style="${maxMis} overflow-y: auto;">
                    ${unidad?.objetivo}
                </div>
            </td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Tel&eacute;fono</td>

            <td class="campo">${unidad?.telefono}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Fax</td>

            <td class="campo">${unidad?.fax}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">E-mail</td>

            <td class="campo">${unidad?.email}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Provincia</td>

            <td class="campo">${unidad?.provincia?.nombre}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Fecha Inicio</td>

            <td class="campo">${unidad?.fechaInicio?.format("dd-MM-yyyy")}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Fecha Fin</td>

            <td class="campo">${unidad?.fechaFin?.format("dd-MM-yyyy")}</td> <!-- campo -->
        </tr>

        <tr class="prop">
            <td class="label">Observaciones</td>

            <td class="campo">
                <div style="${maxObs} overflow-y: auto;">
                    ${unidad?.observaciones}
                </div>
            </td> <!-- campo -->
        </tr>

    <tr class="prop">
        <td class="label">Id</td>
        <td class="campo">${unidad?.id} - padre:${unidad?.padre.id}</td> <!-- campo -->
    </tr>


    <tr class="prop" style="max-height: 200px;">
            <td class="label">Presupuesto</td>

            <td class="campo" style="">
                <div style="${maxPre} overflow-y: auto;">
                    <table border="1" cellpadding="2" style="border-collapse: collapse; border-color: #aaa;" width="100%">
                        <g:set var="arr" value="${presupuestos}"/>
                        <g:each in="${arr}" var="pr" status="i">
                            <thead class="thead" id="head_${i}">
                                <tr>
                                    <th colspan="2">A&ntilde;o ${pr.anio}</th>
                                </tr>
                            </thead>
                            <tbody class="tbody ui-helper-hidden" id="body_${i}">
                                <tr>
                                    <th>Max. Inversi&oacute;n</th>

                                    <td>
                                        <g:formatNumber number="${pr.maxInversion}" format="###,##0"
                                                        minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Max. Corrientes</th>

                                    <td>
                                        <g:formatNumber number="${pr.maxCorrientes}" format="###,##0"
                                                        minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>
                                </tr>

                                <g:set var="max" value="${40}"/>

                                <tr>
                                    <th>Eje program&aacute;tico</th>

                                    <td>
                                        <g:if test="${pr.ejeProgramatico?.descripcion}">
                                            ${pr.ejeProgramatico?.descripcion[0..(pr.ejeProgramatico?.descripcion?.size() > max ? (max - 1) : pr.ejeProgramatico?.descripcion?.size() - 1)]}${(pr.ejeProgramatico?.descripcion?.size() > max ? "..." : "")}
                                        </g:if>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Objetivo estrat&eacute;gico</th>

                                    <td>
                                        <g:if test="${pr.objetivoEstrategico?.descripcion}">
                                            ${pr.objetivoEstrategico?.descripcion[0..(pr.objetivoEstrategico?.descripcion?.size() > max ? (max - 1) : pr.objetivoEstrategico?.descripcion?.size() - 1)]}${(pr.objetivoEstrategico?.descripcion?.size() > max ? "..." : "")}
                                        </g:if>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Objetivo GPR</th>

                                    <td>
                                        <g:if test="${pr.objetivoGobiernoResultado?.descripcion}">
                                            ${pr.objetivoGobiernoResultado?.descripcion[0..(pr.objetivoGobiernoResultado?.descripcion?.size() > max ? (max - 1) : pr.objetivoGobiernoResultado?.descripcion?.size() - 1)]}${(pr.objetivoGobiernoResultado?.descripcion?.size() > max ? "..." : "")}
                                        </g:if>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Pol&iacute;tica MIES</th>

                                    <td>
                                        <g:if test="${pr.politica?.descripcion}">
                                            ${pr.politica?.descripcion[0..(pr.politica?.descripcion?.size() > max ? (max - 1) : pr.politica?.descripcion?.size() - 1)]}${(pr.politica?.descripcion?.size() > max ? "..." : "")}
                                        </g:if>
                                    </td>
                                </tr>
                            </tbody>
                        </g:each>
                    </table>
                </div>
            </td> <!-- campo -->
        </tr>

    </tbody>
</table>

<script type="text/javascript">
    $(function () {
        $(".thead").click(function () {

            var head = $(this);
            var strId = head.attr("id");
            var parts = strId.split("_");
            var id = parts[1];
            var body = $("#body_" + id);
            $(".tbody").not("#body_" + id).hide();
            $(".thead").removeClass("show");

            if (body.is(":visible")) {
                body.hide();
            } else {
                head.addClass("show");
                body.show();
            }

        });
    });
</script>