package it.us.web.action.vam.cc.ricoveri;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import javax.imageio.ImageIO;
import org.hibernate.HibernateException;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.StrutturaClinica;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoEsito;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.Screenshot;

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
		setSegnalibroDocumentazione("ricoveri");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);
			
		int idStrutturaClinica = interoFromRequest("idStrutturaClinica");
		
		//Recupero Bean CartellaClinica
		StrutturaClinica sc = (StrutturaClinica) persistence.find (StrutturaClinica.class, idStrutturaClinica); 
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		String dataRicovero 	= req.getParameter("ricoveroData");		
		Date ricoveroData 		= format.parse(dataRicovero);	
				
		cc.setRicoveroData				(ricoveroData);
		cc.setRicoveroBox				(req.getParameter("ricoveroBox"));
		cc.setRicoveroMotivo			(req.getParameter("ricoveroMotivo"));
		cc.setRicoveroSintomatologia	(req.getParameter("ricoveroSintomatologia"));
		cc.setRicoveroNote				(req.getParameter("ricoveroNote"));
		cc.setStrutturaClinica			(sc);
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
			logger.error("Cannot Edit Ricovero" + e.getMessage());
			throw e;		
		}
		
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(cc);
		}
		
		setMessaggio("Ricovero inserito/modificato con successo");
		redirectTo( "vam.cc.ricoveri.Detail.us" );	
					
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Ricovero";
	}
	
	
}

