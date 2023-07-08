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
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
@WebServlet("/AddProf")
public class AjouterProf extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("login")!=null){
			String nom=request.getParameter("nom");
			String sexe=request.getParameter("sexe");
			String date=request.getParameter("date");
			System.out.println("input date : "+date);
			String nbheure;
			LocalDate inputDate = LocalDate.parse(date);
			LocalDate currentDate = LocalDate.now();
			System.out.println("currentDate : "+currentDate);
			LocalDate startDate;
			LocalDate endDate;
			if (inputDate.isBefore(currentDate)){
				 startDate = LocalDate.of(currentDate.getYear()-1, 9, 20); // 20 septembre de l'année actuelle
		         endDate = LocalDate.of(currentDate.getYear(), 6, 20);
			}
			else {
				 startDate = LocalDate.of(currentDate.getYear(), 9, 20); // 20 septembre de l'année actuelle
		         endDate = LocalDate.of(currentDate.getYear() + 1, 6, 20);
			}
			System.out.println("startDate : "+startDate);
			System.out.println("endDate : "+endDate);
	         // 20 juin de l'année suivante

	        if (date.equals(startDate.toString()) && (currentDate.isBefore(startDate)||currentDate.toString().equals(startDate.toString()) ) ) {
	            nbheure = "208"; // si la date est équivalente à 20 septembre de l'année actuelle
	        } else if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
	            long numberOfWeeks = ChronoUnit.WEEKS.between(inputDate, endDate);
	            int calculatedNbheure = 4 * (int) numberOfWeeks;
	            nbheure = String.valueOf(calculatedNbheure);
	        } else {
	            nbheure = "0";
	        }
	            
			String url="jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
			String user="root";
			String pwd="";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection(url,user,pwd);
				
				PreparedStatement pst=con.prepareStatement("INSERT INTO professeurs (nom, sex, date_ins, nbheure_restant) VALUES(?,?,?,?)"); //  
				
				pst.setString(1,nom);
				pst.setString(2,sexe);
				pst.setDate(3,Date.valueOf(date));
				pst.setInt(4,Integer.valueOf(nbheure));
				
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
