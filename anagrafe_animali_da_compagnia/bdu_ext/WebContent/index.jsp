<%@page import="org.aspcfs.utils.ApplicationProperties"%>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>

<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>

<%
int responseCodeLogin=-1;
String ambiente = "";

try {
ambiente = ApplicationProperties.getAmbiente();
} catch (Exception e) {}

System.out.println("### APPLICATIVO GISA: VERIFICO AMBIENTE. AMBIENTE: "+ambiente +" ###");

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
System.out.println("### APPLICATIVO GISA: CERCO SE ESISTE APPLICATIVO LOGIN. URLNameE: "+URLName +" ###");
System.out.println("### APPLICATIVO GISA: CERCO SE ESISTE APPLICATIVO LOGIN. RESPONSE CODE: "+responseCodeLogin +" ###");
   %>


<% boolean redirected = false;

  // During Servlet initialization, the setup parameter is set if the application
  // is completely configured
  if ((Object) getServletConfig().getServletContext().getAttribute("cfs.setup") == null) {
    System.out.println("### APPLICATIVO GISA: NON ESISTE FILE CONFIGURAZIONE. REDIRECTO ALLA CONFIGURAZIONE ###");
    RequestDispatcher setup = getServletConfig().getServletContext().getRequestDispatcher("/Setup.do?command=Default");
    setup.forward(request, response);
  } else {
	
      System.out.println("### APPLICATIVO GISA: ESISTE FILE CONFIGURAZIONE. ###");
	  
	  if (responseCodeLogin == 200 || responseCodeLogin == 302) {
	    System.out.println("### APPLICATIVO GISA: ESISTE FILE CONFIGURAZIONE ED ESISTE APPLICATIVO LOGIN. REDIRECTO A /LOGIN ###");
	  	//response.sendRedirect("/login");
	  	response.sendRedirect("utils23/indexEnterDisabled.jsp");
	  	redirected=true;
	  }
  
	 if (!redirected) { 
	  
  // If the site is setup, then check to see if this is an upgraded version of the app
  if (applicationPrefs.isUpgradeable()) {
    RequestDispatcher upgrade = getServletConfig().getServletContext().getRequestDispatcher("/Upgrade.do?command=Default");
    upgrade.forward(request, response);
  } else {
			  if (!"ufficiale".equalsIgnoreCase(ambiente)) {
	    			System.out.println("### APPLICATIVO GISA: ESISTE FILE CONFIGURAZIONE E NON ESISTE APPLICATIVO LOGIN. REDIRECTO A EX_LOGIN.JSP (2) ###");
				    response.sendRedirect("ex_login_031.jsp");
    		  } else {
    			  	System.out.println("### APPLICATIVO GISA: ESISTE FILE CONFIGURAZIONE E NON ESISTE APPLICATIVO LOGIN IN AMBIENTE UFFICIALE. NON FACCIO NULLA (2) ###");
    		  }

  } } }
%>