package org.aspcfs.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Logger;

public class ApplicationPropertiesStart {
	
	private static Properties applicationProperties = null;
	private transient static Logger logger = Logger.getLogger("MainLogger");
	//costruttore
	public ApplicationPropertiesStart() { }
	 
//	static {
//		
//		InputStream is = ApplicationProperties.class.getResourceAsStream( "application.properties" );
//		applicationProperties = new Properties();
//		try{
//			applicationProperties.load( is );
//		}catch(IOException e) {
//			  logger.severe("[CANINA] - EXCEPTION nella classe ApplicationProperties");
//			applicationProperties = null;
//		}
//	}
	
	public static String getProperty ( String property ){
		return ( applicationProperties != null) ? applicationProperties.getProperty( property ) : null;
	}
	
	
public ApplicationPropertiesStart(String nomeFile) { 
		
		InputStream is = ApplicationProperties.class.getResourceAsStream( nomeFile);
		applicationProperties = new Properties();
		try{
			applicationProperties.load( is );
		}catch(IOException e) {
			  logger.severe("[CANINA] - EXCEPTION nella classe ApplicationProperties");
			applicationProperties = null;
		}
		
		
	}
	 
	
}