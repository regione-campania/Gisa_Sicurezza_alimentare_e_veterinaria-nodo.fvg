<%@page import="it.us.web.util.properties.Application"%>

<%
String HEADER_URI = request.getRequestURI();
String HEADER_URL = request.getRequestURL().toString();
String HEADER_DOMINIO = HEADER_URL.replaceAll(HEADER_URI, "").replaceAll("https://", "").replaceAll("http://", "");
if (HEADER_DOMINIO.indexOf(":")>0)
	HEADER_DOMINIO = HEADER_DOMINIO.substring(0, HEADER_DOMINIO.indexOf(":"));

HEADER_DOMINIO = HEADER_DOMINIO.replaceAll("srv2","sca");
%>


<div align="center">
	<a href="#" onclick="window.open('<%=request.getScheme() %>://<%= HEADER_DOMINIO %>/guc/login.LoginNoPassword.us?cf_spid=${utente.codiceFiscale}&messaggio_home=true&endpoint=vam&iframe=true','','scrollbars=1,width=800,height=600'); return false;">MESSAGGIO</a>
<%-- 	<a href="#" onclick="window.open('<%=request.getScheme() %>://<%= HEADER_DOMINIO %>:8081/guc/login.LoginNoPassword.us?cf_spid=${utente.codiceFiscale}&messaggio_home=true&endpoint=vam&iframe=true','','scrollbars=1,width=800,height=600'); return false;">MESSAGGIO</a> --%>
</div>