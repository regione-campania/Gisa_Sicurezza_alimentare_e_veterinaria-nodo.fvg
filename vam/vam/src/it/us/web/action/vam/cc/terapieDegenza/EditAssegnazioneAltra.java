package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupModalitaSomministrazioneFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupVieSomministrazioneFarmaci;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EditAssegnazioneAltra extends GenericAction 
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
		
		final Logger logger = LoggerFactory.getLogger(EditAssegnazioneAltra.class);
				
		TerapiaAssegnata ta = (TerapiaAssegnata) persistence.find(TerapiaAssegnata.class, interoFromRequest("idTerapiaAssegnata"));
					
		BeanUtils.populate(ta, req.getParameterMap());
					
		
		LookupModalitaSomministrazioneFarmaci lmsf 
			= (LookupModalitaSomministrazioneFarmaci) persistence.find(LookupModalitaSomministrazioneFarmaci.class, interoFromRequest("modalitaSomministrazione"));
		ta.setLmsf(lmsf);
		
		ta.setModified(new Date());		
		ta.setModifiedBy(utente);		
				
		
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
			logger.error("Cannot update Assegnazione" + e.getMessage());
			throw e;		
		}
			
		setMessaggio("Aggiornamento Assegnazione effettuato con successo");
		redirectTo("vam.cc.terapieDegenza.DetailAltra.us?idTerapiaDegenza="+ta.getTerapiaDegenza().getId());
	
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Assegnazione Altra Terapia";
	}

}




