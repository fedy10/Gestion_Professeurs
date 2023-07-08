package tn.iit.projet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		
		String login=request.getParameter("login");
		String password=request.getParameter("pwd");
		
		String url="jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
		String user="root";
		String pwd="";
		try {
			//pour se connecter au base de donnée de phpmyadmin
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection(url,user,pwd);
			
			// pour verifer le password et le mot de passe 
			PreparedStatement pst=con.prepareStatement("SELECT id_Admin FROM administration WHERE login=? AND password=?"); // SELECT ...  FROM name of table WHERE condition 
			pst.setString(1, login);
			pst.setString(2, password);
			ResultSet rs=pst.executeQuery();
			
			if(rs.next()) { 
				// il se trouve au moins une ligne dans la base de donnée
				session.setAttribute("login", login);
				response.sendRedirect("index.jsp");
			}
			else response.sendRedirect("authentification.jsp");
			rs.close();
			pst.close();
			con.close();
		}
		catch(Exception e) {
			System.out.print(e);
		}
	}

}


