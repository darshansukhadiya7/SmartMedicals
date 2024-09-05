<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*, java.math.BigDecimal" %>
<%@ page import="java.io.*" %>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="getid.getAdminId" %>
<%@ page import="GenerateRandom.genRandomNumber" %>

<%
    // Fetch customer details
    String customerName = request.getParameter("cname");
    String doctorName = request.getParameter("dname");
    String contact = request.getParameter("contact");
    String address = request.getParameter("address");
    String date = request.getParameter("date");
    String paymentType = request.getParameter("ptype");

    // Fetch bill number with validation
    int billNo = 0;
    try 
    {
        billNo = Integer.parseInt(request.getParameter("billno"));
    } 
    catch (NumberFormatException e) 
    {
        out.println("Invalid bill number");
        return;
    }

    // Fetch medicine details
    String[] mid = request.getParameterValues("mid[]");
    String[] totalpack = request.getParameterValues("totalpack[]");
    String[] Medicinenames = request.getParameterValues("name[]");
    String[] packsizes = request.getParameterValues("packsize[]");
    String[] quantities = request.getParameterValues("quantity[]");
    String[] prices = request.getParameterValues("price[]");
    String[] totalPrices = request.getParameterValues("totalprice[]");
    String[] companyName = request.getParameterValues("companyname[]");
    String[] expiryDate = request.getParameterValues("expirydate[]");

    // Fetch billing total details
    double gtotal = Double.parseDouble(request.getParameter("grandTotal"));
    BigDecimal discountt = new BigDecimal(request.getParameter("discount"));
    double adtotal = Double.parseDouble(request.getParameter("discountedTotal"));

    Connection conn = null;
    PreparedStatement stmt1 = null;
    PreparedStatement stmt2 = null;
    PreparedStatement stmt3 = null;
    PreparedStatement stmt4 = null;
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
    else if ("0".equals(paymentType)) 
    {
        response.sendRedirect("../includes/makebill.jsp?msg=select");
    } 
    else 
    {
        try 
        {
            int cnt = 0;
            conn = ConnectionProvider.getcon();
            conn.setAutoCommit(false); // Start transaction
            // Add customer details
            String cusbillque = "insert into bill(bill_no,cusname,dname,address,date1,contactno,paymenttype,aname) values(?,?,?,?,?,?,?,?)";
            stmt1 = conn.prepareStatement(cusbillque);
            stmt1.setInt(1, billNo);
            stmt1.setString(2, customerName);
            stmt1.setString(3, doctorName.toUpperCase());
            stmt1.setString(4, address.toUpperCase());
            stmt1.setString(5, date);
            stmt1.setString(6, contact);
            stmt1.setString(7, paymentType);
            stmt1.setString(8, aname);
            stmt1.executeUpdate();

            // Add product details query
            String billdetailsque = "insert into bill_details(bdid,bill_no,mname,co_name,edate,pack_size,quantity,price,total_price) values(?,?,?,?,?,?,?,?,?)";
            stmt2 = conn.prepareStatement(billdetailsque);
            
            // Update qty query
            String updateqtyque = "update medicine set totalpack = ? where mid = ?";
            stmt4 = conn.prepareStatement(updateqtyque);
            
            for (int i = 0; i < Medicinenames.length; i++) 
            {
                long totalpackqty = Long.parseLong(totalpack[i]);
                long qty = Long.parseLong(quantities[i]);
                int id = Integer.parseInt(mid[i]);
                long updateqty = totalpackqty - qty;
                
                stmt2.setInt(1, genRandomNumber.genRanNumber());
                stmt2.setInt(2, billNo);
                stmt2.setString(3, Medicinenames[i]);
                stmt2.setString(4, companyName[i]);
                stmt2.setString(5, expiryDate[i]);
                stmt2.setString(6, packsizes[i]);
                stmt2.setString(7, quantities[i]);
                stmt2.setString(8, prices[i]);
                stmt2.setString(9, totalPrices[i]);
                
                // Update qty in db
                stmt4.setLong(1, updateqty);
                stmt4.setInt(2, id);
                stmt4.executeUpdate();
                
                // Add bill details in db
                stmt2.executeUpdate();
            }

            // Add total details
            String queaddtotal = "insert into bill_total_details(btd,bill_no,total,discount,afterdtotal) values(?,?,?,?,?)";
            stmt3 = conn.prepareStatement(queaddtotal);
            stmt3.setInt(1, genRandomNumber.genRanNumber());
            stmt3.setInt(2, billNo);
            stmt3.setDouble(3, gtotal);
            stmt3.setBigDecimal(4, discountt.setScale(3, BigDecimal.ROUND_HALF_UP)); // Ensure correct scale and rounding
            stmt3.setDouble(5, adtotal);
            cnt = stmt3.executeUpdate();

            if (cnt > 0) 
            {
                conn.commit();  // Commit transaction if all is successful
                response.sendRedirect("../includes/invoice.jsp?i="+billNo); 
            } 
            else 
            {
                conn.rollback(); // Rollback transaction if insert into bill_total_details fails
                response.sendRedirect("../includes/makebill.jsp?msg=notadd");
            }
        } 
        catch (Exception e) 
        {
            conn.rollback(); // Rollback transaction in case of exception
            out.println("<p>Error inserting data: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } 
        finally 
        {
            try 
            {
                if (conn != null) conn.setAutoCommit(true); // Reset auto-commit to true
                if (conn != null) conn.close();
            } 
            catch (SQLException e1) 
            {
                e1.printStackTrace();
            }
        }
    }
%>
