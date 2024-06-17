<%@page import="org.aspcfs.modules.suap.base.BeanPerXmlRichiesta"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%org.aspcfs.modules.suap.base.Stabilimento st = (org.aspcfs.modules.suap.base.Stabilimento) request.getAttribute("Stabilimento");




Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
out.print(gson.toJson(st));
out.flush();
%>