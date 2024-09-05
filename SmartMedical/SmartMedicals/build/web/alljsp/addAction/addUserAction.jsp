<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@page import="GenerateRandom.genRandomNumber" %>
<%@page import="getid.getAdminId" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.ZoneId" %>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<% 
    
    Connection conn = null;
    PreparedStatement stmt = null;
    int rs = 0;
    LocalDate ld = LocalDate.now();
    java.sql.Date sqlDate = java.sql.Date.valueOf(ld);
    String username = request.getParameter("username");
    String password = request.getParameter("pass");
    String special = request.getParameter("special");
    if(getAdminId.checkAdminExist(username) == 0)
    {
        try
        {
            conn = ConnectionProvider.getcon();
            String que = "insert into admin(aid,username,password1,date1,special) values(?,?,?,?,?)";
            stmt = conn.prepareStatement(que);
            stmt.setInt(1, genRandomNumber.genRanNumber());
            stmt.setString(2, username);
            stmt.setString(3, password);
            stmt.setDate(4, sqlDate);
            stmt.setString(5, special);
            rs = stmt.executeUpdate();
            if(rs > 0)
            {
                response.sendRedirect("../includes/adduser.jsp?msg=added");
            }
            else
            {
                response.sendRedirect("../includes/adduser.jsp?msg=notadded");
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    else
    {
        response.sendRedirect("../includes/adduser.jsp?msg=exist");
    }
    
%>
