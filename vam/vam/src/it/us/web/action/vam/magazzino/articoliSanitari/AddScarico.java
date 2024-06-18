package it.us.web.action.vam.magazzino.articoliSanitari;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.MagazzinoArticoliSanitari;
import it.us.web.bean.vam.ScaricoArticoloSanitario;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AddScarico extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "MAGAZZINO", "AS", "EDIT" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("magazzinoAS");
	}

	public void execute() throws Exception
	{
					
		final Logger logger = LoggerFactory.getLogger(AddScarico.class);
					
		/* ***************************************** */
		/* ***************************************** */
		/* 			GESTIONE MAGAZZINO 				*/
		/* ***************************************** */
		/* ***************************************** */
		MagazzinoArticoliSanitari magazzinoArticoliSanitari = (MagazzinoArticoliSanitari) persistence.find(MagazzinoArticoliSanitari.class, interoFromRequest("idArticoloSanitario"));
		
		float quantitaDaScaricare = floatFromRequest("quantitaDaScaricare");
		
		if ( (magazzinoArticoliSanitari.getQuantita() - quantitaDaScaricare) < 0f) 
		{
			setErrore("La quantità residua deve essere maggiore o uguale a zero");
			goToAction( new Detail() );
		}
		
		magazzinoArticoliSanitari.setQuantita(magazzinoArticoliSanitari.getQuantita() - quantitaDaScaricare);
		
		/* ***************************************** */
		/* ***************************************** */
		/* 			GESTIONE SCARICO 				*/
		/* ***************************************** */
		/* ***************************************** */
		ScaricoArticoloSanitario scaricoArticoloSanitario = new ScaricoArticoloSanitario();
		
		scaricoArticoloSanitario.setDataScarico(new Date());
		scaricoArticoloSanitario.setEntered(new Date());		
		scaricoArticoloSanitario.setEnteredBy(utente);
		scaricoArticoloSanitario.setModified(new Date());		
		scaricoArticoloSanitario.setModifiedBy(utente);
		
		scaricoArticoloSanitario.setQuantita(quantitaDaScaricare);		
		scaricoArticoloSanitario.setMagazzinoArticoliSanitari(magazzinoArticoliSanitari);
		
		
		validaBean( magazzinoArticoliSanitari, new Detail()  );
		validaBean( scaricoArticoloSanitario, new Detail()  );
		try {				
			
			persistence.update(magazzinoArticoliSanitari);				
			persistence.insert(scaricoArticoloSanitario);
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
			logger.error("Cannot save Magazzino" + e.getMessage());
			throw e;		
		}
		
		setMessaggio("Magazzino aggiornato con successo");
		redirectTo("vam.magazzino.articoliSanitari.Detail.us");
	
	}

}




