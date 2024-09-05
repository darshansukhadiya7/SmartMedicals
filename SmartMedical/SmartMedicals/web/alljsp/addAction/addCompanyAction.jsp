<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.ZoneId" %>
<%@page import="GenerateRandom.genRandomNumber" %>
<%@page import="getid.getAdminId" %>

<%!
    public static final int UNIQUE_CONSTRAINT_CONAME = -1;
    public static final int UNIQUE_CONSTRAINT_COBNO = -2;
    
    public static int addCompany(String coname, String cobno, String copno, String coemail, String aname) 
    {
        LocalDate ld = LocalDate.now();
        java.sql.Date sqlDate = java.sql.Date.valueOf(ld);
        int result = 0;
        Connection con = null;
        PreparedStatement stmt = null;

        try 
        {
            con = ConnectionProvider.getcon();
            String que = "insert into company(co_id, co_name, co_batchno, co_phoneno, co_email, added_date, update_date, aname) values(?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(que);
            stmt.setInt(1, genRandomNumber.genRanNumber());
            stmt.setString(2, coname);
            stmt.setString(3, cobno);
            stmt.setString(4, copno);
            stmt.setString(5, coemail);
            stmt.setDate(6, sqlDate);
            stmt.setDate(7, sqlDate);
            stmt.setString(8, aname);
            result = stmt.executeUpdate();
        }
        catch(SQLIntegrityConstraintViolationException e)
        {
            String errormsg = e.getMessage();
            if(errormsg.contains("co_name"))
            {
                result = UNIQUE_CONSTRAINT_CONAME;
            }
            if(errormsg.contains("co_batchno"))
            {
                result = UNIQUE_CONSTRAINT_COBNO;
            }
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        } 
        return result;
    }
%>

<%
    HttpSession AdminUname = request.getSession(false);
    String aname = null;
    if (AdminUname != null) 
    {
        aname = (String) AdminUname.getAttribute("username");
    }

    if (aname == null) 
    {
        response.sendRedirect("./Authentication/login.jsp?msg=sessionExpired");
    } 
    else 
    {
        try 
        {
            String coname = request.getParameter("cname");
            String cobno = request.getParameter("cbno");
            String copno = request.getParameter("cphno");
            String coemail = request.getParameter("cemail");

            int a = addCompany(coname, cobno, copno, coemail, aname);
            if (a == UNIQUE_CONSTRAINT_CONAME) 
            {
                response.sendRedirect("../includes/addcompany.jsp?msg=conameexists");
            } 
            else if (a == UNIQUE_CONSTRAINT_COBNO) 
            {
                response.sendRedirect("../includes/addcompany.jsp?msg=cobnoexists");
            } 
            else if (a > 0) 
            {
                response.sendRedirect("../includes/addcompany.jsp?msg=added");
            } 
            else 
            {
                response.sendRedirect("../includes/addcompany.jsp?msg=notadded");
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
