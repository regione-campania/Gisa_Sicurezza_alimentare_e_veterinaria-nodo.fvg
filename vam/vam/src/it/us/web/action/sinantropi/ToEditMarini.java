package it.us.web.action.sinantropi;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.sinantropi.lookup.LookupSpecieSinantropi;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEditMarini extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_anagrafica");
	}

	public void execute() throws Exception
	{
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo)persistence.find(Sinantropo.class, idSinantropo);
		
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
		
		ArrayList<LookupTaglie>		taglie		= (ArrayList<LookupTaglie>) persistence.createCriteria( LookupTaglie.class )
		.add( Restrictions.eq( "enabled", true ) )
		.addOrder( Order.asc( "level" ) )
		.addOrder( Order.asc( "description" ) ).list();
		
		ArrayList<LookupSinantropiEta> listEta = (ArrayList<LookupSinantropiEta>) persistence.createCriteria( LookupSinantropiEta.class )
				.list();
		
				
		req.setAttribute("taglie", taglie);
		req.setAttribute("s", s);
		req.setAttribute("listSelaci", listSelaci);
		req.setAttribute("listMammiferiCetacei", listMammiferiCetacei);
		req.setAttribute("listRettiliTestuggini", listRettiliTestuggini);
		req.setAttribute("listEta", listEta);
		
		gotoPage("sinantropi_default","/jsp/sinantropi/editMarini.jsp");
	}
}

