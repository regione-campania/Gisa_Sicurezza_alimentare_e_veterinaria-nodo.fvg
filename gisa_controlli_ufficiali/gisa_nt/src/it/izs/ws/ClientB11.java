package it.izs.ws;


import java.io.FileNotFoundException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;





public class ClientB11 {

	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	
	
	static Logger logger = Logger.getLogger(ClientB11.class);
	private static String getData() {
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		//SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String rit = sdf.format( gc.getTime() );//.replace(":", "_");
		return ( rit );
	}
	
	public static Timestamp getTime ()
	{
		Timestamp time = new Timestamp(System.currentTimeMillis());
		return time ;
	}
	


}

				