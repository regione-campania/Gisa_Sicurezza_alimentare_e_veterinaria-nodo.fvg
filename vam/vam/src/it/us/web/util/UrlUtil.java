package it.us.web.util;

import it.us.web.util.properties.Application;
import it.us.web.util.vam.Token;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

public class UrlUtil
{
	public static String getUrlResponse( String urlString ) throws IOException
	{
		String ret = null;
		
		URL					url = new URL( urlString );
		URLConnection		uc 	= url.openConnection();
		uc.setDoOutput( true );
		
		OutputStreamWriter	wr = new OutputStreamWriter( uc.getOutputStream() );
		wr.flush();
		wr.close();
		
		BufferedReader	br		= new BufferedReader( new InputStreamReader( uc.getInputStream() ) );
		StringBuffer	sb		= new StringBuffer();
		String			temp	= null;
		
		while( (temp = br.readLine()) != null )
		{
			sb.append( temp );
		}
		br.close();
		
		ret = sb.toString();
		
		return ret;
	}
	
	/* TEST */
	public static void main (String argv[]) throws IOException {
		String url = Application.get( "CANINA_GETINFOCANE_URL" ) + "222222322222222"  + Token.generate( "g.nave" );
		
		System.out.println(UrlUtil.getUrlResponse(url));
	}
}
