package org.aspcfs.modules.macellazioninew.utils;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ApplicationPropertiesConfigTipo {
	
	private static Properties applicationProperties = null;
	
	private ApplicationPropertiesConfigTipo(){ }
	
	static{
		InputStream is = ApplicationPropertiesConfigTipo.class.getResourceAsStream( "configTipo.properties" );
		applicationProperties = new Properties();
		try {
			applicationProperties.load( is );
		} catch (IOException e) {
			applicationProperties = null;
		}
	}
	
	
	public static Properties getApplicationProperties() {
		return applicationProperties;
	}


	public static String getProperty( String property ){
		return (applicationProperties != null) ? applicationProperties.getProperty( property ) : "";
	}
}