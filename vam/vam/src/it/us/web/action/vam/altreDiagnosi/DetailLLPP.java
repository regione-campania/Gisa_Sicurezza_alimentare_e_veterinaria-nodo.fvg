package it.us.web.action.vam.altreDiagnosi;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Colonia;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.remoteBean.ProprietarioCane;
import it.us.web.bean.remoteBean.ProprietarioGatto;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.sinantropi.Detenzioni;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.AltreDiagnosi;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;

public class DetailLLPP extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "ALTRE_DIAGNOSI", "LIST_LLPP", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connectionBdu = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);
		
		

		int id = interoFromRequest("id");
		AltreDiagnosi a = (AltreDiagnosi) persistence.find(AltreDiagnosi.class, id );	
		
		req.setAttribute( "a", a );		

		boolean liberoProfessionista = booleanoFromRequest("liberoProfessionista");
		
		req.setAttribute("liberoProfessionista", liberoProfessionista);
		
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		req.setAttribute( "specieAnimale", a.getAnimale().getLookupSpecie().getId() );
		
		ServicesStatus status = new ServicesStatus();
		
		HashMap<String, Object> fetchAnimale = AnimaliUtil.fetchAnimale( a.getAnimale().getIdentificativo(), persistence, utente, status, connectionBdu,req );
		
		Animale animale = (Animale)fetchAnimale.get("animale");
		
		int specie = a.getAnimale().getLookupSpecie().getId();
		Gatto gatto = null;
		Cane cane = null;
		if(!a.getAnimale().getDecedutoNonAnagrafe())
		{
			if (specie == Specie.CANE ) 
			{
				cane = CaninaRemoteUtil.findCane(a.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
				RegistrazioniCaninaResponse res	= AnimaliUtil.fetchDatiDecessoCane(cane);
				req.setAttribute("res", res);
			}
			else if (specie == Specie.GATTO) 
			{
				gatto = FelinaRemoteUtil.findGatto(a.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
				RegistrazioniFelinaResponse rfr	= AnimaliUtil.fetchDatiDecessoGatto(gatto);
				req.setAttribute("res", rfr);
			}
			else if (specie == Specie.SINANTROPO) 
			{
				RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, a.getAnimale());
				req.setAttribute("res", rsr);
				req.setAttribute("fuoriAsl", false);
				req.setAttribute("versoAssocCanili", false);
			}
		}
		
		if(a.getAnimale().getDecedutoNonAnagrafe())
		{
			Iterator<Accettazione> accettazioni = a.getAnimale().getAccettaziones().iterator();
			if(accettazioni.hasNext())
			{
				Accettazione accettazione = accettazioni.next();
				req.setAttribute("proprietarioCognome",  accettazione.getProprietarioCognome());
				req.setAttribute("proprietarioNome",  accettazione.getProprietarioNome());
				req.setAttribute("proprietarioCodiceFiscale",  accettazione.getProprietarioCodiceFiscale());
				req.setAttribute("proprietarioDocumento",  accettazione.getProprietarioDocumento());
				req.setAttribute("proprietarioIndirizzo",  accettazione.getProprietarioIndirizzo());
				req.setAttribute("proprietarioCap",  accettazione.getProprietarioCap());
				req.setAttribute("proprietarioComune",  accettazione.getProprietarioComune());
				req.setAttribute("proprietarioProvincia",  accettazione.getProprietarioProvincia());
				req.setAttribute("proprietarioTelefono",  accettazione.getProprietarioTelefono());
				req.setAttribute("proprietarioTipo",  accettazione.getProprietarioTipo());
				req.setAttribute("randagio",  accettazione.getRandagio());
				req.setAttribute("nomeColonia",  accettazione.getNomeColonia());
			}
		}
		else
		{
			if (specie == Specie.CANE) 
			{
				cane = (Cane)fetchAnimale.get("cane");
				if(cane==null)
					cane = CaninaRemoteUtil.findCane(a.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
				
				ProprietarioCane proprietario = CaninaRemoteUtil.findProprietario(a.getAnimale().getIdentificativo(), utente, connectionBdu,req);
				
				if(proprietario!=null)
				{
					req.setAttribute("proprietarioCognome",  proprietario.getCognome());
					req.setAttribute("proprietarioNome",  proprietario.getNome());
					req.setAttribute("proprietarioCodiceFiscale",  proprietario.getCodiceFiscale());
					req.setAttribute("proprietarioDocumento",  proprietario.getDocumentoIdentita());
					req.setAttribute("proprietarioIndirizzo",  proprietario.getVia());
					req.setAttribute("proprietarioCap",  proprietario.getCap());
					req.setAttribute("proprietarioComune",  proprietario.getCitta());
					req.setAttribute("proprietarioProvincia",  proprietario.getProvincia());
					req.setAttribute("proprietarioTelefono",  proprietario.getNumeroTelefono());
					req.setAttribute("proprietarioTipo",  proprietario.getTipo());
				}
			}
			else if (specie == Specie.GATTO) 
			{
				gatto = (Gatto)fetchAnimale.get("gatto");
				if(gatto==null)
					gatto = FelinaRemoteUtil.findGatto(a.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
				
				Colonia colonia = (Colonia)fetchAnimale.get("colonia");
				if(colonia==null)
					colonia = FelinaRemoteUtil.findColonia(a.getAnimale().getIdentificativo(), utente, connectionBdu,req);
				
				req.setAttribute("colonia", colonia);
				
				ProprietarioGatto proprietario = FelinaRemoteUtil.findProprietario(a.getAnimale().getIdentificativo(), utente, connectionBdu,req);
				
				if(proprietario!=null)
				{
					req.setAttribute("proprietarioCognome",  proprietario.getCognome());
					req.setAttribute("proprietarioNome",  proprietario.getNome());
					req.setAttribute("proprietarioCodiceFiscale",  proprietario.getCodiceFiscale());
					req.setAttribute("proprietarioDocumento",  proprietario.getDocumentoIdentita());
					req.setAttribute("proprietarioIndirizzo",  proprietario.getVia());
					req.setAttribute("proprietarioCap",  proprietario.getCap());
					req.setAttribute("proprietarioComune",  proprietario.getCitta());
					req.setAttribute("proprietarioProvincia",  proprietario.getProvincia());
					req.setAttribute("proprietarioTelefono",  proprietario.getNumeroTelefono());
					req.setAttribute("proprietarioTipo",  proprietario.getTipo());
				}
			}
			else if (specie == Specie.SINANTROPO) 
			{
				Sinantropo sinantropo = SinantropoUtil.getSinantropoByNumero(persistence, a.getAnimale().getIdentificativo());
				Detenzioni detenzioni = SinantropoUtil.getLastActiveDetentore( persistence, a.getAnimale().getIdentificativo() );
				if (detenzioni !=null && detenzioni.getLookupDetentori()!=null){
					if( detenzioni.getLookupDetentori().getId() == 1 ) //detentore privato
					{
						req.setAttribute("proprietarioCognome",  detenzioni.getDetentorePrivatoCognome());
						req.setAttribute("proprietarioNome",  detenzioni.getDetentorePrivatoNome());
						req.setAttribute("proprietarioCodiceFiscale",  detenzioni.getDetentorePrivatoCodiceFiscale());
						req.setAttribute("proprietarioDocumento", ((detenzioni.getLookupTipologiaDocumento()!=null)? detenzioni.getLookupTipologiaDocumento().getDescription():"") + ": "+ detenzioni.getDetentorePrivatoNumeroDocumento()  );
						req.setAttribute("proprietarioIndirizzo",  detenzioni.getLuogoDetenzione());
						req.setAttribute("proprietarioCap",   detenzioni.getComuneDetenzione().getCap());
						req.setAttribute("proprietarioComune",  detenzioni.getComuneDetenzione().getDescription());
						req.setAttribute("proprietarioProvincia", calcolaProvinciaSinantropo(detenzioni.getComuneDetenzione()));
						req.setAttribute("proprietarioTelefono",  detenzioni.getDetentorePrivatoTelefono());
						req.setAttribute("proprietarioTipo", "Detentore");
					}
					else //detentore non privato
					{
						if( detenzioni.getLookupDetentori().getLookupComuni() != null )
						{
							req.setAttribute("proprietarioCap",detenzioni.getLookupDetentori().getLookupComuni().getCap() );
							req.setAttribute("proprietarioComune", detenzioni.getLookupDetentori().getLookupComuni().getDescription() );
							req.setAttribute("proprietarioProvincia", calcolaProvinciaSinantropo( detenzioni.getLookupDetentori().getLookupComuni() ) );
						}
						req.setAttribute("proprietarioIndirizzo", detenzioni.getLookupDetentori().getIndirizzo() );
						req.setAttribute("proprietarioNome", detenzioni.getLookupDetentori().getDescription() );
						req.setAttribute("proprietarioTelefono", detenzioni.getLookupDetentori().getTelefono() );
						req.setAttribute("proprietarioTipo", "Detentore");
					}
				}
			}
		
		}
		
		
		req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(a.getAnimale(), cane, gatto, persistence, utente, status, connectionBdu,req));
		
		animale.getLookupSpecie().getId();
		SpecieAnimali.getInstance().getSinantropo();
		req.setAttribute( "animale", animale );
		
		Set<LookupAlimentazioni> 	la = a.getLookupAlimentazionis();
		Set<LookupHabitat> 			lh = a.getLookupHabitats();
		Set<LookupAlimentazioniQualita> 	listAlimentazioniQualita = a.getLookupAlimentazioniQualitas();
		
		req.setAttribute("listAlimentazioniQualita", listAlimentazioniQualita);
		req.setAttribute( "la", la );
		req.setAttribute( "lh", lh );
		
		
		gotoPage("onlybody", "/jsp/vam/altreDiagnosi/detailLLPP.jsp" );
	
	}
	
	
	
	private static String calcolaProvinciaSinantropo( LookupComuni comune )
	{
		String ret = "";
		
		if( comune.getAv() ) { ret = "AV"; }
		else if( comune.getBn() ) { ret = "BN"; }
		else if( comune.getCe() ) { ret = "CE"; }
		else if( comune.getNa() ) { ret = "NA"; }
		else if( comune.getSa() ) { ret = "SA"; }
		
		return ret;
	}
}


