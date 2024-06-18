package org.aspcfs.opu.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.utils.GestoreConnessioni;
import org.directwebremoting.extend.LoginRequiredException;


public class ServletStradeNapoli extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/** 
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletStradeNapoli() {
		super();
		// TODO Auto-generated constructor stub
	}

 

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		Connection db = null;
		String esito = "";
        String tipoOutput = request.getParameter("tipoOutput");
        System.out.println("tipo"+tipoOutput);

		try {
			db = GestoreConnessioni.getConnection();
			if (db != null) { 
				
   			    pst = db.prepareStatement("select * from get_strade_napoli(?)");
   			    pst.setString(1, tipoOutput);
   			    
				rs = pst.executeQuery();

				while (rs.next()) {
					esito = rs.getString(1);
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (LoginRequiredException e) {

			throw e;
		} finally {
			GestoreConnessioni.freeConnection(db);
		}
		
		response.getWriter().println(esito);
	}
}