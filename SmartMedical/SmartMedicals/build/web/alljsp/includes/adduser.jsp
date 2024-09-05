<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="fetchData.fetchAdmin" %>
<% 
    String msg = null;
    msg = request.getParameter("msg");
    int usertotal = (int) fetchAdmin.getCountUser();
    if("added".equals(msg))
    {
        msg = "user created successfully..";
    }
    if("notadded".equals(msg))
    {
        msg = "user not created..";
    }
    if("exist".equals(msg))
    {
        msg = "username already exists..";
    }
    if(usertotal >= 3)
    {
        msg = "don't create user..";
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="header.jsp" %>
</head>
<body>
<%@ include file="navbar.jsp" %>

<!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">

            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active"><a href="adduser.jsp">Add User</a></li>
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
                            <% if(!"don't create user..".equals(msg)) { %>
                            <div class="form-validation">
                                    <form class="form-valide" action="../addAction/addUserAction.jsp" method="post">
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-username">UserName <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="text" class="form-control" name="username" required="" maxlength="20" minlength="2" placeholder="Enter a username..">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-password">Password <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6 mb-2">
                                                <input type="text" class="form-control"  name="pass" required="" maxlength="20" minlength="2" placeholder="Enter a user password..">
                                                <input type="hidden"  name="special" value="N">
                                            </div>
                                        </div>
                                        
                                                                                
                                        <div class="form-group row mb-2">
                                            <div class="col-lg-8 ml-auto">
                                                <button type="submit" class="btn btn-primary">Submit</button>
                                            </div>
                                        </div>
                                    </form>
                            </div>
                            <% } %>
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

<%@ include file="footer.jsp" %>
</body>
</html>