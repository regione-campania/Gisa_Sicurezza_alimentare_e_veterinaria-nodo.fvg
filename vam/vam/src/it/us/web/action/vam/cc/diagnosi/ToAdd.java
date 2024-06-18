package it.us.web.action.vam.cc.diagnosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupDiagnosi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class ToAdd extends GenericAction 
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
		setSegnalibroDocumentazione("diagnosi");
	}
	
	@Override
	public void execute() throws Exception
	{
			ArrayList<LookupDiagnosi> diagnosiMediche = null;
			ArrayList<LookupDiagnosi> diagnosiChirurgiche = null;
			ArrayList<LookupDiagnosi> diagnosiInfettive = null;
			ArrayList<LookupDiagnosi> diagnosiCP = null;
			
			int tipologiaAnimale = cc.getAccettazione().getAnimale().getLookupSpecie().getId();
			
			if (tipologiaAnimale == 1) {
			
			diagnosiMediche = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
				.add( Restrictions.eq( "medica", true ) )
				.add( Restrictions.eq( "chirurgica", false ) )
				.add( Restrictions.eq( "infettiva", false ) )
				.add( Restrictions.eq( "controlloPeriodico", false ) )
				.add( Restrictions.eq( "cane", true ) )
				.addOrder( Order.asc( "description" ) )
				.list();
			
			diagnosiChirurgiche = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
				.add( Restrictions.eq( "medica", false ) )
				.add( Restrictions.eq( "chirurgica", true ) )
				.add( Restrictions.eq( "infettiva", false ) )
				.add( Restrictions.eq( "controlloPeriodico", false ) )
				.add( Restrictions.eq( "cane", true ) )
				.addOrder( Order.asc( "description" ) )
				.list();
			
			diagnosiInfettive = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
				.add( Restrictions.eq( "medica", false ) )
				.add( Restrictions.eq( "chirurgica", false ) )
				.add( Restrictions.eq( "infettiva", true ) )
				.add( Restrictions.eq( "controlloPeriodico", false ) )
				.add( Restrictions.eq( "cane", true ) )
				.addOrder( Order.asc( "description" ) )
				.list();
			
			diagnosiCP = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
				.add( Restrictions.eq( "medica", false ) )
				.add( Restrictions.eq( "chirurgica", false ) )
				.add( Restrictions.eq( "infettiva", false ) )
				.add( Restrictions.eq( "controlloPeriodico", true ) )
				.add( Restrictions.eq( "cane", true ) )
				.addOrder( Order.asc( "description" ) )
				.list();
			}
			
			else if (tipologiaAnimale == 2) {
				
				diagnosiMediche = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", true ) )
					.add( Restrictions.eq( "chirurgica", false ) )
					.add( Restrictions.eq( "infettiva", false ) )
					.add( Restrictions.eq( "controlloPeriodico", false ) )
					.add( Restrictions.eq( "gatto", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				
				diagnosiChirurgiche = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", false ) )
					.add( Restrictions.eq( "chirurgica", true ) )
					.add( Restrictions.eq( "infettiva", false ) )
					.add( Restrictions.eq( "controlloPeriodico", false ) )
					.add( Restrictions.eq( "gatto", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				
				diagnosiInfettive = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", false ) )
					.add( Restrictions.eq( "chirurgica", false ) )
					.add( Restrictions.eq( "infettiva", true ) )
					.add( Restrictions.eq( "controlloPeriodico", false ) )
					.add( Restrictions.eq( "gatto", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				
				diagnosiCP = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", false ) )
					.add( Restrictions.eq( "chirurgica", false ) )
					.add( Restrictions.eq( "infettiva", false ) )
					.add( Restrictions.eq( "controlloPeriodico", true ) )
					.add( Restrictions.eq( "gatto", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				}
			
			if (tipologiaAnimale == 3) {
				
				diagnosiMediche = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", true ) )
					.add( Restrictions.eq( "chirurgica", false ) )
					.add( Restrictions.eq( "infettiva", false ) )
					.add( Restrictions.eq( "controlloPeriodico", false ) )
					.add( Restrictions.eq( "sinantropo", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				
				diagnosiChirurgiche = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", false ) )
					.add( Restrictions.eq( "chirurgica", true ) )
					.add( Restrictions.eq( "infettiva", false ) )
					.add( Restrictions.eq( "controlloPeriodico", false ) )
					.add( Restrictions.eq( "sinantropo", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				
				diagnosiInfettive = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", false ) )
					.add( Restrictions.eq( "chirurgica", false ) )
					.add( Restrictions.eq( "infettiva", true ) )
					.add( Restrictions.eq( "controlloPeriodico", false ) )
					.add( Restrictions.eq( "sinantropo", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				
				diagnosiCP = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
					.add( Restrictions.eq( "medica", false ) )
					.add( Restrictions.eq( "chirurgica", false ) )
					.add( Restrictions.eq( "infettiva", false ) )
					.add( Restrictions.eq( "controlloPeriodico", true ) )
					.add( Restrictions.eq( "sinantropo", true ) )
					.addOrder( Order.asc( "description" ) )
					.list();
				}
			
			int numeroDiagnosi = diagnosiMediche.size() + diagnosiChirurgiche.size() + diagnosiInfettive.size() +diagnosiCP.size();
			
			req.setAttribute( "diagnosiMediche", diagnosiMediche );
			req.setAttribute( "diagnosiChirurgiche", diagnosiChirurgiche );
			req.setAttribute( "diagnosiInfettive", diagnosiInfettive );
			req.setAttribute( "diagnosiCP", diagnosiCP );
			req.setAttribute( "numeroDiagnosi", numeroDiagnosi);
			
			gotoPage( "/jsp/vam/cc/diagnosi/add.jsp" );
	}
}
