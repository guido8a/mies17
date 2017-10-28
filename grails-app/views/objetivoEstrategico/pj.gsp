<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Pj</title>
    <style type="text/css">
    td{
        height: ${(ancho/filas.size().toFloat().round(0))}px;
        border: 1px solid black;
        background-color: #79c9ec;
    }
    .p1{
        background: url("${resource(dir: 'images', file: 'token1.jpg')}")
    }
    .p2{
        background: url("${resource(dir: 'images', file: 'token2.jpg')}")
    }
    </style>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.6.2.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.16.custom.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/start', file: 'jquery-ui-1.8.16.custom.css')}"/>
</head>
<body>

<table width="${ancho}px" border="1">
    <tbody>
    <g:each in="${filas}" status="i" var="fila">
        <tr class="${i+1}">
            <g:each in="${filas}" status="k" var="col">
                <td class="vacio" fila="${i+1}" col="${k+1}"></td>
            </g:each>
        </tr>
    </g:each>
    </tbody>
</table>


</body>
<script type="text/javascript">
    $(function() {
        var pj = 1
        $(".vacio").css("cursor","pointer")
        $(".vacio").click(function(){
            if(pj==1){
                $(this).addClass("p1")
                $(this).removeClass("vacio")
                var col= $(this).attr("col")*1
                var band = false
                $.each($(this).parent().find("td"),function(){
                    if($(this).attr("col")*1<col-1){
                        if($(this).hasClass("p1")){
                            band=true
                        }else{
                            if(band){
                                $(this).removeClass("p2")
                                $(this).addClass("p1")
                            }

                        }
                    }
//                    //console.log($(this).attr("col"))
                });
                if(!band){
                    $.each($(this).parent().find("td").reverse(),function(){
                        if($(this).attr("col")*1>col+1){
                            if($(this).hasClass("p1")){
                                band=true
                            }else{
                                if(band){
                                    $(this).removeClass("p2")
                                    $(this).addClass("p1")
                                }

                            }
                        }
//                    //console.log($(this).attr("col"))
                    });
                }
                pj=2
            }else{
                $(this).addClass("p2")
                $(this).removeClass("vacio")
                var col= $(this).attr("col")*1
                var band = false
                $.each($(this).parent().find("td"),function(){
                    if($(this).attr("col")*1<col-1){
                        if($(this).hasClass("p2")){
                            band=true
                        }else{
                            if(band){
                                $(this).removeClass("p1")
                                $(this).addClass("p2")
                            }

                        }
                    }
//                    //console.log($(this).attr("col"))
                });
                if(!band){
                    $.each($(this).parent().find("td").reverse(),function(){
                        if($(this).attr("col")*1>col+1){
                            if($(this).hasClass("p2")){
                                band=true
                            }else{
                                if(band){
                                    $(this).removeClass("p1")
                                    $(this).addClass("p2")
                                }

                            }
                        }
//                    //console.log($(this).attr("col"))
                    });
                }
                pj=1
            }
        });
    });

    function nodo() {
        this.valor = 0;
        this.izq = new nodo();
        this.der = new nodo();
    }

</script>
</html>