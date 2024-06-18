package org.aspcfs.modules.richiestecontributi.actions;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.richiestecontributi.base.QTestBean;

import com.darkhorseventures.framework.actions.ActionContext;

public class QTest extends CFSModule {
	 
		public String executeCommandDefault(ActionContext context) {
		    return executeCommandView(context);
		  }

			
		  public String executeCommandView(ActionContext context) {
		    if (!hasPermission(context, "richiesta-contributi-view")) {
		      return ("PermissionError");    }

		    
		    return ("init");
		  }
		  
		  
		  public String executeCommandAddRichiesta (ActionContext context) {
			  if (!hasPermission(context, "richiesta-contributi-view")) {
			      return ("PermissionError");
			    }
			  return"AddRichiesta";
		  }

		  public String executeCommandAvviaRichiesta(ActionContext context) {
			  if (!hasPermission(context, "richiesta-contributi-view")) {
			      return ("PermissionError");
			    }
			  
			
		    Connection db = null;
		    
		    try {
		    	
		      db = this.getConnection(context);	     
		      
		      String query=context.getRequest().getParameter("query");
		      
		      
		      QTestBean qtb=new QTestBean();
		            
		      
		      GregorianCalendar gc1 = new GregorianCalendar();
		     
		      SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss:SSSS");
		      
		      String di=sdf.format(gc1.getTime());
		      ResultSet resultQuery = null; 
		      resultQuery=qtb.executeQuery(db, query,context);
		    
		      GregorianCalendar gc2 = new GregorianCalendar();
		      String df=sdf.format(gc2.getTime());
		     		     
		      context.getRequest().setAttribute("resQuery", resultQuery);
		      context.getRequest().setAttribute("dataInizio", di);
		      context.getRequest().setAttribute("dataFine", df);
		      
		      
		    } catch (SQLException e) {
		      e.printStackTrace();
		      context.getRequest().setAttribute("Error", e.getMessage());
		      return ("SystemError");
		    } finally {
		      this.freeConnection(context, db);
		    }
		    return ("ViewResult");
		  }

		  
	
		  
		}
