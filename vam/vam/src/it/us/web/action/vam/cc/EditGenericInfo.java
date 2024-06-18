package it.us.web.action.vam.cc;

import java.util.Date;
import java.util.HashSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupFerite;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.vam.CartellaClinicaDAONoH;
import it.us.web.exceptions.AuthorizationException;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EditGenericInfo extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("cc");
	}

	public void execute() throws Exception
	{
		
			final Logger logger = LoggerFactory.getLogger(EditGenericInfo.class);
			
			Context ctx = new InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/jdbc/vamM");
			connection = ds.getConnection();
			GenericAction.aggiornaConnessioneApertaSessione(req);
					
			
			cc.setPeso(req.getParameter("peso"));
			
			HashSet<LookupHabitat> setH = objectList (LookupHabitat.class, "oph_");
			cc.setLookupHabitats(setH);
			
			HashSet<LookupFerite> setF = objectList (LookupFerite.class, "opf_");
			cc.setLookupFerite(setF);
			
			HashSet<LookupAlimentazioni> setA = objectList (LookupAlimentazioni.class, "opa_");
			HashSet<LookupAlimentazioniQualita> setAQ = objectList (LookupAlimentazioniQualita.class, "opaq_");
			cc.setLookupAlimentazionis(setA);
			cc.setLookupAlimentazioniQualitas(setAQ);
			
			cc.setModified( new Date() );
			cc.setModifiedBy( utente );
					
			try {
				CartellaClinicaDAONoH cDao = new CartellaClinicaDAONoH();
				cDao.updateGenericInfo(connection, cc, utente);
				//persistence.update(cc);
				//persistence.commit();
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
				logger.error("Cannot Edit Generic INfo" + e.getMessage());
				throw e;		
			}
			
			
			
			setMessaggio("Informazioni aggiornate con successo");
			redirectTo( "vam.cc.Detail.us" );		
	}
}

