package it.us.web.action.vam.cc.esamiIstopatologici;

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
		if (interoFromRequest("id")!=-1){
			EsameIstopatologico esame = (EsameIstopatologico) persistence.find (EsameIstopatologico.class, interoFromRequest("id") );	
			if(esame.getTipoDiagnosi().getId()!=3)
				esame.setDiagnosiNonTumorale("");
			req.setAttribute( "esame", esame);
			req.setAttribute( "idIstopatologico", String.valueOf(esame.getId()) );
			
			if (esame.getCartellaClinica()!=null)
			req.setAttribute( "idAccettazione", String.valueOf(esame.getCartellaClinica().getAccettazione().getId()) );


		}
		//gotoPage( "uploadPopup", "/jsp/vam/cc/esamiIstopatologici/gestioneImmagini.jsp" );
		goToAction(new ListaAllegati());

	}
}


