package it.us.web.action.vam.cc.ehrlichiosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.lookup.LookupEhrlichiosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Edit extends GenericAction {

	
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
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);

		int id = interoFromRequest("idEhrlichiosi");		
		
		//Recupero Bean Ehrlichiosi
		Ehrlichiosi e = (Ehrlichiosi) persistence.find(Ehrlichiosi.class, id);
			
		BeanUtils.populate(e, req.getParameterMap());
		
		e.setModified(new Date());
		e.setModifiedBy(utente);
		
		/* Gestione Esito */
		int idEsito = interoFromRequest("esito");
		
		ArrayList<LookupEhrlichiosiEsiti> leeList = (ArrayList<LookupEhrlichiosiEsiti>) persistence.createCriteria( LookupEhrlichiosiEsiti.class )
		.list();		
		
		LookupEhrlichiosiEsiti lee = null;		
		Iterator leeIterator = leeList.iterator();		
		
		while(leeIterator.hasNext()) {			
			lee = (LookupEhrlichiosiEsiti) leeIterator.next();			
			if (lee.getId() == idEsito) 
				e.setLee(lee);	
		}
				
		validaBean( e ,  new ToEdit() );
		
		try 
		{
			persistence.update(e);
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
			logger.error("Cannot edit Ehrlichiosi" + ex.getMessage());
			throw ex;		
		}
					
		setMessaggio("Modica dell'Ehrlichiosi eseguita");
		redirectTo( "vam.cc.ehrlichiosi.List.us" );	
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Ehrlichiosi";
	}
}


