package org.aspcfs.utils.ws;

import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.gestioneanagrafica.base.Stabilimento;
import org.aspcfs.modules.noscia.dao.StabilimentoDAO;

import com.darkhorseventures.framework.actions.ActionContext;
import com.google.gson.Gson;



public class Verificaesistenzastabilimento extends CFSModule
{

	public String  executeCommandSearch(ActionContext context) throws Exception 
	{
		Gson gson = new Gson();
		String json = "";
		Connection db = null;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, String[]> parameterMap = context.getRequest().getParameterMap();
		Stabilimento stab = new Stabilimento(parameterMap);
		
		Boolean exist = null;
		
		try 
		{
		    db = this.getConnection(context);
		    StabilimentoDAO stabDao = new StabilimentoDAO(stab);
		    exist = stabDao.exist(db);
		    
		    
		}
		catch(Exception errorMessage)
		{
		
		}
		finally
		{
		    this.freeConnection(context, db);
		}
				
		if(exist)
		{
			map.put("status", "1");  
		}
		else
		{
			map.put("status", "2");
		}
		
		json = gson.toJson(map);	
		
		PrintWriter writer = context.getResponse().getWriter();
		writer.print(json);
		writer.close();
		
		return "";
		
	}


}
