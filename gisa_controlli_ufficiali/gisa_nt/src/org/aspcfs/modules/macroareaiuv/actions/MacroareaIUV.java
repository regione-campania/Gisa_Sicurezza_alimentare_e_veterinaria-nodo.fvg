package org.aspcfs.modules.macroareaiuv.actions;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.login.beans.UserBean;

import com.darkhorseventures.framework.actions.ActionContext;

public final class MacroareaIUV extends CFSModule {
	
	public String executeCommandDashboardScelta(ActionContext context) {
	    if (!hasPermission(context, "macroarea-view")) {
	      if (!hasPermission(context, "macroarea-view")) {
	        return ("PermissionError");
	      }
	      
	    }
	    addModuleBean(context, "Dashboard", "Dashboard");
	    
	  

	    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");


	  
	    context.getRequest().setAttribute("Return", "Accounts");
	    return ("DashboardSceltaOK");
	  }

}
