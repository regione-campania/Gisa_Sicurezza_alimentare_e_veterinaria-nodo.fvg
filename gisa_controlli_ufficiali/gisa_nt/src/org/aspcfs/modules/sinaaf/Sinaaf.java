package org.aspcfs.modules.sinaaf;

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
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.aspcfs.modules.util.imports.DbUtil;

import com.darkhorseventures.framework.beans.GenericBean;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import okhttp3.MediaType;

public class Sinaaf extends Thread {

	private static Logger log = Logger .getLogger(Sinaaf.class);
	
	String id;
	String entita;
	Connection db;
	int userId;
	
	public Sinaaf()
	{
		
	}
	
	public Sinaaf(Connection db, int userId, String id, String entita)
	{
		this.id = id;
		this.entita = entita;
		this.db=db;
		this.userId = userId;
		
	}
	
	public String[] aggiornamento(Connection db, int userId, String id, String code, String entita, String method) throws Exception
	{
		String[] toReturn = new String[5];
		int i = 0;
		WsPost ws;
		
		ArrayList<WsPost> lista = new WsPost().getChiamate(db, id, entita, method);
		while(i<lista.size())
		{
			ws = lista.get(i);
			
			JsonParser parser = new JsonParser();
		
			String token = ws.getToken();
			
			if( ws.method.equals("DELETE"))
					ws.url+="/"+ws.idSinaaf;
			
			if(ws.method.equals("GET") )
			{
				if(ws.idSinaaf==null)
					ws.url+="/search/"+ws.nomeCampoCodiceSinaafGET+"/"+code;
				else
					ws.url+="/"+ws.idSinaaf;
			}
	
		    String wsResponse = ws.post(db, userId, MediaType.parse("application/json;charset=UTF-8"), token,ws.idEntita,ws.tabella,ws.method);
	  
		    JsonObject json = (JsonObject) parser.parse(wsResponse);
		    String status = (json.get("status")==null)?(null):(json.get("status").toString());
		    String error = (json.get("error")==null)?(null):(json.get("error").toString());
		    String errors = (json.get("errors")==null)?(null):(json.get("errors").toString());
		    if(!getEsitoChiamata(status, error, errors))
		    	toReturn[1] = (status==null)?(error):(status)+"";
		    else if(getEsitoChiamataNessunaModifica(status, error, errors))
		    {
			    toReturn[0] = ws.idSinaaf;
		    }
		    else
		    {
		    	String idSinaaf = null;
		    	String responseGet = null;
		    	if(getEsitoChiamataRecordPresente(status, error, errors))
		    	{
		    		JsonObject jsonRequest = (JsonObject) parser.parse( ws.getWsRequest());
		    		responseGet = vediInSinaaf(db, userId, ws.idEntita, jsonRequest.get(ws.nomeCampoCodiceSinaaf).toString().replaceAll("\"", ""), ws.getTokenReturn().split("@")[1])[1];
		    		JsonObject jsonGet = (JsonObject) parser.parse( responseGet);
		    		idSinaaf = jsonGet.get(ws.nomeCampoIdSinaaf).toString();
		    	}
		    	else
		    	{
		    		idSinaaf = json.get(ws.nomeCampoIdSinaaf).toString(); 
		    	}
		    	
		    	String codiceSinaaf = null;
		    	if(ws.nomeCampoCodiceSinaaf!=null && (json.get(ws.nomeCampoCodiceSinaaf)!=null || getEsitoChiamataRecordPresente(status, error, errors)))
		    	{
		    		if(getEsitoChiamataRecordPresente(status, error, errors))
			    	{
			    		JsonObject jsonRequest = (JsonObject) parser.parse( ws.getWsRequest());
			    		if(responseGet!=null)
			    			responseGet = vediInSinaaf(db, userId, jsonRequest.get(ws.nomeCampoCodiceSinaaf).toString(), null, entita)[1];
			    		JsonObject jsonGet = (JsonObject) parser.parse( responseGet);
			    		codiceSinaaf = jsonGet.get(ws.nomeCampoCodiceSinaaf).toString();
			    		codiceSinaaf=codiceSinaaf.replaceAll("\"", "");
			    	}
			    	else
			    	{
			    		codiceSinaaf = json.get(ws.nomeCampoCodiceSinaaf).toString();
			    		codiceSinaaf=codiceSinaaf.replaceAll("\"", "");
			    	}
		    		
		    	}
			    toReturn[0] = idSinaaf;
			    if(!ws.method.equals("GET") )
			    	ws.setIdSinaaf(db, idSinaaf, id,codiceSinaaf);
		    }
		    toReturn[2] = wsResponse;
		    
		    if(toReturn[1]!=null)
		    	break;
			i++;
		}
		
		if(lista.isEmpty())
		{
			toReturn[3] = "Entita' gia' inviata e sincronizzata";
		}
		
	    
	    return toReturn;
	}
	
	
	public String[] delete(Connection db, int userId, String id, String entita) throws Exception
	{
		return aggiornamento(db, userId, id, null, entita, "DELETE");
	}
	
	public String[] get(Connection db, int userId, String id, String code, String entita) throws Exception
	{
		return aggiornamento(db, userId, id, code, entita, "GET");
	}
	
	public String[] inviaInSinaaf(Connection db, int userId,String idEntita, String entita) throws Exception
	{
	if(ApplicationProperties.getProperty("cooperazione_SINAC").equals("true"))
		{
		String net = InetAddress.getByName(ApplicationProperties.getProperty("GISA2SINAC_HOST_L")).getHostAddress();

			String[] toReturn = new String[2];
			try {
				  
				  URL url = new URL("http://"+net+":"+ApplicationProperties.getProperty("GISA2SINAC_PORT")+"/"+ApplicationProperties.getProperty("GISA2SINAC_SYNC_APP")+"?json={\"token\":\""+idEntita+"@"+entita+"\",\"ambiente\":\""+ApplicationProperties.getProperty("ambiente")+"\",\"forza_allineamento\":\"false\"}"); 
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
				return toReturn;
		}else{
		
		String[] toReturn = new String[2];
		String [] esito = new Sinaaf().aggiornamento(db, userId, idEntita, null, entita, null);
		
		if(esito[1]!=null )
		{
			toReturn[1] = "Errore durante la propagazione in Sinaaf: " + esito[2];
			toReturn[1]=toReturn[1].replaceAll("'","");
		}
		else if(esito[4]!=null )
		{
			toReturn[1] = esito[4];
			toReturn[1]=toReturn[1].replaceAll("'","");
		}
		else if(esito[3]!=null )
		{
			toReturn[0] = esito[3];
		}
		else
		{
			toReturn[0] = "Propagazione avvenuta in Sinaaf correttamente";
		}
		
		return toReturn;
		}
	}
	
	
	
	public void unificaProprietari(Connection db, int userId,int idDaRimuovere, int idDaConservare, String entita, ArrayList<Integer> idEventoAggiornati) throws Exception
	{
		if(ApplicationProperties.getProperty("GISA2SINAC_UNIFICA_ON").equals("true"))
		{
			
			String net = InetAddress.getByName(ApplicationProperties.getProperty("GISA2SINAC_HOST_L")).getHostAddress();

			try {
				  
				  URL url = new URL("http://"+net+":"+ApplicationProperties.getProperty("GISA2SINAC_PORT")+"/"+ApplicationProperties.getProperty("GISA2SINAC_UNIFICAZIONE")+"?json={\"id_eventi_da_aggiornare\":\""+new Gson().toJson(idEventoAggiornati)+"\",\"id_prop_da_eliminare\":\""+idDaRimuovere+"\",\"id_prop_in_sostituzione\":\""+idDaConservare+"\",\"ambiente\":\""+"sviluppo"+"\"}"); 
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
	}
	
	public String[] deleteInSinaaf(Connection db, int userId,String idEntita, String entita) throws Exception
	{
		String[] toReturn = new String[2];
		String [] esito = new Sinaaf().aggiornamento(db, userId, idEntita, null, entita, "DELETE");
		
		if(esito[1]!=null )
		{
			toReturn[1] = "Errore durante la propagazione in Sinaaf: " + esito[2];
			toReturn[1]=toReturn[1].replaceAll("'","");
		}
		else if(esito[4]!=null )
		{
			toReturn[1] = esito[4];
			toReturn[1]=toReturn[1].replaceAll("'","");
		}
		else if(esito[3]!=null )
		{
			toReturn[0] = esito[3];
		}
		else
		{
			toReturn[0] = "Propagazione avvenuta in Sinaaf correttamente";
		}
		
		return toReturn;
	}
	
	public String[] vediInSinaaf(Connection db, int userId,String idEntita, String codeEntita, String entita) throws Exception
	{
		
		String toReturn[] = new String[2];
		String [] esito = new Sinaaf().get(db, userId, idEntita, codeEntita, entita);
		
		if(esito[1]!=null )
		{
			if(esito[2].contains("E_NOTFOUND"))
				esito[2] = "Entita' non trovata";
			toReturn[0] = "Errore durante la ricerca in Sinaaf: " + esito[2];
			toReturn[0]=toReturn[0].replaceAll("'","");
		}
		else if(esito[3]!=null )
		{
			toReturn[0] = esito[3];
		}
		else
		{
			toReturn[1] = esito[2];
		}
		  System.out.println("RETURN"+toReturn);

		return toReturn;
		}
	
	
	
	private boolean getEsitoChiamata(String status, String error, String errors)
	{
		boolean statusError = status!=null && (status.equals("422") || status.equals("403"));
	    boolean status404 = status!=null && (status.equals("404") || status.equals("500"));
	    boolean nessunaModifica = getEsitoChiamataNessunaModifica(status, error, errors) || getEsitoChiamataRecordPresente(status, error, errors);
	    if(statusError || (status404 && !nessunaModifica))
	    	return false;
	    else
	    	return true;
	}
	
	
	private boolean getEsitoChiamataNessunaModifica(String status, String error, String errors)
	{
		return (error!=null && error.toUpperCase().contains("NESSUNA MODIFICA")) || (errors!=null && errors.toUpperCase().contains("NESSUNA MODIFICA"));
	}
	
	private boolean getEsitoChiamataRecordPresente(String status, String error, String errors)
	{
		return (error!=null && error.toUpperCase().contains("PRESENTE IN ANAGRAFE")) || (errors!=null && errors.toUpperCase().contains("PRESENTE IN ANAGRAFE"));
	}
	
	public String[] inviaInSinaafAsync(Connection db, int userId,String idEntita, String entita) throws Exception
	{
		 String[] toReturn = new String[2];
		 Sinaaf t = new Sinaaf(db,userId, idEntita, entita);
		 t.start();
		 
		return toReturn;
	}

	
	
	
	
	
	public void run() 
	{
		
		if(ApplicationProperties.getProperty("cooperazione_SINAC").equals("true"))
	{

		String[] toReturn = new String[2];
		try {
			String net = ApplicationProperties.getProperty("GISA2SINAC_HOST_L");
			
			  URL url = new URL("http://"+net+":"+ApplicationProperties.getProperty("GISA2SINAC_PORT")+"/"+ApplicationProperties.getProperty("GISA2SINAC_SYNC_APP")+"?json={\"token\":\""+id+"@"+entita+"\",\"ambiente\":\""+ApplicationProperties.getProperty("ambiente")+"\",\"forza_allineamento\":\"false\"}"); 
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
			//return toReturn;
	}else{
	
	String[] toReturn = new String[2];
	String[] esito;
	try {
		esito = new Sinaaf().aggiornamento(db, userId, id, null, entita, null);
		
		
		if(esito[1]!=null )
		{
			toReturn[1] = "Errore durante la propagazione in Sinaaf: " + esito[2];
			toReturn[1]=toReturn[1].replaceAll("'","");
		}
		else if(esito[4]!=null )
		{
			toReturn[1] = esito[4];
			toReturn[1]=toReturn[1].replaceAll("'","");
		}
		else if(esito[3]!=null )
		{
			toReturn[0] = esito[3];
		}
		else
		{
			toReturn[0] = "Propagazione avvenuta in Sinaaf correttamente";
		}
		
		//return toReturn;
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	}
	
	}
	
}
