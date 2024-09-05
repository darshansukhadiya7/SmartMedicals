<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.ZoneId" %>
<%@page import="GenerateRandom.genRandomNumber" %>
<%@page import="getid.getAdminId" %>
<%@ page import="javax.naming.InitialContext" %>
<%!
    public static final int UNIQUE_CONSTRAINT_CATNAME = -1;

    public static int checkCatExist(int co_id,String cat_name)
    {
        int result = 5;
        try
        {
            String c = "select * from category where co_id = ? and cat_name = ?";
            Connection con1 = ConnectionProvider.getcon();
            PreparedStatement stmt1 = con1.prepareStatement(c);
            stmt1.setInt(1, co_id);
            stmt1.setString(2, cat_name);
            ResultSet rs1 = stmt1.executeQuery();
            if(rs1.next())
            {
                result = 1;
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return result;
    }
    
    public static int addCategory(String cat_name,int co_id,String aname) 
    {
        LocalDate ld = LocalDate.now();
        java.sql.Date sqlDate = java.sql.Date.valueOf(ld);
        int result = 0;
        Connection con = null;
        PreparedStatement stmt = null;
        try 
        {
            con = ConnectionProvider.getcon();
            String que = "insert into category(cat_id, cat_name, added_date, update_date, co_id, aname) values(?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(que);
            stmt.setInt(1, genRandomNumber.genRanNumber());
            stmt.setString(2, cat_name);
            stmt.setDate(3, sqlDate);
            stmt.setDate(4, sqlDate);
            stmt.setInt(5, co_id);
            stmt.setString(6, aname);
            result = stmt.executeUpdate();
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
        response.sendRedirect("../../Authentication/login.jsp?msg=sessionExpired");
    } 
    else 
    {
        try 
        {   
            String catname = request.getParameter("catname");
            int coid = Integer.parseInt(request.getParameter("cmid"));
            if(coid == 0)
            {
                response.sendRedirect("../includes/addcategory.jsp?msg=select");
            }
            else
            {
                int check = checkCatExist(coid,catname);
                out.println(check);
                if(check == 1)
                {
                    response.sendRedirect("../includes/addcategory.jsp?msg=catnameexists");
                }
                else
                {
                    int a = addCategory(catname, coid, aname);
                    if (a > 0) 
                    {
                        response.sendRedirect("../includes/addcategory.jsp?msg=added");
                    } 
                    else 
                    {
                        response.sendRedirect("../includes/addcategory.jsp?msg=notadded");
                    }
                }
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }
%>