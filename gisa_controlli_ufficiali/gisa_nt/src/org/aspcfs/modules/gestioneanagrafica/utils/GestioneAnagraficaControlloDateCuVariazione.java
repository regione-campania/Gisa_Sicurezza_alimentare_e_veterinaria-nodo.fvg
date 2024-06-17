package org.aspcfs.modules.gestioneanagrafica.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.utils.GestoreConnessioni;
import org.directwebremoting.extend.LoginRequiredException;

import com.darkhorseventures.framework.actions.ActionContext;

public class GestioneAnagraficaControlloDateCuVariazione extends CFSModule{
	
	public String executeCommandSearch(ActionContext context) throws IOException{
			
			String output = "";
			String id_cu = "";
			String data_variazione = "";
			id_cu = context.getRequest().getParameter("id_cu");
			data_variazione = context.getRequest().getParameter("data_variazione");
			
			String sql = "select count(*) as esito "
					+ "from ticket "
					+ " where ticketid = ? "
					+ " AND  to_char(assigned_date, 'YYYY-MM-DD')::timestamp without time zone <= ?::timestamp without time zone";
			Connection db = null;
			try{
				db = GestoreConnessioni.getConnection();
				PreparedStatement pst = db.prepareStatement(sql);
				pst.setInt(1, Integer.parseInt(id_cu));
				pst.setString(2, data_variazione);
				ResultSet rs= pst.executeQuery();
				
				System.out.println("query verifica da cu vs variazione " + pst);
				while(rs.next())
				{
					if(rs.getInt("esito") > 0){
						output = "1";
					} else {
						output = "0";
					}
					
				}
			
			}catch(LoginRequiredException e)
			{
				throw e;
			}catch(Exception e)
			{
				e.printStackTrace();		
			}
			finally
			{
				GestoreConnessioni.freeConnection(db);
			}
			
			PrintWriter writer = context.getResponse().getWriter();
			writer.print("{\"esito\":\""+ output +"\"}");
			writer.close();
			return "";	
			
		}
}
