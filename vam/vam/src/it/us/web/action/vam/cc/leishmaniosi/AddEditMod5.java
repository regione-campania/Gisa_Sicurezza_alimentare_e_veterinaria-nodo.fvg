package it.us.web.action.vam.cc.leishmaniosi;

import java.text.SimpleDateFormat;
import java.util.Date;
import org.hibernate.HibernateException;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.dao.GuiViewDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AddEditMod5 extends GenericAction {

	
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
		
		final Logger logger = LoggerFactory.getLogger(AddEditMod5.class);
			
		//Recupero Bean CartellaClinica
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date data 		= dataFromRequest("dataMod5");
		String num 		= stringaFromRequest("numMod5");
				
		cc.setDataMod5(data);
		cc.setNumMod5(num);
		cc.setModified					( new Date() );
		cc.setModifiedBy				( utente );
				
		try {
			persistence.update(cc);
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
			logger.error("Cannot Edit Mod 5" + e.getMessage());
			throw e;		
		}
		
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(cc);
		}
		
		setMessaggio("Mod. 5/A inserito/modificato con successo");
		redirectTo( "vam.cc.leishmaniosi.List.us" );	
					
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Mod.5 Leishmaniosi";
	}
	
	
}

