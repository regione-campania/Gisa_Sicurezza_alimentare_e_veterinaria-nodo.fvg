package org.aspcfs.modules.bloccocu.actions;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.bloccocu.base.EventoBloccoCu;
import org.aspcfs.modules.login.beans.UserBean;

import com.darkhorseventures.framework.actions.ActionContext;

public class EventoCu extends CFSModule{
	
	
	public String executeCommandViewBlocco(ActionContext context)
	{
		Connection db = null;
		try
		{
			db = this.getConnection(context);
			EventoBloccoCu bloccoCu = new EventoBloccoCu();
			bloccoCu.queryRecord(db);
			
			context.getRequest().setAttribute("EventoBlocco", bloccoCu);
			
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{	
			this.freeConnection(context, db);
		}
		return "viewBloccoOK";
		
	}
	
	public String executeCommandAddBlocco(ActionContext context)
	{
		Connection db = null;
		try
		{
			db = this.getConnection(context);
			EventoBloccoCu bloccoCu = new EventoBloccoCu();
			bloccoCu.queryRecord(db);
			
			context.getRequest().setAttribute("Error",context.getRequest().getAttribute("Error"));
			context.getRequest().setAttribute("BloccoCu", bloccoCu);
			
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{	
			this.freeConnection(context, db);
		}
		return "addBloccoOK";
		
	}
	
	
	private void setDataBloccoSblocco(EventoBloccoCu bloccoCu)
	{
		Date data_corrente = new Date(System.currentTimeMillis());
		
	
	}
	
	
	
	public String executeCommandInsertBlocco(ActionContext context) throws ParseException
	{
		
		Connection db = null;
		try
		{
			db = this.getConnection(context);
			
			EventoBloccoCu eventoEsistente = new EventoBloccoCu();
			eventoEsistente.queryRecord(db);
			
			
			EventoBloccoCu bloccoCu = (EventoBloccoCu)context.getFormBean();
			//bloccoCu.setDataBloccoSblocco(new Date(System.currentTimeMillis()));
			bloccoCu.setData_blocco(context.getParameter("data_blocco"));
			bloccoCu.setData_sblocco(context.getParameter("data_sblocco"));

			
			
			UserBean user = (UserBean)context.getRequest().getSession().getAttribute("User");
			bloccoCu.setEnteredby(user.getUserId());
			bloccoCu.insert_blocco(db,context);
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{	
			this.freeConnection(context, db);
		}
		return executeCommandViewBlocco(context);
		
	}
	
	
	public String executeCommandInsertSblocco(ActionContext context)
	{
		Connection db = null;
		try
		{
			db = this.getConnection(context);
			EventoBloccoCu bloccoCu = (EventoBloccoCu)context.getFormBean();
			bloccoCu.setId(context.getParameter("id"));
			UserBean user = (UserBean)context.getRequest().getSession().getAttribute("User");
			bloccoCu.setModifiedby(user.getUserId());
			bloccoCu.insert_sblocco(db);
			
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{	
			this.freeConnection(context, db);
		}
		return executeCommandViewBlocco(context);
		
	}
	
	

}
