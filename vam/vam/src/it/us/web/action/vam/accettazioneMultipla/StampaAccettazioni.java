package it.us.web.action.vam.accettazioneMultipla;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.AnimaleAnagrafica;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupAssociazioni;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.bean.vam.lookup.LookupMantelli;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.bean.vam.lookup.LookupPersonaleInterno;
import it.us.web.bean.vam.lookup.LookupRazze;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.bean.vam.lookup.LookupTipiRichiedente;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdOperazioniDM;
import it.us.web.constants.IdRichiesteVarie;
import it.us.web.constants.IdTipiRichiedente;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.lookup.LookupAslDAO;
import it.us.web.dao.lookup.LookupOperazioniAccettazioneDAO;
import it.us.web.dao.vam.AccettazioneDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;


public class StampaAccettazioni extends GenericAction  implements Specie
{

	@Override
	public void can() throws AuthorizationException
	{
		
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	
	}

	@Override
	public void execute() throws Exception
	{
		Context ctxBdu = new InitialContext();
		javax.sql.DataSource dsBdu = (javax.sql.DataSource)ctxBdu.lookup("java:comp/env/jdbc/bduS");
		Connection connectionBdu = dsBdu.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);
		
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		
		ArrayList<Animale>			animali			= new ArrayList<Animale>();
		ArrayList<Accettazione> accettazioni = AccettazioneDAO.getAccettazioniMultiple(stringaFromRequest("idAccMultipla"), connection);
		ServicesStatus	status			= new ServicesStatus();
		Gatto gatto = null;
		Cane cane   = null;
		
		int i=0;
		while(i<accettazioni.size())
		{
			Accettazione accettazione = accettazioni.get(i);
			String identificativo = accettazione.getAnimale().getIdentificativo();
			HashMap<String, Object> fetchAnimale = AnimaliUtil.fetchAnimale(identificativo, connection, persistence, utente, status, connectionBdu, req);
			Animale animale = (Animale)fetchAnimale.get("animale");
			animali.add(animale);
			
			String specieAnimale = null;
			switch ( animale.getLookupSpecie().getId() )
			{
				case CANE:
					specieAnimale = "canina";
					cane = CaninaRemoteUtil.findCane(animale.getIdentificativo(), utente, status, connectionBdu,req);
					break;
				case GATTO:
					specieAnimale = "felina";
					gatto = FelinaRemoteUtil.findGatto(animale.getIdentificativo(), utente, status, connectionBdu,req);
					break;
			}
			
			AnimaleAnagrafica anag = AnimaliUtil.getAnagrafica(animale, cane, gatto, persistence, utente, status, connectionBdu,req);
			req.setAttribute("anagraficaAnimale"+(i+1), anag);
			i++;
		}
		
		req.setAttribute( "animali", animali );
		req.setAttribute( "accettazione", accettazioni.get(0) );
		req.setAttribute( "accettazioni", accettazioni );
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		
		gotoPage( "popup", "/jsp/vam/accettazioneMultipla/stampaAccettazioni.jsp" );
	} 

}
