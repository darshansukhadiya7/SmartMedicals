<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection con = ConnectionProvider.getcon();
    String que = "select c.cat_id, c.cat_name, co.co_name, co.co_batchno from category c join company co on c.co_id = co.co_id order by co.co_name";
    PreparedStatement stmt = con.prepareStatement(que);
    ResultSet rs = stmt.executeQuery();
%>
<% 
    String msg = null;
    msg = request.getParameter("msg");
    if("select".equals(msg)) {
        msg = "Choose a one category and company..";
    } else if("added".equals(msg)) {
        msg = "medicine added successfully..";
    } else if("notadded".equals(msg)) {
        msg = "medicine not added..";
    } else if("mednameexists".equals(msg)) {
        msg = "medicine name already exists..";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@ include file="header.jsp"%>
</head>
<body>
    <%@ include file="navbar.jsp"%>

    <div class="content-body">
        <div class="row page-titles mx-0">
            <div class="col p-md-0">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="addmedicine.jsp">Add Medicine</a></li>
                </ol>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <% if(msg != null) { %>
                                <div class="alert alert-success alert-dismissible fade show">
                                    <%= msg %>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            <% } %>
                            <h4 class="card-title">Add Medicine Details..</h4>
                            <div class="basic-form mt-4">
                                <form method="post" action="../addAction/addMedicineAction.jsp">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <label>Company Name and Category Name</label>
                                            <select id="company" name="catid" class="form-control">
                                                <option selected="selected" value="0">Choose...</option>
                                                <% while(rs.next()) {
                                                    String c = rs.getString("co.co_name") + " --- " + rs.getString("c.cat_name") + " --- " + rs.getString("co.co_batchno");
                                                %>
                                                <option value="<%= rs.getInt("c.cat_id") %>"><%= c %></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Medicine Name*</label>
                                        <input type="text" class="form-control" name="mname" required="" maxlength="255" minlength="1">
                                        
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-2">
                                            <label>Pack Size*</label>
                                            <input type="number" id="pack_size" name="packsize" required="" minlength="1" maxlength="4" class="form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label>Buying Price*</label>
                                            <input type="number" id="price_pack" name="pricepack" required="" minlength="1" maxlength="7" class="form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label>Selling Price*</label>
                                            <input type="number" name="sprice" id="sprice" required="" minlength="1" maxlength="7" class="form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label>Ordered Quantity*</label>
                                            <input type="text" id="total_pack" name="totalpack" required="" minlength="1" maxlength="6" class="form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label>Total Discount in %*</label>
                                            <input type="text" id="total_disc" name="disc" required="" value="0" maxlength="3" class="form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label for="date">Select Expiry Date*</label>
                                            <input type="date" name="edate" required="" class="form-control" id="date">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-3">
                                            <label>Max. Qty. Required*</label>
                                            <input type="text" id="maxqty" name="maxqty" required="" minlength="1" maxlength="4" class="form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label>Price 1 qty vise*</label>
                                            <input type="text" id="qtyprice" name="qtyprice" readonly="" class="form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label>Discount in ₹</label>
                                            <input type="text" id="distinr" name="distinr" readonly="" class="form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label>Total price</label>
                                            <input type="text" id="total_price" name="totalprice" readonly="" required="" class="form-control">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-dark">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Get input elements
        const packSizeInput = document.getElementById('pack_size');
        const totalPackInput = document.getElementById('total_pack');
        const pricePerPackInput = document.getElementById('price_pack');
        const totalDiscountInput = document.getElementById('total_disc');
        const totalPriceInput = document.getElementById('total_price');
        const qtyPriceInput = document.getElementById('qtyprice');
        const distInrInput = document.getElementById('distinr');
        const spriceInput = document.getElementById('sprice');

        // Function to calculate and update total price
        function updateTotalPrice() {
            const packSize = parseInt(packSizeInput.value) || 0;
            const totalPack = parseInt(totalPackInput.value) || 0;
            const pricePack = parseFloat(spriceInput.value) || 0;
            const qtyPrice = pricePack / packSize;
            const totalPrice = qtyPrice * totalPack;
            const discount = parseFloat(totalDiscountInput.value) || 0;
            const discountedPrice = totalPrice - (totalPrice * discount / 100);
            
            const distInr = (totalPrice * discount / 100);
            qtyPriceInput.value = qtyPrice.toFixed(2);
            distInrInput.value = distInr.toFixed(2);
            totalPriceInput.value = discountedPrice.toFixed(2);
        }

        // Event listeners to update price on input change
        packSizeInput.addEventListener('input', updateTotalPrice);
        totalPackInput.addEventListener('input', updateTotalPrice);
        pricePerPackInput.addEventListener('input', updateTotalPrice);
        totalDiscountInput.addEventListener('input', updateTotalPrice);
    </script>

    <%@ include file="footer.jsp"%>
</body>
</html>
