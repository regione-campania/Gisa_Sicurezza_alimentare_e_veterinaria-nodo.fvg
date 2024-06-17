<%@page import="org.aspcfs.modules.admin.base.Suap"%>
<%@page import="org.aspcfs.modules.suap.base.BeanPerXmlRichiesta"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%Suap st = (Suap) request.getAttribute("SupLogout");




Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
out.print(gson.toJson(st));
out.flush();
%>