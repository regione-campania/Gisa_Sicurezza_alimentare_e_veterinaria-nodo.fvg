package org.aspcfs.modules.anagrafe_animali.base;



import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;



public class anagrafeUtilis {

	protected static Properties load( String fileName )
	{
		InputStream	is = anagrafeUtilis.class.getResourceAsStream( fileName );
		Properties prop = new Properties();
		try
		{
			prop.load( is );
		} 
		catch (IOException e)
		{
			prop = null;
		}
		return prop;
	}
}
