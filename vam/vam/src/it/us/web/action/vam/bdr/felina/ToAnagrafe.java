package it.us.web.action.vam.bdr.felina;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAnagrafe extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("accettazione");
	}

	@Override
	public void execute() throws Exception
	{
		req.setAttribute("identificativo", stringaFromRequest("identificativo"));
		req.setAttribute("operazioneIscrizione", (LookupOperazioniAccettazione)persistence.find(LookupOperazioniAccettazione.class, IdOperazioniBdr.iscrizione));
		gotoPage( "/jsp/vam/bdr/felina/anagrafa.jsp" );
	}
	
}
