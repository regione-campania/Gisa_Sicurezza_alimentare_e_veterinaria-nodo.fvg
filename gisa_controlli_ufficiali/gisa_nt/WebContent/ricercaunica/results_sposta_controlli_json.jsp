<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<jsp:useBean id="StabilimentiList" class="org.aspcfs.modules.ricercaunica.base.RicercaList" scope="request"/>
<%
Gson gson = new GsonBuilder().create();
out.print(gson.toJson(StabilimentiList));
out.flush();
%>