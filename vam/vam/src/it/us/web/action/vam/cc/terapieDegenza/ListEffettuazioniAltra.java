package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.TerapiaEffettuata;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupModalitaSomministrazioneFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupVieSomministrazioneFarmaci;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Set;

public class ListEffettuazioniAltra extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("terapia");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		int idTerapiaAssegnata = interoFromRequest("idTerapiaAssegnata");
		
		TerapiaAssegnata ta = (TerapiaAssegnata) persistence.find(TerapiaAssegnata.class, idTerapiaAssegnata);
		
		//Recupero di tutte le terapie
		ArrayList<TerapiaEffettuata> teList = (ArrayList<TerapiaEffettuata>) persistence.getNamedQuery("GetTerapieEffettuate").setInteger("idTerapiaAssegnata", idTerapiaAssegnata).list();
	
		req.setAttribute("ta", ta);	
		req.setAttribute("teList", teList);	
											
		gotoPage("popup", "/jsp/vam/cc/terapieDegenza/listEffettuazioniAltra.jsp");
	}
}


