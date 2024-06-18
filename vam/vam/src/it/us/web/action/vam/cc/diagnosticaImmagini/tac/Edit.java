package it.us.web.action.vam.cc.diagnosticaImmagini.tac;


import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Tac;
import it.us.web.dao.GuiViewDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;

public class Edit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tac");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);

		int idTac  = interoFromRequest("idTac");
		
		Tac tac  = (Tac) persistence.find(Tac.class, idTac);
	
		BeanUtils.populate(tac, req.getParameterMap());				
		tac.setModified(new Date());		
		tac.setModifiedBy(utente);
		tac.setCartellaClinica( cc );			
			
		validaBean( tac , new ToEdit() );
		
			
		try {
			persistence.update(tac);	
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(tac);
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
			logger.error("Cannot edit TAC" + e.getMessage());
			throw e;	
		}
		setMessaggio("TAC modificato");
		redirectTo("vam.cc.diagnosticaImmagini.tac.List.us");
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Tac";
	}
}
