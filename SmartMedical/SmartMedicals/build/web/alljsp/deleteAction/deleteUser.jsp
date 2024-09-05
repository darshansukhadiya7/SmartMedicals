<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<% 
    int aid = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement stmt = null;
    int du = 0;
    try
    {
        conn = ConnectionProvider.getcon();
        String que = "delete from admin where aid="+aid;
        stmt = conn.prepareStatement(que);
        du = stmt.executeUpdate();
        if(du > 0)
        {
            response.sendRedirect("../includes/viewuser.jsp?msg=d");
        }
        else
        {
            response.sendRedirect("../includes/viewuser.jsp?msg=nd");
        }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
%>
