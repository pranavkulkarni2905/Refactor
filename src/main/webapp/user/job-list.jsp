<%@page import="java.sql.ResultSet"%>
<%@page import="com.job.DAO.UserDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="com.job.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="404.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>WorkConnect | Job List</title>
<meta content="" name="description">
<meta content="" name="keywords">

<script src="sweetalert2.all.min.js"></script>
<script src="sweetalert2.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Favicons -->
<link href="../assets/img/favicon.png" rel="icon">
<link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="../assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="../assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="../assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="../assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="../assets/vendor/simple-datatables/style.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="../assets/css/style.css" rel="stylesheet">

<script>
	$(document).ready(function() {
		$(".toast").toast({
			autohide : false
		});
	});
</script>
</head>

<body>
	<%@ include file="_header.jsp"%>
	<%@ include file="_sidebar.jsp"%>



	<main id="main" class="main">



		<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		%>
		<%
		String uname = (String) session.getAttribute("user-uname");
		%>

		<div class="pagetitle">

			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="user-index.jsp">Home</a></li>
					<li class="breadcrumb-item">Dashboard</li>
					<li class="breadcrumb-item active">Listed Jobs</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">

			<div class="row mb-3">
				<h5>Filter</h5>
				<form action="job-list.jsp" method="post">
					<div class="row">
						<label class="col-sm-1 col-form-label">Job Type</label>

						<div class="col-sm-2">
							<select class="form-select" aria-label="Default select example"
								name="type">
								<option selected>Select</option>
								<option value="Full-Time">Full-Time</option>
								<option value="part-Time">Part-Time</option>
								<option value="contract">Contract</option>
								<option value="Internship">Internship</option>
								<option value="temp">Temporary</option>
							</select>
						</div>


						<label class="col-sm-1 col-form-label">Location</label>
						<div class="col-sm-2">
							<select class="form-select" aria-label="Default select example"
								name="location">
								<option selected>Select</option>
								<%
								UserDAO uu=new UserDAO();
								ResultSet rs4=uu.getAllJobs();
								while(rs4.next()){
									%>
									<option value="<%=rs4.getString(7) %>"><%=rs4.getString(7) %></option>
									<% 
								}
								%>
								
								
								
							</select>
						</div>

						<label class="col-sm-1 col-form-label">Company</label>
						<div class="col-sm-2">
							<select class="form-select" aria-label="Default select example"
								name="company">
								<option selected>Select</option>
								<%
								UserDAO uu1=new UserDAO();
								ResultSet rs5=uu1.getAllJobs();
								while(rs5.next()){
									%>
									<option value="<%=rs5.getString(3) %>"><%=rs5.getString(3) %></option>
									<% 
								}
								%>
							</select>
						</div>

						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary">Search</button>

						</div>
					</div>
				</form>

				<%
				try {
					UserDAO ud = new UserDAO();
					ResultSet rs = null;
					String type = request.getParameter("type");
					String location = request.getParameter("location");
					String company = request.getParameter("company");
					if (type != null && location != null && company != null) {
						rs = ud.filterByTypeAndLocation(type, location, company);
					} else if (location != null) {

					} else if (company != null) {

					} else{
						rs = ud.getAllJobs();
					}
						
						while (rs.next()) {
					int id = rs.getInt(2);
					ResultSet rs2 = ud.getCompanyNameById(id);
					if (rs2.next()) {
				%>

				<div class="col-md-6 pt-5">


					<!-- Card with an image on left -->
					<div class="card mb-3 ">
						<div class="row g-0">

							<div class="col-md-2">
								<img src="../company-images/<%=rs2.getString(12)%>"
									class="img-fluid rounded-start" alt="...">
							</div>

							<div class="col-md-8">
								<div class="card-body">
									<h5 class="card-title"><%=rs2.getString(5)%></h5>
									<p class="card-text"><%=rs.getString(4)%></p>
									<p class="card-text">
										<span><i class="bx bxs-map"></i></span><span><%=rs.getString(8)%></span>
										<span class="p-1"><i class="bx bx-time"></i></span> <span><%=rs.getString(5)%></span><span
											class="p-1"><i class="bx bxs-calendar"></i></span><span
											class="p-1"><%=rs.getString(9)%></span>
									</p>
								</div>
							</div>

							<div class="col-md-2 pt-4">
								<a href="job-details.jsp?id=<%=rs.getInt(1)%>">
									<button type="button" class="btn btn-primary rounded-pill">View</button>
								</a>
							</div>

						</div>
					</div>
					<!-- End Card with an image on left -->

				</div>


				<%
				
				}
				}
				} catch (Exception e) {

				}
				%>


				<!--              cards in half div -->
		</section>

	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="copyright">
			&copy; Copyright <strong><span>WorkConnect</span></strong>. All
			Rights Reserved
		</div>
		<div class="credits">

			Designed by <a href="">WorkConnect Team</a>
		</div>
	</footer>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="../assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="../assets/vendor/chart.js/chart.umd.js"></script>
	<script src="../assets/vendor/echarts/echarts.min.js"></script>
	<script src="../assets/vendor/quill/quill.min.js"></script>
	<script src="../assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="../assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="../assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="../assets/js/main.js"></script>

	<script src="../assets/css/saber-toast.js"></script>
	<script src='./assets/css/script.js'></script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 -->
</body>

</html>