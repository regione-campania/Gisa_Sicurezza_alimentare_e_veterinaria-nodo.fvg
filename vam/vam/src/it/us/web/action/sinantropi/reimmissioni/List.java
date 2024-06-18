package it.us.web.action.sinantropi.reimmissioni;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_reimmissione");
	}

	public void execute() throws Exception
	{		
		
		int idCattura = interoFromRequest("idCattura");
		
		Catture c 	= (Catture) persistence.find(Catture.class, idCattura);
		
		Sinantropo s = c.getSinantropo();				
		
		req.setAttribute("c", c);
		req.setAttribute("s", s);
				
		gotoPage("sinantropi_default","/jsp/sinantropi/reimmissioni/list.jsp");
		
	}
		
}


