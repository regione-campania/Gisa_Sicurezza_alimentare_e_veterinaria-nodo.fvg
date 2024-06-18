package it.us.web.action.sinantropi.catture;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Set;

public class List extends GenericAction {

		
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "LIST", "MAIN" );
		can( gui, "w" );
	}

	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_cattura");
	}
	
	public void execute() throws Exception
	{		
		
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo) persistence.find(Sinantropo.class, idSinantropo);
				
		req.setAttribute("s", s);
				
		gotoPage("sinantropi_default","/jsp/sinantropi/catture/list.jsp");
		
	}
		
}

