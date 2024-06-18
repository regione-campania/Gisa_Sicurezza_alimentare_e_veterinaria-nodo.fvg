package it.us.web.action.vam.helpDesk;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Ticket;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "HD", "EDIT", "MAIN" );
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
			
		int id = interoFromRequest("idTicket");
		
		Ticket t = (Ticket) persistence.find(Ticket.class, id);
	
		req.setAttribute("t", t);		
							
		gotoPage("/jsp/vam/helpDesk/edit.jsp");
	}
}


