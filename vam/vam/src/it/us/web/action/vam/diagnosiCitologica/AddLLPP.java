package it.us.web.action.vam.diagnosiCitologica;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;
import it.us.web.util.vam.IstopatologicoUtil;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.criterion.Restrictions;
import org.json.JSONObject;

import configurazione.centralizzata.nuova.gestione.ClientServizioCentralizzato;

public class AddLLPP extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "RICHIESTA_ISTOPATOLOGICO", "ADD_LLPP", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		EsameCitologico esame;
		
		if (booleanoFromRequest("modify")) {
			esame = (EsameCitologico) persistence.find( EsameCitologico.class, interoFromRequest( "id" ) );
		}
		else {
			esame = new EsameCitologico();
		}
		
		
		BeanUtils.populate( esame, req.getParameterMap() );
		
		HashSet<LookupHabitat> setH = objectList (LookupHabitat.class, "oph_");
		esame.setLookupHabitats(setH);
		
		HashSet<LookupAlimentazioni> setA = objectList (LookupAlimentazioni.class, "opa_");
		esame.setLookupAlimentazionis(setA);
		
		HashSet<LookupAlimentazioniQualita> setAQ = objectList (LookupAlimentazioniQualita.class, "opaq_");
		esame.setLookupAlimentazioniQualitas(setAQ);
		
		if(!stringaFromRequest( "idStatoGeneraleLookup" ).equals(""))
		{
			LookupStatoGenerale statoGenerale = (LookupStatoGenerale) persistence.find( LookupStatoGenerale.class, interoFromRequest( "idStatoGeneraleLookup" ) );
			esame.setStatoGeneraleLookup(statoGenerale);
		}
		
		
		
		Animale a = (Animale) persistence.find( Animale.class, interoFromRequest( "idAnimale" ) );
		
		esame.setOutsideCC(true);
		esame.setAnimale(a);
		
		esame.setAspettoLesione(stringaFromRequest("aspettoLesione"));
		
		LookupEsameCitologicoTipoPrelievo tipoPrelievo = (interoFromRequest("idTipoPrelievo")>0)?((LookupEsameCitologicoTipoPrelievo)persistence.find(LookupEsameCitologicoTipoPrelievo.class, interoFromRequest("idTipoPrelievo"))):(null);
		esame.setTipoPrelievo(tipoPrelievo);
		
		
		int idDiagnosi = interoFromRequest("idDiagnosi");
		LookupEsameCitologicoDiagnosi diagnosi = null;
		if(idDiagnosi>0)
		{
			diagnosi = (LookupEsameCitologicoDiagnosi) persistence.find( LookupEsameCitologicoDiagnosi.class, interoFromRequest( "idDiagnosi" ) );
		}
		
		int padreDiagnosi = interoFromRequest("padreDiagnosi");
		LookupEsameCitologicoDiagnosi diagnosiPadre = null;
		if(padreDiagnosi>0)
		{
			diagnosiPadre = (LookupEsameCitologicoDiagnosi) persistence.find( LookupEsameCitologicoDiagnosi.class, interoFromRequest( "padreDiagnosi" ) );
		}
		
		
		esame.setDiagnosiPadre( diagnosiPadre );
		
		esame.setDiagnosi( diagnosi );
		
		esame.setModified( new Date() );
		esame.setModifiedBy( utente );
		
		if( esame.getId() > 0 )
		{		
			
			persistence.update( esame );			
			setMessaggio( "Esame citologico modificato con successo" );
		}
		else
		{
			esame.setEntered( new Date() );
			esame.setEnteredBy( utente );
			
			persistence.insert( esame );
			setMessaggio( "Esame citologico inserito con successo" );
		}
		
		persistence.commit();
		//String pathVam = Application.get("VAM_PROTOCOLLO") + Application.get("VAM_NOME_HOST") + Application.get("VAM_PORTA") + "/vam";
		ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
		JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
		String pathVam = mappaEndPoints.getString("vam");
		
		redirectTo( pathVam + "/vam.diagnosiCitologica.DetailLLPP.us?id=" + esame.getId(),false );
	}
}
