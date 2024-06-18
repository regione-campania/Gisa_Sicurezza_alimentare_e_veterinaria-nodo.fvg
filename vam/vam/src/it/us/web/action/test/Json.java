package it.us.web.action.test;

import it.us.web.action.GenericAction;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.json.JSONObject;
import it.us.web.util.properties.Application;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import com.google.gson.Gson;

public class Json extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
		URL					url = new URL( Application.get( "CANINA_GETINFOCANE_URL" ) + "985120021339767" );
		URLConnection		uc = url.openConnection();
		uc.setDoOutput( true );
		OutputStreamWriter	wr = new OutputStreamWriter(uc.getOutputStream());
		wr.flush();
		wr.close();
		BufferedReader br = new BufferedReader( new InputStreamReader( uc.getInputStream() ) );
		StringBuffer sb = new StringBuffer();
		String temp = null;
		while( (temp = br.readLine()) != null )
		{
			sb.append( temp );
		}
		br.close(); 
		
		JSONObject json = new JSONObject( sb.toString() );
		JSONObject bean = (JSONObject)( (JSONObject)json.get( "ns:getInfoCaneResponse" ) ).get( "ns:return" );
		bean.remove( "@xmlns" );
		System.out.println( bean );
		System.out.println( bean.toString()
						.replaceAll( "ax24:", "" )
						.replaceAll( "\"\\$\":", "" )
						.replaceAll( ":\\{", ":" )
						.replaceAll( "\\},", "," )
						.replaceAll( "\"@xsi:nil\":\"true\"", "null" ) );
//		JsonObject j = new JsonObject();
		Gson g = new Gson( );
//		System.out.println( sb.toString() );
		Cane cane = g.fromJson( 
					bean.toString()
						.replaceAll( "ax24:", "" )
						.replaceAll( "\"\\$\":", "" )
						.replaceAll( ":\\{", ":" )
						.replaceAll( "\\},", "," )
						.replaceAll( "\"@xsi:nil\":\"true\"", "null" ),
					Cane.class );
		
		System.out.println( cane );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
