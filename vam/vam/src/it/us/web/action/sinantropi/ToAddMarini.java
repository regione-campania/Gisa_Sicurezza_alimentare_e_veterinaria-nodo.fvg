package it.us.web.action.sinantropi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.lookup.LookupDetentori;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.sinantropi.lookup.LookupSpecieSinantropi;
import it.us.web.bean.sinantropi.lookup.LookupTipiDocumento;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class ToAddMarini extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_anagrafica");
	}

	public void execute() throws Exception
	{
			
		ArrayList<LookupSpecieSinantropi> listSelaci = (ArrayList<LookupSpecieSinantropi>) persistence.createCriteria( LookupSpecieSinantropi.class )
		.add( Restrictions.eq( "selaci", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();	
		
		ArrayList<LookupSpecieSinantropi> listMammiferiCetacei = (ArrayList<LookupSpecieSinantropi>) persistence.createCriteria( LookupSpecieSinantropi.class )
		.add( Restrictions.eq( "mammiferoCetaceo", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupSpecieSinantropi> listRettiliTestuggini = (ArrayList<LookupSpecieSinantropi>) persistence.createCriteria( LookupSpecieSinantropi.class )
		.add( Restrictions.eq( "rettileTestuggine", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupTipiDocumento> listTipologiaDocumenti = (ArrayList<LookupTipiDocumento>) persistence.createCriteria( LookupTipiDocumento.class )
		.addOrder( Order.asc( "level" ) )
		.list();
				
/*		ArrayList<LookupComuni> listComuniBN = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
		.add( Restrictions.eq( "bn", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupComuni> listComuniNA = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
		.add( Restrictions.eq( "na", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupComuni> listComuniSA = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
		.add( Restrictions.eq( "sa", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupComuni> listComuniAV = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
		.add( Restrictions.eq( "av", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupComuni> listComuniCE = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
		.add( Restrictions.eq( "ce", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		*/
		
		ArrayList<LookupDetentori> listDetentori = (ArrayList<LookupDetentori>) persistence.createCriteria( LookupDetentori.class )
		.add(Restrictions.eq("zoo", false))
		.addOrder( Order.asc( "description" ) )
		.list();
		
		ArrayList<LookupTaglie>		taglie		= (ArrayList<LookupTaglie>) persistence.createCriteria( LookupTaglie.class )
		.add( Restrictions.eq( "enabled", true ) )
		.addOrder( Order.asc( "level" ) )
		.addOrder( Order.asc( "description" ) ).list();
		
		ArrayList<LookupSinantropiEta> listEta = (ArrayList<LookupSinantropiEta>) persistence.createCriteria( LookupSinantropiEta.class )
				.list();
		
		
/*		req.setAttribute("listComuniBN", listComuniBN);
		req.setAttribute("listComuniNA", listComuniNA);
		req.setAttribute("listComuniSA", listComuniSA);
		req.setAttribute("listComuniCE", listComuniCE);
		req.setAttribute("listComuniAV", listComuniAV);*/		
		
		req.setAttribute("taglie", taglie);
		req.setAttribute("listSelaci", listSelaci);
		req.setAttribute("listMammiferiCetacei", listMammiferiCetacei);
		req.setAttribute("listRettiliTestuggini", listRettiliTestuggini);
		
		req.setAttribute("listDetentori", listDetentori);
		
		req.setAttribute("listTipologiaDocumenti", listTipologiaDocumenti);
		
		req.setAttribute("listEta", listEta);
		
		
		if ( req.getParameter("interactiveMode") != null && req.getParameter("interactiveMode").equalsIgnoreCase("y")) {
			req.setAttribute("interactiveMode", "y");
			if ( req.getParameter("identificativo") != null && !("").equals(req.getParameter("identificativo"))) {
				req.setAttribute("identificativo", req.getParameter("identificativo"));
			}
			gotoPage("sinantropi_popup_marini","/jsp/sinantropi/addMarini.jsp");			
		}
		else {
			req.setAttribute("interactiveMode", "N");
			gotoPage("sinantropi_default_marini","/jsp/sinantropi/addMarini.jsp");
			
		}
		

			
	}
}



