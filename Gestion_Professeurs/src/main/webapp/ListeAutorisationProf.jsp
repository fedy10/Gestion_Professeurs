<%@ page language="java" %>
<%@ page import="java.sql.*" %>
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
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div align="right">
	Hello <%=login %><br>
	<a href="index.jsp"> Home</a>
</div>

<h1> Permissions list </h1>
<table border="1" width="100%" cellpadding="4" cellspacing="4">
	<tr bgcolor="#0066CC">
		<th>Name</th>
		<th>Start Date</th>
		<th>End Date</th>
		<th>Nombre of hours</th>
	</tr>
	
	<%
		String url="jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
		String user="root";
		String pwd="";
		
		String id = request.getParameter("id");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection(url,user,pwd);
			
			PreparedStatement pst=con.prepareStatement("SELECT p.nom, a.date_début, a.date_fin, a.nbheuredecontra FROM professeurs p INNER JOIN autorisation a ON p.id_professeur = a.id_professeur WHERE p.id_professeur = ?"); // SELECT ...  FROM name of table WHERE condition 
			pst.setInt(1, Integer.valueOf(id));
			ResultSet rs=pst.executeQuery();
			
			while (rs.next()) {
				String nom = rs.getString("nom");
	%>
	
	<tr bgcolor="#21d4fc">
		<td><%=nom %></td>
		<td><%=rs.getString("date_début") %></td>
		<td><%=rs.getString("date_fin") %></td>
		<td><%=rs.getString("nbheuredecontra") %></td>
	</tr>
	
	<%
			}
			
			rs.close();
			pst.close();
			con.close();
		}
		catch(Exception e) {
			System.out.print(e);
		}
	%>
</body>
</html>
