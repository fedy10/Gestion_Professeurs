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


@WebServlet("/AutoriserProf")
public class AutoriserProf extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("login")!=null){
			
			String idprof=request.getParameter("idprof");
			String nbheureinitial=request.getParameter("nbd");
			String datedébut=request.getParameter("datedébut");
			String datefin=request.getParameter("datefin");
			String nbheure=request.getParameter("nbheure");
			
			String url="jdbc:mysql://localhost:3306/gestion_des_autorisations_des_enseignants";
			String user="root";
			String pwd="";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection con=DriverManager.getConnection(url,user,pwd);
	            
	            int nbheureinitialInt = Integer.parseInt(nbheureinitial);
	            int nbheureInt = Integer.parseInt(nbheure);
	            Date datedebutDate = Date.valueOf(datedébut);
	            Date datefinDate = Date.valueOf(datefin);
	            
	            // Calcul du nombre total d'heures entre datedébut et datefin
	            long differenceMillis = Math.abs(datefinDate.getTime() - datedebutDate.getTime());
	            long differenceDays = differenceMillis / (24 * 60 * 60 * 1000);
	            int nbjours = (int) differenceDays;
	            int nbsemaines = (nbjours + 6) / 7;
	            //int nbheuredecontraInt = nbjours * nbheureInt;
	            
	            int limiteNbheure = 4;
	            ////////////////////////////////////////
	            PreparedStatement pstCount = con.prepareStatement("SELECT SUM(nbheuredecontra) AS totalHours FROM autorisation WHERE id_professeur = ? AND WEEK(date_fin) = WEEK(?) ORDER BY id_Autorisation DESC LIMIT 1");
	            pstCount.setInt(1, Integer.valueOf(idprof));
	            pstCount.setDate(2, Date.valueOf(datefin));

	            ResultSet rs = pstCount.executeQuery();
	            int totalHours = 0;
	            if (rs.next()) {
	                totalHours = rs.getInt("totalHours");
	            }
	            pstCount.close();

	            int maxWeeklyHours = 4;
	            if (totalHours + nbheureInt > maxWeeklyHours) {
	                response.sendRedirect("Error.jsp");
	            } 
	            else {
	            if (nbheureinitialInt > nbheureInt && nbheureInt <= limiteNbheure*nbsemaines) {
	                PreparedStatement pst=con.prepareStatement("INSERT INTO autorisation (id_professeur, date_début, date_fin, nbheuredecontra) VALUES(?,?,?,?)");
	                
	                pst.setInt(1,Integer.valueOf(idprof));
	                pst.setDate(2,Date.valueOf(datedébut));
	                pst.setDate(3,Date.valueOf(datefin));
	                pst.setInt(4,Integer.valueOf(nbheure));
	                
	                pst.executeUpdate();
	                pst.close();
	                
	                // Mise à jour de nbheureinitial
	                int newNbheureinitial = nbheureinitialInt - nbheureInt;
	                PreparedStatement pst2=con.prepareStatement("UPDATE professeurs SET nbheure_restant=?  WHERE id_professeur=?");
	                pst2.setInt(1, newNbheureinitial);
	                pst2.setInt(2,Integer.valueOf(idprof));
	                pst2.executeUpdate();
	                pst2.close();
	                
	                response.sendRedirect("index.jsp");
	            } else {
	                response.sendRedirect("Error.jsp");
	            }

	            con.close();
			
	            }
			}
			
			
			catch(Exception e) {
				System.out.print(e);
			}
			
		}
		else response.sendRedirect("authentification.jsp");
		
		
	}

}
