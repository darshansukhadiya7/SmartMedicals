<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.ZoneId" %>
<%@page import="GenerateRandom.genRandomNumber" %>
<%@page import="getid.getAdminId" %>
<%@page import="java.math.BigDecimal" %>

<%!
    public static final int UNIQUE_CONSTRAINT_CATNAME = -1;

    public static int checkMedExist(int cat_id, String mname) 
    {
        int result = 5;
        try 
        {
            String c = "select * from medicine where cat_id = ? and mname = ?";
            Connection con1 = ConnectionProvider.getcon();
            PreparedStatement stmt1 = con1.prepareStatement(c);
            stmt1.setInt(1, cat_id);
            stmt1.setString(2, mname);
            ResultSet rs1 = stmt1.executeQuery();
            if (rs1.next()) 
            {
                result = 1;
            }
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
        return result;
    }

    public static int addMedicine(String mname, long packsize, long totalpack, BigDecimal ppp, BigDecimal discount, java.sql.Date edate, int catid, String aname, BigDecimal totalprice, BigDecimal qtyprice, BigDecimal discountinrs, BigDecimal sprice, int maxqty) 
    {
        LocalDate ld = LocalDate.now();
        java.sql.Date sqlDate = java.sql.Date.valueOf(ld);
        int result = 0;
        Connection con = null;
        PreparedStatement stmt = null;
        try 
        {
            con = ConnectionProvider.getcon();
            // Start transaction
            con.setAutoCommit(false);

            String que = "insert into medicine(mid, mname, packsize, totalpack, priceperpack, selling_price, discount, priceperqty, discountinrs, totalprice, edate, added_date, cat_id, aname, maxqty) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(que);
            stmt.setInt(1, genRandomNumber.genRanNumber());
            stmt.setString(2, mname);
            stmt.setLong(3, packsize);
            stmt.setLong(4, totalpack);
            stmt.setBigDecimal(5, ppp);
            stmt.setBigDecimal(6, sprice);
            stmt.setBigDecimal(7, discount);
            stmt.setBigDecimal(8, qtyprice);
            stmt.setBigDecimal(9, discountinrs);
            stmt.setBigDecimal(10, totalprice);
            stmt.setDate(11, edate);
            stmt.setDate(12, sqlDate);
            stmt.setInt(13, catid);
            stmt.setString(14, aname);
            stmt.setInt(15, maxqty);
            result = stmt.executeUpdate();

            // Commit transaction if successful
            con.commit();
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
            if (con != null) 
            {
                try 
                {
                    con.rollback();
                } 
                catch (SQLException ex) 
                {
                    ex.printStackTrace();
                }
            }
        } 
        finally 
        {
            try 
            {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } 
            catch (SQLException ex) 
            {
                ex.printStackTrace();
            }
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
            String catidStr = request.getParameter("catid");
            String mname = request.getParameter("mname");
            String packsizeStr = request.getParameter("packsize");
            String totalpackStr = request.getParameter("totalpack");
            String priceperpackStr = request.getParameter("pricepack");
            String priceqtyStr = request.getParameter("qtyprice");
            String discountinrsStr = request.getParameter("distinr");
            String totalpriceStr = request.getParameter("totalprice");
            String discountStr = request.getParameter("disc");
            String edateget = request.getParameter("edate");
            String spriceget = request.getParameter("sprice");
            int maxqty = Integer.parseInt(request.getParameter("maxqty"));

            int catid = catidStr != null && !catidStr.isEmpty() ? Integer.parseInt(catidStr) : 0;
            long packsize = packsizeStr != null && !packsizeStr.isEmpty() ? Long.parseLong(packsizeStr) : 0;
            long totalpack = totalpackStr != null && !totalpackStr.isEmpty() ? Long.parseLong(totalpackStr) : 0;

            BigDecimal discount = discountStr != null && !discountStr.isEmpty() ? new BigDecimal(discountStr) : BigDecimal.ZERO;
            BigDecimal priceperpack = priceperpackStr != null && !priceperpackStr.isEmpty() ? new BigDecimal(priceperpackStr) : BigDecimal.ZERO;
            BigDecimal sprice = spriceget != null && !spriceget.isEmpty() ? new BigDecimal(spriceget) : BigDecimal.ZERO;
            BigDecimal priceqty = priceqtyStr != null && !priceqtyStr.isEmpty() ? new BigDecimal(priceqtyStr) : BigDecimal.ZERO;
            BigDecimal discountinrs = discountinrsStr != null && !discountinrsStr.isEmpty() ? new BigDecimal(discountinrsStr) : BigDecimal.ZERO;
            BigDecimal totalprice = totalpriceStr != null && !totalpriceStr.isEmpty() ? new BigDecimal(totalpriceStr) : BigDecimal.ZERO;

            Date edate = null;
            if (edateget != null && !edateget.isEmpty()) 
            {
                edate = Date.valueOf(edateget);
            }
            if (catid == 0) 
            {
                response.sendRedirect("../includes/addmedicine.jsp?msg=select");
            } 
            else 
            {
                int check = checkMedExist(catid, mname);
                if (check == 1) 
                {
                    response.sendRedirect("../includes/addmedicine.jsp?msg=mednameexists");
                } 
                else 
                {
                    int a = addMedicine(mname, packsize, totalpack, priceperpack, discount, edate, catid, aname, totalprice, priceqty, discountinrs, sprice, maxqty);
                    if (a > 0) 
                    {
                        response.sendRedirect("../includes/addmedicine.jsp?msg=added");
                    } 
                    else 
                    {
                        response.sendRedirect("../includes/addmedicine.jsp?msg=notadded");
                    }
                }
            }
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
%>
