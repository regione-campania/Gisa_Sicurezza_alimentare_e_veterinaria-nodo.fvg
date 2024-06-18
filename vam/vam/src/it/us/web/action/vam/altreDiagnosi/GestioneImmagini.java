package it.us.web.action.vam.altreDiagnosi;

import it.us.web.action.GenericAction;
import it.us.web.action.documentale.ListaAllegati;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.AltreDiagnosi;
import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class GestioneImmagini extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "ALTRE_DIAGNOSI", "LIST_LLPP", "MAIN" );
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
		AltreDiagnosi esame = (AltreDiagnosi) persistence.find (AltreDiagnosi.class, interoFromRequest("id") );	
		req.setAttribute( "esame", esame );
		req.setAttribute( "idAltraDiagnosi", String.valueOf(esame.getId()) );
		
		req.setAttribute( "readonly", "false");
		goToAction(new ListaAllegati());

	}
}


