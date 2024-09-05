<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String msg = null;
    msg = request.getParameter("msg");
    if("added".equals(msg))
    {
        msg = "Company details added successfully..";
    }
    if("notadded".equals(msg))
    {
        msg = "Company details not added..";
    }
    if("conameexists".equals(msg))
    {
        msg = "Company name already exists..";
    }
    if("cobnoexists".equals(msg))
    {
        msg = "Company batch no. exists...";
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
                        <li class="breadcrumb-item active"><a href="addcompany.jsp">Add Companies</a></li>
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
                                    <form class="form-valide" action="../addAction/addCompanyAction.jsp" method="post">
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-username">Company Name <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="text" class="form-control" name="cname" required="" maxlength="100" minlength="2" placeholder="Enter a company name..">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-password">Batch No. <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="text" class="form-control"  name="cbno" required="" maxlength="30" minlength="4" placeholder="Enter a company batch number...">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-phoneus">Phone No. <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="text" class="form-control"  name="cphno" required="" maxlength="10" minlength="10" placeholder="+91 123-4567-890">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-email">Email <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <input type="email" class="form-control" name="cemail" required="" maxlength="50" minlength="11" placeholder="Enter Company valid email..">
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

<%@ include file="footer.jsp" %>
</body>
</html>