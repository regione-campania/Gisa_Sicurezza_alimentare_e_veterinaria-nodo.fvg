package it.us.web.action.vam.cc;

import java.sql.Connection;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupFerite;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupMantelli;
import it.us.web.bean.vam.lookup.LookupRazze;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;

import org.hibernate.HibernateException;
import org.hibernate.criterion.Order;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ChangeToDegenza extends GenericAction implements Specie{

	
	public void can() throws Exception
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
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
	
			
			final Logger logger = LoggerFactory.getLogger(ChangeToDegenza.class);
			
			try{
				
				cc.setDayHospital(false);
				
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
				logger.error("Cannot update Cartella Clinica" + e.getMessage());
				throw e;		
			}
			
			
			ArrayList<LookupAlimentazioni> listAlimentazioni = (ArrayList<LookupAlimentazioni>) persistence.createCriteria( LookupAlimentazioni.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupHabitat> listHabitat = (ArrayList<LookupHabitat>) persistence.createCriteria( LookupHabitat.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupHabitat> listFerite = (ArrayList<LookupHabitat>) persistence.createCriteria( LookupFerite.class )
					.addOrder( Order.asc( "level" ) )
					.list();
					
			req.setAttribute("listFerite", listFerite);	
			
			
			req.setAttribute("listAlimentazioni", listAlimentazioni);		
			req.setAttribute("listHabitat", listHabitat);		
			
					
				
			ServicesStatus status = new ServicesStatus();
			if(cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe() || cc.getAccettazione().getAnimale().getLookupSpecie().getId() == SINANTROPO)
			{
				req.setAttribute("fuoriAsl", false);
				req.setAttribute("versoAssocCanili", false);
			}
			
			req.setAttribute( "specie", SpecieAnimali.getInstance() );
			req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(cc.getAccettazione().getAnimale(), persistence, utente, status, connection,req));

			gotoPage("/jsp/vam/cc/home.jsp");
	}
}
