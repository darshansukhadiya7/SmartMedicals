<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection con = ConnectionProvider.getcon();
    String que = "select m.mid,m.mname,m.totalpack,m.maxqty,m.edate,ca.cat_name,co.co_name"
            + " from medicine m"
            + " join category ca on m.cat_id = ca.cat_id "
            + "join company co on ca.co_id = co.co_id "
            + "where totalpack<maxqty";
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
						href="javascript:void(0)">View Notifications</a></li>
				</ol>
			</div>
		</div>
		<!-- row -->
                		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">View Notifications</h4>
							<div class="table-responsive mt-4 pt-4">
								<table class="table table-bordered">
									<thead>
										<tr>
                                                                                    <th scope="col"></th>
											
											<th scope="col" style="text-align: center;">Medicine name</th>
											<th scope="col" style="text-align: center;">Category Name</th>
											<th scope="col" style="text-align: center;">Company Name</th>
											<th scope="col" style="text-align: center;">Quantity Available</th>
                                                                                        <th scope="col" style="text-align: center;">Max. Quantity Available</th>
                                                                                        <th scope="col" style="text-align: center;">Expiry Date</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody>
										<% 
											int cnt = 0; 
											while(rs.next()) { 
										%>
										<tr>
											<td style="text-align: center;"><%= ++cnt %></td>
											<td style="text-align: center;"><%= rs.getString("mname") %></td>
											<td style="text-align: center;"><%= rs.getString("cat_name") %></td>
											<td style="text-align: center;"><%= rs.getString("co_name") %></td>
											<td style="text-align: center;"><%= rs.getString("totalpack") %></td>
                                                                                        <td style="text-align: center;"><%= rs.getString("maxqty") %></td>
                                                                                        <td style="text-align: center;"><%= rs.getString("edate") %></td>
											<td style="text-align: center;">
												<span>
                                                                                                    <a href="editQty.jsp?id=<%= rs.getString("mid") %>" data-toggle="tooltip" data-placement="top" title="Edit">
														<i class="fa fa-pencil color-muted m-r-5"></i> 
                                                                                                    </a>
												</span>
											</td>
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