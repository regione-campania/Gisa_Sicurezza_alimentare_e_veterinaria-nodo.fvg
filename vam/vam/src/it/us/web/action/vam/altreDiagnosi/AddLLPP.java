package it.us.web.action.vam.altreDiagnosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.AltreDiagnosi;
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
import it.us.web.dao.UtenteDAO;
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
		BGuiView gui = GuiViewDAO.getView( "ALTRE_DIAGNOSI", "ADD_LLPP", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{
		Animale a = (Animale) persistence.find( Animale.class, interoFromRequest( "idAnimale" ) );
		
		AltreDiagnosi altreDiagnosi = new AltreDiagnosi();
		
		BeanUtils.populate( altreDiagnosi, req.getParameterMap() );
		
		HashSet<LookupHabitat> setH = objectList (LookupHabitat.class, "oph_");
		altreDiagnosi.setLookupHabitats(setH);
		
		HashSet<LookupAlimentazioni> setA = objectList (LookupAlimentazioni.class, "opa_");
		altreDiagnosi.setLookupAlimentazionis(setA);
		
		HashSet<LookupAlimentazioniQualita> setAQ = objectList (LookupAlimentazioniQualita.class, "opaq_");
		altreDiagnosi.setLookupAlimentazioniQualitas(setAQ);
		
		if(!stringaFromRequest( "idStatoGeneraleLookup" ).equals(""))
		{
			LookupStatoGenerale statoGenerale = (LookupStatoGenerale) persistence.find( LookupStatoGenerale.class, interoFromRequest( "idStatoGeneraleLookup" ) );
			altreDiagnosi.setStatoGeneraleLookup(statoGenerale);
		}
		
		if(!stringaFromRequest( "idDiagnosiNoteBase1" ).equals("") && stringaFromRequest("idDiagnosi").equals("1"))
		{
			altreDiagnosi.setNoteBase1(stringaFromRequest( "idDiagnosiNoteBase1" ));
		}
		if(!stringaFromRequest( "idDiagnosiNoteBase2" ).equals("")  && stringaFromRequest("idDiagnosi").equals("2"))
		{
			altreDiagnosi.setNoteBase2(stringaFromRequest( "idDiagnosiNoteBase2" ));
		}
		
		if(!stringaFromRequest( "idDiagnosiNoteRx" ).equals("")  && stringaFromRequest("idDiagnosiRx")!=null  && stringaFromRequest("idDiagnosiRx").equals("1"))
		{
			altreDiagnosi.setNoteBase3Rx(stringaFromRequest( "idDiagnosiNoteRx" ));
			altreDiagnosi.setBase3Rx(true);
		}
		
		if(!stringaFromRequest( "idDiagnosiNoteRM" ).equals("")  && stringaFromRequest("idDiagnosiRM")!=null  && stringaFromRequest("idDiagnosiRM").equals("4"))
		{
			altreDiagnosi.setNoteBase3Rm(stringaFromRequest( "idDiagnosiNoteRM" ));
			altreDiagnosi.setBase3RM(true);
		}
		
		if(!stringaFromRequest( "idDiagnosiNoteTac" ).equals("")  && stringaFromRequest("idDiagnosiTac")!=null  && stringaFromRequest("idDiagnosiTac").equals("3"))
		{
			altreDiagnosi.setNoteBase3Tac(stringaFromRequest( "idDiagnosiNoteTac" ));
			altreDiagnosi.setBase3Tac(true);
		}
		
		if(!stringaFromRequest( "idDiagnosiNoteEco" ).equals("")  && stringaFromRequest("idDiagnosiEco")!=null  && stringaFromRequest("idDiagnosiEco").equals("2"))
		{
			altreDiagnosi.setNoteBase3Eco(stringaFromRequest( "idDiagnosiNoteEco" ));
			altreDiagnosi.setBase3Eco(true);
		}
		
		
		
		
		
		
		
		altreDiagnosi.setAltraDiagnosi(interoFromRequest( "idDiagnosi"));
		altreDiagnosi.setNote(stringaFromRequest( "idDiagnosiNote"));
		altreDiagnosi.setEnteredBy(UtenteDAO.getUtenteAll(utente.getId()));
		altreDiagnosi.setEntered(new Date());
		altreDiagnosi.setAnimale(a);
			
		persistence.insert( altreDiagnosi );			
		setMessaggio( "Diagnosi inserita con successo" );
		
		persistence.commit();
		
		//String pathVam = Application.get("VAM_PROTOCOLLO") + Application.get("VAM_NOME_HOST") + Application.get("VAM_PORTA") + "/vam";
		ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
		JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
		String pathVam = mappaEndPoints.getString("vam");
		
		redirectTo( pathVam + "/vam.altreDiagnosi.DetailLLPP.us?id=" + altreDiagnosi.getId(),false );
	}
}
