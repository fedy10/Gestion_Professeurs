<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%
String login = "";
if (session.getAttribute("login") != null) {
	login = session.getAttribute("login").toString();
} else {
	response.sendRedirect("authentification.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>

<link rel="stylesheet" href="style.css">


</head>
<body>


	<table class="header">
		<tr>
			<th>
				<div align="left">
					Hello
					<%=login%><br>
				</div>
			</th>
			<th><div align="right">
					<a href="Logout"> <img src="images/logout.png" Width="40"
						Height="40"></a>
				</div></th>

		</tr>

	</table>

	<table class="header">
		<tr>
			<th>
				<div align="left">
					<h1>Liste of teatchers</h1>
				</div>
			</th>
			<th><a class="printer" titlt="print screen" alt="print screen"
				onclick="window.print();" target="_blank" style="cursor: pointer;"><center>
						<img src="images/printer.png" width="30" height="30">
					</center></a></th>
			<th><div align="right">
					<a href="AjouterProfesseur.jsp"><button type="button">Add new teatcher </button> </a>
				</div></th>

		</tr>

	</table>




	<table border="1" width="100%" cellpadding="4" cellspacing="4">
		<tr bgcolor="#0066CC">
			
			<th>Name</th>
			<th>Sexe</th>
			<th>Date Registration</th>
			<th>Number of hours remaining</th>
			<th>Action</th>
		</tr>
		<%
		String url = "jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
		String user = "root";
		String pwd = "";
		int number = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, pwd);
			PreparedStatement pst = con.prepareStatement("SELECT * FROM professeurs "); // SELECT ...  FROM name of table WHERE condition 
			//parcourir la base est afficher la liste de prof 1 par 1
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
		%>
		<tr bgcolor="#21d4fc">
	
			<td><%=rs.getString("nom")%></td>
			<td><%=rs.getString("sex")%></td>
			<td><%=rs.getString("date_ins")%></td>
			<td><%=rs.getString("nbheure_restant")%></td>

			<td>
				
				<a href="AutoriserProf.jsp?id=<%=rs.getString("id_professeur")%>&nbheure_restant=<%=rs.getString("nbheure_restant")%>"><img src="images/check.png" Width="30" Height="30">
			</a> <a
				href="ListeAutorisationProf.jsp?id=<%=rs.getString("id_professeur")%>"><img src="images/calendar.png" Width="30" Height="30"></a> <a
				href="UpdateProfesseur.jsp?id=<%=rs.getString("id_professeur")%>"><img src="images/edit.png" Width="30" Height="30"> </a> <a
				href="DeleteProf?id=<%=rs.getString("id_professeur")%>"><img src="images/delete.png" Width="30" Height="30"> </a>
			</td>
		</tr>
		<%
		}

		pst = con.prepareStatement("SELECT COUNT(*) FROM professeurs "); // SELECT ...  FROM name of table WHERE condition 
		rs = pst.executeQuery();
		rs.next();
		number = rs.getInt(1);

		rs.close();
		pst.close();
		con.close();
		} catch (Exception e) {
		System.out.print(e);
		}
		%>
	</table>

	Nombre of teatchers :<%=number%><br>




</body>
</html>