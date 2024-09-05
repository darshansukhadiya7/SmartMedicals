<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.ZoneId" %>

<%
    int id = Integer.parseInt(request.getParameter("mid"));
    int qtyava = Integer.parseInt(request.getParameter("qtyava"));
    int qty = Integer.parseInt(request.getParameter("qty"));
    String edateget = request.getParameter("edate");
    int totalQty = qtyava + qty; 
    Date edate = null;
    if (edateget != null && !edateget.isEmpty())
    {
        edate = Date.valueOf(edateget);
    }
    try
    {
        Connection con = ConnectionProvider.getcon();
        String que = "update medicine set totalpack=?, edate=? where mid=?";
        PreparedStatement stmt = con.prepareStatement(que);
        stmt.setInt(1, totalQty);
        stmt.setDate(2, edate);
        stmt.setInt(3, id);
        int a = stmt.executeUpdate();
        if(a>0)
        {
            response.sendRedirect("../includes/editQty.jsp?msg=added&id="+id);
        }
        else
        {
            response.sendRedirect("../includes/editQty.jsp?msg=notadded&id="+id);
        }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
%>