package it.izs.apicoltura.apianagraficaattivita.ws;

import it.izs.bdn.action.utilsXML;
import it.izs.ws.WsPost;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.aspcfs.modules.gestoriacquenew.base.EccezioneDati;
import org.aspcfs.modules.util.imports.ApplicationProperties;

import com.sun.xml.internal.ws.fault.ServerSOAPFaultException;

import ext.aspcfs.modules.apiari.base.Operatore;
import ext.aspcfs.modules.apiari.base.WSBdnLog;

public class WsApiAnagraficaAttivita {
	
	  private final static Logger log = Logger.getLogger(it.izs.apicoltura.apianagraficaattivita.ws.WsApiAnagraficaAttivita.class);

	ApiattEndpoint endPointAnagraficaAttivita = null ;
	SOAPAutenticazioneWS autenticazione = null ;
	
	public WsApiAnagraficaAttivita()
	{
		ApiattEndpointService service = new ApiattEndpointService();
		endPointAnagraficaAttivita = service.getApiattEndpointPort();
		autenticazione = new SOAPAutenticazioneWS();
		autenticazione.setUsername(ApplicationProperties.getProperty("USERNAME_BDAPI"));
		autenticazione.setPassword(ApplicationProperties.getProperty("PASSWORD_BDAPI"));
		autenticazione.setRuoloCodice(ApplicationProperties.getProperty("RUOLO_CODICE_BDAPI"));
		autenticazione.setRuoloValoreCodice(ApplicationProperties.getProperty("RUOLO_VALORE_BDAPI"));
		
	}
	
	
	
	public Apiatt search(Operatore op,Connection db,int idutente) throws BusinessWsException_Exception
	{
		
		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idutente);
		logWS.setIdOggetto(-1);
		logWS.setNomeTabella("");
		logWS.setTipoOperazione(WSBdnLog.TYPE_WS_SEARCH_AZIENDA);
		Apiatt attResp = null ;
		Apiatt attivita = new Apiatt();
		
		/**
		 * Settare i filtri
		 */
		
		if(op.getSedeLegale()!=null)
		{
		attivita.setComSlIstat(op.getSedeLegale().getCodiceIstatComune());
		}
		attivita.setAziendaCodice(op.getCodiceAzienda());
		
		SearchApiAttivita search = new SearchApiAttivita();
		search.setApiAttivitaSearch(attivita);
		List<Apiatt> listaAziende = new ArrayList<Apiatt>();
		try {
			logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));
			
			SearchApiAttivitaResponse responce = endPointAnagraficaAttivita.searchApiAttivita(search, autenticazione);
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("OK");
			logWS.insertBdnLogWs();
			 listaAziende = responce.getApiAttivitaTO();
			 
			 if (listaAziende.size()>0)
				 attResp = listaAziende.get(0);
			
		} catch (it.izs.apicoltura.apianagraficaattivita.ws.BusinessWsException_Exception e) {
			
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			
			String errore ="";
			if (e instanceof BusinessWsException_Exception)
			{
				BusinessWsException_Exception ee = (BusinessWsException_Exception)e;
			 errore = ee.getFaultInfo().getMessage()+" : "+ee.getFaultInfo().getResult().getErrore();
			
			for (FieldError error : ee.getFaultInfo().getResult().getErrors())
			{
				errore +="["+error.getField()+": "+error.getMessage()+ "]" ;
	
			}
			}
			
			logWS.setNoteEsito(errore);
			
			logWS.insertBdnLogWs();
			throw e ;
		}
		return attResp;
		
	}
	
	public Apiatt insertApiAnagraficaattivita(Operatore attivitaApicoltura,Connection db,int idUtente) throws SQLException, EccezioneDati 
	{
		/*log.info("##WS.API.ANAGRAFICA.ATTIVITA## CHIAMATO SERVIZIO");
		Apiatt ricattivitaTo = new Apiatt();
		String codiceAttivita ="";

		Apiatt attResp = null;
		
		attResp = search(attivitaApicoltura, db, idUtente);
		if (attResp != null)
			return attResp;
		
		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idUtente);
		logWS.setIdOggetto(attivitaApicoltura.getIdOperatore());
		logWS.setNomeTabella("apicoltura_imprese");
		logWS.setTipoOperazione(WSBdnLog.TYPE_WS_INSERT_ATTIVITA);
		logWS.setNomerServizio("insertAttivita");
		try {
			
			PreparedStatement pst = db.prepareStatement("select codice_attivita from apicoltura_lookup_tipo_attivita where code =? ");
			pst.setInt(1, attivitaApicoltura.getIdTipoAttivita());
			ResultSet rs =pst.executeQuery();
			if (rs.next())
				codiceAttivita=rs.getString(1);
			
			ricattivitaTo.setDenominazione(attivitaApicoltura.getRagioneSociale());
			ricattivitaTo.setComSlIstat(attivitaApicoltura.getSedeLegale().getCodiceIstatComune()); // istat
			ricattivitaTo.setComSlCap(attivitaApicoltura.getSedeLegale().getCap()); 
			ricattivitaTo.setComSlProSigla(attivitaApicoltura.getSedeLegale().getSiglaProvincia()); // sigla provincia
			ricattivitaTo.setIndirizzoSl(attivitaApicoltura.getSedeLegale().getVia());
			ricattivitaTo.setLocalitaSl(attivitaApicoltura.getSedeLegale().getVia());
			ricattivitaTo.setAziendaCodice(attivitaApicoltura.getCodiceAzienda());
			ricattivitaTo.setApitipattCodice(codiceAttivita);
			ricattivitaTo.setNumTelFisso(attivitaApicoltura.getTelefono1());
			ricattivitaTo.setNumTelMobile(attivitaApicoltura.getTelefono2());
			ricattivitaTo.setEmail(attivitaApicoltura.getDomicilioDigitale());
			ricattivitaTo.setAslCodice(attivitaApicoltura.getSedeLegale().getCodiceAsl());
			

			
			ricattivitaTo.setPropIdFiscale(attivitaApicoltura.getRappLegale().getCodFiscale()); // anagrafare persona se non esiste
			ricattivitaTo.setPropCognNome(attivitaApicoltura.getRappLegale().getCognome()+" "+attivitaApicoltura.getRappLegale().getNome());
			
			GregorianCalendar c = new GregorianCalendar();
			c.setTime(attivitaApicoltura.getDataInizio());
			XMLGregorianCalendar dtApertura = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
			ricattivitaTo.setDtInizioAttivita(dtApertura);
			
			

			InsertApiAttivita insertAttivita = new InsertApiAttivita();
			insertAttivita.setApiAttivitaTO(ricattivitaTo);
			logWS.setParametri(ricattivitaTo);
			try {

				logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));
				InsertApiAttivitaResponse response =  endPointAnagraficaAttivita.insertApiAttivita(insertAttivita, autenticazione);
				logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
				logWS.setEsito("OK");
				logWS.insertBdnLogWs();
				
				attResp =  response.getApiAttivitaTO();
				
				log.info("##WS.API.ANAGRAFICA.ATTIVITA## CHIAMATO SERVIZIO OK");
				
				 pst = db.prepareStatement("update  apicoltura_imprese set id_bda = ? where id = ?  ");
				 pst.setInt(1, attResp.getApiattId());
				 pst.setInt(2, attivitaApicoltura.getIdOperatore());
				 pst.execute();

			} catch (BusinessWsException_Exception e) {
				
				log.info("##WS.API.ANAGRAFICA.ATTIVITA## CHIAMATO SERVIZIO KO");
				
				logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
				
				String errore = e.getFaultInfo().getMessage()+" : "+e.getFaultInfo().getResult().getErrore();
				
				for (FieldError error : e.getFaultInfo().getResult().getErrors())
				{
					errore +="["+error.getField()+": "+error.getMessage()+ "]" ;

					
				}
				
				logWS.setEsito("KO");
				logWS.setNoteEsito(errore);
				logWS.insertBdnLogWs();
				// TODO Auto-generated catch block
				throw e ;
			}
			catch (ServerSOAPFaultException e) {
				// TODO Auto-generated catch block
				logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
				logWS.setEsito("KO");
				
				logWS.setNoteEsito("ERRORE : "+e.getMessage());
				logWS.insertBdnLogWs();
				
				log.info("##WS.API.ANAGRAFICA.ATTIVITA## CHIAMATO SERVIZIO KO");
				throw e ;
			
				
			}


		} catch (DatatypeConfigurationException e) {
			log.info("##WS.API.ANAGRAFICA.ATTIVITA## CHIAMATO SERVIZIO KO");
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			logWS.setNoteEsito("ERRORE : "+e.getMessage());
			logWS.insertBdnLogWs();
			// TODO Auto-generated catch block
			e.printStackTrace();
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e1) {
			log.info("##WS.API.ANAGRAFICA.ATTIVITA## CHIAMATO SERVIZIO KO");
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			logWS.setNoteEsito("ERRORE : "+e1.getMessage());
			logWS.insertBdnLogWs();
			// TODO Auto-generated catch block
			// TODO Auto-generated catch block
		}
		return attResp ;*/
		
		String codiceAttivita ="";
		
		PreparedStatement pst = db.prepareStatement("select codice_attivita from apicoltura_lookup_tipo_attivita where code =? ");
		pst.setInt(1, attivitaApicoltura.getIdTipoAttivita());
		ResultSet rs =pst.executeQuery();
		if (rs.next())
			codiceAttivita=rs.getString(1);
		
		NumberFormat formattatore = NumberFormat.getNumberInstance(Locale.CANADA); // cultura predefinita

		// imposto il formattatore con le specifiche desiderate
		formattatore.setMaximumFractionDigits(6); // max 6 cifre decimali dopo la virgola
		
		WsPost wsPost = new WsPost(db, WsPost.ENDPOINT_API_ATTIVITA,WsPost.AZIONE_INSERT);
		
		HashMap<String, Object> campiInput = new HashMap<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		campiInput.put("denominazione",attivitaApicoltura.getRagioneSociale());
		campiInput.put("dtInizioAttivita",sdf.format(attivitaApicoltura.getDataInizio())+"T00:00:00.0");
		campiInput.put("comSlIstat",attivitaApicoltura.getSedeLegale().getCodiceIstatComune());
		campiInput.put("comSlCap",attivitaApicoltura.getSedeLegale().getCap());
		campiInput.put("comSlProSigla",attivitaApicoltura.getSedeLegale().getSiglaProvincia());
		campiInput.put("indirizzoSl",attivitaApicoltura.getSedeLegale().getVia());
		campiInput.put("localitaSl",attivitaApicoltura.getSedeLegale().getVia());
		campiInput.put("aziendaCodice",attivitaApicoltura.getCodiceAzienda());
		campiInput.put("apitipattCodice",codiceAttivita);
		campiInput.put("numTelFisso",attivitaApicoltura.getTelefono1());
		campiInput.put("numTelMobile",attivitaApicoltura.getTelefono2());
		campiInput.put("email",attivitaApicoltura.getDomicilioDigitale());
		campiInput.put("aslCodice",attivitaApicoltura.getSedeLegale().getCodiceAsl());
		campiInput.put("propIdFiscale",attivitaApicoltura.getRappLegale().getCodFiscale());
		campiInput.put("propCognNome",attivitaApicoltura.getRappLegale().getCognome()+" "+attivitaApicoltura.getRappLegale().getNome());
		campiInput.put("apiattLabSmielatura",(attivitaApicoltura.isFlagProduzioneConLaboratorio()?("S"):("N")));
		
		if(ApplicationProperties.getProperty("flusso356_2").equals("true")){

		campiInput.put("capacitaStrutturale",(attivitaApicoltura.getCapacita()));
		}
		
		wsPost.setCampiInput(campiInput);
		wsPost.costruisciEnvelope(db);
		String response = wsPost.post(db, idUtente);
		String idAtt = utilsXML.getValoreNodoXML(response,"apiattId");
		
		if(idAtt==null || idAtt.equals(""))
		{
			System.out.println("Errore nell'invio in bdn dell'attivita");
			String messaggio = utilsXML.getValoreNodoXML(response,"faultstring");
			throw new EccezioneDati("Errore nell'invio in bdn: " + ((messaggio!=null)?(messaggio):("")) );
		}
		else
		{
			Apiatt attivita = new Apiatt();
			attivita.setApiattId(Integer.parseInt(idAtt)); 
			return attivita;
		}
		
	}
	
	
	public String cessa(Operatore op,Connection db,int idutente) throws Exception
	{
		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idutente);
		logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));
		
		Apiatt att = new Apiatt();
		
		try
		{
			att = search(op, db, idutente);
			if(att==null)
				return "Attività non presente in bdn";
			GregorianCalendar cFine = new GregorianCalendar();
			cFine.setTime(op.getDataChiusura());
			XMLGregorianCalendar dtChiusura = DatatypeFactory.newInstance().newXMLGregorianCalendar(cFine);
			att.setDtCessazione(dtChiusura);	
	
			UpdateApiAttivita updateAttivita = new UpdateApiAttivita();
			updateAttivita.setApiAttivitaTO(att);
	
			logWS.setIdOggetto(op.getIdOperatore());
			logWS.setNomeTabella("apicoltura_imprese");
			logWS.setTipoOperazione(WSBdnLog.TYPE_WS_UPDATE_ATTIVITA);
			logWS.setNomerServizio("updateApiAttivita");
			logWS.setParametri(att);
			logWS.setNomeTabella("apicoltura_imprese");
			UpdateApiAttivitaResponse responce = endPointAnagraficaAttivita.updateApiAttivita(updateAttivita, autenticazione);
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("OK");
			logWS.setNoteEsito(responce.getApiAttivitaTO().toString());
			logWS.insertBdnLogWs();
			return "OK";
		}
		catch (it.izs.apicoltura.apianagraficaattivita.ws.BusinessWsException_Exception e) 
		{
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			String errore ="";
			
			errore = e.getFaultInfo().getMessage()+" : "+e.getFaultInfo().getResult().getErrore();
			
			for (it.izs.apicoltura.apianagraficaattivita.ws.FieldError error : e.getFaultInfo().getResult().getErrors())
			{
				errore +="["+error.getField()+": "+error.getMessage()+ "]" ;
	
			}
			
			logWS.setNoteEsito(errore);
			logWS.insertBdnLogWs();
			return errore;
		}
		
		
		
		
		
		
	}
	
	
	public String updateRagioneSociale(Operatore attivitaApicoltura,Connection db,int idUtente) throws BusinessWsException_Exception 
	{
		log.info("##WS.API.ANAGRAFICA.VARIAZIONE.APIARIO## CHIAMATO SERVIZIO");

		
		try
		{
		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idUtente);
		logWS.setIdOggetto(attivitaApicoltura.getIdOperatore());
		logWS.setNomeTabella("apicoltura_imprese");
		logWS.setTipoOperazione(WSBdnLog.TYPE_WS_UPDATE_ATTIVITA);
		logWS.setNomerServizio("updateAttivita");
		Apiatt api = searchByPk(attivitaApicoltura, db, idUtente);
		
		api.setDenominazione(attivitaApicoltura.getRagioneSociale());
		
		
		UpdateApiAttivita attivita = new UpdateApiAttivita();
		attivita.setApiAttivitaTO(api);
		
		logWS.setParametri(api);

		try {
			logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));
			UpdateApiAttivitaResponse response =  endPointAnagraficaAttivita.updateApiAttivita(attivita, autenticazione);
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("OK");
			logWS.insertBdnLogWs();
			
			
			log.info("##WS.API.ANAGRAFICA.VARIAZIONE.ATTIVITA## CHIAMATO SERVIZIO OK");
		} catch (BusinessWsException_Exception e) {
			
			String errore ="";
			if (e instanceof BusinessWsException_Exception)
			{
				BusinessWsException_Exception ee = (BusinessWsException_Exception)e;
			 errore = ee.getFaultInfo().getMessage()+" : "+ee.getFaultInfo().getResult().getErrore();
			
			for (FieldError error : ee.getFaultInfo().getResult().getErrors())
			{
				errore +="["+error.getField()+": "+error.getMessage()+ "]" ;
	
			}
			}
			
			logWS.setNoteEsito(errore);

			
			log.info("##WS.API.ANAGRAFICA.VARIAZIONE.ATTIVITA## CHIAMATO SERVIZIO KO");
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			//logWS.insertBdnLogWs();
			logWS.insertBdnLogWsErrore();
			
			return errore;
			
		}
		catch (ServerSOAPFaultException e) {
			// TODO Auto-generated catch block
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			logWS.setNoteEsito("ERRORE ServerSOAPFaultException: "+e.getMessage());
			//logWS.insertBdnLogWs();
			logWS.insertBdnLogWsErrore();
			
			log.info("ServerSOAPFaultException: ##WS.API.ANAGRAFICA.VARIAZIONE.APIARIO## CHIAMATO SERVIZIO KO");
			return e.getMessage();
		
			
		}

		}catch(Exception e)
		{
			return e.getMessage();
		}
		return "OK";
	


	}
	
	
	public String updateCapacita(Operatore attivitaApicoltura,Connection db,int idUtente) throws BusinessWsException_Exception 
	{
		log.info("##WS.API.ANAGRAFICA.VARIAZIONE.APIARIO## CHIAMATO SERVIZIO");

		
		try
		{
		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idUtente);
		logWS.setIdOggetto(attivitaApicoltura.getIdOperatore());
		logWS.setNomeTabella("apicoltura_imprese");
		logWS.setTipoOperazione(WSBdnLog.TYPE_WS_UPDATE_ATTIVITA);
		logWS.setNomerServizio("updateAttivita");
		Apiatt api = searchByPk(attivitaApicoltura, db, idUtente);
		
		Integer capacita = attivitaApicoltura.getCapacita();
	
		api.setCapacitaStrutturale(capacita);
		
		
		UpdateApiAttivita attivita = new UpdateApiAttivita();
		attivita.setApiAttivitaTO(api);
		
		logWS.setParametri(api);

		try {
			logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));
			UpdateApiAttivitaResponse response =  endPointAnagraficaAttivita.updateApiAttivita(attivita, autenticazione);
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("OK");
			logWS.insertBdnLogWs();
			
			
			log.info("##WS.API.ANAGRAFICA.VARIAZIONE.ATTIVITA## CHIAMATO SERVIZIO OK");
		} catch (BusinessWsException_Exception e) {
			
			String errore ="";
			if (e instanceof BusinessWsException_Exception)
			{
				BusinessWsException_Exception ee = (BusinessWsException_Exception)e;
			 errore = ee.getFaultInfo().getMessage()+" : "+ee.getFaultInfo().getResult().getErrore();
			
			for (FieldError error : ee.getFaultInfo().getResult().getErrors())
			{
				errore +="["+error.getField()+": "+error.getMessage()+ "]" ;
	
			}
			}
			
			logWS.setNoteEsito(errore);

			
			log.info("##WS.API.ANAGRAFICA.VARIAZIONE.ATTIVITA## CHIAMATO SERVIZIO KO");
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			//logWS.insertBdnLogWs();
			logWS.insertBdnLogWsErrore();
			
			return errore;
			
		}
		catch (ServerSOAPFaultException e) {
			// TODO Auto-generated catch block
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			logWS.setNoteEsito("ERRORE ServerSOAPFaultException: "+e.getMessage());
			//logWS.insertBdnLogWs();
			logWS.insertBdnLogWsErrore();
			
			log.info("ServerSOAPFaultException: ##WS.API.ANAGRAFICA.VARIAZIONE.APIARIO## CHIAMATO SERVIZIO KO");
			return e.getMessage();
		
			
		}

		}catch(Exception e)
		{
			return e.getMessage();
		}
		return "OK";
	


	}
	
	
	
	
	
	public Apiatt searchByPk(Operatore attivitaApicoltura,Connection db,int idUtente) throws BusinessWsException_Exception 
	{
		log.info("##WS.API.ANAGRAFICA.VARIAZIONE.ATTIVITA## CHIAMATO SERVIZIO");

		Apiatt risposta = new Apiatt();
		try
		{
		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idUtente);
		logWS.setIdOggetto(attivitaApicoltura.getIdOperatore());
		logWS.setNomeTabella("apicoltura_imprese");
		logWS.setTipoOperazione(WSBdnLog.TYPE_WS_SEARCH_ATTIVITA);
		logWS.setNomerServizio("searchAttivita");
		Apiatt api = new Apiatt();
		api.setApiattId(attivitaApicoltura.getIdBda());
		
		SearchApiAttivitaByPk attivita = new SearchApiAttivitaByPk();
		attivita.setApiattId(api.getApiattId());
		
		logWS.setParametri(api);

		try {
			logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));
			SearchApiAttivitaByPkResponse response =  endPointAnagraficaAttivita.searchApiAttivitaByPk(attivita, autenticazione);
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("OK");
			logWS.insertBdnLogWs();
			
			
			 risposta =  response.getApiAttivitaTO();
			return risposta ;
			

		} 
		catch (ServerSOAPFaultException e) {
			// TODO Auto-generated catch block
			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			logWS.setNoteEsito("ERRORE ServerSOAPFaultException: "+e.getMessage());
			//logWS.insertBdnLogWs();
			logWS.insertBdnLogWsErrore();
			
			log.info("ServerSOAPFaultException: ##WS.API.ANAGRAFICA.VARIAZIONE.APIARIO## CHIAMATO SERVIZIO KO");
			throw e ;
		
			
		}

		}catch(Exception e)
		{
			throw e;
		}
	


	}

}
