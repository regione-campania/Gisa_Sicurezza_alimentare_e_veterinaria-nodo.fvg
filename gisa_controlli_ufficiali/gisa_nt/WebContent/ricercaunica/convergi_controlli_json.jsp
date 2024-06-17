<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<jsp:useBean id="AnagraficaDestinazione" class="org.aspcfs.modules.ricercaunica.base.RicercaOpu" scope="request"/>
<%
System.out.println("jsonpage");
Gson gson = new GsonBuilder().create();
	out.print(gson.toJson(AnagraficaDestinazione));

out.flush();
%>