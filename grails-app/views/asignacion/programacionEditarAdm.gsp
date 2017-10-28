<table style="width: 1000px;">
    <thead>
    <th style="width: 70px;">Enero</th>
    <th style="width: 70px;">Feb.</th>
    <th style="width: 70px;">Marzo</th>
    <th style="width: 70px;">Abril</th>
    <th style="width: 70px;">Mayo</th>
    <th style="width: 70px;">Junio</th>
    <th style="width: 70px;">Julio</th>
    <th style="width: 70px;">Agos.</th>
    <th style="width: 70px;">Sept.</th>
    <th style="width: 70px;">Oct.</th>
    <th style="width: 70px;">Nov.</th>
    <th style="width: 70px;">Dic.</th>
    <th style="width: 80px;">Total</th>
    <th></th>
    <th></th>
    </thead>
    <tbody>

    <g:set var="asignado" value="0"></g:set>

    <tr>
        <td colspan="15"><b>Programa:</b>${asg.programa} <b>Actividad:</b> ${asg.actividad} <b>Partida:</b> ${asg.presupuesto.descripcion}
        </td>
    </tr>

    <tr>
        <g:set var="suma" value="${0}"/>
        <g:each in="${meses}" var="mes">
            <g:set var="progra" value="${mies.ProgramacionAsignacion.findAll('from ProgramacionAsignacion where asignacion = '+asg.id+' and mes = '+mes+' and padre is null')?.pop()}"></g:set>
            <td class="${mes}" style="width: 70px;">
                <input type="text" class="${mes} valor asg_cor_${asg.id}" mes="${mes}" value="${g.formatNumber(number: progra?.valor, format: '###,##0', minFractionDigits: '2', maxFractionDigits: '2')}" style="width: 80px;text-align: right">
                <g:set var="suma" value="${suma+progra.valor}"/>

            </td>
        </g:each>
        <td class="total" id="total_cor_${asg.id}" style="width: 80px;">
            <g:if test="${suma.toDouble().round(2) != asg.planificado}">
                <span style="color: red;"><g:formatNumber number="${suma}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></span>
            </g:if>
            <g:else>
                <g:formatNumber number="${(asg.redistribucion==0)?asg.planificado:asg.redistribucion}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
            </g:else>
        </td>

        <td class=""><a href="#" class="btn guardarPrg ajax" asg="${asg.id}" icono="ico_cor_${i}" max="${(asg.redistribucion == 0) ? asg.planificado : asg.redistribucion}" clase="asg_cor_${asg.id}" total="total_cor_${asg.id}">Guardar</a>
        </td>

        <td class="ui-state-active"><span class="" id="ico_cor_${i}" title="Guardado" style="display: none"><span class="ui-icon ui-icon-check"></span>
        </span></td>
    </tr>



    </tbody>
</table>
<div class="message">
    Utilize el boton <a href="#" class="btnPrb">Guardar</a> para grabar los cambios
</div>
<script type="text/javascript">
    $(".guardarPrg").button({
        icons:{
            primary:"ui-icon-disk"
        },
        text:false
    });
    $(".btnPrb").button({
        icons:{
            primary:"ui-icon-disk"
        },
        text:false
    });
    $(".guardarPrg").click(function () {
        var icono = $("#" + $(this).attr("icono"))
        var total = 0
        var max = $(this).attr("max") * 1
        var datos = ""
        $.each($("." + $(this).attr("clase")), function () {
            var val = $(this).val()
            val = str_replace(".", "", val)
            val = str_replace(",", ".", val)
            val = val * 1
            total += val
            datos += $(this).attr("mes") + ":" + val + ";"
        });
        total = parseFloat(total).toFixed(2);
        if (total != max) {
            alert("El total programado (" + total + ") es diferente al monto de la asignación" + max)
            $("#" + $(this).attr("total")).html(total).css("color", "red").show("pulsate")
        } else {
            $("#" + $(this).attr("total")).html(total).css("color", "black")
            $.ajax({
                type:"POST",
                url:"${createLink(action:'guardarProgramacion',controller:'asignacion')}",
                data:"asignacion=" + $(this).attr("asg") + "&datos=" + datos,
                success:function (msg) {
                    if (msg == "ok") {
                        icono.show("pulsate")
                    }
                }
            });
        }

    });
</script>
