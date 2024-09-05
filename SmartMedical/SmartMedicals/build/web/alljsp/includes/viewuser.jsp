<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String msg = null;
    msg = request.getParameter("msg");
    Connection con = ConnectionProvider.getcon();
    String que = "select aid, username, date1 from admin where special='N'";
    PreparedStatement stmt = con.prepareStatement(que);
    ResultSet rs = stmt.executeQuery();
    if("d".equals(msg))
    {
        msg = "user deleted successfully..";
    }
    if("nd".equals(msg))
    {
        msg = "user not deleted successfully..";
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
					<li class="breadcrumb-item active"><a
						href="javascript:void(0)">View Users</a></li>
				</ol>
			</div>
		</div>
		<!-- row -->
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
							<h4 class="card-title">View Users Details</h4>
							<div class="table-responsive mt-4 pt-4">
								<table class="table table-bordered">
									<thead>
										<tr>
                                                                                    <th scope="col"></th>
											<th scope="col" style="text-align: center;">User Name</th>
											<th scope="col" style="text-align: center;">Added Date</th>
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
											<td style="text-align: center;"><%= rs.getString("username") %></td>
											<td style="text-align: center;"><%= rs.getString("date1") %></td>
											<td style="text-align: center;">
												<span>
                                                                                                    <a href="#" data-toggle="tooltip" data-placement="top" title="Edit">
														<i class="fa fa-pencil color-muted m-r-5"></i> 
													</a>
                                                                                                    <a href="../deleteAction/deleteUser.jsp?id=<%= rs.getString("aid") %>" data-toggle="tooltip" data-placement="top" title="Close">
														<i class="fa fa-close color-danger"></i>
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