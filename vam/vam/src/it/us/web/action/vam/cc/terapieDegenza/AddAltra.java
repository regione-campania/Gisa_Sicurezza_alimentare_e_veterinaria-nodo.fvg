package it.us.web.action.vam.cc.terapieDegenza;

import java.util.ArrayList;
import java.util.Date;

import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupModalitaSomministrazioneFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupVieSomministrazioneFarmaci;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;


public class AddAltra extends GenericAction 
{

	@Override
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("terapia");
	}
	
	@Override
	public void execute() throws Exception
	{		
		
		final Logger logger = LoggerFactory.getLogger(AddAltra.class);
		
		
		ArrayList<LookupModalitaSomministrazioneFarmaci> modalitaSomministrazione
			= (ArrayList<LookupModalitaSomministrazioneFarmaci>) persistence.findAll(LookupModalitaSomministrazioneFarmaci.class);
		
		TerapiaDegenza td = new TerapiaDegenza();
		td.setEntered(new Date());		
		td.setEnteredBy(utente);
		td.setModified(new Date());		
		td.setModifiedBy(utente);
		td.setCartellaClinica(cc);
		td.setData(new Date());
		td.setTipo("Altra");
		
		//Chiusura Terapia Degenza Precedente
		//Chiudo la prima della lista poich� � la pi� recente, e quindi, seguendo l'algoritmo che ad ogni apertura corrisponde una chiusura,
		//risulta che la pi� recente al momento � anche l'unica aperta
		ArrayList<TerapiaDegenza> tdList = (ArrayList<TerapiaDegenza>) persistence.getNamedQuery("GetTerapieDegenzaByCCAltra").setInteger("idCartellaClinica", idCc).list();
		if(!tdList.isEmpty())
		{
			TerapiaDegenza terapiaToClose = tdList.get(0);
			terapiaToClose.setDataChiusura(new Date());
			persistence.update(terapiaToClose);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(terapiaToClose);
			}
		}
		
		validaBean( td ,  new List()  );
			
		try {
			persistence.insert(td);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(td);
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
			logger.error("Cannot save Terapia" + e.getMessage());
			throw e;		
		}
		
		req.setAttribute("td", 							td);	
		req.setAttribute("modalitaSomministrazione", 	modalitaSomministrazione);	
			
		setMessaggio ("Terapia creata con successo.");
		redirectTo("vam.cc.terapieDegenza.DetailAltra.us?idTerapiaDegenza="+td.getId());
			
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Altra Terapia";
	}

}

