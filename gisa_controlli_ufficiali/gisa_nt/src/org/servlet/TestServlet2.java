package org.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.modules.suap.campiestesiv2.CampiEstesiV2;
import org.aspcfs.utils.GestoreConnessioni;

public class TestServlet2 extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		Connection conn = null;
		try 
		{
			conn =  GestoreConnessioni.getConnection();
			int idIstanzaVal = Integer.parseInt(req.getParameter("idIstanzaVal"));
			int idRelStabLp = Integer.parseInt(req.getParameter("idRelStabLp"));
//			System.out.println("ISTANZA VAL "+idIstanzaVal);
			Map<String, String[]> pars = req.getParameterMap();
			HashMap<String,String> values = new HashMap<String,String>();
			for(String parName : pars.keySet())
			{
				if(parName.equalsIgnoreCase("idIstanzaVal") || parName.equalsIgnoreCase("idRelStabLp")) /*questi li scarto perche' non sono i campi estesi ovviamente */
					continue;
				
				String[] t = pars.get(parName);
				for(String val : t)
				{
//					System.out.print(parName+"-"+val+" ,");
					
					values.put(parName, val);
				}
//				System.out.println("\n");
			}
			CampiEstesiV2.upsertValoriCampi(idRelStabLp, idIstanzaVal, values, conn);
			
			
			
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
