package it.izs.apicoltura.apimovimentazione.ws;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.GregorianCalendar;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.aspcfs.modules.util.imports.ApplicationProperties;

import ext.aspcfs.modules.apiari.base.ModelloC;
import ext.aspcfs.modules.apiari.base.WSBdnLog;



public class WsApiAnagraficaMovimentazioni {
	
	private ApiingEndpoint serviceAnagraficaAziende =null ;
	SOAPAutenticazioneWS autenticazione = null ;


	public WsApiAnagraficaMovimentazioni()
	{
		ApiingEndpointService service = new ApiingEndpointService();

		serviceAnagraficaAziende = service.getApiingEndpointPort();
		autenticazione = new SOAPAutenticazioneWS();
		autenticazione.setUsername(ApplicationProperties.getProperty("USERNAME_BDAPI"));
		autenticazione.setPassword(ApplicationProperties.getProperty("PASSWORD_BDAPI"));
		autenticazione.setRuoloCodice(ApplicationProperties.getProperty("RUOLO_CODICE_BDAPI"));
		autenticazione.setRuoloValoreCodice(ApplicationProperties.getProperty("RUOLO_VALORE_BDAPI"));
	}
	
	
	
	public Apiing insert(ModelloC movimentazione,Connection db,int idutente) throws it.izs.apicoltura.apimovimentazione.ws.BusinessWsException_Exception
	{

		WSBdnLog logWS = new WSBdnLog();
		
		Apiing aziendaResp = null;
		Apiing apiIngTo = new Apiing();
		apiIngTo.setApiattAziendaCodice(movimentazione.getCodiceAziendaDestinazione());
		apiIngTo.setApiProgressivo(Integer.parseInt(movimentazione.getProgressivoApiarioDestinazione()));
		apiIngTo.setProvApiattAziendaCodice(movimentazione.getCodiceAziendaOrigine());
		apiIngTo.setProvApiProgressivo(Integer.parseInt(movimentazione.getProgressivoApiarioOrigine()));
		apiIngTo.setNumAlveari(movimentazione.getNumApiariSpostati());
		apiIngTo.setNumApiRegine(0);
		apiIngTo.setNumPacchiDapi(0);
		apiIngTo.setNumSciami(0);
		
		try {

			GregorianCalendar c = new GregorianCalendar();
			
			c.setTime(movimentazione.getDataMovimentazione());
			XMLGregorianCalendar dtApertura = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);

			apiIngTo.setDtIngresso(dtApertura);								

		} catch (DatatypeConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(movimentazione.getIdTipoMovimentazione()==1)
			apiIngTo.setApimotingCodice("C");
		else
			apiIngTo.setApimotingCodice("N");
		
		InsertApiing ingressoMovimentazione = new InsertApiing();
		ingressoMovimentazione.setApiingTO(apiIngTo);

		logWS.setParametri(apiIngTo);
		try {
			logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));

			InsertApiingResponse responce = serviceAnagraficaAziende.insertApiing(ingressoMovimentazione, autenticazione);

			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("OK");
			logWS.insertBdnLogWs();
			aziendaResp = responce.getApiingTO();
			

		} catch (it.izs.apicoltura.apimovimentazione.ws.BusinessWsException_Exception e) {

			logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
			logWS.setEsito("KO");
			String errore ="";
			
			 errore = e.getFaultInfo().getMessage()+" : "+e.getFaultInfo().getResult().getErrore();
			
			for (it.izs.apicoltura.apimovimentazione.ws.FieldError error : e.getFaultInfo().getResult().getErrors())
			{
				errore +="["+error.getField()+": "+error.getMessage()+ "]" ;
	
			}
			
			
			logWS.setNoteEsito(errore);
			
			logWS.insertBdnLogWs();
			throw e ;
		}
		return aziendaResp;

	}


}
