<script language="javascript">

function openChk_farmaco(orgId,idControllo, versione, url){
	var res;
	var result;
		window.open('PrintModulesHTML.do?command=SchedaFarmacosorveglianza&idControllo='+idControllo+'&orgId='+orgId+'&url='+url+'&versione='+versione,'popupFco'+idControllo+versione,
		'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function inviaChecklist_farmaco(idIstanza, idControllo) {
	loadModalWindow();
	window.open('GestioneInvioChecklist.do?command=InviaChecklistFarmacosorveglianza&id='+idIstanza+'&idControllo='+idControllo,'popupInvioFco'+idIstanza,
	'height=300px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');

}

function riapriChk_farmaco(idIstanza, idControllo){
	if (confirm("Attenzione. Procedendo, la checklist selezionata verrà riaperta e sarà possibile modificarla ed inviarla nuovamente. Si raccomanda di verificare che venga effettivamente re-inviata a stretto giro per non lasciare situazioni in sospeso.")){
		loadModalWindow();
		window.open('GestioneInvioChecklist.do?command=RiapriChecklistFarmacosorveglianza&id='+idIstanza+'&idControllo='+idControllo,'popupRiapriBio'+idIstanza,
		'height=300px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
}
</script>


<% 
boolean hasFarmacosorveglianza = false;

for(Piano p :TicketDetails.getPianoMonitoraggio()) {
	if (PopolaCombo.hasEventoMotivoCU("isFarmacosorveglianza", p.getId(), -1)){
		hasFarmacosorveglianza = true;
		break;
	}
	}

int versione = 2020;
if (TicketDetails.getDataInizioControllo().after(java.sql.Timestamp.valueOf("2022-01-01 00:00:00")))
	versione = 2022;

int indiceId= 0;
int indiceBozza = 1;
int indiceDataInvio = 2;
int indiceIdEsitoClassyfarm = 3;
int indiceDescrizioneErroreClassyfarm = 4;
int indiceDescrizioneMessaggioClassyfarm = 5;
int indiceRiaperta = 6;

%>

<%
if (hasFarmacosorveglianza && versione == 2020) {
	String[] datiIstanza = PopolaCombo.getInfoChecklistFarmacosorveglianzaIstanza(TicketDetails.getId(), versione);
	String statoGisa = toHtml(datiIstanza[indiceBozza]).equals("t") ? "APERTA" : toHtml(datiIstanza[indiceBozza]).equals("f") ? "CHIUSA" : "";
	String idIstanza = toHtml(datiIstanza[indiceId]);
	String dataInvio =  toDateasStringFromStringWithTime(datiIstanza[indiceDataInvio]);
	String idEsitoClassyfarm = toHtml(datiIstanza[indiceIdEsitoClassyfarm]);
	String descrizioneErroreClassyfarm =  toHtml(datiIstanza[indiceDescrizioneErroreClassyfarm]);
	String descrizioneMessaggioClassyfarm =  toHtml(datiIstanza[indiceDescrizioneMessaggioClassyfarm]);
	String statoRiaperta = toHtml(datiIstanza[indiceRiaperta]).equals("t") ? "SI" : toHtml(datiIstanza[indiceRiaperta]).equals("f") ? "NO" : "";
	%>
	<div align="right" style="padding-left: 210px; margin-top: 35px">
	<table class="details" cellpadding="10" cellspacing="10" width="40%">
	<col width="30%">
	<tr><th colspan="2">
	<a href="javascript:openChk_farmaco('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>', '<%=versione %>', '<%=TicketDetails.getURlDettaglio() %>');"> 
	<input type="button" value="Visualizza checklist di Farmacosorveglianza"/></a>
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
<%-- 	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_farmaco('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr> --%>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if (hasFarmacosorveglianza && versione == 2022) {
	String[] datiIstanza = PopolaCombo.getInfoChecklistFarmacosorveglianzaIstanza(TicketDetails.getId(), versione);
	String statoGisa = toHtml(datiIstanza[indiceBozza]).equals("t") ? "APERTA" : toHtml(datiIstanza[indiceBozza]).equals("f") ? "CHIUSA" : "";
	String idIstanza = toHtml(datiIstanza[indiceId]);
	String dataInvio =  toDateasStringFromStringWithTime(datiIstanza[indiceDataInvio]);
	String idEsitoClassyfarm = toHtml(datiIstanza[indiceIdEsitoClassyfarm]);
	String descrizioneErroreClassyfarm =  toHtml(datiIstanza[indiceDescrizioneErroreClassyfarm]);
	String descrizioneMessaggioClassyfarm =  toHtml(datiIstanza[indiceDescrizioneMessaggioClassyfarm]);
	String statoRiaperta = toHtml(datiIstanza[indiceRiaperta]).equals("t") ? "SI" : toHtml(datiIstanza[indiceRiaperta]).equals("f") ? "NO" : "";
	%>
	<div align="right" style="padding-left: 210px; margin-top: 35px">
	<table class="details" cellpadding="10" cellspacing="10" width="40%">
	<col width="30%">
	<tr><th colspan="2">
	<a href="javascript:openChk_farmaco('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>', '<%=versione %>', '<%=TicketDetails.getURlDettaglio() %>');"> 
	<input type="button" value="Compila/Visualizza checklist di Farmacosorveglianza"/></a>
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_farmaco('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b> <%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_farmaco('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

