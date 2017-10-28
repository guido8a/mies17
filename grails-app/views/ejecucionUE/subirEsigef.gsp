<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Subir archivo de ESIGEF</title>
    <style type="text/css">
    th {
        background: #ddd;
        vertical-align: middle;
        text-align: center;
    }
    </style>

</head>

<body>
<div style="width: 1020px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <g:form name="frmUpload" enctype="multipart/form-data" method="post" action="subirArchivo">
        <div class="container ui-corner-all" style="min-height: 500px; width: 1020px;">

            <br/>
            Unidad Ejecutora:<g:select class="field ui-widget-content ui-corner-all" name="unidad"
                      title="Unidad Ejecutora" from="${mies.UnidadEjecutora.list([sort: 'nombre'])}" optionKey="id"
                      value="" noSelection="['null': 'Seleccione una Unidad Ejecutora']" style="width: 400px;" />
            &nbsp;&nbsp;
            Año:<g:select class="field ui-widget-content ui-corner-all" name="anio"
                      title="Año" from="${mies.Anio.list()}" optionKey="id"
                      value="${mies.Anio.findByAnio(new Date().format("yyyy"))}"  style="width: 80px;" />
            &nbsp;&nbsp;
            Fuente:<g:select class="field ui-widget-content ui-corner-all" name="fuente"
                          title="Fuente de financiamiento" from="${mies.Fuente.list()}" optionKey="id"
                          value="${mies.Fuente.findByCodigo('001')}"  style="width: 300px;" />
            <br/><br/>
            <div style="background: #eee; padding: 10px; ">
            1. Seleccione la Unidad Ejecutora, el Año y la Fuente de financiamiento<br/><br/>
            2. Cargado de archivo del ESIGEF para cuadrar valores y generar avances.
            Los pasos a seguir para la generación del archivo del eSIGEF son:
            <ul>
                <li>Ingresar al eSIGEF con su usuario y contraseña</li>
                <li>Seleccionar la opción de menú:</li>
                <ul>
                    <li>Ejecución de Gastos -> Reportes -> Información Consolidada -> Ejecución del Presupuesto (Grupos dinámicos)</li>
                </ul>
                <li>Desde la pantalla que aprece, ingrese:</li>
                <lu>
                    <li> Ingrese el número de la Entidad Institucional y la Unidad Ejecutora</li>
                </lu>
            </ul>
            <img src="${resource(dir: 'esigef', file: 'cuadro1.jpeg')}" alt="Valores de Filtrado" border="1px;" style="margin-left: 40px;">
            <lu>
                <li> Sefina la estuctura del reporte como:</li>
            </lu>
            <img src="${resource(dir: 'esigef', file: 'cuadro2.jpeg')}" alt="Valores de Filtrado" border="1px;" style="margin-left: 40px;">
            <lu>
                <li> Seleccione el mes de cierre y en el formato de reporte escoja "Archivo CSV (Excel)</li>
                <li>Finalmente, genere el archivo u guardelo con un nombre, este deberá luego localizarlo para subir al sistema.</li>
            </lu>



            </div><br/><br/>

            Archivo CSV: <input type="file" class="ui-corner-all" name="file" id="file" size="70"/>



            <a href="#" id="btnUpload">Subir el Archivo y Comparar Valores</a>

        </div>
    </g:form>
</div>
<script type="text/javascript">
    $(function () {
        $("#btnUpload").button().click(function () {
            $("#frmUpload").submit();
        });
    });
</script>

</body>
</html>