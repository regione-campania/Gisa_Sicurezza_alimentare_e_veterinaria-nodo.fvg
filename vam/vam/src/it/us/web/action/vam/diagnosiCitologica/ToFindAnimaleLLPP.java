package it.us.web.action.vam.diagnosiCitologica;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToFindAnimaleLLPP extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "DIAGNOSI_CITOLOGICA", "ADD_LLPP", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{			
			
		gotoPage("onlybody","/jsp/vam/diagnosiCitologica/findAnimaleLLPP.jsp");					
		
	}
}

