<%@page import="java.util.Hashtable"%>
<%@page import="com.darkhorseventures.database.ConnectionElement"%>
<%@page import="org.aspcfs.controller.ApplicationPrefs"%>
<%@page import="org.aspcfs.controller.SystemStatus"%>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<%
String link = request.getParameter("link");
String suffisso = (String) request.getServletContext().getAttribute("SUFFISSO_TAB_ACCESSI");
String guida = "";
ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
String ceDriver = prefs.get("GATEKEEPER.DRIVER");
String ceHost = prefs.get("GATEKEEPER.URL");
String ceUser = prefs.get("GATEKEEPER.USER");
String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

ConnectionElement ce = new ConnectionElement(ceHost, ceUser, ceUserPw);

if (suffisso!=null && suffisso.equalsIgnoreCase("_ext"))
{
	guida = "guidaGisaExt.jsp";
	SystemStatus systemStatus = null ;
	systemStatus = (SystemStatus) ((Hashtable) application.getAttribute("SystemStatus")).get(ce.getUrl());
	if(systemStatus.hasPermission(User.getRoleId(), "guida-apicoltura-view"))
	{
		guida="http://www.gisacampania.it/manuali/Manuale Utente BDA-R.pdf";
	}
}
	
else
	guida = "guida.jsp";
guida += "#"+link;
%>

<script>
document.location.href='<%=guida%>'
</script>