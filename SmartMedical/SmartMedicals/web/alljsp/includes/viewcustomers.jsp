<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection con = ConnectionProvider.getcon();
    String que = "select b.cusname, b.dname, b.address, b.date1, b.contactno, b.aname from bill b";
    PreparedStatement stmt = con.prepareStatement(que);
    ResultSet rs = stmt.executeQuery();
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
					<li class="breadcrumb-item active"><a
						href="javascript:void(0)">View Customer</a></li>
				</ol>
			</div>
		</div>
		<!-- row -->
                		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">View Customers Details</h4>
							<div class="table-responsive mt-4 pt-4">
								<table class="table table-bordered">
									<thead>
										<tr>
                                                                                        <th scope="col"></th>
											<th scope="col" style="text-align: center;">Customer Name</th>
											<th scope="col" style="text-align: center;">Doctor Name</th>
											<th scope="col" style="text-align: center;">Address</th>
											<th scope="col" style="text-align: center;">Contact No.</th>
											<th scope="col" style="text-align: center;">Added Date</th>
											<th scope="col" style="text-align: center;">Added Name</th>
										</tr>
									</thead>
									<tbody>
										<% 
											int cnt = 0; 
											while(rs.next()) { 
										%>
										<tr>
											<td style="text-align: center;"><%= ++cnt %></td>
											<td style="text-align: center;"><%= rs.getString("cusname") %></td>
											<td style="text-align: center;"><%= rs.getString("dname") %></td>
											<td style="text-align: center;"><%= rs.getString("address") %></td>
											<td style="text-align: center;"><%= rs.getString("contactno") %></td>
                                                                                        <td style="text-align: center;"><%= rs.getString("date1") %></td>
											<td style="text-align: center;"><span class="label gradient-2 btn-rounded"><%= rs.getString("aname") %></span></td>
										</tr>
										<% 
											} 
										%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		<!-- #/ container -->
	<%@ include file="footer.jsp"%>
</body>
</html>