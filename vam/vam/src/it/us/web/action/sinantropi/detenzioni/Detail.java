package it.us.web.action.sinantropi.detenzioni;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Detenzioni;
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
		setSegnalibroDocumentazione("sinantropi_detenzione");
	}
	
	public void execute() throws Exception
	{
		int idDetenzione = interoFromRequest("idDetenzione");
		
		Detenzioni d = (Detenzioni) persistence.find(Detenzioni.class, idDetenzione);
		Sinantropo s = (Sinantropo) d.getCatture().getSinantropo();
		Catture c = (Catture) d.getCatture();
		
		req.setAttribute("s", s);
		req.setAttribute("d", d);	
		req.setAttribute("c", c);	
							
		gotoPage("sinantropi_default", "/jsp/sinantropi/detenzioni/detail.jsp");
	}
}

