<%@page import="it.us.web.util.properties.Application"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="configurazione.centralizzata.nuova.gestione.ClientServizioCentralizzato"%>
<%
int responseCodeLogin=-1;
String ambiente = "";

try {
	ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
    //ambiente="sviluppo";
	ambiente=(String) sclient.getAmbiente().getString("ambiente");
} catch (Exception e) {}

System.out.println("### APPLICATIVO VAM: VERIFICO AMBIENTE. AMBIENTE: "+ambiente +" ###");

String URLName=request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort() + "/login/index.jsp"  ;
try {
       HttpURLConnection.setFollowRedirects(false);
       HttpURLConnection con = (HttpURLConnection) new URL(URLName).openConnection();
       con.setRequestMethod("HEAD");
       responseCodeLogin=con.getResponseCode();
     }
     catch (Exception e) {
        e.printStackTrace();
     }
System.out.println("### APPLICATIVO VAM: CERCO SE ESISTE APPLICATIVO LOGIN. RESPONSE CODE: "+responseCodeLogin +" ###");
   %>


<% boolean redirected = false;

  // During Servlet initialization, the setup parameter is set if the application
  // is completely configured
	
      System.out.println("### APPLICATIVO VAM: ESISTE FILE CONFIGURAZIONE. ###");
	  
	  if (responseCodeLogin == 200) {
	    System.out.println("### APPLICATIVO VAM: ESISTE APPLICATIVO LOGIN. REDIRECTO A /LOGIN ###");
	  	response.sendRedirect("/login");
	  	redirected=true;
	  }
  
	 if (!redirected) { 
	  
  // If the site is setup, then check to see if this is an upgraded version of the app
    //During login, check the application locale if needed
			  if (!"ufficiale".equalsIgnoreCase(ambiente)) {
	    			System.out.println("### APPLICATIVO VAM: NON ESISTE APPLICATIVO LOGIN. REDIRECTO A login.Logout (2) ###");
	    			session.setAttribute("system","vam");
	    			String contextPath = "";
	    			if(Application.get("GESTIONE_CONTEXT_PATH_SENDREDIRECT").equals("true"))
	    				contextPath = request.getContextPath() + "/";
	    			response.sendRedirect(contextPath + "ex_login_031.jsp");
    		  } else {
    			  	System.out.println("### APPLICATIVO VAM: NON ESISTE APPLICATIVO LOGIN IN AMBIENTE UFFICIALE. NON FACCIO NULLA (2) ###");
    		  }

  } 
%>