<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="Connection.ConnectionProvider" %>
<% 
    int id = Integer.parseInt(request.getParameter("i"));

    Connection conn = ConnectionProvider.getcon();
    String quefc = "select b.cusname, b.dname, b.address, b.date1, b.contactno, b.paymenttype, bo.total, bo.discount, bo.afterdtotal "
            + "from bill b join bill_total_details bo on b.bill_no = bo.bill_no where b.bill_no ="+id;
    PreparedStatement stmtfc = conn.prepareStatement(quefc);
    ResultSet rsfc = stmtfc.executeQuery();
    String cusname = null;
    String dname = null;
    String address = null;
    String date1 = null;
    String cno = null;
    String paymenttype = null;
    String total = null;
    String discount = null;
    String adt = null;
    int cnt = 0;
    while(rsfc.next()) {
        cusname = rsfc.getString("cusname");
        dname = rsfc.getString("dname");
        address = rsfc.getString("address");
        date1 = rsfc.getString("date1");
        cno = rsfc.getString("contactno");
        paymenttype = rsfc.getString("paymenttype");
        total = rsfc.getString("total");
        discount = rsfc.getString("discount");
        adt = rsfc.getString("afterdtotal");
    }

    String quefp = "select bd.mname, bd.co_name, bd.edate, bd.pack_size, bd.quantity, bd.price, bd.total_price "
            + "from bill_details bd where bd.bill_no="+id;
    PreparedStatement stmtfp = conn.prepareStatement(quefp);
    ResultSet rsfp = stmtfp.executeQuery();
%>
<!DOCTYPE html>
<html lang="zxx">
<head>   
    <title>Smart Medicals</title>
<link href="../CSS/css/invoicestyle.css" rel="stylesheet">
<link rel="shortcut icon" href="../CSS/images/favicon.png" type="image/x-icon" >
<!-- Google fonts -->
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="invoice-6 invoice-content">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="invoice-inner clearfix">
                    <div class="invoice-info clearfix" id="invoice_wrapper">
                        <div class="invoice-headar">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="invoice-logo">
                                        <!-- logo started -->
                                        <div class="logo">
                                            <img src="../CSS/images/logos/logo.png" alt="logo">
                                        </div>
                                        <!-- logo ended -->
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="invoice-contact-us">
                                        <h1>Contact Us</h1>
                                        <ul class="link">
                                            <li>
                                                <i class="fa fa-map-marker"></i> 169 Teroghoria, Bangladesh
                                            </li>
                                            <li>
                                                <i class="fa fa-envelope"></i> <a href="mailto:sales@hotelempire.com">info@themevessel.com</a>
                                            </li>
                                            <li>
                                                <i class="fa fa-phone"></i> <a href="tel:+55-417-634-7071">+00 123 647 840</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="invoice-contant">
                            <div class="invoice-top">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <h1 class="invoice-name">Invoice</h1>
                                    </div>
                                    <div class="col-sm-6 mb-30">
                                        <div class="invoice-number-inner">
                                            <h2 class="name">Invoice No: #<%= id %></h2>
                                            <p class="mb-0">Invoice Date: <span><%= date1 %></span></p>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-30">
                                        <div class="invoice-number">
                                            <h4 class="inv-title-1">Invoice To</h4>
                                            <h2 class="name mb-10"><%= cusname %></h2>
                                            <p class="invo-addr-1 mb-0">
                                                Dr. Name : <%= dname %> <br/>
                                                Contact : <%= cno %><br/>
                                                Address : <%= address %> <br/>
                                                
                                            </p>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="invoice-center">
                                <div class="order-summary">
                                    <div class="table-outer">
                                        <table class="default-table invoice-table">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Medicine Name</th>
                                                    <th>Expiry Date</th>
                                                    <th>Qty.</th>
                                                    <th>Price</th>
                                                    <th>Total Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% while(rsfp.next()) { %>
                                                <tr>
                                                    <td><%= ++cnt %></td>
                                                    <td><%= rsfp.getString("mname") %> - <%= rsfp.getString("co_name") %></td>
                                                    <td><%= rsfp.getString("edate") %></td>
                                                    <td><%= rsfp.getString("quantity") %></td>
                                                    <td>₹<%= rsfp.getString("price") %></td>
                                                    <td>₹<%= rsfp.getString("total_price") %></td>
                                                </tr>
                                                <% } %>
                                                <tr>
                                                    <td style="text-align: center;" colspan="3"><strong>Total</strong></td>
                                                    <td colspan="2"></td>
                                                    <td><strong>₹<%= total %></strong></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;" colspan="3"><strong>Discount</strong></td>
                                                    <td colspan="2"></td>
                                                    <td><strong><%= discount %>%</strong></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;" colspan="3"><strong>Total Amount</strong></td>
                                                    <td colspan="2"></td>
                                                    <td><strong>₹<%= adt %></strong></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="invoice-bottom">
                                <div class="row">
                                    <div class="col-lg-7 col-md-7 col-sm-7">
                                        <div class="terms-conditions mb-30">
                                            Thank you for choose our medical store..
                                        </div>
                                    </div>
                                    <div class="col-lg-5 col-md-5 col-sm-5">
                                        <div class="payment-method mb-30">
                                            <h3 class="inv-title-1 mb-10">Payment Method : <%= paymenttype %></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="invoice-btn-section clearfix d-print-none">
                        <a href="javascript:window.print()" class="btn btn-lg btn-download btn-theme    ">
                            <i class="fa fa-print"></i> Print Invoice
                        </a>
                        <a id="invoice_download_btn" class="btn btn-lg btn-download btn-theme">
                            <i class="fa fa-download"></i> Download Invoice
                        </a>
                        <a href="dashboard.jsp" class="btn btn-lg btn-download btn-theme">
                            <i class="fa fa-home"></i> Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../CSS/js/jquery.min.js"></script>
<script src="../CSS/js/jspdf.min.js"></script>
<script src="../CSS/js/html2canvas.js"></script>
<script src="../CSS/js/app.js"></script>
</body>
</html>
