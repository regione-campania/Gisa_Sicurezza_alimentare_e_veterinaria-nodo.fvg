package it.us.web.action.vam.izsm.esamiIstopatologici;

import it.us.web.action.GenericAction;
import it.us.web.action.documentale.ListaAllegati;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.EsameIstopatologico;
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
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		EsameIstopatologico esame = (EsameIstopatologico) persistence.find (EsameIstopatologico.class, interoFromRequest("id") );	
		req.setAttribute( "esame", esame );
		req.setAttribute( "idIstopatologico", String.valueOf(esame.getId()) );
		if (esame.getCartellaClinica()!=null)
			req.setAttribute( "idAccettazione", String.valueOf(esame.getCartellaClinica().getAccettazione().getId()) );
		
		req.setAttribute( "readonly", "false");
		//gotoPage( "uploadPopup", "/jsp/vam/izsm/esamiIstopatologici/gestioneImmagini.jsp" );
		goToAction(new ListaAllegati());

	}
}


