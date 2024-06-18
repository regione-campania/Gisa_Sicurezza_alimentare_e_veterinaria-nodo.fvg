package it.us.web.action.vam.cc.autopsie;

import it.us.web.action.GenericAction;
import it.us.web.action.documentale.ListaAllegati;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Autopsia;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class GestioneImmagini extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("esameNecroscopico");
	}

	public void execute() throws Exception
	{
		if (interoFromRequest("id")!=-1){
			Autopsia autopsia = (Autopsia) persistence.find (Autopsia.class, interoFromRequest("id") );	
			req.setAttribute( "a", autopsia );
			req.setAttribute( "idAutopsia", String.valueOf(autopsia.getId()) );
			req.setAttribute( "idAccettazione", String.valueOf(autopsia.getCartellaClinica().getAccettazione().getId()) );

		}
		
		req.setAttribute( "readonly", stringaFromRequest("readonly") );
		//gotoPage( "uploadPopup", "/jsp/vam/cc/autopsie/gestioneImmagini.jsp" );
		
		goToAction(new ListaAllegati());

	}
}


