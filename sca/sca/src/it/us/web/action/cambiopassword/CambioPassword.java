package it.us.web.action.cambiopassword;

import it.us.web.action.GenericAction;
import it.us.web.exceptions.AuthorizationException;

public class CambioPassword extends GenericAction
{
	
	
	
	public CambioPassword() {		
	}
	
	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
			gotoPage("/jsp/cambiopassword/cambioPassword.jsp" );
		}


	
}
	
