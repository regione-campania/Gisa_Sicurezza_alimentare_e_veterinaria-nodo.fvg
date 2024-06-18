package it.us.web.action;

import it.us.web.bean.BGuiView;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class LogOperazioni extends GenericAction {

	@Override
	public void can() throws AuthorizationException, Exception {
		BGuiView gui = GuiViewDAO.getView( "LOG_OPERAZIONI", "FUNZIONI", "MAIN" );
		can( gui, "w" );
	}

	@Override
	public void setSegnalibroDocumentazione() {
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void execute() throws Exception {
		gotoPage("/jsp/logOperazioni/home.jsp");
	}

}
