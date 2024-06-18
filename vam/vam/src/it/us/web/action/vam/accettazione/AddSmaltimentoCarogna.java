package it.us.web.action.vam.accettazione;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.FascicoloSanitario;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.Date;

import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AddSmaltimentoCarogna extends GenericAction  implements Specie
{

	@Override
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "ACCETTAZIONE", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("dimissioni");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void execute() throws Exception
	{		
		
		final Logger logger = LoggerFactory.getLogger(Add.class);
		
		int idAccettazione = interoFromRequest("idAccettazione");
		Accettazione accettazione 			 = (Accettazione) persistence.find (Accettazione.class, idAccettazione);
		Animale animale 			 = accettazione.getAnimale();

		animale.setDataSmaltimentoCarogna(dataFromRequest("dataSmaltimentoCarogna"));
		animale.setDdt(stringaFromRequest("ddt"));
		animale.setDittaAutorizzata(stringaFromRequest("dittaAutorizzata"));

		validaBean( animale,  new it.us.web.action.vam.cc.Detail() );
			
		try {
			persistence.update(animale);
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
			logger.error("Cannot update Smaltimento Carogna" + e.getMessage());
			throw e;		
		}
		setMessaggio("Trasporto spoglie registrato con successo");
					
		redirectTo("vam.accettazione.Detail.us?id="+idAccettazione);
	}

}



