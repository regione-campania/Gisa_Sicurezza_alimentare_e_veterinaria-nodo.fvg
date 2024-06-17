package org.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.modules.suap.campiestesiv2.CampiEstesiV2;
import org.aspcfs.utils.GestoreConnessioni;
import org.json.JSONObject;

public class TestServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		Connection conn = null;
		try 
		{


			conn =  GestoreConnessioni.getConnection();
			Integer idLinea = Integer.parseInt(req.getParameter("idLinea"));
			Integer idRelazione = Integer.parseInt(req.getParameter("idRelazione"));
			JSONObject campi = CampiEstesiV2.getCampiEstesi(idLinea,  idRelazione,conn);

			 

			resp.setContentType("application/json");
			resp.getWriter().println(campi.toString());



			
			
			
			
		} 
		catch (Exception ex) {
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
		finally
		{
			try{pst.close();}catch(Exception ex){}
			try{rs.close();}catch(Exception ex){}
			GestoreConnessioni.freeConnection(conn);
		}
	}
	
	 
	
	
}
