<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection con = ConnectionProvider.getcon();
    String que = "select c.co_id, c.co_name, c.co_batchno, c.co_phoneno, c.co_email, c.added_date, c.update_date, c.aname from Company c order by c.added_date desc";
    PreparedStatement stmt = con.prepareStatement(que);
    ResultSet rs = stmt.executeQuery();
    String msg = null;
    msg = request.getParameter("msg");
    if("delete".equals(msg))
    {
        msg = "Company related all category and medicine deleted...";
    }
    if("notdelete".equals(msg))
    {
        msg = "Company related all category and medicine not deleted...";
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
						href="viewcompany.jsp">Company Details</a></li>
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
							<h4 class="card-title">View Company Details</h4>
							<div class="table-responsive mt-4 pt-4">
								<table class="table table-bordered">
									<thead>
										<tr>
                                                                                    <th scope="col"></th>
											<th scope="col" style="text-align: center;">Name</th>
											<th scope="col" style="text-align: center;">Batch No.</th>
											<th scope="col" style="text-align: center;">Phone No.</th>
											<th scope="col" style="text-align: center;">Email</th>
											<th scope="col" style="text-align: center;">Added Date</th>
											<th scope="col" style="text-align: center;">Updated Date</th>
                                                                                        <th scope="col" style="text-align: center;">Added Name</th>
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
											<td style="text-align: center;"><%= rs.getString("co_name") %></td>
											<td style="text-align: center;"><%= rs.getString("co_batchno") %></td>
											<td style="text-align: center;"><%= rs.getString("co_phoneno") %></td>
											<td style="text-align: center;"><%= rs.getString("co_email") %></td>
											<td style="text-align: center;"><%= rs.getString("added_date") %></td>
											<td style="text-align: center;"><%= rs.getString("update_date") %></td>
                                                                                        <td style="text-align: center;"><span class="label gradient-2" style="color: greenyellow;"><%= rs.getString("aname") %></span></td>
											<td style="text-align: center;">
												<span>
                                                                                                    <a href="#" data-toggle="tooltip" data-placement="top" title="Edit">
														<i class="fa fa-pencil color-muted m-r-5"></i> 
													</a>
                                                                                                    <a href="#" data-toggle="tooltip" data-placement="top" title="Close">
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
