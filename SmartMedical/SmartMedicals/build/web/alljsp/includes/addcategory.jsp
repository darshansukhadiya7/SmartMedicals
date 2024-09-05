<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
    Connection con = ConnectionProvider.getcon();
    String que = "select co_id, co_name from company";
    PreparedStatement stmt = con.prepareStatement(que);
    ResultSet rs= stmt.executeQuery();
%>
<% 
    String msg = null;
    msg = request.getParameter("msg");
    if("select".equals(msg))
    {
        msg = "Choose a one company..";
    }
    if("added".equals(msg))
    {
        msg = "Category added successfully..";
    }
    if("notadded".equals(msg))
    {
        msg = "Category not added..";
    }
    if("catnameexists".equals(msg))
    {
        msg = "Category name already exists..";
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
						href="javascript:void(0)">Home</a></li>
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
								<form class="form-valide" action="../addAction/addCategoryAction.jsp" method="post">
									<div class="form-group row">
										<label class="col-lg-4 col-form-label" for="val-skill">Company Name <span class="text-danger">*</span></label>
										<div class="col-lg-6">
                                                                                    
											<select class="form-control" name="cmid">
                                                                                            <option value="0">Select company name..</option>
                                                                                            <% while(rs.next()) { %>
                                                                                                <option value="<%= rs.getInt("co_id") %>"><%= rs.getString("co_name") %></option>
                                                                                             <% } %>
                                                                                        </select>
                                                                                   
										</div>
									</div>
									<div class="form-group row">
										<label class="col-lg-4 col-form-label" for="val-password">Category
											Name <span class="text-danger">*</span>
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" name="catname"
                                                                                               placeholder="Enter a category name..." required="" minlength="1" maxlength="30">
										</div>
									</div>
				
									<div class="form-group row">
										<div class="col-lg-8 ml-auto">
											<button type="submit" class="btn btn-primary">Submit</button>
										</div>
									</div>
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