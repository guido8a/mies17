<%@ page contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>mies</title>


    <script type="text/javascript" src="${resource(dir:'js/jquery/plugins', file:'jquery.cookie.js')}"></script>

</head>

<body>
<div class="container ui-corner-all " style="">
<div style="float:left; width:700px;">
    <div id="info">
        <ul id="info-nav">
            <li><a href="#proy">Proyectos</a></li>
            <li><a href="#snpl">Proyectos Senplades</a></li>
            <li><a href="#papp">PAPP y PAC</a></li>
            <li><a href="#grgf">Generales</a></li>
        </ul>

        <div>
            <div id="proy" class="ui-widget-content" style="height: 440px">
                <div class="item" texto="grpr">
                    <g:link  controller="grupoProcesos" action="list">Grupo de Procesos del Proyecto</g:link> se les suele conocer también como etapas del proyecto
                </div><br>
                <div class="item" texto="obes">
                    <g:link  controller="objetivoEstrategicoProyecto" action="list">Objetivos Estratégicos</g:link> con los cuales se alinean los proyectos
                </div><br>
                %{--<div class="item" texto="obes">--}%
                    %{--<g:link  controller="objetivoEstrategicoProyecto" action="list">Objetivos Estratégicos</g:link> con los cuales se alinean los proyectos--}%
                %{--</div><br>--}%
                <div class="item" texto="obgr">
                    <g:link  controller="objetivoGobiernoResultado" action="list">Objetivos del Gobierno por Resultados</g:link> de acuerdo al sistema de Gobierno por Resultados
                </div><br>
                <div class="item" texto="pltc">
                    <g:link  controller="politica" action="list">Pol&iacute;ticas MIES que aplica el proyecto</g:link> Distintas políticas que pueden ser aplicadas en un proyecto
                </div><br>
                <div class="item" texto="prgr">
                    <g:link  controller="programa" action="list">Programa</g:link> del cual forma parte un proyecto
                </div><br>
                <div class="item" texto="plas">
                    <g:link  controller="politicaAgendaSocial" action="list">Políticas de la Agenda Social</g:link> que pueden aplicarse a un proyecto
                </div><br>
%{--
                <div class="item" texto="tpel">
                    <g:link  controller="tipoElemento" action="list">Tipo de Elemento del Marco Lógico</g:link> para identificar los diferentes componentes del Marco L&oacute;gico
                </div><br>
                <div class="item" texto="tpif">
                    <g:link  controller="tipoInforme" action="list">Tipo de Informe</g:link> que puede presentar el responsable o gerente del proyecto
                </div><br>
                <div class="item" texto="tpmd">
                    <g:link  controller="tipoModificacion" action="list">Tipo de Modificaci&oacute;n</g:link> que puede realizarse en el proyecto
                </div><br>
--}%
                <div class="item" texto="tpmt">
                    <g:link  controller="tipoMeta" action="list">Tipo de Meta</g:link> para la desagregaci&oacute;n de las metas a modo de unidad de medida del efecto social.
                </div><br>
                <div class="item" texto="mtbv">
                    <g:link  controller="metaBuenVivir" action="list">Metas Buen Vivir</g:link>
                </div><br>
            </div>

            <div id="snpl" class="ui-widget-content" style="height: 440px">
%{--
                <div class="item" texto="calf">
                    <g:link  controller="calificacion" action="list">Calificaci&oacute;n</g:link> Criterio de calificaci&oacute;n del proyecto.
                </div><br>
--}%
                <div class="item" texto="cbrt">
                    <g:link  controller="cobertura" action="list">Cobertura del Proyecto</g:link> Cobertura geográfica del proyecto: nacional, provincial, etc.
                </div><br>
                <div class="item" texto="edpy">
                    <g:link  controller="estadoProyecto" action="list">Estado del proyecto</g:link> Estado del proyecto, por ejemplo: arrastre
                </div><br>
                <div class="item" texto="etpa">
                    <g:link  controller="etapa" action="list">Etapa del Proyecto</g:link> etapa en la que puede hallarse el proyecto
                </div><br>
                <div class="item" texto="fase">
                    <g:link  controller="fase" action="list">Fase del Proyecto</g:link> fase administrativa en la que se halla el proyecto
                </div><br>
                <div class="item" texto="lnea">
                    <g:link  controller="linea" action="list">Lineamiento de inversi&oacute;n</g:link> Línea de inversión del proyecto, valores determinados por la Senplades
                </div><br>
%{--
                <div class="item" texto="sctr">
                    <g:link  controller="sector" action="list">Sector Econ&oacute;mico</g:link> que apoya o en el que se interviene con el proyecto
                </div><br>
                <div class="item" texto="sbst">
                    <g:link  controller="subSector" action="list">Subsector Econ&oacute;mico</g:link> que apoya o en el que se interviene con el proyecto
                </div><br>
                <div class="item" texto="tpaq">
                    <g:link  controller="tipoAdquisicion" action="list">Tipo de Adquisici&oacute;n</g:link> de bienes o servicios que se realiza en el proyecto
                </div><br>
                <div class="item" texto="tpgr">
                    <g:link  controller="tipoGrupo" action="list">Tipo de Grupo de Atenci&oacute;n</g:link> prioritario para el proyecto
                </div><br>
                <div class="item" texto="tpiv">
                    <g:link  controller="tipoInversion" action="list">Tipo de Inversi&oacute;n</g:link> social que se puede hacer en el proyecto,
                </div><br>
                <div class="item" texto="tppc">
                    <g:link  controller="tipoProcedencia" action="list">Tipo de Procedencia</g:link> de los bienes o servicios a adquirirse en el proyecto
                </div><br>
                <div class="item" texto="tppd">
                    <g:link  controller="tipoProducto" action="list">Tipo de Producto</g:link> que se espera de resultado de la ejecuci&oacute;n del proyecto
                </div><br>
--}%
                <div class="item" texto="tppt">
                    <g:link  controller="tipoParticipacion" action="list">Tipo de Participaci&oacute;n</g:link> de la Entidad en el proyecto
                </div>
            </div>

            <div id="papp" class="ui-widget-content" style="height: 440px">
                <div class="item" texto="actv">
                    <g:link  controller="actividad" action="list">Actividades de Gasto Corriente</g:link> que figuran en el PAPP
                </div><br>
                <div class="item" texto="anio">
                    <g:link  controller="anio" action="list">A&ntilde;o Fiscal</g:link> Año al cual corresponde el PAPP. Es similar al período contable o año fiscal.
                </div><br>
%{--
                <div class="item" texto="ctrm">
                    <g:link  controller="cuatrimestre" action="list">Cuatrimestre</g:link> para la programación de la ejecución presupuestaria y del PAC
                </div><br>
--}%
                <div class="item" texto="fnte">
                    <g:link  controller="componente" action="list">Componente</g:link> Componentes, usados en el registro de asignaciones corrientes.
                </div><br>
                <div class="item" texto="fnte">
                    <g:link  controller="fuente" action="list">Fuente de Financiamiento</g:link> Posibles fuentes de financiamiento que puede tener un proyecto
                </div><br>
                <div class="item" texto="prsp">
                    <g:link  controller="presupuesto" action="list">Plan de cuentas Presupuestario</g:link> o partidas presupuestarias para la asignación de gasto corriente y de inversión
                </div><br>
                <div class="item" texto="pgps">
                    <g:link  controller="programaPresupuestario" action="list">Programa Presupuestario</g:link> o dependencia a la cual se carga el POA o PAPP
                </div><br>
                <div class="item" texto="tpcp">
                    <g:link  controller="tipoCompra" action="list">Tipo de Compra o adquisici&oacute;n</g:link> seg&uacute;n el INCOP
                </div><br>
                <div class="item" texto="tpgs">
                    <g:link  controller="tipoGasto" action="list">Tipo de Gasto</g:link> de las asignaciones presupuestarias para los distintos proyectos y el PAPP
                </div><br>
            </div>

            <div id="grgf" class="ui-widget-content" style="height: 440px">
                <div class="item" texto="cgpr">
                    <g:link  controller="cargoPersonal" action="list">Cargos del Personal de la Unidad Ejecutora</g:link> que se aplican a los responsables del ingreso y seguimiento del proyecto
                </div><br>
%{--
                <div class="item" texto="mess">
                    <g:link  controller="mes" action="list">Mes del a&ntilde;o</g:link> para la planificaci&oacute;n del cronograma valorado
                </div><br>
                <div class="item" texto="zona">
                    <g:link  controller="zona" action="list">Zona de Planificaci&oacute;n</g:link> zona geogr&aacute;fica de planificaci&oacute;n
                </div><br>
--}%
                <div class="item" texto="regn">
                    <g:link  controller="region" action="list">Regi&oacute;n</g:link> geogr&aacute;fica
                </div><br>
%{--
                <div class="item" texto="dstt">
                    <g:link  controller="distrito" action="list">Distritos</g:link> divisi&oacute;n del territorio ecuatoriano en distritos
                </div><br>
--}%
                <div class="item" texto="geog">
                    <g:link  controller="zona" action="arbol">Divisi&oacute;n geogr&aacute;fica del Pa&iacute;s</g:link> en zonas, regiones, provincias, cantones y parroquias.
                </div><br>
                <div class="item" texto="tpin">
                    <g:link  controller="tipoInstitucion" action="list">Tipo de Institución</g:link> que se aplica a las distintas entidades y unidades ejecutoras
                </div><br>
                <div class="item" texto="undd">
                    <g:link  controller="unidad" action="list">Unidad de Medida</g:link> Unidad de control o conteo de obras para el plan anual de adquisiciones (PAC) y para fijar las metas.
                </div>
            </div>

        </div>
    </div>

</div>

<div id="tool" style="float:left; width: 160px; height: 300px; margin: 30px; display: none; padding:25px;"
     class="ui-widget-content ui-corner-all">
</div>

<div id="cgpr" style="display:none">
    <h1>Cargos del Personal</h1><br>
    <p>Cargos del personal de la Unidad Ejecutora y de la planta central del MIES.</p>
    <p>Estos cargo se aplican a quienes van a ser los responsables del ingreso o seguimiento y de la ejecución del proyecto</p>
</div>
<div id="grpr" style="display:none">
    <h1>Grupo de Procesos</h1><br>
    <p>El grupo de procesos del proyecto se refiere a los distintos momentos del proyecto como son:</p>
    <p>Inicio, Planificaci&oacute;n, Ejecuci&oacute;n y Cierre</p>
    <p>Se les conoce tambi&eacute;n como etapas del Proyecto</p>
</div>
<div id="mess" style="display:none">
    <h1>Meses</h1><br>
    <p>Meses del a&ntilde;o para la programaci&oacute;n y registro del Cronograma valorado</p>
</div>
<div id="pltc" style="display:none">
    <h1>Pol&iacute;ticas</h1><br>
    <p>Distintas pol&iacute;s que pueden aplicarse en un proyecto</p>
</div>
<div id="prgr" style="display:none">
    <h1>Programas</h1><br>
    <p>Programas de proyectos, sirve para identificar a los distintos proyectos que se ejecutan alineados o como parte de programa</p>
</div>

<div id="tpel" style="display:none">
    <h1>Tipo de Elemento</h1><br>
    <p>Tipo de elemento del marco lógico:</p>
    <p>Sirve para distinguir entre meta o fin, objetivo o prop&oacute;sito, componentes y actividades.</p>
    <p class="label">No se debe editar este parámetro.</p>
</div>

<div id="tpif" style="display:none">
    <h1>Tipo de Informe</h1><br>
    <p>Tipo de informe o documento que genera el responsable del proyecto o gerente del proyecto(PM):</p>
    <p>Pueden ser: Informes o pedidos de modificación.</p>
    <p class="label">No se debe editar este parámetro.</p>
</div>

<div id="tpmd" style="display:none">
    <h1>Tipo de Modificaci&oacute;n</h1><br>
    <p>Tipos de modificaciones del proyecto a lo largo de su vida.</p>
    <p>Pueden haber modificaciones de marco l&oacute;gico, cronograma, programaci&oacute;n presupuestaria,
      presupuesto y al PAC.</p>
    <p class="label">No se debe editar este parámetro.</p>
</div>

    <div id="mtbv" style="display:none">
        <h1>Metas del Buen Vivir</h1><br>
        <p>Edición y Creación de Metas del Buen Vivir</p>
    </div>

<div id="tpmt" style="display:none">
    <h1>Tipo de Meta</h1><br>
    <p>Tipo de meta para la desagregación de las metas a modo de unidad de medida del efecto social.</p>
    <p>Puenden ser valores como: personas de la tercera edad, adolecentes, niños, niñas, etc.</p>
</div>

<div id="tpsp" style="display:none">
    <h1>Tipo de Supuesto</h1><br>
    <p>Tipo de supuesto para cada elemento del marco l&oacute;gico.</p>
    <p>La idea es crear un conjunto de supuestos para su utilización en el marco l&oacute;gico</p>
</div>

<div id="undd" style="display:none">
    <h1>Unidad de Medida</h1><br>
    <p>Unidad de control o conteo de obras para el plan anual de adquisiciones (PAC) y para fijar las metas.</p>
    <p>Pueden ser: kil&oacute;metros, metros, escuelas, unidades, etc.</p>
</div>


<div id="calf" style="display:none">
    <h1>Calificaci&oacute;n del Proyecto</h1><br>
    <p>Criterio de calificación del proyecto</p>
    <p>Opciones: ADMISIBLE, DESEABLE, INDISPENSABLE, NECESARIO.</p>
</div>

<div id="cbrt" style="display:none">
    <h1>Cobertura del Proyecto</h1><br>
    <p>Cobertura geogr&aacute;fica del proyecto: nacional, provincial, zonal, cantonal, etc.</p>
</div>

<div id="edpy" style="display:none">
    <h1>Estado del proyecto</h1><br>
    <p>Se refiere a si el proyecto es nuevo o de arrastre</p>
    <p>Valores: NUEVO, ARRASTRE</p>
</div>

<div id="etpa" style="display:none">
    <h1>Etapa del Proyecto</h1><br>
    <p>Etapa en la que se halla el proyecto</p>
    <p>por ejemplo: POSTULACION, EJECUCION, CIERRE</p>
</div>

<div id="fase" style="display:none">
    <h1>Fase del Proyecto</h1><br>
    <p>Fase administrativa en la que se halla el proyecto</p>
    <p>por ejemplo: VALIDACION, PRIORIZADO</p>
</div>

<div id="lnea" style="display:none">
    <h1>Lineamiento de inversi&oacute;n</h1><br>
    <p>Línea de inversión del proyecto, valores determinados por la Senplades</p>
    <p>Hay valores como: “apalancamiento de la inversión para la econom&iacute;a popular y solidaria”, etc.</p>
</div>

<div id="sctr" style="display:none">
    <h1>Sector Econ&oacute;mico</h1><br>
    <p>Sector econ&oacute;mico que apoya o en el que inteviene el Proyecto</p>
    <p>Ejemplos: ADMINISTRATIVO; AGRICULTURA, GANADERIA Y PESCA; APOYO PRODUCTIVO; ASUNTOS DEL EXTERIOR; ASUNTOS INTERNOS; CULTURA; DEPORTES;</p>
</div>

<div id="sbst" style="display:none">
    <h1>Subsector Econ&oacute;mico</h1><br>
    <p>Sector econ&oacute;mico que apoya o en el que inteviene el Proyecto</p>
    <p>Ejemplos: ATENCI&Oacute;N ADOLECENTES J&Oacute;VENES; ATENCI&Oacute;N ADULTOS MAYORES; ATENCI&Oacute;N A DISCAPACITADOS; ATENCI&Oacute;N PRIMERA INFANCIA; DESARROLLO RURAL</p>
</div>

<div id="tpaq" style="display:none">
    <h1>Tipo de Adquisici&oacute;n</h1><br>
    <p>Distintos tipos de adquisiciones que se pueden hacer en el Proyecto</p>
    <p>Ejemplos: BIENES, BIENES Y SERVICIOS, SERVICIOS.</p>
</div>

<div id="tpgr" style="display:none">
    <h1>Tipo de Grupo de Atenci&oacute;n</h1><br>
    <p>Tipo de grupo de atenci&oacute;n prioritario seg&uacute;n se registra en la Senplades</p>
</div>

<div id="tpiv" style="display:none">
    <h1>Tipo de Inversi&oacute;n</h1><br>
    <p>Distintos tipos de inversión que se puede hacer en el Proyecto</p>
    <p>Ejemplos: ALIMENTACION, CAPACIDADES HUMANAS, CIENCIA Y TECNOLOGIA,...</p>
</div>

<div id="tppc" style="display:none">
    <h1>Tipo de Procedencia</h1><br>
    <p>Procedencia de los bienes y servicios a ser adquiridos en el Proyecto</p>
    <p>Ejemplos: NACIONAL e IMPORTADOS</p>
</div>

<div id="tppd" style="display:none">
    <h1>Tipo de Producto</h1><br>
    <p>Tipo de producto que se espera de resultado del proyecto</p>
    <p>puede ser: BIENES, BIENES Y SERVICIOS, SERVICIOS.</p>
</div>

<div id="tppt" style="display:none">
    <h1>Tipo de Participaci&oacute;n</h1><br>
    <p>Tipo de participación de una entidad en el proyecto</p>
    <p>puede ser: PATROCINADOR, VEEDOR, u OTROS.</p>
</div>


<div id="actv" style="display:none">
    <h1>Actividades de Gasto Corriente</h1><br>
    <p>Actividad de gasto corriente que no tiene relación con los proyectos, </p>
    <p>se refieren a las necesarias para establecer la proforma presupuestaria del a&ntilde;o</p>
</div>

<div id="anio" style="display:none">
    <h1>A&ntilde;o Fiscal</h1><br>
    <p>Año al cual corresponde el PAPP, cada año debe iniciarse una nueva gestión de proyectos.</p>
    <p>Es similar al período contable o año fiscal.</p>
</div>

<div id="ctrm" style="display:none">
    <h1>Cuatrimestre</h1><br>
    <p>Cuatrimestres para el registro de la asignación presupuestaria</p>
    <p>En base a los cuatrimestres se programa la ejecucui&oacute;n de las asignaciones</p>
</div>

<div id="fnte" style="display:none">
    <h1>Fuente de Finan-ciamiento</h1><br>
    <p>Fuente de financiamiento del proyecto, puede ser estado, préstamo a organismos internacionales, aporte propio, etc.</p>
</div>
<div id="prsp" style="display:none">
    <h2>Plan de cuentas Presupuestario</h2><br>
    <p>Plan de cuentas o de partidas presupuestarias conforme exista en el ESIGEF</p>
</div>
<div id="tpcp" style="display:none">
    <h1>Tipo de Compra o adquisici&oacute;n</h1><br>
    <p>Tipo de compra para el PAC, distingue entre bienes, servicios, etc.</p>
</div>

<div id="tpgs" style="display:none">
    <h1>Tipo de Gasto</h1><br>
    <p>Tipo de gasto: corriente y de inversión. Sirve para indicar si la asignación es para una actividad de gasto corriente
    o una actividad de inversión</p>
</div>


<div id="zona" style="display:none">
    <h1>Zona de Planificaci&oacute;n</h1><br>
    <p>Zona geogr&aacute;fica de planificaci&oacute;n </p>
    <p>de acuerdo a la distribuci&oacute;n geogr&aacute;fica determinada por el estado para organizar las inversiones</p>
</div>

<div id="regn" style="display:none">
    <h1>Regi&oacute;n</h1><br>
    <p>Regi&oacute;n geogr&aacute;fica del Ecuador </p>
    <p>Costa, Sierra, Oriente y regi&oacute;n Insular</p>
</div>

<div id="dstt" style="display:none">
    <h1>Distritos</h1><br>
    <p>Zona distrital de la geogr&aacute;fica del Ecuador</p>
    <p>de acuerdo a la distribuci&oacute;n determinada por el estado para organizar las inversiones</p>
</div>

<div id="geog" style="display:none">
    <h1>Divisi&oacute;n geogr&aacute;fica del Pa&iacute;s</h1><br>
    <p>Zonas, regiones, provincias, cantones y parroquias</p>
</div>
<div id="tpin" style="display:none">
    <h1>Tipo de Institución</h1><br>
    <p>Se aplica a las distintas entidades, instituciones y dependencias para diferenciarlas como:</p>
    <p>Direcciones, Programas, Coordinaciones Zonales, Entidades Adscritas, entidades externas, etc.</p>
</div>
<div id="pgps" style="display:none">
    <h2>Programa Presupuestario</h2><br>
    <p>Corresponde a la subdivisión de acuerdo al ESIGEF de la dependencia a la cual se carga el POA o PAPP</p>
</div>
<div id="obes" style="display:none">
    <h1>Objetivo Estratégico</h1><br>
    <p>Objetivo con los cuales pueden alinearse los proyectos</p>
</div>
<div id="obgr" style="display:none">
    <h1>Objetivo GPR</h1><br>
    <p>Objetivo del sistema de Gobierno por Resultados</p>
</div>
<div id="plas" style="display:none">
    <h1>Políticas de la Agenda Social</h1><br>
    <p>Políticas de la agenda social que pueden aplicarse a un proyecto</p>
</div>

</div>%{-- cierra el div de contenedor --}%

<script type="text/javascript">
    $(document).ready(function() {
        $('.item').hover(function() {
            //$('.item').click(function(){
            //entrar
            $('#tool').html($("#" + $(this).attr('texto')).html());
            $('#tool').show();
        }, function() {
            //sale
            $('#tool').hide('');

        });

        $('#info').tabs({
            //event: 'mouseover', fx: {
            cookie: { expires: 30 },
            event: 'click', fx: {
                opacity: 'toggle',
                duration: 'fast'
            },
            spinner: 'Cargando...',
            cache: true
        });
    });
</script>
</body>
</html>
