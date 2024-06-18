package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.Date;

import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StopAssegnazione extends GenericAction 
{

	@Override
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("terapia");
	}
	
	@Override
	public void execute() throws Exception
	{		
		
		final Logger logger = LoggerFactory.getLogger(AddEffettuazione.class);
		
							
		TerapiaAssegnata ta = (TerapiaAssegnata) persistence.find(TerapiaAssegnata.class, interoFromRequest("idTerapiaAssegnata"));
						
		ta.setStopped(true);
		ta.setStoppedDate(new Date());
		ta.setStoppedBy(utente);
		ta.setPraticable(false);
		ta.setModifiable(false);
		ta.setErasable(false);
		
		validaBean( ta, new List()  );

		try {				
			persistence.update(ta);
			beanModificati.add(ta);
			cc.setModified( new Date() );
			cc.setModifiedBy( utente );
			persistence.update( cc );
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
			logger.error("Cannot save Assegnazione" + e.getMessage());
			throw e;		
		}
					
		
		setMessaggio("Stop del farmaco registrato con successo");
		redirectTo("vam.cc.terapieDegenza.Detail.us?idTerapiaDegenza="+ta.getTerapiaDegenza().getId());

	}
	
	@Override
	public String getDescrizione()
	{
		return "Stop Assegnazione Terapia Farmacologica";
	}

}




