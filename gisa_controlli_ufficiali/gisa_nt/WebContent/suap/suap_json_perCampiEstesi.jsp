<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap, java.util.ArrayList" %>
<%@page import="org.aspcfs.modules.opu.base.LineeMobiliHtmlFields" %>

<%
 
	
System.out.println("sono suap_json_perCampiEstesi.jsp e sono stato chiamato, rispondo con formato json");
System.out.println("id linea ricevuto" + request.getAttribute("idLinea") != null ? request.getAttribute("idLinea") : "NESSUNO");
ArrayList<LineeMobiliHtmlFields> inputs = (ArrayList<LineeMobiliHtmlFields>) request.getAttribute("inputs");
HashMap<String,String> htmlInputs = new HashMap<String,String>();
System.out.println("stampoInput");
ArrayList<String> labelSequOrdinata = new ArrayList<String>();
for(LineeMobiliHtmlFields l : inputs)
{
	System.out.println(l.getHtml());
	htmlInputs.put(l.getLabel_campo(),l.getHtml());
	labelSequOrdinata.add(l.getLabel_campo());
}
Gson gson = new GsonBuilder().create();
htmlInputs.put("ordine",gson.toJson(labelSequOrdinata));

response.setContentType("application/json");


out.print(gson.toJson(htmlInputs));
out.flush();

%>