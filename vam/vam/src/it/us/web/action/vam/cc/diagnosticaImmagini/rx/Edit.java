package it.us.web.action.vam.cc.diagnosticaImmagini.rx;


import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Rx;
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
		setSegnalibroDocumentazione("rx");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);


		int idRx  = interoFromRequest("idRx");
		
		Rx rx  = (Rx) persistence.find(Rx.class, idRx);
	
		BeanUtils.populate(rx, req.getParameterMap());				
		rx.setModified(new Date());		
		rx.setModifiedBy(utente);
		rx.setCartellaClinica( cc );			
			
		validaBean( rx , new ToEdit() );
			
		try {
			persistence.update(rx);	
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(rx);
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
			logger.error("Cannot edit RX" + e.getMessage());
			throw e;	
		}
		
		setMessaggio("RX modificato");
		redirectTo("vam.cc.diagnosticaImmagini.rx.List.us");
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Rx";
	}
}
