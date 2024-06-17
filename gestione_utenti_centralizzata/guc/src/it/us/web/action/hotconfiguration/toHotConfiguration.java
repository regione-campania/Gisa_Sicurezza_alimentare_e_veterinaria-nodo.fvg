package it.us.web.action.hotconfiguration;

import it.us.web.action.GenericAction;
import it.us.web.db.ApplicationProperties;
import it.us.web.exceptions.AuthorizationException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

import org.json.JSONArray;
import org.json.JSONObject;


public class toHotConfiguration extends GenericAction{

	@Override
	public void can() throws AuthorizationException
	{
		isLogged();
	}

	@Override
	public void execute() throws Exception {
		can(); 
		
		JSONArray jsonProperties = new JSONArray();

		InputStream is = ApplicationProperties.class.getResourceAsStream(ApplicationProperties.getFileProperties());

		BufferedReader reader;
		try {
			reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
			String line = "";

			while (line != null) {
				line = reader.readLine();
				
				if (line!= null){
					line = line.trim();
				
					String tipo = "";
					String chiave = "";
					String valore = "";
	
					if (line.length() > 0) {
						if (line.startsWith("##")) { // capitolo
							tipo = "capitolo";
							chiave = line.replaceAll("#", "").trim();
						} else if (!line.startsWith("#") && line.contains("=")) { // parametro
							tipo = "parametro";
							chiave = line.substring(0, line.indexOf("=")).trim();
							valore = ApplicationProperties.getProperty(chiave).trim();
						}
						
						if (!"".equals(tipo)){
							JSONObject json = new JSONObject();
							json.put("tipo", tipo);
							json.put("chiave", chiave);
							json.put("valore", valore);
							jsonProperties.put(json);
						}
					}
				}
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		req.setAttribute("jsonProperties", jsonProperties);
		
		gotoPage( "/jsp/hotconfiguration/config_new.jsp" );
	}

}
