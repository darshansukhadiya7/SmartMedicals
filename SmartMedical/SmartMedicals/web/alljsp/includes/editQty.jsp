<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = ConnectionProvider.getcon();
    String que = "select * from medicine where mid="+id;
    PreparedStatement stmt = con.prepareStatement(que);
    ResultSet rs= stmt.executeQuery();
    String msg = null;
    msg = request.getParameter("msg");
    if("added".equals(msg))
    {
        msg = "Medicine qty update successfully..";
    }
    if("notadded".equals(msg))
    {
        msg = "Medicine qty not update..";
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

	<!--**********************************
            Content body start
        ***********************************-->
	<div class="content-body">

		<div class="row page-titles mx-0">
			<div class="col p-md-0">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
					<li class="breadcrumb-item active"><a
						href="javascript:void(0)">Edit Qty</a></li>
				</ol>
			</div>
		</div>
		<!-- row -->

		<div class="container-fluid">
			<div class="row justify-content-center">
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
							<div class="form-validation">
								<form class="form-valide" action="../updateAction/updateMedicineQTY.jsp" method="post">
                                                                        <% if(rs.next()) { %>
									<div class="form-group row">
										<label class="col-lg-4 col-form-label" for="val-password"> Medicine Name <span class="text-danger">*</span></label>
										<div class="col-lg-6">
                                                                                    <input type="text" class="form-control" name="mname" value="<%= rs.getString("mname") %>" readonly="">
                                                                                    <input type="hidden" class="form-control" name="mid" value="<%= id %>">
                                                                                    <input type="hidden" class="form-control" name="qtyava" value="<%= rs.getString("totalpack") %>">
										</div>
									</div>
                                                                        <div class="form-group row">
										<label class="col-lg-4 col-form-label" for="val-password"> Quantity <span class="text-danger">*</span></label>
										<div class="col-lg-6">
                                                                                    <input type="text" class="form-control" name="qty" required="" minlength="1" maxlength="6">
										</div>
									</div>
                                                                        <div class="form-group row">
										<label class="col-lg-4 col-form-label" for="val-password"> Select Expiry Date <span class="text-danger">*</span></label>
										<div class="col-lg-6">
                                                                                    <input type="date" class="form-control" name="edate" required="">
										</div>
									</div>
									<div class="form-group row">
										<div class="col-lg-8 ml-auto">
											<button type="submit" class="btn btn-primary">Submit</button>
										</div>
									</div>
                                                                        <% } %>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- #/ container -->
	</div>
	<!--**********************************
            Content body end
        ***********************************-->

	<%@ include file="footer.jsp"%>
</body>
</html>