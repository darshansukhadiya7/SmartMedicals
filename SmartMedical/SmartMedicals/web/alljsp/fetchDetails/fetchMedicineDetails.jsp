<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.io.*" %>
<%@page import="java.util.*" %>
<%
    String term = request.getParameter("term");
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Map<String, String>> medicines = new ArrayList<>();
    try
    {
        conn = ConnectionProvider.getcon();
        String query = "SELECT m.mname, m.mid, co.co_name, co.co_batchno, m.packsize, m.totalpack, m.selling_price, m.edate, m.priceperqty "
                     + "FROM medicine m "
                     + "JOIN category cat ON m.cat_id = cat.cat_id "
                     + "JOIN company co ON cat.co_id = co.co_id "
                     + "WHERE CONCAT(m.mname, ' ', co.co_name, ' ', co.co_batchno) LIKE ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, "%" + term + "%");
        rs = pst.executeQuery();
        
        while (rs.next()) 
        {
            Map<String, String> medicine = new HashMap<>();
            medicine.put("name", rs.getString("mname"));
            medicine.put("company_name", rs.getString("co_name"));
            medicine.put("batch_no", rs.getString("co_batchno"));
            medicine.put("packsize", rs.getString("packsize"));
            medicine.put("price", rs.getString("selling_price"));
            medicine.put("expirydate", rs.getString("edate"));
            medicine.put("mid", rs.getString("mid"));
            medicine.put("priceperqty", rs.getString("priceperqty"));
            medicine.put("totalpack", rs.getString("totalpack"));
            medicines.add(medicine);
        }
        
        String json = new Gson().toJson(medicines);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    catch(Exception e)
    {
        e.printStackTrace();
        response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
    }
    finally 
    {
        try 
        {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }
        catch(SQLException e1)
        {
            e1.printStackTrace();
        }
    }
%>
