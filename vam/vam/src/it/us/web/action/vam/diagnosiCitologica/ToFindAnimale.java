package it.us.web.action.vam.diagnosiCitologica;

import it.us.web.action.GenericAction;
import it.us.web.exceptions.AuthorizationException;

public class ToFindAnimale extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "MAIN", "MAIN" );
//		can( gui, "w" );
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{			
			
		gotoPage("onlybody","/jsp/vam/richiesteIstopatologici/findAnimale.jsp");					
		
	}
}

