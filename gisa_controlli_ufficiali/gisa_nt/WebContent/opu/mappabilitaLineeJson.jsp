<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcfs.modules.opu.actions.BeanMappingLinea" %>
<%@page import="org.aspcfs.modules.opu.actions.BeanMappingGen" %>
<%
Gson gson = new GsonBuilder().create();
response.setContentType("application/json");

String op = (String)request.getAttribute("op");

if(op.equals("get_tipologie"))
{
	HashMap<Integer,String> tipologie = (HashMap<Integer,String>)request.getAttribute("tipologie");	
	out.print(gson.toJson(tipologie));
}
else if(op.equals("get_linee"))
{
	ArrayList<BeanMappingLinea> linee = (ArrayList<BeanMappingLinea>)request.getAttribute("linee");
	String t = gson.toJson(linee);
	System.out.println(t);
	out.print(gson.toJson(linee));
}
else if(op.equals("get_stabilimenti"))
{
	ArrayList<BeanMappingGen> orgs = (ArrayList<BeanMappingGen>) request.getAttribute("orgs");
	System.out.println(gson.toJson(orgs));
	out.print(gson.toJson(orgs));
}
else 
{
	out.print(gson.toJson(""));
}


out.flush();

%>