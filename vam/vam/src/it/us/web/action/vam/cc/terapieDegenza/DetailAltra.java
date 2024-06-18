package it.us.web.action.vam.cc.terapieDegenza;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupModalitaSomministrazioneFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupVieSomministrazioneFarmaci;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class DetailAltra extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
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
		int id = interoFromRequest("idTerapiaDegenza");
		
		//Recupero Bean Terapia Degenza
		TerapiaDegenza td = (TerapiaDegenza) persistence.find (TerapiaDegenza.class, id);
						
		ArrayList<LookupModalitaSomministrazioneFarmaci> modalitaSomministrazione
			= (ArrayList<LookupModalitaSomministrazioneFarmaci>) persistence.findAll(LookupModalitaSomministrazioneFarmaci.class);
		
		//Recupero di tutte le terapie assegnata per quella determinata degenza
		ArrayList<TerapiaAssegnata> taList = (ArrayList<TerapiaAssegnata>) persistence.getNamedQuery("GetTerapieAssegnate").setInteger("idTerapiaDegenza", id).list();

			
		req.setAttribute("taList", taList);		
		req.setAttribute("td", td);		
		
		req.setAttribute("modalitaSomministrazione", 	modalitaSomministrazione);	
				
		gotoPage("/jsp/vam/cc/terapieDegenza/detailAltra.jsp");
	}
}

