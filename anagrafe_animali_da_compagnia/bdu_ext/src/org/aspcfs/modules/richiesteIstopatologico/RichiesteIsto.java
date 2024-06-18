package org.aspcfs.modules.richiesteIstopatologico;

import java.net.URLEncoder;
import java.sql.Connection;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.utils.web.LookupList;
import org.json.JSONObject;

import com.darkhorseventures.framework.actions.ActionContext;

import configurazione.centralizzata.nuova.gestione.ClientServizioCentralizzato;
import crypto.nuova.gestione.ClientSCAAesServlet;

public class RichiesteIsto extends CFSModule 
{

	
	public String executeCommandDefault(ActionContext context) 
	{
		
		if (hasPermission(context, "scheda_decesso-insert")) 
			return executeCommandAdd(context);
		else
			return executeCommandList(context);
	}
	
	
	
	
	
	
	public String executeCommandList(ActionContext context) 
	{
		if (!hasPermission(context, "richieste_isto-view")) 
				return ("PermissionError");

		try
	    {
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			
			
			String endpoint = "/vam";
			
			String[] endpointArray = endpoint.split("/");
			String ultimaParte = endpointArray[endpointArray.length-1];
			endpoint = endpoint.replaceAll("http://", "");
			endpoint = endpoint.replaceAll("//", "/");
			String username = user.getUsername();
			String originalToken = System.currentTimeMillis() + "@"+ username +"@"+endpoint;
			//String goTo = "/vam";
			String goTo = mappaEndPoints.getString("vam");
			
			String encryptedToken = null ;
			String goToCompleteUrl = null;
			 
		    
		    ClientSCAAesServlet cclient = new ClientSCAAesServlet();
		    encryptedToken = cclient.crypt(originalToken);
		    goToCompleteUrl = goTo+"/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
//		    if(ApplicationProperties.getProperty("AMBIENTE").equalsIgnoreCase("collaudo"))
//		    	goToCompleteUrl="http://" + goToCompleteUrl;
		    //goToCompleteUrl="127.0.0.1/vam/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
		    
		    goToCompleteUrl+="&RICHIESTA_ISTOPATOLOGICO-LIST_LLPP=si";
		    
	        context.getRequest().setAttribute("url", goToCompleteUrl);

            
	    }
	    catch(Exception e)
	    {
	    	context.getRequest().setAttribute("Error", e);
			return ("SystemError");
	    }
		
		return getReturn(context, "Add");
	}
	
	
	public String executeCommandListCitologica(ActionContext context) 
	{
		if (!hasPermission(context, "richieste_isto-view")) 
				return ("PermissionError");

		try
	    {
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			
			
			String endpoint = "/vam";
			
			String[] endpointArray = endpoint.split("/");
			String ultimaParte = endpointArray[endpointArray.length-1];
			endpoint = endpoint.replaceAll("http://", "");
			endpoint = endpoint.replaceAll("//", "/");
			String username = user.getUsername();
			String originalToken = System.currentTimeMillis() + "@"+ username +"@"+endpoint;
			//String goTo = "/vam";
			//String goTo = "/vam";
			String goTo = mappaEndPoints.getString("vam");
			
			String encryptedToken = null ;
			String goToCompleteUrl = null;
			 
		    
		    ClientSCAAesServlet cclient = new ClientSCAAesServlet();
		    encryptedToken = cclient.crypt(originalToken);
		    goToCompleteUrl = goTo+"/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
//		    if(ApplicationProperties.getProperty("AMBIENTE").equalsIgnoreCase("collaudo"))
//		    	goToCompleteUrl="http://" + goToCompleteUrl;
    
		    //goToCompleteUrl="127.0.0.1/vam/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
		    
		    goToCompleteUrl+="&DIAGNOSI_CITOLOGICA-LIST_LLPP=si";
		    
	        context.getRequest().setAttribute("url", goToCompleteUrl);

            
	    }
	    catch(Exception e)
	    {
	    	context.getRequest().setAttribute("Error", e);
			return ("SystemError");
	    }
		
		return getReturn(context, "Add");
	}
	
	public String executeCommandListBase123(ActionContext context) 
	{
		if (!hasPermission(context, "richieste_isto-view")) 
				return ("PermissionError");

		try
	    {
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			
			
			String endpoint = "/vam";
			
			String[] endpointArray = endpoint.split("/");
			String ultimaParte = endpointArray[endpointArray.length-1];
			endpoint = endpoint.replaceAll("http://", "");
			endpoint = endpoint.replaceAll("//", "/");
			String username = user.getUsername();
			String originalToken = System.currentTimeMillis() + "@"+ username +"@"+endpoint;
			//String goTo = "/vam";
			String goTo = mappaEndPoints.getString("vam");
			
			String encryptedToken = null ;
			String goToCompleteUrl = null;
			 
		    
		    ClientSCAAesServlet cclient = new ClientSCAAesServlet();
		    encryptedToken = cclient.crypt(originalToken);
		    goToCompleteUrl = goTo+"/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
//		    if(ApplicationProperties.getProperty("AMBIENTE").equalsIgnoreCase("collaudo"))
//		    	goToCompleteUrl="http://" + goToCompleteUrl;
    
		    //goToCompleteUrl="127.0.0.1/vam/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
		    
		    goToCompleteUrl+="&DIAGNOSI_BASE123-LIST_LLPP=si";
		    
	        context.getRequest().setAttribute("url", goToCompleteUrl);

            
	    }
	    catch(Exception e)
	    {
	    	context.getRequest().setAttribute("Error", e);
			return ("SystemError");
	    }
		
		return getReturn(context, "Add");
	}
     
     
	
	
	public String executeCommandAdd(ActionContext context) 
	{
		if (!hasPermission(context, "richieste_isto-add")) 
				return ("PermissionError");

		try
	    {
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			
			
			String endpoint = "/vam";
			
			String[] endpointArray = endpoint.split("/");
			String ultimaParte = endpointArray[endpointArray.length-1];
			endpoint = endpoint.replaceAll("http://", "");
			endpoint = endpoint.replaceAll("//", "/");
			String username = user.getUsername();
			String originalToken = System.currentTimeMillis() + "@"+ username +"@"+endpoint;
			//String goTo = "/vam";
			String goTo = mappaEndPoints.getString("vam");
			
			String encryptedToken = null ;
			String goToCompleteUrl = null;
			 
		    
		    ClientSCAAesServlet cclient = new ClientSCAAesServlet();
		    encryptedToken = cclient.crypt(originalToken);
		    goToCompleteUrl = goTo+"/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
//		    if(ApplicationProperties.getProperty("AMBIENTE").equalsIgnoreCase("collaudo"))
//		    	goToCompleteUrl="http://" + goToCompleteUrl;
		    //goToCompleteUrl="127.0.0.1/vam/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
    
		    goToCompleteUrl+="&RICHIESTA_ISTOPATOLOGICO-ADD_LLPP=si";
		    
	        context.getRequest().setAttribute("url", goToCompleteUrl);

            
	    }
	    catch(Exception e)
	    {
	    	context.getRequest().setAttribute("Error", e);
			return ("SystemError");
	    }
		
		return getReturn(context, "Add");
	}
	
	
	public String executeCommandAddAltraDiagnosi(ActionContext context) 
	{
		if (!hasPermission(context, "richieste_isto-add")) 
				return ("PermissionError");

		try
	    {
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			
			
			String endpoint = "/vam";
			
			String[] endpointArray = endpoint.split("/");
			String ultimaParte = endpointArray[endpointArray.length-1];
			endpoint = endpoint.replaceAll("http://", "");
			endpoint = endpoint.replaceAll("//", "/");
			String username = user.getUsername();
			String originalToken = System.currentTimeMillis() + "@"+ username +"@"+endpoint;
			//String goTo = "/vam";
			String goTo = mappaEndPoints.getString("vam");
			
			String encryptedToken = null ;
			String goToCompleteUrl = null;
			 
		    
		    ClientSCAAesServlet cclient = new ClientSCAAesServlet();
		    encryptedToken = cclient.crypt(originalToken);
		    goToCompleteUrl = goTo+"/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
//		    if(ApplicationProperties.getProperty("AMBIENTE").equalsIgnoreCase("collaudo"))
//		    	goToCompleteUrl="http://" + goToCompleteUrl;
		    //goToCompleteUrl="127.0.0.1/vam/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
    
		    goToCompleteUrl+="&ALTRE_DIAGNOSI-ADD_LLPP=si";
		    
	        context.getRequest().setAttribute("url", goToCompleteUrl);

            
	    }
	    catch(Exception e)
	    {
	    	context.getRequest().setAttribute("Error", e);
			return ("SystemError");
	    }
		
		return getReturn(context, "Add");
	}
	
	public String executeCommandAddCitologica(ActionContext context) 
	{
		if (!hasPermission(context, "richieste_isto-add")) 
				return ("PermissionError");

		try
	    {
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			
			
			String endpoint = "/vam";
			
			String[] endpointArray = endpoint.split("/");
			String ultimaParte = endpointArray[endpointArray.length-1];
			endpoint = endpoint.replaceAll("http://", "");
			endpoint = endpoint.replaceAll("//", "/");
			String username = user.getUsername();
			String originalToken = System.currentTimeMillis() + "@"+ username +"@"+endpoint;
			//String goTo = "/vam";
			String goTo = mappaEndPoints.getString("vam");
			
			String encryptedToken = null ;
			String goToCompleteUrl = null;
			 
		    
		    ClientSCAAesServlet cclient = new ClientSCAAesServlet();
		    encryptedToken = cclient.crypt(originalToken);
		    goToCompleteUrl = goTo+"/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
		    /*if(ApplicationProperties.getProperty("AMBIENTE").equalsIgnoreCase("collaudo"))
		    	goToCompleteUrl="http://" + goToCompleteUrl;*/
		    //goToCompleteUrl="127.0.0.1/vam/Login.do?command=LoginNoPassword&encryptedToken="+URLEncoder.encode(encryptedToken,"UTF-8");
    
		    goToCompleteUrl+="&DIAGNOSI_CITOLOGICA-ADD_LLPP=si";
		    
	        context.getRequest().setAttribute("url", goToCompleteUrl);

            
	    }
	    catch(Exception e)
	    {
	    	context.getRequest().setAttribute("Error", e);
			return ("SystemError");
	    }
		
		return getReturn(context, "Add");
	}
	
	
	
	
	public String executeCommandDetail(ActionContext context) 
	{
		if (!hasPermission(context, "scheda_decesso-view") && !hasPermission(context, "anag_scheda_decesso-view")) 
		{
			return ("PermissionError");
		}
		
		String fromRegistrazione = context.getRequest().getParameter("fromRegistrazione");
		context.getRequest().setAttribute("fromRegistrazione", fromRegistrazione);
		
		Connection db = null;
		try 
		{
			//Thread t = Thread.currentThread();
			db = this.getConnection(context);

			//Recupero parametri in input
			int idAnimale = -1;
			int id = -1;
			String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
			String idString = (String) context.getRequest().getParameter("id");
			if(idAnimaleString==null || idAnimaleString.equals("") || idAnimaleString.equals("-1"))
			{
				if(idString==null || idString.equals("") || idString.equals("-1"))
				{
					throw new Exception("Parametro idAnimale non trovato");
				}
				else
				{
					id = Integer.parseInt(idString);
				}
			}
			else
			{
				idAnimale = Integer.parseInt(idAnimaleString);
			}
			
			LookupList causeDecessoList = new LookupList(db, "lookup_scheda_decesso_causa");
			causeDecessoList.addItem(-1, "<-- Selezionare una voce -->");
			context.getRequest().setAttribute("causeDecessoList", causeDecessoList);
			
			org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = null;
			if(idAnimale>0)
				scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso().getByIdAnimale(db, idAnimale);
			else if(id>0)
				scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso().getById(db, id);
			
			context.getRequest().setAttribute("scheda", scheda);
			
			LookupList specieList = new LookupList();
			specieList.setTable("lookup_specie");
			specieList.buildList(db);
			context.getRequest().setAttribute("specieList", specieList);

			LookupList razzaList = new LookupList();
			razzaList.setTable("lookup_razza");
			razzaList.buildList(db);
			context.getRequest().setAttribute("razzaList", razzaList);
			
			LookupList tagliaList = new LookupList(db, "lookup_taglia");
			context.getRequest().setAttribute("tagliaList", tagliaList);

			LookupList mantelloList = new LookupList();
			mantelloList.setTable("lookup_mantello");
			mantelloList.buildList(db);
			context.getRequest().setAttribute("mantelloList", mantelloList);
			
			context.getRequest().setAttribute("idAnimale", scheda.getAnimale().getIdAnimale());
			context.getRequest().setAttribute("animale", scheda.getAnimale());
			
			return getReturn(context, "Detail");
				
		} 
		catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
	}
	
	public String executeCommandInsert(ActionContext context) 
	{
		if (!hasPermission(context, "scheda_decesso-add") && !hasPermission(context, "anag_scheda_decesso-add")) 
		{
			return ("PermissionError");
		}

		SystemStatus systemStatus = this.getSystemStatus(context);
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		Connection db = null;
		try 
		{
			//Thread t = Thread.currentThread();
			db = this.getConnection(context);
			
			int idAnimale = -1;
			String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
			if(idAnimaleString==null || idAnimaleString.equals("") || idAnimaleString.equals("-1"))
			{
				throw new Exception("Parametro idAnimale non trovato");
			}
			else
			{
				idAnimale = Integer.parseInt(idAnimaleString);
			}
			
			//Inserimento scheda
			org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso();
			scheda.setIdAnimale(idAnimale);
			scheda.setEnteredBy(user.getUserId());
			scheda.setModifiedBy(user.getUserId());
			scheda.setDataDecesso(context.getRequest().getParameter("dataDecesso"));
			scheda.setIdCausa(Integer.parseInt(context.getRequest().getParameter("idCausaDecesso")));
			scheda.insert(db);
			
			
			return executeCommandDetail(context);

		} 
		catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
	}
	
	
	
	
	
}
