<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/24/11
  Time: 4:30 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="mies.seguridad.Usro; mies.Persona" %>

<g:form action="save" class="frm_editar"
        method="post">
    <g:hiddenField name="esUsuario" value="1"/>

    <g:hiddenField name="persona.id" value="${usuario.persona?.id}"/>
    <g:hiddenField name="persona.version" value="${usuario.persona?.version}"/>
    <g:hiddenField name="tipo" value="${tipo}"/>

    <g:hiddenField name="usuario.id" value="${usuario?.id}"/>
    <g:hiddenField name="usuario.version" value="${usuario?.version}"/>
    <g:hiddenField name="usuario.persona.id" value="${usuario?.persona?.id}"/>

    <style type="text/css">
    .row {
        width  : 600px;
        height : 29px;
    }

    .row:hover {
        background : #ABE1F4;
    }

    .perfil {
        float       : left;
        line-height : 29px;
    }

    .boton {
        float : right;
    }

    .datepicker {
        width : 180px;
    }
    </style>

    <table width="100%" class="ui-widget-content ui-corner-all">

        <tbody>

            <tr class="prop ${hasErrors(bean: usuario.persona, field: 'cedula', 'error')} ${hasErrors(bean: usuario.persona, field: 'nombre', 'error')}">

                <td class="label  mandatory" valign="middle">
                    Cédula
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    <g:textField name="persona.cedula" id="cedula"
                                 title="${Persona.constraints.cedula.attributes.mensaje}"
                                 class="field required ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="13" value="${usuario.persona?.cedula}"/>
                </td>

                <td class="label  mandatory" valign="middle">
                    <g:message code="persona.nombre.label" default="Nombre"/>
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    <g:textField name="persona.nombre" id="nombre"
                                 title="${Persona.constraints.nombre.attributes.mensaje}"
                                 class="field required ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="40" value="${usuario.persona?.nombre}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario.persona, field: 'apellido', 'error')} ${hasErrors(bean: usuario.persona, field: 'sexo', 'error')}">

                <td class="label  mandatory" valign="middle">
                    <g:message code="persona.apellido.label" default="Apellido"/>
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    <g:textField name="persona.apellido" id="apellido"
                                 title="${Persona.constraints.apellido.attributes.mensaje}"
                                 class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="40"
                                 value="${usuario.persona?.apellido}"/>
                </td>

                <td class="label  mandatory" valign="middle">
                    <g:message code="persona.sexo.label" default="Sexo"/>
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    <g:select class="required requiredCmb ui-widget-content ui-corner-all" name="persona.sexo"
                              title="${Persona.constraints.sexo.attributes.mensaje}"
                              id="sexo" style="width: 200px;"
                              from="${new Persona().constraints.sexo.inList}" value="${usuario.persona?.sexo}"
                              valueMessagePrefix="persona.sexo"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario.persona, field: 'discapacitado', 'error')} ${hasErrors(bean: usuario.persona, field: 'fechaNacimiento', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="persona.discapacitado.label" default="Discapacitado"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    %{--<g:checkBox name="persona.discapacitado" id="discapacitado" title="${Persona.constraints.discapacitado.attributes.mensaje}"--}%
                    %{--class="field ui-widget-content ui-corner-all"--}%
                    %{--value="${usuario.persona?.discapacitado}"/>--}%

                    <g:radioGroup name="persona.discapacitado" labels="['No','Sí']" values="[0,1]"
                                  value="${usuario.persona?.discapacitado}">
                        ${it.label} ${it.radio}&nbsp;&nbsp;&nbsp;
                    </g:radioGroup>

                </td>

                <td class="label " valign="middle">
                    <g:message code="persona.fechaNacimiento.label" default="Fecha Nacimiento"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    %{--<input type="hidden" value="date.struct" name="persona.fechaNacimiento">--}%
                    <input type="hidden" name="persona.fechaNacimiento_day" id="fechaNacimiento_day"
                           value="${usuario.persona?.fechaNacimiento?.format('dd')}">

                    <input type="hidden" name="persona.fechaNacimiento_month" id="fechaNacimiento_month"
                           value="${usuario.persona?.fechaNacimiento?.format('MM')}">

                    <input type="hidden" name="persona.fechaNacimiento_year" id="fechaNacimiento_year"
                           value="${usuario.persona?.fechaNacimiento?.format('yyyy')}">
                    <g:textField class="datepicker field ui-widget-content ui-corner-all" name="persona.fechaNacimiento"
                                 title="${Persona.constraints.fechaNacimiento.attributes.mensaje}" id="fechaNacimiento"
                                 value="${usuario.persona?.fechaNacimiento?.format('dd/MM/yyyy')}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario.persona, field: 'direccion', 'error')} ${hasErrors(bean: usuario.persona, field: 'telefono', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="persona.direccion.label" default="Dirección"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:textField name="persona.direccion" id="direccion"
                                 title="${Persona.constraints.direccion.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="127" value="${usuario.persona?.direccion}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="persona.telefono.label" default="Teléfono"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:textField name="persona.telefono" id="telefono"
                                 title="${Persona.constraints.telefono.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="10" value="${usuario.persona?.telefono}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario.persona, field: 'mail', 'error')} ${hasErrors(bean: usuario.persona, field: 'fax', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="persona.mail.label" default="Mail"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:textField name="persona.mail" id="mail" title="${Persona.constraints.mail.attributes.mensaje}"
                                 class="field email ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="40" value="${usuario.persona?.mail}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="persona.fax.label" default="Fax"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:textField name="persona.fax" id="fax" title="${Persona.constraints.fax.attributes.mensaje}"
                                 class="field ui-widget-content ui-corner-all"
                                 minLenght="1"
                                 maxLenght="40" value="${usuario.persona?.fax}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario.persona, field: 'observaciones', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="persona.observaciones.label" default="Observaciones"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle" colspan="4">
                    <g:textArea name="persona.observaciones" id="observaciones"
                                title="${Persona.constraints.observaciones.attributes.mensaje}"
                                class="ui-widget-content ui-corner-all" minLenght="1" maxLenght="127"
                                value="${usuario.persona?.observaciones}" rows="2" cols="81"/>
                </td>

            </tr>

        </tbody>
    </table>

    <table width="100%" class="ui-widget-content ui-corner-all">

        <tbody>

            <tr class="prop ${hasErrors(bean: usuario, field: 'cargoPersonal', 'error')} ${hasErrors(bean: usuario, field: 'login', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="usro.unidad.label" default="Unidad"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:select class="field ui-widget-content ui-corner-all" name="usuario.unidad.id"
                              title="${Usro.constraints.unidad.attributes.mensaje}" style="width: 200px;"
                              from="${mies.UnidadEjecutora.list([sort:'nombre'])}" optionKey="id" value="${unidad?.id}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="usro.cargoPersonal.label" default="Cargo Personal"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    <g:select class="field ui-widget-content ui-corner-all" name="usuario.cargoPersonal.id"
                              title="${Usro.constraints.cargoPersonal.attributes.mensaje}" style="width: 200px;"
                              from="${mies.CargoPersonal.list()}" optionKey="id" value="${usuario?.cargoPersonal?.id}"
                              noSelection="['null': '']"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario, field: 'usroPassword', 'error')} ${hasErrors(bean: usuario, field: 'autorizacion', 'error')}">

                <td class="label  mandatory" valign="middle">
                    Usuario
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    <g:textField name="usuario.login" id="login"
                                 title="${Usro.constraints.login.attributes.mensaje}"
                                 class="field required ui-widget-content ui-corner-all" minLenght="1" maxLenght="15"
                                 value="${usuario?.login}"/>
                </td>

                <td class="label" valign="middle">
                    Contrase&ntilde;a
                </td>

                <td class="indicator">
                    <span class="indicator"></span>
                </td>

                <td class="" valign="middle">
                    <g:passwordField name="usuario.usroPassword" id="usroPassword"
                                     title="${Usro.constraints.usroPassword.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="64"
                                     value="${(usuario.usroPassword && usuario.usroPassword?.trim() != '') ? '****' : ''}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario, field: 'sigla', 'error')} ${hasErrors(bean: usuario, field: 'usroActivo', 'error')}">

                <td class="label  mandatory" valign="middle">
                    <g:message code="usro.sigla.label" default="Sigla"/>
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    <g:textField name="usuario.sigla" id="sigla" title="${Usro.constraints.sigla.attributes.mensaje}"
                                 class="field required ui-widget-content ui-corner-all"
                                 minLenght="1" maxLenght="8" value="${usuario?.sigla}"/>
                </td>

                <td class="label  mandatory" valign="middle">
                    <g:message code="usro.usroActivo.label" default="Activo"/>
                </td>

                <td class="indicator mandatory">
                    <span class="indicator">*</span>
                </td>

                <td class=" mandatory" valign="middle">
                    %{--<g:textField class="field number required ui-widget-content ui-corner-all" name="usuario.usroActivo"--}%
                    %{--title="${Usro.constraints.usroActivo.attributes.mensaje}"--}%
                    %{--id="usroActivo" value="${fieldValue(bean: usuario, field: 'usroActivo')}"/>--}%
                    <g:radioGroup name="usuario.usroActivo" labels="['No','Sí']" values="[0,1]"
                                  value="${usuario?.usroActivo}">
                        ${it.label} ${it.radio}&nbsp;&nbsp;&nbsp;
                    </g:radioGroup>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario, field: 'fechaPass', 'error')} ${hasErrors(bean: usuario, field: 'observaciones', 'error')}">

                <td class="label" valign="middle">
                    <g:message code="usro.autorizacion.label" default="Autorización"/>
                </td>

                <td class="indicator">
                    <span class="indicator"></span>
                </td>

                <td class="" valign="middle">
                    <g:passwordField name="usuario.autorizacion" id="autorizacion"
                                     title="${Usro.constraints.autorizacion.attributes.mensaje}"
                                     class="field ui-widget-content ui-corner-all" minLenght="1"
                                     maxLenght="255"
                                     value="${(usuario.autorizacion && usuario.autorizacion?.trim() != '') ? '****' : ''}"/>
                </td>

                <td class="label " valign="middle">
                    <g:message code="usro.fechaPass.label" default="Fecha cambio contraseña"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle">
                    %{--<input type="hidden" value="date.struct" name="usuario.fechaPass">--}%
                    <input type="hidden" name="usuario.fechaPass_day" id="fechaPass_day"
                           value="${usuario?.fechaPass?.format('dd')}">

                    <input type="hidden" name="usuario.fechaPass_month" id="fechaPass_month"
                           value="${usuario?.fechaPass?.format('MM')}">

                    <input type="hidden" name="usuario.fechaPass_year" id="fechaPass_year"
                           value="${usuario?.fechaPass?.format('yyyy')}">
                    <g:textField class="datepicker field ui-widget-content ui-corner-all" name="usuario.fechaPass"
                                 title="${Usro.constraints.fechaPass.attributes.mensaje}"
                                 id="fechaPass" value="${usuario?.fechaPass?.format('dd/MM/yyyy')}"/>
                </td>

            </tr>

            <tr class="prop ${hasErrors(bean: usuario, field: 'unidad', 'error')}">

                <td class="label " valign="middle">
                    <g:message code="usro.observaciones.label" default="Observaciones"/>
                </td>

                <td class="indicator">
                    &nbsp;
                </td>

                <td class="" valign="middle" colspan="4">
                    <g:textArea name="usuario.observaciones" id="observaciones"
                                title="${Usro.constraints.observaciones.attributes.mensaje}"
                                class="ui-widget-content ui-corner-all" minLenght="1" maxLenght="255"
                                value="${usuario?.observaciones}" cols="81" rows="2"/>
                </td>

            </tr>

        </tbody>
    </table>

    <g:hiddenField name="perfiles_add" id="perfiles_add"/>
    <g:hiddenField name="perfiles_remove" id="perfiles_remove"/>

    <table width="100%" class="ui-widget-content ui-corner-all">
        <tr>
            <td class="label mandatory" valign="middle" rowspan="2">
                Perfiles
            </td>

            <td class="indicator mandatory" rowspan="2">
                <span class="indicator">*</span>
            </td>

            <td class=" mandatory" valign="middle">
                <g:select class="field ui-widget-content ui-corner-all" name="perfiles.perfil.id" id="perfiles"
                          title="Perfil" style="width: 200px;" from="${mies.seguridad.Prfl.list()}" optionKey="id"/>
                <a href="#" id="btn_agregarPerfil">Agregar</a>
            </td>
        </tr>

        <tr>
            <td id="td_perfiles">
                <g:each in="${perfiles}" var="perfil">
                    <div class="row" data-tipo="">
                        <div class="perfil">
                            ${perfil}
                        </div>

                        <div class="boton">
                            <a href="#" class="btn del" id="${perfil.id}">Eliminar</a>
                        </div>
                    </div>
                </g:each>
            </td>
        </tr>
    </table>

</g:form>


<script type="text/javascript">
    $(function () {

        $(".del").button({
            icons:{
                primary:"ui-icon-trash"
            },
            text:false
        }).click(function () {
                    $(this).parent().parent().remove();
                    var ids = $("#perfiles_remove").val();
                    var id = $(this).attr("id");
                    if (ids == "") {
                        ids += ","
                    }
                    ids += id + ","
                    $("#perfiles_remove").val(ids);
                    return false;
                });

        $("#btn_agregarPerfil").button({
            icons:{
                primary:"ui-icon-plusthick"
            },
            text:false
        }).click(function () {
                    var id = $("#perfiles").val();
                    var txt = $("#perfiles option:selected").text();

                    var td = $("#td_perfiles div:icontains('" + txt + "')");
                    if (td.length == 0) {

                        var ids = $("#perfiles_add").val();
                        if (ids == "") {
                            ids += ","
                        }
                        ids += id + ","
                        $("#perfiles_add").val(ids);

                        var row = $('<div class="row">');
                        var divPer = $('<div class="perfil">');
                        var divBtn = $('<div class="boton">');

                        var btn = $('<a href="#">Eliminar</a>');
                        divPer.append(txt);
                        divBtn.append(btn);
                        row.append(divPer);
                        row.append(divBtn);

                        $("#td_perfiles").append(row);

                        btn.button({
                            icons:{
                                primary:"ui-icon-trash"
                            },
                            text:false
                        }).click(function () {
                                    $(this).parent().parent().remove();
                                    var ids = $("#perfiles_add").val();
                                    ids = str_replace(id + ",", '', ids);
                                    $("#perfiles_add").val(ids);
                                    return false;
                                });

                    }
                    return false;
                });

        $('#fechaNacimiento').datepicker({
            changeMonth:true,
            changeYear:true,
            dateFormat:'dd/mm/yy',
            yearRange:'-80:+05',
            onClose:function (dateText, inst) {
                var date = $(this).datepicker('getDate');
                var day, month, year;
                if (date != null) {
                    day = date.getDate();
                    month = parseInt(date.getMonth()) + 1;
                    year = date.getFullYear();
                } else {
                    day = '';
                    month = '';
                    year = '';
                }
                var id = $(this).attr('id');
                $('#' + id + '_day').val(day);
                $('#' + id + '_month').val(month);
                $('#' + id + '_year').val(year);
            }
        });

        $('#fechaPass').datepicker({
            changeMonth:true,
            changeYear:true,
            dateFormat:'dd-mm-yy',
            onClose:function (dateText, inst) {
                var date = $(this).datepicker('getDate');
                var day, month, year;
                if (date != null) {
                    day = date.getDate();
                    month = parseInt(date.getMonth()) + 1;
                    year = date.getFullYear();
                } else {
                    day = '';
                    month = '';
                    year = '';
                }
                var id = $(this).attr('id');
                $('#' + id + '_day').val(day);
                $('#' + id + '_month').val(month);
                $('#' + id + '_year').val(year);
            }
        });

        var myForm = $(".frm_editar");

        // Tooltip de informacion para cada field (utiliza el atributo title del textfield)
        var elems = $('.field')
                .each(function (i) {
                    $.attr(this, 'oldtitle', $.attr(this, 'title'));
                })
                .removeAttr('title');
        $('<div />').qtip(
                {
                    content:' ', // Can use any content here :)
                    position:{
                        target:'event' // Use the triggering element as the positioning target
                    },
                    show:{
                        target:elems,
                        event:'click mouseenter focus'
                    },
                    hide:{
                        delay:0,
                        leave:false,
                        target:elems
                    },
                    events:{
                        show:function (event, api) {
                            // Update the content of the tooltip on each show
                            var target = $(event.originalEvent.target);
                            api.set('content.text', target.attr('title'));
                        }
                    },
                    style:{
                        classes:'ui-tooltip-rounded ui-tooltip-cream'
                    }
                });
        // fin del codigo para los tooltips

        // Validacion del formulario
        myForm.validate({
            errorClass:"errormessage",
            onkeyup:false,
            errorElement:"em",
            errorClass:'error',
            validClass:'valid',
            errorPlacement:function (error, element) {
                // Set positioning based on the elements position in the form
                var elem = $(element),
                        corners = ['right center', 'left center'],
                        flipIt = elem.parents('span.right').length > 0;

                // Check we have a valid error message
                if (!error.is(':empty')) {
                    // Apply the tooltip only if it isn't valid
                    elem.filter(':not(.valid)').qtip({
                        overwrite:false,
                        content:error,
                        position:{
                            my:corners[ flipIt ? 0 : 1 ],
                            at:corners[ flipIt ? 1 : 0 ],
                            viewport:$(window)
                        },
                        show:{
                            event:false,
                            ready:true
                        },
                        hide:false,
                        style:{
                            classes:'ui-tooltip-rounded ui-tooltip-red' // Make it red... the classic error colour!
                        }
                    })

                        // If we have a tooltip on this element already, just update its content
                            .qtip('option', 'content.text', error);
                }

                // If the error is empty, remove the qTip
                else {
                    elem.qtip('destroy');
                }
            },
            success:$.noop // Odd workaround for errorPlacement not firing!
        })
        ;
        //fin de la validacion del formulario


        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
        $(".show").button("option", "icons", {primary:'ui-icon-bullet'});
        $(".save").button("option", "icons", {primary:'ui-icon-disk'}).click(function () {
            myForm.submit();
            return false;
        });
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function () {
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>