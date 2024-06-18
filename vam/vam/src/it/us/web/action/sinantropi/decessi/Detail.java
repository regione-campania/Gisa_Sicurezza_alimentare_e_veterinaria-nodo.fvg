package it.us.web.action.sinantropi.decessi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Detenzioni;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.CartellaClinica;
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
		setSegnalibroDocumentazione("sinantropi_decesso");
	}

	public void execute() throws Exception
	{
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo) persistence.find(Sinantropo.class, idSinantropo);
		
		if (s.getDataDecesso() == null) {
			goToAction(new ToAdd());
		}
		else {		
		
		req.setAttribute("s", s);		
							
		gotoPage("sinantropi_default", "/jsp/sinantropi/decessi/detail.jsp");
		}
	}
}


