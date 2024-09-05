<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="fetchData.fetchAdmin" %>
<% 
    HttpSession session1 = request.getSession(false);
    String adminname = null;
    String aname1 = fetchAdmin.getAdminName();
    if (session1 != null) 
    {
        adminname = (String) session1.getAttribute("username");
    }

    if (adminname == null) 
    {
        return; // Ensure the rest of the page does not execute after redirect
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="theme-name" content="quixlab" />
    <title>Smart Medicals</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../CSS/images/favicon.png">
    <link href="../CSS/./plugins/pg-calendar/css/pignose.calendar.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../CSS/./plugins/chartist/css/chartist.min.css">
    <link rel="stylesheet" href="../CSS/./plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css">
    <link href="../CSS/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- The rest of your HTML content -->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>

    <div class="nav-header" style="height: 5rem; width: 15.1875rem; display: inline-block; text-align: left; position: absolute; left: 0; top: 0; background: #ffffff; box-shadow: 0 1px 10px rgba(0, 0, 0, 0.15); transition: all .2s ease; overflow: hidden;">
        <div class="brand-logo" style="z-index: 999; display: flex; align-items: center; height: 100%;">
            <a href="dashboard.jsp" style="display: flex; align-items: center; height: 100%; text-decoration: none;">
                <span class="brand-title" style="color: #000; font-size: 20px; font-weight: bold; font-family: 'Arial', sans-serif; letter-spacing: 0.05em; text-transform: uppercase; margin: 0; padding: 0;">
                    Smart Medical
                </span>
            </a>
        </div>
    </div>

        
        <div class="nk-sidebar">           
            <div class="nk-nav-scroll">
                <ul class="metismenu" id="menu">
                    <li>
                        <a href="dashboard.jsp" aria-expanded="false">
                            <i class="icon-speedometer"></i><span class="nav-text">Dashboard</span>
                        </a>
                    </li>
                    <% if(adminname.equals(aname1)) { %>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">User Details</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="adduser.jsp">Add User</a></li>
                            <li><a href="viewuser.jsp">View User</a></li>
                        </ul>
                    </li>
                    <% } %>
                    
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Company Details</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="addcompany.jsp">Add Company</a></li>
                            <li><a href="viewcompany.jsp">View Company</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Categories Details</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="addcategory.jsp">Add Category</a></li>
                            <li><a href="viewcategory.jsp">View Category</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Medicine Details</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="addmedicine.jsp">Add Medicine</a></li>
                            <li><a href="viewmedicine.jsp">View Medicines</a></li>
                        </ul>
                    </li>                    
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Customer Details</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="viewcustomers.jsp">View Customers</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Billing Details</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="makebill.jsp">Make Bill</a></li>
                            <li><a href="viewbill.jsp">View Bill</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Reports</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="#">Profit</a></li>
                            <li><a href="#">Sales</a></li>
                            <li><a href="#">Revenue</a></li>
                            <li><a href="#">Expiry</a></li>
                            <li><a href="#">Customer</a></li>
                            <li><a href="#">Stocks</a></li>
                            <li><a href="#">Orders</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="../../Authentication/login.jsp" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Log Out</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

    <script src="../CSS/plugins/common/common.min.js"></script>
    <script src="../CSS/js/custom.min.js"></script>
    <script src="../CSS/js/settings.js"></script>
    <script src="../CSS/js/gleek.js"></script>
    <script src="../CSS/js/styleSwitcher.js"></script>
    <script src="../CSS/./plugins/chart.js/Chart.bundle.min.js"></script>
    <script src="../CSS/./plugins/circle-progress/circle-progress.min.js"></script>
    <script src="../CSS/./plugins/d3v3/index.js"></script>
    <script src="../CSS/./plugins/topojson/topojson.min.js"></script>
    <script src="../CSS/./plugins/datamaps/datamaps.world.min.js"></script>
    <script src="../CSS/./plugins/raphael/raphael.min.js"></script>
    <script src="../CSS/./plugins/morris/morris.min.js"></script>
    <script src="../CSS/./plugins/moment/moment.min.js"></script>
    <script src="../CSS/./plugins/pg-calendar/js/pignose.calendar.min.js"></script>
    <script src="../CSS/./plugins/chartist/js/chartist.min.js"></script>
    <script src="../CSS/./plugins/chartist-plugin-tooltips/js/chartist-plugin-tooltip.min.js"></script>
    <script src="../CSS/./js/dashboard/dashboard-1.js"></script>
</body>
</html>