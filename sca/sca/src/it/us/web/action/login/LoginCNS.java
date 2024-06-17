package it.us.web.action.login;

import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import it.us.web.action.GenericAction;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;

public class LoginCNS extends GenericAction {

	@Override
	public void can() throws AuthorizationException
	{
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		if( utenteGuc != null )
		{
			Enumeration<String> e = session.getAttributeNames();
			while( e.hasMoreElements() )
			{
				session.removeAttribute( e.nextElement() );
			}
			utenteGuc = null;
		}
		
		String cf = stringaFromRequest( "codiceFiscale" );
				
		utenteGuc = UtenteDAO.authenticateUnifiedAccess(cf,db);
		((HashMap<String, HttpSession>) session.getServletContext().getAttribute("utenti")).put(utenteGuc.getUsername(), session);
		
		if( utenteGuc == null)
		{
			setErrore("Autenticazione fallita");
		}
		
		else {
			
			session.setAttribute( "utenteGuc", utenteGuc );			
		}
			
		
		redirectTo( "IndexCNS.us" );
		
	}
}
