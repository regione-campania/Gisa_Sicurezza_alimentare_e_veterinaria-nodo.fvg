package org.aspcfs.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.aspcfs.modules.util.imports.ApplicationProperties;

public class DwrDocumentale {
	
public String ChiamaServizio(String urlService) {
		
		String output = "{}";
		
			URL url = null;
			HttpURLConnection connection;
			int random = (int )(Math.random() * 50 + 1);
			
	        System.out.println("[SERVER DOCUMENTALE] "+random+" INPUT URL: "+urlService);
			
	        try {
				url = new URL(urlService); //Creating the URL.
		        connection = (HttpURLConnection) url.openConnection();
		        connection.setRequestMethod("GET");
		       // connection.setRequestProperty("Content-Type", "application/json");
		        //connection.setRequestProperty("Accept", "application/json");
		        connection.setUseCaches(false);
		        connection.setDoInput(true);
		        connection.setDoOutput(true);
		        connection.connect(); //New line
	
		        //Send request
		        OutputStream os = connection.getOutputStream();
		        OutputStreamWriter osw = new OutputStreamWriter(os, "UTF-8");
		        System.out.println("[SERVER DOCUMENTALE] "+random+" SERVICE URL: "+url.toString());
		        osw.flush();
		        osw.close();
		        if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
		            System.out.println("[SERVER DOCUMENTALE] "+random+" SERVICE Ok response!");
		        } else {
		            System.out.println("[SERVER DOCUMENTALE] "+random+" SERVICE ******* Bad response *******");
		        }
			
		        BufferedReader in = new BufferedReader( new InputStreamReader(connection.getInputStream()));
				StringBuffer result = new StringBuffer();
		
				//Leggo l'output: l'header del documento generato e il nome assegnatogli
				if (in != null) {
					String ricevuto = in.readLine();
					result.append(ricevuto); }
					in.close();
				output = result.toString();
		        System.out.println("[SERVER DOCUMENTALE] "+random+" OUTPUT JSON: "+output);
		        
		        } catch (MalformedURLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
	        	return output;
		}
	
	public String Documentale_InfoService(String header) { 
		String url = ApplicationProperties.getProperty("APP_DOCUMENTALE_URL")+ApplicationProperties.getProperty("APP_DOCUMENTALE_INFO_SERVICE")+"?output=json&codDocumento="+header;
		return ChiamaServizio(url);
}
	
}
