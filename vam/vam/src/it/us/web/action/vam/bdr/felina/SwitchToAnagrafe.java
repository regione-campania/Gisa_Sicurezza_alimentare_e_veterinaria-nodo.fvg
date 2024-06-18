package it.us.web.action.vam.bdr.felina;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;

public class SwitchToAnagrafe extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "MAIN", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		BUtente utenteCopia = utente;
		
		//Fase di Logout
		/*if( utente != null )
		{
			eliminaUtenteContext(utente.getUsername());
			String system = (String) session.getAttribute("system");
			session.setAttribute( "utente", null );
			session.setAttribute("utente", null);
			try
			{
				session.invalidate();
			}
			catch (IllegalStateException e) 
			{
				
			}		
			utente = null;
		}*/
		
		//Redirect alla bdr interessata
		redirectTo(CaninaRemoteUtil.getLoginUrlNuovo(utenteCopia, null, null, null, null, null, connection,req, null));
	}
	
}
