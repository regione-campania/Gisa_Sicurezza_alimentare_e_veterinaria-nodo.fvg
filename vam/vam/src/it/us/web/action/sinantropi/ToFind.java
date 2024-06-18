package it.us.web.action.sinantropi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToFind extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "MAIN", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_ricerca");
	}

	public void execute() throws Exception
	{			
			
		gotoPage("sinantropi_default","/jsp/sinantropi/find.jsp");				
		
	}
}


