package it.us.web.action.vam.cc.diagnosticaImmagini.rx;

import java.util.Date;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Rx;
import it.us.web.dao.GuiViewDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;

public class Add extends GenericAction {

	
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
		
		final Logger logger = LoggerFactory.getLogger(Add.class);

		Rx rx = new Rx();
		
		BeanUtils.populate(rx, req.getParameterMap());				
		rx.setEntered(new Date());		
		rx.setEnteredBy(utente);
		rx.setCartellaClinica( cc );	
		
		validaBean( rx ,  new ToAdd());
			
		try {
			persistence.insert(rx);		
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
			logger.error("Cannot save RX" + e.getMessage());
			throw e;		
		}
		
		setMessaggio("RX aggiunta");
		redirectTo("vam.cc.diagnosticaImmagini.rx.List.us");
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Rx";
	}
}
