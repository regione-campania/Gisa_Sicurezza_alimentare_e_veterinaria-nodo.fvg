package it.us.web.action.vam.cc;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToFind extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "MAIN", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("cc");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{			
			
		gotoPage("/jsp/vam/cc/find.jsp");					
		
	}
}

