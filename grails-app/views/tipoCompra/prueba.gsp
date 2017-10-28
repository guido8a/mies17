<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style type="text/css">
    @page {
        size: A4;  /* width height */
        margin: 0.25in;
    }
    </style>
    <title>Simple GSP page</title>
</head>
<body>

    <table style="width:19cm"  border="1">
        <g:each in="${1..50}" status="i" var="k">
            <tr>
                <g:each in="${1..10}" status="j" var="l">
                    <td>${i} ${j}</td>
                    </g:each>
            </tr>
        </g:each>
    </table>

</body>
</html>