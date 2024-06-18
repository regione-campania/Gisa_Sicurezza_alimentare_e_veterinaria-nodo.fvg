package it.us.web.action.vam.cc.leishmaniosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.remoteBean.EsitoLeishmaniosi;
import it.us.web.bean.remoteBean.PrelievoCampioniLeishmania;
import it.us.web.bean.vam.AttivitaBdr;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.Leishmaniosi;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Restrictions;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("leishmaniosi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		Context ctxBdu = new InitialContext();
		javax.sql.DataSource dsBdu = (javax.sql.DataSource)ctxBdu.lookup("java:comp/env/jdbc/bduS");
		Connection connectionBdu = dsBdu.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);
		
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");

		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnection(connection);
		
		//Recupero di tutti le Leishmaniosi associate alla CC
		ArrayList<Leishmaniosi> l = (ArrayList<Leishmaniosi>) persistence.getNamedQuery("GetLeishmaniosiByCC").setInteger("idCartellaClinica", idCc).list();
		req.setAttribute("l", l);
		
		//Recupero di tutti gli esiti leishmania presenti in BDU il cui esito è pervenuto entro la data di chiusura della CC
		ArrayList<EsitoLeishmaniosi> lBdu = (ArrayList<EsitoLeishmaniosi>) CaninaRemoteUtil.getEsitiLeishmaniosi(cc.getAccettazione().getAnimale().getIdentificativo(),cc.getDataChiusura(),utente,connectionBdu, req);
		req.setAttribute("lBdu", lBdu);
		req.setAttribute("lBdu2", lBdu);
		
		//Allineamento registrazioni Prelievo Leishmania inseriti dalla cc
		RegistrazioniUtil.sincronizzaPrelievoCampioniLeishmaniaDaBdu(cc, persistence, connection, utente, req);
		
		//Recupero di tutte le registrazioni di prelievo campioni leishmania inseriti dalla cc
		Iterator<AttivitaBdr> prelievoCampioniLeishmaniaBduIter = ((ArrayList<AttivitaBdr>)persistence.createCriteria(AttivitaBdr.class)
				 				.add(Restrictions.eq("cc.id", cc.getId()))
				 				.add(Restrictions.eq("operazioneBdr.id", IdOperazioniBdr.prelievoLeishmania))
				 				.list()).iterator();
		
		ArrayList<PrelievoCampioniLeishmania> prelievoCampioniLeishmaniaBdu = new ArrayList<PrelievoCampioniLeishmania>();
		while(prelievoCampioniLeishmaniaBduIter.hasNext())
		{
			AttivitaBdr att = prelievoCampioniLeishmaniaBduIter.next();
			if(att.getIdRegistrazioneBdr()!=null)
			{
				PrelievoCampioniLeishmania leish = RegistrazioniUtil.getRegPrelCampioniLeish(att.getIdRegistrazioneBdr(), req, connectionBdu);
				prelievoCampioniLeishmaniaBdu.add(leish);
			}
			else
			{
				prelievoCampioniLeishmaniaBdu.add(new PrelievoCampioniLeishmania());
			}
		}
		
		req.setAttribute("prelievoCampioniLeishmaniaBdu", prelievoCampioniLeishmaniaBdu);
		
		
		req.setAttribute("operazione", (LookupOperazioniAccettazione)persistence.find(LookupOperazioniAccettazione.class, IdOperazioniBdr.prelievoLeishmania));
		req.setAttribute("regEffettuabili", AnimaliUtil.findRegistrazioniEffettuabili(connection, cc.getAccettazione().getAnimale(), utente, connectionBdu,req));
		
				 				
				 				
		gotoPage("/jsp/vam/cc/leishmaniosi/list.jsp");
	}
}



