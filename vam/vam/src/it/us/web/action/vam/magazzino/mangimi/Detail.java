package it.us.web.action.vam.magazzino.mangimi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.MagazzinoMangimi;
import it.us.web.bean.vam.lookup.LookupEtaAnimale;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupMangimi;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupTipoAnimale;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "MAGAZZINO", "MANGIMI", "DETAIL" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("magazzinoMangimi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		ArrayList<LookupMangimi> 		mangimi 				= (ArrayList<LookupMangimi>) persistence.findAll(LookupMangimi.class);
		ArrayList<LookupTipoAnimale> 	tipiAnimale 			= (ArrayList<LookupTipoAnimale>) persistence.findAll(LookupTipoAnimale.class);
		ArrayList<LookupEtaAnimale> 	etaAnimale 				= (ArrayList<LookupEtaAnimale>) persistence.findAll(LookupEtaAnimale.class);
		ArrayList<MagazzinoMangimi> 	magazzinoMangimiList 	= (ArrayList<MagazzinoMangimi>) persistence.getNamedQuery("GetMangimiByClinica").setInteger("idClinica", utente.getClinica().getId()).list();
	
		req.setAttribute("mangimi", 		 mangimi);
		req.setAttribute("tipiAnimale", 	 tipiAnimale);	
		req.setAttribute("etaAnimale", 		 etaAnimale);	
		req.setAttribute("magazzinoMangimiList", 	magazzinoMangimiList);	
						
		gotoPage("/jsp/vam/magazzino/mangimi/detail.jsp");
	}
}

