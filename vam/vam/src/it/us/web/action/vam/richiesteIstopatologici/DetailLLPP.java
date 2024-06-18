package it.us.web.action.vam.richiesteIstopatologici;

import java.util.Set;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class DetailLLPP extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
//		can( gui, "w" );
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
		EsameIstopatologico esame = (EsameIstopatologico) persistence.find (EsameIstopatologico.class, interoFromRequest("id") );	
		
		req.setAttribute( "esame", esame );		
	
		Set<LookupAlimentazioni> 	la = esame.getLookupAlimentazionis();
		Set<LookupHabitat> 			lh = esame.getLookupHabitats();
		Set<LookupAlimentazioniQualita> 	listAlimentazioniQualita = esame.getLookupAlimentazioniQualitas();
		req.setAttribute("listAlimentazioniQualita", listAlimentazioniQualita);
		
		req.setAttribute( "la", la );
		req.setAttribute( "lh", lh );
		
		boolean liberoProfessionista = booleanoFromRequest("liberoProfessionista");
		
		req.setAttribute("liberoProfessionista", liberoProfessionista);
		
		gotoPage("onlybody","/jsp/vam/richiesteIstopatologici/detailLLPP.jsp" );
	}
}


