<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap" %>
<%
 
HashMap<String,String> risp = new HashMap<String,String>();

Gson gson = new GsonBuilder().create();
String risultato = (String)request.getAttribute("risultato");
risp.put("risultato",risultato);
if(request.getAttribute("msg_ko") != null)
{
	risp.put("msg_ko",(String)request.getAttribute("msg_ko"));
}

response.setContentType("application/json");

out.print(gson.toJson(risp));
out.flush();

%>