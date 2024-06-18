<%@ page import="org.aspcfs.utils.ApplicationProperties" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />

<%
String HEADER_URI = request.getRequestURI();
String HEADER_URL = request.getRequestURL().toString();
String HEADER_DOMINIO = HEADER_URL.replaceAll(HEADER_URI, "").replaceAll("https://", "").replaceAll("http://", "");
if (HEADER_DOMINIO.indexOf(":")>0)
	HEADER_DOMINIO = HEADER_DOMINIO.substring(0, HEADER_DOMINIO.indexOf(":"));

HEADER_DOMINIO = HEADER_DOMINIO.replaceAll("srv2","sca");
%>

<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home"><dhv:label name="My Home Page" mainMenuItem="true">La Mia Home Page</dhv:label></a> >
Messaggio Home Page
</td>
</tr>
</table>

<div align="center">
	<a href="#" onclick="window.open('<%=request.getScheme() %>://<%= HEADER_DOMINIO %>/guc/login.LoginNoPassword.us?cf_spid=<%= User.getContact().getCodiceFiscale().toUpperCase() %>&messaggio_home=true&endpoint=bdu&iframe=true','','scrollbars=1,width=800,height=600'); return false;">MESSAGGIO</a>
<%-- 	<a href="#" onclick="window.open('<%=request.getScheme() %>://<%= HEADER_DOMINIO %>:8081/guc/login.LoginNoPassword.us?cf_spid=<%= User.getContact().getCodiceFiscale().toUpperCase() %>&messaggio_home=true&endpoint=bdu&iframe=true','','scrollbars=1,width=800,height=600'); return false;">MESSAGGIO</a> --%>
</div>