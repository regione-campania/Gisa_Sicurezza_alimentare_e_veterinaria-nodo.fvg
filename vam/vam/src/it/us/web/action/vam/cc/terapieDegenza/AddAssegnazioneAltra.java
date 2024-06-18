package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupModalitaSomministrazioneFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupVieSomministrazioneFarmaci;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AddAssegnazioneAltra extends GenericAction 
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
		
		final Logger logger = LoggerFactory.getLogger(AddAssegnazioneAltra.class);

					
		TerapiaDegenza td = (TerapiaDegenza) persistence.find(TerapiaDegenza.class, interoFromRequest("idTerapiaDegenza"));
		
		TerapiaAssegnata ta = new TerapiaAssegnata();
		
		BeanUtils.populate(ta, req.getParameterMap());
		
		LookupModalitaSomministrazioneFarmaci lmsf 
			= (LookupModalitaSomministrazioneFarmaci) persistence.find(LookupModalitaSomministrazioneFarmaci.class, interoFromRequest("modalitaSomministrazione"));
		ta.setLmsf(lmsf);
		
		ta.setEntered(new Date());		
		ta.setEnteredBy(utente);
		ta.setModified(new Date());		
		ta.setModifiedBy(utente);
		ta.setTerapiaDegenza(td);
		ta.setData(new Date());
		
		
		validaBean( ta ,  new List()  );
		
		try {
			persistence.insert(ta);
			persistence.update(td);
			beanModificati.add(ta);
			beanModificati.add(td);
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
		
		setMessaggio("Assegnazione effettuata con successo");
		redirectTo("vam.cc.terapieDegenza.DetailAltra.us?idTerapiaDegenza="+td.getId());
	
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Assegnazione Altra Terapia";
	}


}


