package it.us.web.action.vam.helpDesk;

import java.util.Date;

import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtenteAll;
import it.us.web.bean.vam.Ticket;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;

public class Edit extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "HD", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("helpDesk");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);
			
		int id = interoFromRequest("idTicket");
		
		Ticket t = (Ticket) persistence.find(Ticket.class, id);
		
		t.setAperto(false);
		t.setClosed(new Date());
		BUtenteAll ut = UtenteDAO.getUtenteAll(utente.getId());
		t.setClosedBy( ut);
		
		String cd = stringaFromRequest("closureDescription");
		if (!cd.equalsIgnoreCase(""))
			t.setClosureDescription(cd);
		
		try {
			persistence.update(t);
			persistence.commit();
		}
		catch (RuntimeException e)
		{
			try
			{		
				persistence.rollBack();				
			}
			catch (HibernateException e1)
			{				
				logger.error("Error during Rollback transaction" + e1.getMessage());
			}
			logger.error("Cannot close Ticket" + e.getMessage());
			throw e;		
		}
		
		setMessaggio("Segnalazione numero "+" "+ t.getId()+ " " + " chiusa con successo");
		redirectTo("vam.helpDesk.List.us");
		
	}
}


