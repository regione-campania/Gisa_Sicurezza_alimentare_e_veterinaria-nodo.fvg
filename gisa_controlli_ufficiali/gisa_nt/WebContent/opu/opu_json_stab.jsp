<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%org.aspcfs.modules.opu.base.Stabilimento st = (org.aspcfs.modules.opu.base.Stabilimento) request.getAttribute("Stabilimento");

Gson gson = new GsonBuilder().create();
out.print(gson.toJson(st));
out.flush();
%>