<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="fetchData.fetchCountProduct" %>
<%@page import="fetchData.fetchCountSoldProduct" %>
<%@page import="fetchData.fetchTotalCustomer" %>
<%@page import="fetchData.fetchNetProfit" %>
<%@page import="Connection.ConnectionProvider" %>
<%
    String codPercentage = "";
    String onlinePercentage = "";
    String chequePercentage = "";
    String codCount = "";
    String onlineCount = "";
    String chequeCount = ""; 
    
    Connection conn = ConnectionProvider.getcon();
    String quefpo = "select paymenttype, (count(*) * 100.0 / (select count(*) from bill)) as per, count(*) as counti from bill group by paymenttype";
    PreparedStatement stmtfpo = conn.prepareStatement(quefpo);
    ResultSet rsfpo = stmtfpo.executeQuery();
    
    while(rsfpo.next()) 
    {
        String paymenttype = rsfpo.getString("paymenttype");
        int cou = rsfpo.getInt("counti");
        double percentage = rsfpo.getDouble("per");
        int roundedPercentage = (int) Math.round(percentage);  // Round and convert to int

        if ("cash".equalsIgnoreCase(paymenttype)) {
            codPercentage = String.valueOf(roundedPercentage);
            codCount = String.valueOf(cou);
        } else if ("online".equalsIgnoreCase(paymenttype)) {
            onlinePercentage = String.valueOf(roundedPercentage);
            onlineCount = String.valueOf(cou);
        } else if ("cheque".equalsIgnoreCase(paymenttype)) {
            chequePercentage = String.valueOf(roundedPercentage);
            chequeCount = String.valueOf(cou);
        }
    }
%>

<% 
   String que5 = "SELECT b.cusname, b.address, b.contactno, b.paymenttype, b.aname, bd.afterdtotal " +
              "FROM bill b " +
              "JOIN bill_total_details bd ON b.bill_no = bd.bill_no " +
              "WHERE STR_TO_DATE(b.date1, '%d/%m/%Y') = CURDATE() " +
              "LIMIT 5";
    PreparedStatement stmt5 = conn.prepareStatement(que5);
    ResultSet rs5 = stmt5.executeQuery();
%>

<% 
    String que6 = "select username,special from admin";
    PreparedStatement stmt6 = conn.prepareStatement(que6);
    ResultSet rs6 = stmt6.executeQuery();
%>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>
        <div class="content-body">

            <div class="container-fluid mt-3">
                <div class="row">
                    <div class="col-lg-3 col-sm-6">
                        <div class="card gradient-1">
                            <div class="card-body">
                                <h3 class="card-title text-white">Available Products</h3>
                                <div class="d-inline-block">
                                    <h2 class="text-white"><%= fetchCountProduct.getTotalProducts() %></h2>
                                </div>
                                <span class="float-right display-5 opacity-5"><i class="fa fa-shopping-cart"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card gradient-2">
                            <div class="card-body">
                                <h3 class="card-title text-white">Sold Products</h3>
                                <div class="d-inline-block">
                                    <h2 class="text-white"><%= fetchCountSoldProduct.getSoldProducts() %></h2>
                               
                                </div>
                                <span class="float-right display-5 opacity-5"><i class="fa fa-shopping-cart"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card gradient-4">
                            <div class="card-body">
                                <h3 class="card-title text-white">Net Profit</h3>
                                <div class="d-inline-block">
                                    <h2 class="text-white">₹<%= fetchNetProfit.getNetProfit() %></h2>
                                    
                                </div>
                                <span class="float-right display-5 opacity-5"><i class="fa fa-money"></i></span>
                            </div>
                        </div>
                    </div>                                    
                    <div class="col-lg-3 col-sm-6">
                        <div class="card gradient-3">
                            <div class="card-body">
                                <h3 class="card-title text-white">Total Customers</h3>
                                <div class="d-inline-block">
                                    <h2 class="text-white"><%= fetchTotalCustomer.getTotalCustomer() %></h2>
                                    
                                </div>
                                <span class="float-right display-5 opacity-5"><i class="fa fa-users"></i></span>
                            </div>
                        </div>
                    </div>
                </div>


                

                <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="card card-widget">
                                <div class="card-body">
                                    <h5 class="text-muted">Payment Overview</h5>
                                    <h2 class="mt-4">₹<%= fetchNetProfit.getNetProfit() %></h2>
                                    <span>Total Revenue</span>
                                    <div class="mt-4">
                                        <h4><%= codCount != null ? codCount : "0" %></h4>
                                        <h6>Cash <span class="pull-right"><%= codPercentage != null ? codPercentage : "0" %>%</span></h6>
                                        <div class="progress mb-3" style="height: 7px">
                                            <div class="progress-bar bg-primary" style="width: 30%;" role="progressbar"><span class="sr-only"><%= codPercentage %></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-4">
                                        <h4><%= onlineCount != null ? onlineCount : "0" %></h4>
                                        <h6 class="m-t-10 text-muted">Online <span class="pull-right"><%= onlinePercentage != null ? onlinePercentage : "0" %>%</span></h6>
                                        <div class="progress mb-3" style="height: 7px">
                                            <div class="progress-bar bg-success" style="width: 50%;" role="progressbar"><span class="sr-only"><%= onlinePercentage %></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-4">
                                        <h4><%= chequeCount != null ? chequeCount : "0" %></h4>
                                        <h6 class="m-t-10 text-muted">Cheque <span class="pull-right"><%= chequePercentage != null ? chequePercentage : "0" %>%</span></h6>
                                        <div class="progress mb-3" style="height: 7px">
                                            <div class="progress-bar bg-warning" style="width: 20%;" role="progressbar"><span class="sr-only"><%= chequePercentage %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <div class="col-lg-9 col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="active-member">
                                    <div class="table-responsive">
                                        <table class="table table-xs mb-0">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Customer</th>
                                                    <th>City</th>
                                                    <th>Payment Type</th>
                                                    <th>Phone No.</th>
                                                    <th>Total</th>
                                                    <th>Admin Name</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% int cnt = 0; while(rs5.next()) { %>
                                                <tr>
                                                    <td><%= ++cnt %></td>
                                                    <td><%= rs5.getString("cusname") %></td>
                                                    <td><%= rs5.getString("address") %></td>
                                                    <td>
                                                        <span><%= rs5.getString("paymenttype") %></span>
                                                    </td>
                                                    <td>
                                                        <%= rs5.getString("contactno") %>
                                                    </td>
                                                    <td><%= rs5.getString("afterdtotal") %></td>
                                                    <td><%= rs5.getString("aname") %></td>
                                                </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>               
                    </div>
                </div>
                <div class="row">
                    <% while(rs6.next()) { 
                        String special = rs6.getString("special");
                        if("Y".equals(special)) { special = "Admin"; }
                        else { special = "User"; }
                    %>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="text-center">
                                    
                                    <h5 class="mt-3 mb-1"><%= rs6.getString("username") %></h5>
                                    <p class="m-0"><%= special %></p>
                                    <!-- <a href="javascript:void()" class="btn btn-sm btn-warning">Send Message</a> -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                                 
                    </div>
                </div>
            </div>

        </div>
      <%@ include file="footer.jsp" %>