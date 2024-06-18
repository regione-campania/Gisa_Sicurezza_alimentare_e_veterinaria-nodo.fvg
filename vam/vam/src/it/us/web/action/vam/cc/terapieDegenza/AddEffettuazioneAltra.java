package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.magazzino.farmaci.Detail;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.ScaricoFarmaco;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.bean.vam.TerapiaEffettuata;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AddEffettuazioneAltra extends GenericAction 
{

	@Override
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
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
		
		final Logger logger = LoggerFactory.getLogger(AddEffettuazioneAltra.class);


		TerapiaAssegnata ta = (TerapiaAssegnata) persistence.find(TerapiaAssegnata.class, interoFromRequest("idTerapiaAssegnata"));
				
		
		/* ***************************************** */
		/* ***************************************** */
		/* 			GESTIONE EFFETTUAZIONE TERAPIA	*/
		/* ***************************************** */
		/* ***************************************** */
		
		TerapiaEffettuata te = new TerapiaEffettuata();
					
		te.setEntered(new Date());		
		te.setEnteredBy(utente);
		te.setModified(new Date());		
		te.setModifiedBy(utente);
		te.setTerapiaAssegnata(ta);
		te.setData(new Date());
		
		ta.setDataUltimaEffettuazione(new Date());
		ta.setModifiable(false);
		ta.setErasable(false);
		
		
		
		validaBean( te , new List()  );
		
		try {
			persistence.insert(te);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(te);
			}
			persistence.update(ta);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(ta);
			}
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
		
		setMessaggio("Effettuazione registrata sul diario");
		redirectTo("vam.cc.terapieDegenza.DetailAltra.us?idTerapiaDegenza="+ta.getTerapiaDegenza().getId());
	
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Effettuazione Altra Terapia";
	}

}




