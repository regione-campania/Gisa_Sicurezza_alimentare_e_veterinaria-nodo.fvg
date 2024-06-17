<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap" %>
<%@page import ="org.aspcfs.utils.DestinatarioPecMailChecker" %>
<%

HashMap<String,String> esitoObj = new HashMap<String,String>();
Integer esito =  Integer.parseInt((String)request.getAttribute("esito_validazione_pec"));

esitoObj.put("esito",esito+"");

String msgPerClient = null;
if(esito == DestinatarioPecMailChecker.FORMATO_INVALIDO)
{
	msgPerClient = "FORMATO INVALIDO";
}
else if(esito == DestinatarioPecMailChecker.PROVIDER_INVALIDO)
{
	msgPerClient = "PROVIDER PEC NON VALIDO";
}
else if(esito == DestinatarioPecMailChecker.ESITO_OK)
{
	msgPerClient = "PEC MAIL VALIDA";
}

esitoObj.put("messaggio",msgPerClient);


Gson gson = new GsonBuilder().create();
out.print(gson.toJson(esitoObj));
out.flush();
%>