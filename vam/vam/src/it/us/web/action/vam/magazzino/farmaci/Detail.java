package it.us.web.action.vam.magazzino.farmaci;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "MAGAZZINO", "FARMACI", "DETAIL" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("magazzinoFarmaci");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		ArrayList<LookupFarmaci> farmaci 
			= (ArrayList<LookupFarmaci>) persistence.findAll(LookupFarmaci.class);
				
		ArrayList<LookupTipiFarmaco> tipiFarmaco
			= (ArrayList<LookupTipiFarmaco>) persistence.findAll(LookupTipiFarmaco.class);
		
		ArrayList<MagazzinoFarmaci> mf 
		= (ArrayList<MagazzinoFarmaci>) persistence.findAll(MagazzinoFarmaci.class);
	
		req.setAttribute("mf", 			mf);		
		req.setAttribute("farmaci", 	farmaci);			
		req.setAttribute("tipiFarmaco", tipiFarmaco);	
		
		ArrayList<MagazzinoFarmaci> mfList 
		= (ArrayList<MagazzinoFarmaci>) persistence.getNamedQuery("GetFarmaciByClinica").setInteger("idClinica", utente.getClinica().getId()).list();
		
		req.setAttribute("mfList", 	mfList);	
						
		gotoPage("/jsp/vam/magazzino/farmaci/detail.jsp");
	}
}

