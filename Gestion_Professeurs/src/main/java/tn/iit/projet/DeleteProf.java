package tn.iit.projet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/DeleteProf")
public class DeleteProf extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("login")!=null){
			String id=request.getParameter("id");
			
			
			String url="jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
			String user="root";
			String pwd="";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection(url,user,pwd);
				
				PreparedStatement pst2=con.prepareStatement("DELETE FROM autorisation WHERE id_professeur=?"); //  
				pst2.setInt(1,Integer.valueOf(id));
				pst2.executeUpdate();
				
				PreparedStatement pst=con.prepareStatement("DELETE FROM professeurs WHERE id_professeur=?"); //  
				pst.setInt(1,Integer.valueOf(id));
				pst.executeUpdate();
				

				
				response.sendRedirect("index.jsp");
				
				pst.close();
				pst2.close();
				con.close();
			}
			catch(Exception e) {
				System.out.print(e);
			}
		}
		else response.sendRedirect("authentification.jsp");
	}

	

}
