package org.aspcfs.modules.bdu;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.apache.log4j.Logger;
import it.izs.ws.WsPost;
import org.aspcfs.modules.sinaaf.Sinaaf;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.aspcfs.modules.util.imports.DbUtil;

import com.darkhorseventures.framework.beans.GenericBean;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Gisa2Bdu extends GenericBean {

	public Gisa2Bdu(){}
	
	
	public String[] inviaInBdu(Connection db, int userId,String idEntita, String entita) throws Exception
	{
		String[] toReturn = new String[2];

	if(ApplicationProperties.getProperty("cooperazione_SINAC").equals("true"))
		{
		String net = InetAddress.getByName(ApplicationProperties.getProperty("GISA2SINAC_HOST_L")).getHostAddress();

			try {
				  
				  URL url = new URL("http://"+net+":"+ApplicationProperties.getProperty("GISA2BDU_PORT")+"/"+ApplicationProperties.getProperty("GISA2BDU_APP")+"?ambiente="+ApplicationProperties.getProperty("ambiente")+"&caller=gisa&endpoint=bdu&id_stab_gisa="+idEntita+"&entita="+entita); 
				  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				  System.out.println(url);
				  BufferedReader read = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				  String line = read.readLine();
				  String html = "";
				  while(line!=null) {
				    html += line;
				    line = read.readLine();
				  }
				} catch(MalformedURLException ex) {
				        ex.printStackTrace();
				} catch(IOException ioex) {
				        ioex.printStackTrace();
				}
				
		}				

	return toReturn;
		
		}
	
	
	
	
	
	
	
	
	
}
