package org.aspcfs.modules.postit.actions;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Timestamp;
import java.util.logging.Logger;

import org.aspcfs.modules.actions.CFSModule;

import com.darkhorseventures.framework.actions.ActionContext;


public final class PostIt extends CFSModule 
{
	
	Logger logger = Logger.getLogger("MainLogger");
	
	public String executeCommandDefault( ActionContext context )
	{
		return executeCommandDashboard(context);
	}
	
	public String executeCommandDashboard(ActionContext context) {
		
		 if (!hasPermission(context, "accounts-dashboard-view")) {
			 if (!hasPermission(context, "postit-view")) {
		        return ("PermissionError");
		     }
		 } 
		 
		 return "MessaggioOK";
		  
	}
	
	public String executeCommandMessaggio(ActionContext context) {
		
		 if (!hasPermission(context, "accounts-dashboard-view")) {
			 if (!hasPermission(context, "postit-view")) {
		        return ("PermissionError");
		     }
		 } 
		 
			try{
			
				String messaggio = context.getParameter("messaggio");
				
				
				String pathFile = context.getServletContext().getRealPath("templates/postit.txt");
				
				File f = new File(pathFile);
				
				FileOutputStream fos = new FileOutputStream(f);
				PrintStream ps = new PrintStream(fos);
				//String msg = "<h1><center><font color = 'red'>"+messaggio+"</font></center></h1>" ;
				ps.print(messaggio);
				ps.flush();
				context.getRequest().setAttribute("mess", "Messaggio inserito con successo");

				Timestamp dataUltimaModifica = new Timestamp(System.currentTimeMillis());
				context.getServletContext().setAttribute("MessaggioHome", dataUltimaModifica+"&&"+messaggio);
				
			}
			catch (Exception e) {
				logger.severe("Errore nell'inserimento del messaggio nel post-it");
				context.getRequest().setAttribute("mess", "Errore durante inserimento del messaggio nel post-it");
			}
		 
		 return "MessaggioOK";
		  
	}

}