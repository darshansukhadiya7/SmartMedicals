<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="Connection.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection con = ConnectionProvider.getcon();
    HttpSession AdminUname = request.getSession(false);
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String uname = null;
    String pass1 = null;
    try
    {
        PreparedStatement stmt = con.prepareStatement("select * from admin where username = ? and password1 = ?");
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();
        if(rs.next())
        {
            uname = rs.getString("username");
            pass1 = rs.getString("password1");
            if(uname.equals(username) && pass1.equals(password))
            {
                AdminUname.setAttribute("username", username);
                response.sendRedirect("../alljsp/includes/dashboard.jsp");
            }
            else
            {
                response.sendRedirect("login.jsp?msg=invalid");
            }
        }
        else
        {
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
%>
