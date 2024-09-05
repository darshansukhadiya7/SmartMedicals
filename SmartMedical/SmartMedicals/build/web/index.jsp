<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Smart Medicals</title>
    </head>
    <body>
        <%
            boolean b = true;
            if(b)
            {
                response.sendRedirect("Authentication/login.jsp");
            }
        %>
    </body>
</html>
