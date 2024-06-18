package it.us.web.action.vam.richiesteIstopatologici;

import it.us.web.constants.Specie;
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
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.AnimaleAnagrafica;
import it.us.web.bean.vam.Diagnosi;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumore;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdRichiesteVarie;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class StampaIstoSingoloLP extends GenericAction {
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
		setSegnalibroDocumentazione("cc");
	}
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		//Se idCartellaClinica vuol dire che è già in sessione	
		int id = interoFromRequest("id");
		
		if(id>0)
			session.setAttribute("idEsame", id);		
		
		EsameIstopatologico esame = (EsameIstopatologico) persistence.find (EsameIstopatologico.class, id );	
		esame.getId();
		
		Gatto gatto = null;
		Cane cane = null;
		ServicesStatus status = new ServicesStatus();
		int specie = esame.getAnimale().getLookupSpecie().getId();
		if(!esame.getAnimale().getDecedutoNonAnagrafe())
		{
			if (specie == 1 ) 
			{
				cane = CaninaRemoteUtil.findCane(esame.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
			}
			else if (specie == 2) 
			{
				gatto = FelinaRemoteUtil.findGatto(esame.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
			}
		}
		
		
				
		req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(esame.getAnimale(), cane, gatto, persistence, utente, status, connection,req));
		
		req.setAttribute( "esame", esame);
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		
		
		
		HashMap<String, Object> fetchAnimale = AnimaliUtil.fetchAnimale( esame.getAnimale().getIdentificativo(), persistence, utente, status, connection,req );
		Animale animale = (Animale)fetchAnimale.get("animale");
			
			if(!animale.getDecedutoNonAnagrafe())
			{
				if (specie == Specie.CANE ) 
				{
					cane = CaninaRemoteUtil.findCane(animale.getIdentificativo(), utente, status, connectionBdu,req);
					RegistrazioniCaninaResponse res	= AnimaliUtil.fetchDatiDecessoCane(cane);
					req.setAttribute("res", res);
				}
				else if (specie == Specie.GATTO) 
				{
					gatto = FelinaRemoteUtil.findGatto(animale.getIdentificativo(), utente, status, connectionBdu,req);
					RegistrazioniFelinaResponse rfr	= AnimaliUtil.fetchDatiDecessoGatto(gatto);
					req.setAttribute("res", rfr);
				}
				else if (specie == Specie.SINANTROPO) 
				{
					RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, animale);
					req.setAttribute("res", rsr);
					req.setAttribute("fuoriAsl", false);
					req.setAttribute("versoAssocCanili", false);
				}
			}
			
			if(animale.getDecedutoNonAnagrafe())
			{
				Iterator<Accettazione> accettazioni = animale.getAccettaziones().iterator();
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
						cane = CaninaRemoteUtil.findCane(esame.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
					
					ProprietarioCane proprietario = CaninaRemoteUtil.findProprietario(esame.getAnimale().getIdentificativo(), utente, connectionBdu,req);
					
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
						gatto = FelinaRemoteUtil.findGatto(esame.getAnimale().getIdentificativo(), utente, status, connectionBdu,req);
					
					Colonia colonia = (Colonia)fetchAnimale.get("colonia");
					if(colonia==null)
						colonia = FelinaRemoteUtil.findColonia(esame.getAnimale().getIdentificativo(), utente, connectionBdu,req);
					
					req.setAttribute("colonia", colonia);
					
					ProprietarioGatto proprietario = FelinaRemoteUtil.findProprietario(esame.getAnimale().getIdentificativo(), utente, connectionBdu,req);
					
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
					Sinantropo sinantropo = SinantropoUtil.getSinantropoByNumero(persistence, esame.getAnimale().getIdentificativo());
					Detenzioni detenzioni = SinantropoUtil.getLastActiveDetentore( persistence, animale.getIdentificativo() );
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
			
		boolean liberoProfessionista = booleanoFromRequest("liberoProfessionista");
		req.setAttribute("liberoProfessionista", liberoProfessionista);
			
		req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(animale, cane, gatto, persistence, utente, status, connectionBdu,req));
		
		
		Set<LookupAlimentazioni> 	la = esame.getLookupAlimentazionis();
		Set<LookupHabitat> 			lh = esame.getLookupHabitats();
		Set<LookupAlimentazioniQualita> 	listAlimentazioniQualita = esame.getLookupAlimentazioniQualitas();
		
		req.setAttribute("listAlimentazioniQualita", listAlimentazioniQualita);
		req.setAttribute( "la", la );
		req.setAttribute( "lh", lh );
		
		req.setAttribute("animale", animale);
		
		gotoPage("popup", "/jsp/vam/richiesteIstopatologici/istoSingoloLP.jsp");
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
