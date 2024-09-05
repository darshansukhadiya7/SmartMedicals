<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Connection.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
    HttpSession AdminUname = request.getSession(false);
    String aname = null;
    if (AdminUname != null) {
        aname = (String) AdminUname.getAttribute("username");
    }

    if (aname == null) {
        response.sendRedirect("../../Authentication/login.jsp?msg=sessionExpired");
    }
    Connection conn11 = ConnectionProvider.getcon();
    String quesc1 = "select count(*) as totalcou from medicine where totalpack < maxqty";
    PreparedStatement stmt11 = conn11.prepareStatement(quesc1);
    ResultSet rss1 = stmt11.executeQuery();
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">

<!-- theme meta -->
<meta name="theme-name" content="quixlab" />

<title>Smart Medicals</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="../CSS/images/favicon.png">
<!-- Pignose Calender -->
<link href="../CSS/./plugins/pg-calendar/css/pignose.calendar.min.css"
	rel="stylesheet">
<!-- Chartist -->
<link rel="stylesheet"
	href="../CSS/./plugins/chartist/css/chartist.min.css">
<link rel="stylesheet"
	href="../CSS/./plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css">
<!-- Custom Stylesheet -->
<link href="../CSS/css/style.css" rel="stylesheet">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>

<body>
    
    
    <div class="header">    
            <div class="header-content clearfix">
                
                <div class="nav-control">
                    <div class="hamburger">
                        <span class="toggle-icon"><i class="icon-menu"></i></span>
                    </div>
                </div>
                <div class="header-left">
                    <div class="input-group icons">
                        <div class="input-group-prepend">
                            <span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3" id="basic-addon1"><i class="mdi mdi-magnify"></i></span>
                        </div>
                        <input type="search" class="form-control" placeholder="Search Dashboard" aria-label="Search Dashboard">
                        <div class="drop-down animated flipInX d-md-none">
                            <form action="#">
                                <input type="text" class="form-control" placeholder="Search">
                            </form>
                        </div>
                    </div>
                </div>
                <div class="header-right">
                    <ul class="clearfix">
                        <li class="icons dropdown">
                            <a href="viewNotification.jsp">
                                <i class="mdi mdi-bell-outline"></i>
                                <% if(rss1.next()) { %>
                                <span class="badge badge-pill gradient-2"><%= rss1.getString("totalcou") %></span>
                                <% } %>
                            </a>
                        </li>
                        <li class="icons dropdown">
                            <a href="profile.jsp" class="profile-link">
                                <div class="user-img c-pointer position-relative">
                                    <img src="../CSS/images/user/1.png" height="40" width="40" alt="" class="rounded-img">
                                </div>
                            </a>
                        </li>


                    </ul>
                </div>
            </div>
        </div>
	<script src="../CSS/plugins/common/common.min.js"></script>
	<script src="../CSS/js/custom.min.js"></script>
	<script src="../CSS/js/settings.js"></script>
	<script src="../CSS/js/gleek.js"></script>
	<script src="../CSS/js/styleSwitcher.js"></script>

	<!-- Chartjs -->
	<script src="../CSS/./plugins/chart.js/Chart.bundle.min.js"></script>
	<!-- Circle progress -->
	<script src="../CSS/./plugins/circle-progress/circle-progress.min.js"></script>
	<!-- Datamap -->
	<script src="../CSS/./plugins/d3v3/index.js"></script>
	<script src="../CSS/./plugins/topojson/topojson.min.js"></script>
	<script src="../CSS/./plugins/datamaps/datamaps.world.min.js"></script>
	<!-- Morrisjs -->
	<script src="../CSS/./plugins/raphael/raphael.min.js"></script>
	<script src="../CSS/./plugins/morris/morris.min.js"></script>
	<!-- Pignose Calender -->
	<script src="../CSS/./plugins/moment/moment.min.js"></script>
	<script src="../CSS/./plugins/pg-calendar/js/pignose.calendar.min.js"></script>
	<!-- ChartistJS -->
	<script src="../CSS/./plugins/chartist/js/chartist.min.js"></script>
	<script
		src="../CSS/./plugins/chartist-plugin-tooltips/js/chartist-plugin-tooltip.min.js"></script>



	<script src="../CSS/./js/dashboard/dashboard-1.js"></script>

</body>
</html>