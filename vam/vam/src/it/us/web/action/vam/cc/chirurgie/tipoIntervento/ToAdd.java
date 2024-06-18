package it.us.web.action.vam.cc.chirurgie.tipoIntervento;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.cc.trasferimenti.List;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.bean.vam.lookup.LookupTipologiaAltroInterventoChirurgico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.SuperUtenteDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.vam.ClinicaDAO;
import it.us.web.util.vam.ComparatorSuperUtenti;
import it.us.web.util.vam.ComparatorUtenti;

public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tipoIntervento");
	}

	public void execute() throws Exception
	{
			Context ctx = new InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/jdbc/vamM");
			connection = ds.getConnection();
			GenericAction.aggiornaConnessioneApertaSessione(req);
			
			//Recupero lista operatori disponibili
			ArrayList<SuperUtente> operatori = new ArrayList<SuperUtente>();
			for(BUtente u :UtenteDAO.getUtenti(connection, -1, utente.getClinica().getId()))
			{
				if(u.getRuolo()!=null && 
						(u.getRuolo().equals("Ambulatorio - Veterinario") || u.getRuolo().equals("5") || 
						 u.getRuolo().equalsIgnoreCase("Referente Asl")   || u.getRuolo().equals("14") ||
						 u.getRuolo().equalsIgnoreCase("Sinantropi")   || u.getRuolo().equals("13") ||
						 u.getRuolo().equalsIgnoreCase("Borsisti")   || u.getRuolo().equals("12")
						 )
				  )
				{
					SuperUtente su = SuperUtenteDAO.getSuperUtente(u.getSuperutente().getId(), connection);
					ArrayList<BUtente> utentiS = new ArrayList<>();
					utentiS.add(u);
					su.setUtenti(utentiS);
					operatori.add(su);
				}
			}
			
			Collections.sort(operatori, new ComparatorSuperUtenti());
			req.setAttribute("operatori", operatori);	
			
			ArrayList<LookupTipologiaAltroInterventoChirurgico> listTipologieAltriInterventi = (ArrayList<LookupTipologiaAltroInterventoChirurgico>) persistence.createCriteria( LookupTipologiaAltroInterventoChirurgico.class )
					.addOrder( Order.asc( "level" ) )
					.list();
			req.setAttribute("listTipologieAltriInterventi", listTipologieAltriInterventi);	
		
			gotoPage("/jsp/vam/cc/chirurgie/tipoIntervento/add.jsp");
	}
}

