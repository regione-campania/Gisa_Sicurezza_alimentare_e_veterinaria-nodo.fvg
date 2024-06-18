package it.us.web.action.vam.helpDesk;

import java.util.ArrayList;
import java.util.Date;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.lookup.LookupTickets;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAdd extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "HD", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("helpDesk");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{	
		
		//Recupero lista problemi
		ArrayList<LookupTickets> tipologieTickets = (ArrayList<LookupTickets>) persistence.findAll(LookupTickets.class);
					
		req.setAttribute("tipologieTickets", tipologieTickets);		
		req.setAttribute("utente", utente);
		req.setAttribute("dataRichiesta", new Date());
		
		gotoPage("/jsp/vam/helpDesk/add.jsp");
			
	}
}
