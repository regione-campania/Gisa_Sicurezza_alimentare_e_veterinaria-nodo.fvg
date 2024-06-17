package it.izs.sinsa.services;

import it.izs.sinsa.services.PrelievoAltreInformazioniWs.Informazioni;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

public class Client {

	/**
	 * @param args
	 * @throws ParseException 
	 * @throws DatatypeConfigurationException 
	 */
	public static void main(String[] args) throws ParseException, DatatypeConfigurationException {

		//prelevatori   ASL Napoli 1 Centro
					
		PrelieviService service = new PrelieviService();
		Prelievi prelievi = service.getPrelieviPort();
		
		AutenticazioneTO autenticazione = new AutenticazioneTO();
		autenticazione.setUsername("izsna_006");
		autenticazione.setPassword("na.izs34");
		
		AutorizzazioneTO autorizzione = new AutorizzazioneTO();
		autorizzione.setRuoloCodice("SVREG");
		autorizzione.setRuoloValoreCodice("150");
		PrelievoWsTO prelievoTo = new PrelievoWsTO();
		
		prelievoTo.setPianoCodice("PMAM"); //OK
		prelievoTo.setNumeroScheda("1043A-10440-B");//OK
		
		String data = "2016-01-18";//OK
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		GregorianCalendar c = new GregorianCalendar();
		c.setTime(sdf.parse(data));
		XMLGregorianCalendar dtcontrollo = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
		prelievoTo.setDataPrelievo(dtcontrollo);
	
		prelievoTo.setLaboratorioCodice("1043A");//OK
		prelievoTo.setLuogoPrelievoCodice("ALL");//OK
		prelievoTo.setMetodoCampionamentoCodice("001");//OK
		prelievoTo.setMotivoCodice("003");//OK
		prelievoTo.setSitoCodice("1500012");//OK
		prelievoTo.setSitoComCodice("049");//OK
		prelievoTo.setSitoProSigla("NA");//OK
		prelievoTo.setSitoLatitudine(40.790562);//OK
		prelievoTo.setSitoLongitudine(14.173803);//OK
		
		//NEW
		prelievoTo.setAssistCodFiscale("06328131211");//OK
		//NEW OK
		ContaminanteWsTO contaminanteWsTO = new ContaminanteWsTO();
		contaminanteWsTO.setContaminanteCodice("SAL");
		prelievoTo.getContaminanti().add(contaminanteWsTO);
		
		PrelevatoreWsTO prel = new PrelevatoreWsTO();
		prel.setPrelCodFiscale("06328131211");//OK
		prelievoTo.getPrelevatori().add(prel);
		
		
		CampionePrelevatoWsTO campione = new CampionePrelevatoWsTO();
		//campione.setProgressivoCampione(1);
		//campione.setFoodexCodice("FCI");
		
		PrelievoAltreInformazioniWs al = new PrelievoAltreInformazioniWs();
		Informazioni in = new Informazioni();
		it.izs.sinsa.services.PrelievoAltreInformazioniWs.Informazioni.Entry e = new it.izs.sinsa.services.PrelievoAltreInformazioniWs.Informazioni.Entry();
	
		//e.setKey("profFondale");
		//e.setValue("232");;
		//in.getEntry().add(e);
		//al.setInformazioni(in);
		//campione.setAltreInformazioni(al);
		
		
		prelievoTo.getCampioniPrelevati().add(campione);
		
		InsertPrelievo p = new InsertPrelievo();
		p.setPrelievo(prelievoTo);
		
		
		try {
		InsertPrelievoResponse risposta = prelievi.insertPrelievo(p, autenticazione, autorizzione);
		risposta.getReturn();
		
		
		} catch (BusinessException_Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (Exception_Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (IzsWsException_Exception e3) {
			
			e3.printStackTrace();
		} catch (SOAPException_Exception e4) {
			// TODO Auto-generated catch block
			e4.printStackTrace();
		}
		

	}

}
