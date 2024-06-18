package it.us.web.action.vam.cc.esamiSangue;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameSangue;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;

public class Edit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sangue");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);


		int idEsameSangue  = interoFromRequest("idEsameSangue");
		
		//Recupero Bean EsameSangue
		EsameSangue es  = (EsameSangue) persistence.find(EsameSangue.class, idEsameSangue);
		
		BeanUtils.populate(es, req.getParameterMap());
		es.setModified(new Date());
		es.setModifiedBy(utente);
		
		try {
			persistence.update(es);
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
			logger.error("Cannot edit Esame Sangue" + e.getMessage());
			throw e;		
		}
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(es);
		}
		
		setMessaggio("Modica dell'esame eseguita");
		redirectTo( "vam.cc.esamiSangue.List.us");	
					
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Esame Sangue";
	}
}


