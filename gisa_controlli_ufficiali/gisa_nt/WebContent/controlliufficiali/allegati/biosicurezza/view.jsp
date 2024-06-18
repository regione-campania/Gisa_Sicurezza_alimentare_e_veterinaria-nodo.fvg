<%@ page import="org.aspcfs.utils.*" %>

<%! 
public static String toHtml(String s) {
    return StringUtils.toHtml(s);
  }
private static String toDateasStringFromStringWithTime(String timestring)
{
	  String toRet = "";
	  if (timestring == null || timestring == "" ||  timestring.length()<10)
		  return toRet;
	  String anno = timestring.substring(0,4);
	  String mese = timestring.substring(5,7);
	  String giorno = timestring.substring(8,10);
	  String ore = timestring.substring(11,13);
	  String minuti = timestring.substring(14,16);

	  toRet =giorno+"/"+mese+"/"+anno+ " " + ore+":"+minuti;
	  return toRet;
	  
}
%>

<%

int indiceId= 0;
int indiceBozza = 1;
int indiceDataInvio = 2;
int indiceIdEsitoClassyfarm = 3;
int indiceDescrizioneErroreClassyfarm = 4;
int indiceDescrizioneMessaggioClassyfarm = 5;
int indiceRiaperta = 6;

int idControllo = Integer.parseInt(request.getParameter("idControllo"));
int orgId =Integer.parseInt(request.getParameter("orgId"));
int versione = Integer.parseInt(request.getParameter("versione"));
String urlDettaglio = request.getParameter("urlDettaglio");
String closed = request.getParameter("closed");
int specieChecklist = Integer.parseInt(request.getParameter("specieChecklist"));
String nomeChecklist = request.getParameter("nomeChecklist");
boolean disponibile = Boolean.parseBoolean(request.getParameter("disponibile"));


String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(idControllo, specieChecklist, versione);
	String statoGisa = toHtml(datiIstanza[indiceBozza]).equals("t") ? "APERTA" : toHtml(datiIstanza[indiceBozza]).equals("f") ? "CHIUSA" : "";
	String idIstanza = toHtml(datiIstanza[indiceId]);
	String dataInvio =  toDateasStringFromStringWithTime(datiIstanza[indiceDataInvio]);
	String idEsitoClassyfarm = toHtml(datiIstanza[indiceIdEsitoClassyfarm]);
	String descrizioneErroreClassyfarm =  toHtml(datiIstanza[indiceDescrizioneErroreClassyfarm]);
	String descrizioneMessaggioClassyfarm =  toHtml(datiIstanza[indiceDescrizioneMessaggioClassyfarm]);
	String statoRiaperta = toHtml(datiIstanza[indiceRiaperta]).equals("t") ? "SI" : toHtml(datiIstanza[indiceRiaperta]).equals("f") ? "NO" : "";
	%>
	
	<table class="details" cellpadding="10" cellspacing="10" width="40%">
	<col width="30%">
	<tr><th colspan="2">
	
	<% if (disponibile) { %>
	<a href="javascript:openChk_bio('<%= orgId %>','<%=idControllo%>','<%=urlDettaglio %>','<%=specieChecklist%>', '<%=versione%>');"> 
	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per <%=nomeChecklist%>"/>
	</a> <% } else { %> <input type="button" disabled style="background:grey" value="Compila/Visualizza checklist di Biosicurezza per <%=nomeChecklist%>"/> <font color="red">COMPILAZIONE CHECKLIST NON DISPONIBILE</font> <%} %>
	</th></tr>	
	<% if (closed!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=idControllo%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=idControllo%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	