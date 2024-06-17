package org.aspcf.modules.report.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;




public class ApplicationProperties {
	
	private static Properties applicationProperties = null;
	
	//costruttore
	public ApplicationProperties() { }
	
	static {
		
		InputStream is = ApplicationProperties.class.getResourceAsStream( "application.properties" );
		applicationProperties = new Properties();
		try{
			applicationProperties.load( is );
		}catch(IOException e) {
			applicationProperties = null;
		}
	}
	
	public static String getProperty ( String property ){
		return ( applicationProperties != null) ? applicationProperties.getProperty( property ) : null;
	}
}