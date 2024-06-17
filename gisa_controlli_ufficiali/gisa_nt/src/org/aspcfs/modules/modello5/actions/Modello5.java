package org.aspcfs.modules.modello5.actions;
import java.sql.Connection;
import java.util.logging.Logger;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.modello5.base.Mod5;
import org.aspcfs.modules.vigilanza.base.Ticket;

import com.darkhorseventures.framework.actions.ActionContext;


public final class Modello5 extends CFSModule {
	

	Logger logger = Logger.getLogger("MainLogger");


	public String executeCommandView(ActionContext context) {
		
		int idControllo = -1;
		
		try { idControllo = Integer.parseInt(context.getRequest().getParameter("idControllo"));} catch (Exception e) {}
		if (idControllo == -1)
			try { idControllo = Integer.parseInt((String)context.getRequest().getAttribute("idControllo"));} catch (Exception e) {}
		
		String tipoMod = context.getRequest().getParameter("tipoMod");
		if (tipoMod == null)
			tipoMod = (String) context.getRequest().getAttribute("tipoMod");
		
		context.getRequest().setAttribute("tipoMod", tipoMod);
		
		int rev = -1;
		
		try { rev = Integer.parseInt(context.getRequest().getParameter("rev"));} catch (Exception e) {}
		if (rev == -1)
			try { rev = Integer.parseInt((String)context.getRequest().getAttribute("rev"));} catch (Exception e) {}
		
	
		Connection db = null;
		try {
			db = this.getConnection(context);
			
			Ticket cu = new Ticket(db, idControllo);
			context.getRequest().setAttribute("cu", cu);

			Mod5 mod = new Mod5(db, idControllo);
			context.getRequest().setAttribute("mod", mod);
		}catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		if (rev == 9)
			return "Mod5Rev9OK";
		else if (rev == 8)
			return "Mod5Rev8OK";
		return "";
	}

public String executeCommandSave(ActionContext context) {
		
		int idControllo = Integer.parseInt(context.getRequest().getParameter("idControllo"));
		String tipoMod = context.getRequest().getParameter("tipoMod");
		int rev = Integer.parseInt(context.getRequest().getParameter("rev"));
		
		int id = -1;
		try { id = Integer.parseInt(context.getRequest().getParameter("id")); } catch (Exception e) {}
		
		Connection db = null;
		try {
			db = this.getConnection(context);
			Mod5 mod = new Mod5();
			mod.buildDaRequest(context);
			mod.setControlloId(idControllo);
			if (id > 0){
				mod.setId(id);
				mod.setModifiedBy(getUserId(context));
				mod.update(db);
			}
			else {
				mod.setEnteredBy(getUserId(context));
				mod.insert(db);
			}
			
			mod.updateCu(db);
			
			context.getRequest().setAttribute("idControllo", idControllo);
			context.getRequest().setAttribute("tipoMod", tipoMod);
			context.getRequest().setAttribute("rev", String.valueOf(rev));


		}catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		return executeCommandView(context);
	}




}
