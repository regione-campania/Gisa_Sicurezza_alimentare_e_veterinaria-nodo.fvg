package it.us.web.action.vam.cc.anamnesiRecente;

import java.util.Date;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.cc.autopsie.ToAdd;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Edit extends GenericAction {

	
	public void can() throws AuthorizationException, Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("anamnesi");
	}

	public void execute() throws Exception
	{
		final Logger logger = LoggerFactory.getLogger(Edit.class);
			
		BeanUtils.populate(cc, req.getParameterMap());	
		
		cc.setModified(new Date());		
		cc.setModifiedBy(utente);
		
		try {
			
			validaBean( cc , new ToAdd() );
			
			persistence.update(cc);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(cc);
			}
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
			logger.error("Cannot save Anamnesi recente" + e.getMessage());
			throw e;		
		}
		
		setMessaggio("Anamnesi recente aggiornata");
		redirectTo("vam.cc.Detail.us");
}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Anamnesi Recente";
	}
	
}

