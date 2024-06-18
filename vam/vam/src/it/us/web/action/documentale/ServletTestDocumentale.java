package it.us.web.action.documentale;

import it.us.web.action.GenericAction;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.util.HashMap;

public class ServletTestDocumentale extends GenericAction {

	
	public void can() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	public void execute() throws Exception
	{
		
		String esito="";
		HttpURLConnection conn=null;
		
		String urlDocumentale = Application.get("APP_DOCUMENTALE_URL") +  Application.get("APP_DOCUMENTALE_LISTA_DOCUMENTI");

		
		//STAMPE
		URL obj;
		
		try{
			obj = new URL(urlDocumentale);
			conn = (HttpURLConnection) obj.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("GET");

			StringBuffer requestParams = new StringBuffer();
			requestParams.append("tipoCertificato");
			requestParams.append("=").append("-1");
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(requestParams.toString());
			wr.flush();
			conn.getContentLength();
			esito ="<font color=\"green\">Online</font>";
			}
			catch (IOException e) {
				esito ="<font color=\"red\">OFFLINE</font>";
			} 
		finally {
			conn.disconnect();
			res.getWriter().println(esito);
			}
	} 
}