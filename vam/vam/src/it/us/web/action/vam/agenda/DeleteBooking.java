package it.us.web.action.vam.agenda;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.BookingClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DeleteBooking extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DELETE", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("agenda");
	}

	public void execute() throws Exception
	{
		final Logger logger = LoggerFactory.getLogger(DeleteBooking.class);
		
		//ID Prenotazione	
		int id = Integer.parseInt(req.getParameter("id"));
						
		BookingClinica bc = (BookingClinica) persistence.find(BookingClinica.class, id);
				
		bc.setTrashedDate(new Date());
		
		validaBean( bc ,  new ToDetail() );
		
		try 
		{
			persistence.update(bc);
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
			logger.error("Cannot Delete this booking" + e.getMessage());
			throw e;		
		}
	
		setMessaggio("Cancellazione prenotazione eseguita con successo");
		redirectTo( "vam.agenda.ToDetail.us" );	
	}
}


