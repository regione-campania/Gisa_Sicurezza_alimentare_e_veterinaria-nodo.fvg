package it.izs.ws;


import java.io.FileNotFoundException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import javax.xml.rpc.ServiceException;

//import com.itextpdf.text.log.SysoLogger;


public class ClientRemove {

	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	
	private static String getData() {
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("dd_MM_yyyy_HH:mm:ss");
		String rit = sdf.format( gc.getTime() ).replace(":", "_");
		return ( rit );
	}
	
	public static Timestamp getTime ()
	{
		Timestamp time = new Timestamp(System.currentTimeMillis());
		return time ;
	}
	
	
	
	
	public static void main(String[] args) throws InterruptedException, ServiceException  {
 
		
	
			
		ControlliallevamentiService service = new ControlliallevamentiService();
		Controlliallevamenti client = service.getControlliallevamentiPort();
		//AUTENTICAZIONE
		AutenticazioneTO autenticazioneTo = new AutenticazioneTO();
		autenticazioneTo.setUsername("izsna_006");
		autenticazioneTo.setPassword("na.izs34");
		

		//AUTORIZZAZIONE
		AutorizzazioneTO autorizzazioneTo = new AutorizzazioneTO();
		autorizzazioneTo.setRuolo("regione");
		autorizzazioneTo.setGrspeCodice("");
		autorizzazioneTo.setCodiceLingua("IT");

			
				ControlliallevamentiWS con = new ControlliallevamentiWS();
				con.setCaId(65458);
				DeleteControlliallevamentiBA delBa = new DeleteControlliallevamentiBA();
				delBa.setControlliallevamenti(con);
				
				DeleteControlliallevamentiBAResponse response = null;
				
					try {
						response = client.deleteControlliallevamentiBA(delBa, autenticazioneTo, autorizzazioneTo);
					} catch (BusinessException_Exception | Exception_Exception
							| IzsWsException_Exception
							| SOAPException_Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				

				if (response!=null) {
					
					
					
				}
						
						
					}
					
			
		
	
	
	


}

				