package it.us.web.action.vam.diagnosiCitologica;

import it.us.web.action.GenericAction;
import it.us.web.exceptions.AuthorizationException;

public class ToFind extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "MAIN", "MAIN" );
//		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{			
			
		gotoPage("/jsp/vam/richiesteIstopatologici/findEsame.jsp");					
		
	}
}
