package org.aspcfs.modules.schedeCentralizzate.actions;

import java.sql.Connection;
import java.sql.SQLException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.schedeCentralizzate.base.SchedaCentralizzataControllo;
import org.aspcfs.modules.vigilanza.base.Ticket;

import com.darkhorseventures.framework.actions.ActionContext;

public class SchedaCentralizzataControlloAction extends CFSModule {
	public SchedaCentralizzataControlloAction(){
		
	}
	
	public String executeCommandGeneraScheda(ActionContext context) {

		String ticketId = context.getRequest().getParameter("ticketId");
	
		SchedaCentralizzataControllo scheda = new SchedaCentralizzataControllo();
		scheda.setTicketId(Integer.parseInt(ticketId));
			
		Connection db = null;
		
		try {
			db = this.getConnection(context);
			
			Ticket t = new Ticket();
			t.queryRecord(db, Integer.parseInt(ticketId));
			scheda.setTipo(t.getTipoCampione());
			scheda.popolaScheda(db);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("SchedaControllo", scheda);
		return "SchedaControlloOk";
		
	}

	
	
	
	
}
