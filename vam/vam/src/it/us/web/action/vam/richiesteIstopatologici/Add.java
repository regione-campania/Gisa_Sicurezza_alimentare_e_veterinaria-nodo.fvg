package it.us.web.action.vam.richiesteIstopatologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumore;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;
import it.us.web.util.vam.IstopatologicoUtil;

import java.sql.Connection;
import java.util.Date;
import java.util.HashSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.commons.beanutils.BeanUtils;
import org.json.JSONObject;

import configurazione.centralizzata.nuova.gestione.ClientServizioCentralizzato;

public class Add extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
//		can( gui, "w" );
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
		
		EsameIstopatologico esame;
		
		if (booleanoFromRequest("modify")) {
			esame = (EsameIstopatologico) persistence.find( EsameIstopatologico.class, interoFromRequest( "id" ) );
		}
		else {
			esame = new EsameIstopatologico();
		}
		
		
		BeanUtils.populate( esame, req.getParameterMap() );
		
		Animale a = (Animale) persistence.find( Animale.class, interoFromRequest( "idAnimale" ) );
		
		esame.setOutsideCC(true);
		esame.setAnimale(a);
		
		
		HashSet<LookupHabitat> setH = objectList (LookupHabitat.class, "oph_");
		esame.setLookupHabitats(setH);
		
		HashSet<LookupAlimentazioni> setA = objectList (LookupAlimentazioni.class, "opa_");
		esame.setLookupAlimentazionis(setA);
		
		//Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		HashSet<LookupAlimentazioniQualita> setAQ = objectList (LookupAlimentazioniQualita.class, "opaq_");
		esame.setLookupAlimentazioniQualitas(setAQ);
		}
		LookupEsameIstopatologicoSedeLesione sedeLesione
			= (LookupEsameIstopatologicoSedeLesione) persistence.find( LookupEsameIstopatologicoSedeLesione.class, interoFromRequest( "idSedeLesione" ) );
		LookupEsameIstopatologicoTumoriPrecedenti tumoriPrecedenti
			= (LookupEsameIstopatologicoTumoriPrecedenti) persistence.find( LookupEsameIstopatologicoTumoriPrecedenti.class, interoFromRequest( "idTumoriPrecedenti" ) );
		LookupEsameIstopatologicoInteressamentoLinfonodale interessamentoLinfonodale
			= (LookupEsameIstopatologicoInteressamentoLinfonodale) persistence.find( LookupEsameIstopatologicoInteressamentoLinfonodale.class, interoFromRequest( "idInteressamentoLinfonodale" ) );
		LookupEsameIstopatologicoTipoPrelievo tipoPrelievo
			= (LookupEsameIstopatologicoTipoPrelievo) persistence.find( LookupEsameIstopatologicoTipoPrelievo.class, interoFromRequest( "idTipoPrelievo" ) );
		LookupEsameIstopatologicoTipoDiagnosi tipoDiagnosi
			= (LookupEsameIstopatologicoTipoDiagnosi) persistence.find( LookupEsameIstopatologicoTipoDiagnosi.class, interoFromRequest( "idTipoDiagnosi" ) );

		LookupEsameIstopatologicoWhoUmana whoUmana = null;
		//LookupEsameIstopatologicoWhoAnimale whoAnimale = null;
		if( tipoDiagnosi.getId() == 1 )
		{
			whoUmana = (LookupEsameIstopatologicoWhoUmana) persistence.find( LookupEsameIstopatologicoWhoUmana.class, interoFromRequest( "idWhoUmana" ) );
		}
		else if( tipoDiagnosi.getId() == 2 )
		{
			//
		}

		if(!stringaFromRequest( "idStatoGeneraleLookup" ).equals(""))
		{
			LookupStatoGenerale statoGenerale = (LookupStatoGenerale) persistence.find( LookupStatoGenerale.class, interoFromRequest( "idStatoGeneraleLookup" ) );
			esame.setStatoGeneraleLookup(statoGenerale);
		}
		
		if(!stringaFromRequest( "idTumore" ).equals(""))
		{
			LookupEsameIstopatologicoTumore tumore = (LookupEsameIstopatologicoTumore) persistence.find( LookupEsameIstopatologicoTumore.class, interoFromRequest( "idTumore" ) );
			esame.setTumore(tumore);
		}
		
		
		esame.setTumoriPrecedenti( tumoriPrecedenti );
		esame.setTipoPrelievo( tipoPrelievo );
		esame.setInteressamentoLinfonodale( interessamentoLinfonodale );
		esame.setSedeLesione( sedeLesione );
		esame.setTipoDiagnosi( tipoDiagnosi );
		esame.setWhoUmana( whoUmana );
		
		esame.setModified( new Date() );
		esame.setModifiedBy( utente );
		
		
		if( esame.getId() > 0 )
		{		
			
			persistence.update( esame );			
			setMessaggio( "Esame Istopatologico modificato con successo" );
		}
		else
		{
			esame.setEntered( new Date() );
			esame.setEnteredBy( utente );
			
			esame.setNumero(IstopatologicoUtil.getNumero(connection));
			persistence.insert( esame );
			setMessaggio( "Esame Istopatologico inserito con successo" );
		}
		
		persistence.commit();
		//String pathVam = Application.get("VAM_PROTOCOLLO") + Application.get("VAM_NOME_HOST") + Application.get("VAM_PORTA") + "/vam";
		ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
		JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
		String pathVam = mappaEndPoints.getString("vam");
		
		redirectTo( pathVam + "/vam.richiesteIstopatologici.Detail.us?id=" + esame.getId()+"&liberoProfessionista=" + booleanoFromRequest("liberoProfessionista"),false );
	}
}
