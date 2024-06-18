
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonParser"%>
<%
		String prova = "{idAslRiferimento=206, note=v, commandOld=RegistrazioniAnimaledoAdd}"; //, nascita=04/01/2014, idProprietarioCorrente=4192562, idAnimale=6170087, idTipologiaEventoVam=, microchip= 380260002263877, dataAperturaCC=null, command=Insert, specieAnimaleId=1, TimeIni=1458200593291, ruolo=18, doContinue=false, idDetentoreCorrente=4192562, idTipologiaEvento=11, auto-populate=true, datatocheck=, origineInserimento=null, idStatoOriginale=2, registrazione=08/03/2014}";
	
	
		JsonParser parser = new JsonParser();
		JsonObject json1 = (JsonObject) parser.parse(prova);
		int idAnimale 		  = json1.get("idAnimale").getAsInt();
		int idTipologiaEvento = json1.get("idTipologiaEvento").getAsInt();
%>
		Registrazione inserita -  idAnimale: <%=idAnimale%>, idTipologiaEvento: <%=idTipologiaEvento%>
		
	