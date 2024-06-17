<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="java.util.List"%>
<%List<Stabilimento> st= (ArrayList<Stabilimento>)request.getAttribute("ListaTarghe");
Gson gson = new GsonBuilder().create();
response.setContentType("application/json");

out.print(gson.toJson(st));
out.flush();
%>