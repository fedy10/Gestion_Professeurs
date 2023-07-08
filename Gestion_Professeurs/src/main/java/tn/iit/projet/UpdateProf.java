package tn.iit.projet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateProf")
public class UpdateProf extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("login")!=null){
			String id=request.getParameter("idprof");
			
			String nom=request.getParameter("nom");
			String sexe=request.getParameter("sexe");
			String date=request.getParameter("date");
			String nbheure=request.getParameter("nbheure");

			String url="jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
			String user="root";
			String pwd="";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection(url,user,pwd);
				
				PreparedStatement pst=con.prepareStatement("UPDATE  professeurs SET nom=?, sex=?, date_ins=?, nbheure_restant=? WHERE id_professeur=?"); //  
				
				pst.setString(1,nom);
				pst.setString(2,sexe);
				pst.setDate(3,Date.valueOf(date));
				pst.setInt(4,Integer.valueOf(nbheure));
				pst.setInt(5,Integer.valueOf(id));
				pst.executeUpdate();
				response.sendRedirect("index.jsp");
				pst.close();
				con.close();
				
			}
			catch(Exception e) {
				System.out.print(e);
			}
		}
		else response.sendRedirect("authentification.jsp");
		
		
	}

}
