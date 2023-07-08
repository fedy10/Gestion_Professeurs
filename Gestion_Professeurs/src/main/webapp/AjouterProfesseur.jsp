<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<% 
	String login="";
	if(session.getAttribute("login")!=null){
		login=session.getAttribute("login").toString();
	}
	else{
		response.sendRedirect("authentification.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title> Projet j2ee </title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/index-styles.css" rel="stylesheet" />
</head>
<body id="page-top">
		
	<!-- Masthead-->
	<header class="masthead bg-primary text-white text-center">

		<div class="container d-flex align-items-center flex-column">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar mb-3" src="assets/img/iit.png"
				alt="..." />
			<!-- Masthead Heading-->
			<h1 class="masthead-heading text-uppercase mb-0"> ADD NEW TEATCHER :</h1>
		</div>
	</header>
		
	<!-- Contact Section-->
	<section class="page-section" id="contact">
		<div class="container">

			<!-- Contact Section Form-->
			<div class="row justify-content-center">
				<div class="col-lg-8 col-xl-7">
					<form method="post" action="AddProf">
						<table>
						<!-- Last Name-->
							<tr>
								<td><h4>Name : </h4></td>
								<td><input type="text" name="nom" required ></td>
							</tr>
						<!-- Sexe-->
							<tr>
								<td><h4>SEXE : </h4></td>
								<td>
									<input type="radio" name="sexe" value="Homme" checked > MALE
									<input type="radio" name="sexe" value="Femme"  > FEMALE 
								</td>
							</tr>
						<!-- INSCRIPTION DATE -->
							<tr>
								<td><h4>INSCRIPTION DATE : </h4></td>
								<%
								    // Récupérer la date actuelle
								    LocalDate currentDate = LocalDate.now();
								    // Formater la date au format "yyyy-MM-dd"
								    String formattedDate = currentDate.toString();
								%>
								<td><input type="date"  name="date" value="<%= formattedDate %>" required></td>
							</tr>
						</table>
						<!-- Submit Button-->		
							<input type="submit" value="Add" class="btn btn-primary">
							<a href="index.jsp" class="btn btn-primary margin-left :5px"> Home </a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>