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

public class GestioneAnagraficaGetComuneById extends CFSModule{
	
public String executeCommandSearch(ActionContext context) throws IOException{
		
		String output = "[]";
		int idComune = Integer.parseInt(context.getRequest().getParameter("idComune"));
		
		String sql = "select (string_agg(row_to_json(tab)::text, ',')::json)::text as comune from("
				+ "select c.id::text, c.nome "
				+ "from comuni1 c "
				+ " where id = ?) tab";

		Connection db = null;
		try{
			db = GestoreConnessioni.getConnection();
			PreparedStatement pst = db.prepareStatement(sql);
			pst.setInt(1, idComune);
			ResultSet rs= pst.executeQuery();
			
			while(rs.next())
			{
				output = rs.getString("comune");		 
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
		writer.print(output);
		writer.close();
		return "";		
	
	}

}
