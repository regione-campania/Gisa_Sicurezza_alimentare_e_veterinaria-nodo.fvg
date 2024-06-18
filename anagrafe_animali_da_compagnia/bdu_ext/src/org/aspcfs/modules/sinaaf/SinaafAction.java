package org.aspcfs.modules.sinaaf;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.ws.WsPost;
import org.aspcfs.utils.ApplicationProperties;

import com.darkhorseventures.framework.actions.ActionContext;

public class SinaafAction extends CFSModule 
{
	
	
	
	public String executeCommandInvia(ActionContext context) throws SQLException 
	{
		

		if (!hasPermission(context, "proprietari_detentori_modulo-view") && !hasPermission(context, "proprietari_detentori-view")) 
			return ("PermissionError");

		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			
			String esitoInvioSinaaf[] = new Sinaaf().inviaInSinaaf(db, getUserId(context),context.getParameter("id"), context.getParameter("entita"));
			
			String urlToRedirect = context.getParameter("urlToRedirect").replaceAll("_____", "&")+"&errore="+esitoInvioSinaaf[1]+"&messaggio="+esitoInvioSinaaf[0];
			context.getRequest().setAttribute("urlToReturn", urlToRedirect);
			return getReturn(context, "SinaafInvio");
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
	} 
	
	public String executeCommandVedi(ActionContext context) throws SQLException 
	{
		

		if (!hasPermission(context, "proprietari_detentori_modulo-view") && !hasPermission(context, "proprietari_detentori-view")) 
			return ("PermissionError");

		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			
			String codice = context.getParameter("codice");
			codice = (codice!=null && !codice.equals("")&& !codice.equals("null"))?(codice):(null);
			String id = context.getParameter("id");
			id = (id!=null && !id.equals("")&& !id.equals("null"))?(id):(null);
			String[] esito = new Sinaaf().vediInSinaaf(db, getUserId(context),id, codice, context.getParameter("entita"));
			context.getRequest().setAttribute("errore", esito[0]);
			context.getRequest().setAttribute("json",   esito[1]);
			return getReturn(context, "SinaafVediRequest");
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}

	
		
	} 
	
	
	public String executeCommandVediRequest(ActionContext context) throws SQLException 
	{
		

		if (!hasPermission(context, "proprietari_detentori_modulo-view")
				&& !hasPermission(context, "proprietari_detentori-view")) {
			return ("PermissionError");
		}
		Connection db = null;
		try {
			
			db = this.getConnection(context);
			
			String id = context.getParameter("id");
			String entita = context.getParameter("entita");
			
			WsPost ws = new WsPost(db,id,entita,ApplicationProperties.getProperty("END_POINT_SINAAF"));
		
			try 
			{
				  String envelope = "";
				  PreparedStatement pst = db.prepareStatement("select * from " + ws.dbiGetEnvelope + "(?)");
				  pst.setString(1, id);
				  ResultSet rs = pst.executeQuery();
				  while (rs.next())
					  envelope = rs.getString(1);
					
				  context.getRequest().setAttribute("json", envelope);
			  
			}
			catch(Exception e)
			{
			  e.printStackTrace();
			}
		
			
			return getReturn(context, "SinaafVediRequest");
			
		} catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}

	
		
	}
	
	
	
	public String executeCommandRedirect2Bdu2Sinac(ActionContext context ) throws SQLException 
	{
		String html = "";
		
		try 
		{
			boolean proxyAttivo = ApplicationProperties.getProperty("PROXY_ATTIVO").equals("true");
			String idEntita = context.getParameter("idEntita");
			String entita = context.getParameter("entita");
			String tipologia = context.getParameter("tipo");
			String net = (proxyAttivo ? (null) : (InetAddress.getByName(ApplicationProperties.getProperty("BDU2SINAC_HOST_W")).getHostAddress()));
			String net2 = "";
			if(!proxyAttivo)
				net2 = "http://"+net+":"+ApplicationProperties.getProperty("BDU2SINAC_PORT");
			String url = null;
			URL urlS = null;
			HttpURLConnection connection = null;
			BufferedReader read = null;
			String line = null;
			
			switch(tipologia)
			{
				case "sincronizza":
					  	url = net2 + "/"+ApplicationProperties.getProperty("BDU2SINAC_SYNC_APP")+"?json={\"token\":\""+idEntita+"@"+entita+"\",\"ambiente\":\""+ApplicationProperties.getProperty("AMBIENTE")+"\",\"forza_allineamento\":\"true\"}"; 
					  	context.getResponse().sendRedirect(url);
					  	break;
				case "body":
				  	url = net2 + "/"+ApplicationProperties.getProperty("BDU2SINAC_BODY_APP")+"?json={\"token\":\""+idEntita+"@"+entita+"\",\"ambiente\":\""+ApplicationProperties.getProperty("AMBIENTE")+"\"}";
				  	context.getResponse().sendRedirect(url);
				  	break;
				case "vediInSinaaf":
	
				  	url = net2 + "/"+ApplicationProperties.getProperty("BDU2SINAC_SEARCH_APP")+"?json={\"token\":\""+idEntita+"@"+entita+"\",\"ambiente\":\""+ApplicationProperties.getProperty("AMBIENTE")+"\",\"forza_allineamento\":\"true\"}";
				  	context.getResponse().sendRedirect(url);
				  	break;
				case "monitoraggio":
				  	url = net2 + "/"+ApplicationProperties.getProperty("BDU2SINAC_MONITORAGGIO_APP")+"?id_tabella="+idEntita+"&ambiente="+ApplicationProperties.getProperty("AMBIENTE");
				  	context.getResponse().sendRedirect(url);
				  	break;
				
			}
		
		} 
		catch(MalformedURLException ex) 
		{
	        ex.printStackTrace();
		} 
		catch(IOException ioex) 
		{
	        ioex.printStackTrace();
		}
		
		context.getRequest().setAttribute("html", html);
		return "bdu2sinac";

	}

	

}

