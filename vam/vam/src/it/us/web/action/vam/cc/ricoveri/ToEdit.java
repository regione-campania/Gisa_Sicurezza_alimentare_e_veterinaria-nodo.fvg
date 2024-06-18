package it.us.web.action.vam.cc.ricoveri;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.StrutturaClinica;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupDiagnosi;
import it.us.web.bean.vam.lookup.LookupFerite;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
	public void can() throws AuthorizationException
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

			ArrayList<StrutturaClinica> struttureCliniche = (ArrayList<StrutturaClinica>) persistence.getNamedQuery("GetStruttureRicovero").setInteger("idUtente", utente.getId()).list();
			
			ArrayList<LookupAlimentazioni> listAlimentazioni = (ArrayList<LookupAlimentazioni>) persistence.createCriteria( LookupAlimentazioni.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupAlimentazioniQualita> listAlimentazioniQualita = (ArrayList<LookupAlimentazioniQualita>) persistence.createCriteria( LookupAlimentazioniQualita.class )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupHabitat> listHabitat = (ArrayList<LookupHabitat>) persistence.createCriteria( LookupHabitat.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			
			
			req.setAttribute("sc", struttureCliniche);	
			
			req.setAttribute("listAlimentazioni", listAlimentazioni);	
			req.setAttribute("listAlimentazioniQualita", listAlimentazioniQualita);	
			req.setAttribute("listHabitat", listHabitat);	
			
			ArrayList<LookupHabitat> listFerite = (ArrayList<LookupHabitat>) persistence.createCriteria( LookupFerite.class )
					.addOrder( Order.asc( "level" ) )
					.list();
					
			req.setAttribute("listFerite", listFerite);	
			
			gotoPage("/jsp/vam/cc/ricoveri/edit.jsp");
	}
}

