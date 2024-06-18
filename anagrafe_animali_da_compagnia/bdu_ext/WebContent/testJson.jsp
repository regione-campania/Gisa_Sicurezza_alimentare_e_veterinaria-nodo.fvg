<%@page import="org.json.JSONObject"%>
<%

	String stringToParse = "{idAslRiferimento=204, note=, commandOld=RegistrazioniAnimale.do;Add}";
	Json parser = new JsonParser();
	JSONObject json1 = (JsonObject) parser.parse(stringToParse);
	out.print("test : "+json1.get("idAslRiferimento"));
	
%>