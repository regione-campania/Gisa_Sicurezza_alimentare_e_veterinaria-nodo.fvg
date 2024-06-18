package it.us.web.action.vam.statistiche;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Home extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "STATISTICHE", "MAIN", "MAIN" );
		can( gui, "w" );
	}

	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("statistiche");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@Override
	public void execute() throws Exception
	{
		gotoPage( "/jsp/vam/statistiche/home.jsp" );
	}
	
}
