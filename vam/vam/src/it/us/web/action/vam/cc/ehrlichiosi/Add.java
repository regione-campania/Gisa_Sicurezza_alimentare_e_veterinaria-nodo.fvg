package it.us.web.action.vam.cc.ehrlichiosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.bean.vam.lookup.LookupEhrlichiosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.CaninaRemoteUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Add extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ehrlichiosi");
	}

	public void execute() throws Exception
	{
		final Logger logger = LoggerFactory.getLogger(Add.class);

					
		Ehrlichiosi e = new Ehrlichiosi();

		BeanUtils.populate(e, req.getParameterMap());				
				
		e.setEntered(new Date());		
		e.setEnteredBy(utente);
		e.setModified(new Date());
		e.setModifiedBy(utente);
			
		int idEsito = interoFromRequest("esito");
				
		//RegistrazioniCaninaResponse	res	= CaninaRemoteUtil.eseguiEhrlichiosi(cc.getAccettazione().getAnimale(), stringaFromRequest( "dataEhrlichiosi" ), idEsito, utente);	
		
		
		
			/* Gestione Esito */
			ArrayList<LookupEhrlichiosiEsiti> leeList = (ArrayList<LookupEhrlichiosiEsiti>) persistence.createCriteria( LookupEhrlichiosiEsiti.class )
			.list();		
			
			LookupEhrlichiosiEsiti lee = null;		
			Iterator leeIterator = leeList.iterator();		
			
			while(leeIterator.hasNext()) {			
				lee = (LookupEhrlichiosiEsiti) leeIterator.next();			
				if (lee.getId() == idEsito) 
					e.setLee(lee);	
			}
			
			e.setCartellaClinica(cc);			
			
			validaBean( e , new ToAdd());
				
			try {
				persistence.insert(e);
				if(cc.getDataChiusura()!=null)
				{
					beanModificati.add(e);
				}
				cc.setModified( e.getModified() );
				cc.setModifiedBy( utente );
				persistence.update( cc );
				persistence.commit();
			}
			catch (RuntimeException ex)
			{
				try
				{		
					persistence.rollBack();				
				}
				catch (HibernateException e1)
				{				
					logger.error("Error during Rollback transaction" + e1.getMessage());
				}
				logger.error("Cannot save Ehrlichiosi" + ex.getMessage());
				throw ex;		
			}
						
			
			setMessaggio("Ehrlichiosi aggiunta con successo");				
			redirectTo("vam.cc.ehrlichiosi.List.us");
		
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Ehrlichiosi";
	}
}
