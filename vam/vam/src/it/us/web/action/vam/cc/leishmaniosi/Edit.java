package it.us.web.action.vam.cc.leishmaniosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.Leishmaniosi;
import it.us.web.bean.vam.lookup.LookupEhrlichiosiEsiti;
import it.us.web.bean.vam.lookup.LookupLeishmaniosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.CaninaRemoteUtil;

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
		setSegnalibroDocumentazione("leishmaniosi");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);

				
		int id = interoFromRequest("idLeishmaniosi");		
		
		//Recupero Bean Leishmaniosi
		Leishmaniosi l = (Leishmaniosi) persistence.find(Leishmaniosi.class, id);
			
		BeanUtils.populate(l, req.getParameterMap());
		
		l.setModified(new Date());
		l.setModifiedBy(utente);
		
		/* Gestione Esito */
		int idEsito = interoFromRequest("esito");
					
		ArrayList<LookupLeishmaniosiEsiti> lleList = (ArrayList<LookupLeishmaniosiEsiti>) persistence.createCriteria( LookupLeishmaniosiEsiti.class )
		.list();		
		
		LookupLeishmaniosiEsiti lle = null;		
		Iterator lleIterator = lleList.iterator();
		
		while(lleIterator.hasNext()) {			
			lle = (LookupLeishmaniosiEsiti) lleIterator.next();			
			if (lle.getId() == idEsito) 
				l.setLle(lle);	
		}
				
		validaBean( l, new ToEdit() );
			
		try 
		{
			persistence.update(l);
			cc.setModified( new Date() );
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
			logger.error("Cannot edit Leishmaniosi" + ex.getMessage());
			throw ex;		
		}
	
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(l);
		}
		
		setMessaggio("Modica della Leishmaniosi eseguita");
		redirectTo( "vam.cc.leishmaniosi.List.us" );	
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Leishmaniosi";
	}
}


