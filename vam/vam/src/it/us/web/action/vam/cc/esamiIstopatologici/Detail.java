package it.us.web.action.vam.cc.esamiIstopatologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		EsameIstopatologico esame = (EsameIstopatologico) persistence.find(EsameIstopatologico.class, interoFromRequest("id") );	
		if(esame.getTipoDiagnosi().getId()!=3)
			esame.setDiagnosiNonTumorale("");
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) esame.getCartellaClinica();

		//Settaggio cc in sessione dovuto al fatto che si può entrare nel dettaglio dettaglio istologico da 'Gestione Istopatologici'
		//senza passare da dettaglio CC che è il punto in cui viene settata in session per poi essere richiamata in tutte le sezioni
		session.setAttribute("cc", cc);
		session.setAttribute("idCc", cc.getId());
			
		
		req.setAttribute( "esame", esame );		
				
		gotoPage( "/jsp/vam/cc/esamiIstopatologici/detail.jsp" );
	}
}

