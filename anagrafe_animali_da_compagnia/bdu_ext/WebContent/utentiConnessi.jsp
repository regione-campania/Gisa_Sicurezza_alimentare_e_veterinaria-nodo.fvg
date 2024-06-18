<%@page import="java.util.HashMap"%> 
<%@page import="org.aspcfs.controller.ApplicationPrefs"%>
<%@page import="com.darkhorseventures.database.ConnectionPool"%>
<%@page import="org.aspcfs.controller.SystemStatus"%>
<%@page import="org.aspcfs.controller.SessionManager"%>
<%@page import="java.util.Hashtable"%>
<%@page import="org.aspcfs.modules.admin.base.User"%>

<% 
ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
String ceDriver = prefs.get("GATEKEEPER.DRIVER");
String ceHost = prefs.get("GATEKEEPER.URL");
String ceUser = prefs.get("GATEKEEPER.USER");
String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

ConnectionPool cp = new ConnectionPool("java:comp/env/jdbc/bduM");
SystemStatus thisSystem = null; 
SessionManager sessionManager = null;
HashMap sessions = null;
thisSystem = (SystemStatus) ((Hashtable) application.getAttribute("SystemStatus")).get(cp.getUrl());
if(thisSystem != null){
	sessionManager = thisSystem.getSessionManager();
	
}
if(sessionManager != null){
	sessions = sessionManager.getSessions();
}

%>
<%= sessions.keySet().size() %>