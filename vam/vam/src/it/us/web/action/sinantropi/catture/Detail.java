package it.us.web.action.sinantropi.catture;

import it.us.web.action.GenericAction;
import it.us.web.action.sinantropi.decessi.ToAdd;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_cattura");
	}

	public void execute() throws Exception
	{
		int idCattura = interoFromRequest("idCattura");
	
		Catture c = (Catture) persistence.find(Catture.class, idCattura);
		Sinantropo s = c.getSinantropo();
		
		req.setAttribute("s", s);	
		req.setAttribute("c", c);		
							
		gotoPage("sinantropi_default", "/jsp/sinantropi/catture/detail.jsp");
	}
}




