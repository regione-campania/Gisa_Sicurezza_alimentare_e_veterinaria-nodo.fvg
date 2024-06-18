package it.us.web.action.vam.agenda;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.BookingClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.DateUtils;
import java.util.Date;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EditBooking extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("agenda");
	}

	public void execute() throws Exception
	{
		final Logger logger = LoggerFactory.getLogger(EditBooking.class);
		
		//ID Prenotazione	
		int id = Integer.parseInt(req.getParameter("id"));
						
		BookingClinica bc = (BookingClinica) persistence.find(BookingClinica.class, id);
				
		BeanUtils.populate(bc, req.getParameterMap());
			
		bc.setDa(DateUtils.calendarConvert(stringaFromRequest("start")));
		bc.setA(DateUtils.calendarConvert(stringaFromRequest("end")));
				
		bc.setModified(new Date());		
		bc.setModifiedBy(utente);
				
		validaBean( bc , new ToDetail() );
		
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
			logger.error("Cannot Edit this booking" + e.getMessage());
			throw e;		
		}
	
		setMessaggio("Modifica prenotazione eseguita con successo");
		redirectTo( "vam.agenda.ToDetail.us" );	
	}
}


