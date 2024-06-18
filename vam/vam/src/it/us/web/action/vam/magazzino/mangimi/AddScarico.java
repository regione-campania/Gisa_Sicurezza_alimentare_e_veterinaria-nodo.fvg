package it.us.web.action.vam.magazzino.mangimi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.MagazzinoMangimi;
import it.us.web.bean.vam.ScaricoFarmaco;
import it.us.web.bean.vam.ScaricoMangime;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AddScarico extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "MAGAZZINO", "MANGIMI", "EDIT" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("magazzinoMangimi");
	}

	public void execute() throws Exception
	{
					
		final Logger logger = LoggerFactory.getLogger(AddScarico.class);
					
		/* ***************************************** */
		/* ***************************************** */
		/* 			GESTIONE MAGAZZINO 				*/
		/* ***************************************** */
		/* ***************************************** */
		MagazzinoMangimi mMangimi = (MagazzinoMangimi) persistence.find(MagazzinoMangimi.class, interoFromRequest("idMangime"));
		
		float quantitaDaScaricare = floatFromRequest("quantitaDaScaricare");
		
		if ( (mMangimi.getQuantita() - quantitaDaScaricare) < 0f) {
			setErrore("La quantità residua deve essere maggiore o uguale a zero");
			goToAction( new Detail() );
		}
		
		mMangimi.setQuantita(mMangimi.getQuantita() - quantitaDaScaricare );
		
		/* ***************************************** */
		/* ***************************************** */
		/* 			GESTIONE SCARICO 				*/
		/* ***************************************** */
		/* ***************************************** */
		ScaricoMangime sMangime = new ScaricoMangime();
		
		sMangime.setDataScarico(new Date());
		sMangime.setEntered(new Date());		
		sMangime.setEnteredBy(utente);
		sMangime.setModified(new Date());		
		sMangime.setModifiedBy(utente);
		
		sMangime.setQuantita(quantitaDaScaricare);		
		sMangime.setMagazzinoMangime(mMangimi);
		
		
		validaBean( mMangimi, new Detail()  );
		validaBean( sMangime, new Detail()  );
		
		try {				
			
			persistence.update(mMangimi);				
			persistence.insert(sMangime);
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
		redirectTo("vam.magazzino.mangimi.Detail.us");
	}

}




