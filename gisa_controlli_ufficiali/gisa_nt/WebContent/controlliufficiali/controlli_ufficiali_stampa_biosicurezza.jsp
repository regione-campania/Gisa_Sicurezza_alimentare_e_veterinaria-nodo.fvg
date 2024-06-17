<script language="javascript">

function openChk_bio(orgId,idControllo,url,specie, versione){
	var res;
	var result;
		window.open('PrintModulesHTML.do?command=SchedaBiosicurezza&idControllo='+idControllo+'&orgId='+orgId+'&url='+url+'&specie='+specie+'&versione='+versione,'popupBio'+idControllo+specie,
		'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function inviaChecklist_bio(idIstanza, idControllo) {
	loadModalWindow();
	window.open('GestioneInvioChecklist.do?command=InviaChecklistBiosicurezza&id='+idIstanza+'&idControllo='+idControllo,'popupInvioBio'+idIstanza,
	'height=300px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');

}
function riapriChk_bio(idIstanza, idControllo){
	if (confirm("Attenzione. Procedendo, la checklist selezionata verrà riaperta e sarà possibile modificarla ed inviarla nuovamente. Si raccomanda di verificare che venga effettivamente re-inviata a stretto giro per non lasciare situazioni in sospeso.")){
		loadModalWindow();
		window.open('GestioneInvioChecklist.do?command=RiapriChecklistBiosicurezza&id='+idIstanza+'&idControllo='+idControllo,'popupRiapriBio'+idIstanza,
		'height=300px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
}
</script>


<% 
int specieAllevamento = OrgDetails.getSpecieA();
boolean hasBioSicurezzaSuini = false;
boolean hasBioSicurezzaAvicoli = false;
boolean hasBioSicurezzaSuiniStabulatiAlta = false;
boolean hasBioSicurezzaSuiniStabulatiBassa = false;
boolean hasBioSicurezzaSuiniSemibradiAlta = false;
boolean hasBioSicurezzaSuiniSemibradiBassa = false;


for(Piano p :TicketDetails.getPianoMonitoraggio()) { 
	if (PopolaCombo.hasEventoMotivoCU("isBioSicurezzaSuini", p.getId(), -1))
		hasBioSicurezzaSuini = true;
	if (PopolaCombo.hasEventoMotivoCU("isBioSicurezzaAvicoli", p.getId(), -1))
		hasBioSicurezzaAvicoli = true;
	if (PopolaCombo.hasEventoMotivoCU("isBioSicurezzaSuiniStabulatiAlta", p.getId(), -1))
		hasBioSicurezzaSuiniStabulatiAlta = true;
	if (PopolaCombo.hasEventoMotivoCU("isBioSicurezzaSuiniStabulatiBassa", p.getId(), -1))
		hasBioSicurezzaSuiniStabulatiBassa = true;
	if (PopolaCombo.hasEventoMotivoCU("isBioSicurezzaSuiniSemibradiAlta", p.getId(), -1))
		hasBioSicurezzaSuiniSemibradiAlta = true;
	if (PopolaCombo.hasEventoMotivoCU("isBioSicurezzaSuiniSemibradiBassa", p.getId(), -1))
		hasBioSicurezzaSuiniSemibradiBassa = true;
	}


int versione = 2020;
if (TicketDetails.getDataInizioControllo().after(java.sql.Timestamp.valueOf("2023-01-01 00:00:00"))) //conferma del nuovo range???
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
if (specieAllevamento == 122 && hasBioSicurezzaSuini && versione == 2020) {
	int specieChecklist = 122;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');"> 
	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Suini"/>
	</a>
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if (specieAllevamento == 122 && hasBioSicurezzaSuiniStabulatiAlta && versione == 2022) {
	int specieChecklist = 122;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Suini - Allevamenti stabulati ad alta capacita'"/> -->
<!-- 	</a> --> checklist di Biosicurezza per Suini - Allevamenti stabulati ad alta capacita'<br/> MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if (specieAllevamento == 122 && hasBioSicurezzaSuiniSemibradiAlta && versione == 2022) {
	int specieChecklist = 1221;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Suini - Allevamenti semibradi ad alta capacita'"/> -->
<!-- 	</a> -->  checklist di Biosicurezza per Suini - Allevamenti semibradi ad alta capacita'<br/> MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if (specieAllevamento == 122 && hasBioSicurezzaSuiniStabulatiBassa && versione == 2022) {
	int specieChecklist = 1222;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Suini - Allevamenti stabulati a bassa capacita'"/> -->
<!-- 	</a> -->  checklist di Biosicurezza per Suini - Allevamenti stabulati a bassa capacita'<br/>MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if (specieAllevamento == 122 && hasBioSicurezzaSuiniSemibradiBassa && versione == 2022) {
	int specieChecklist = 1223;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Suini - Allevamenti semibradi a bassa capacita'"/> -->
<!-- 	</a> -->  checklist di Biosicurezza per Suini - Allevamenti semibradi a bassa capacita<br/> MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli) {
	int specieChecklist = 132;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Tacchini"/> -->
<!-- 	</a> -->  checklist di Biosicurezza per Tacchini<br/> MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli) {
	int specieChecklist = 131;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Galline ovaiole"/> -->
<!-- 	</a> -->  checklist di Biosicurezza per Galline ovaiole<br/> MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b><%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>

<%
if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli) {
	int specieChecklist = 1310;
	String[] datiIstanza = PopolaCombo.getInfoChecklistBiosicurezzaIstanza(TicketDetails.getId(), specieChecklist, versione);
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
<%-- 	<a href="javascript:openChk_bio('<%= TicketDetails.getOrgId() %>','<%=TicketDetails.getId()%>','<%=TicketDetails.getURlDettaglio() %>','<%=specieChecklist%>', '<%=versione%>');">  --%>
<!-- 	<input type="button" value="Compila/Visualizza checklist di Biosicurezza per Polli da carne"/> -->
<!-- 	</a> -->  checklist di Biosicurezza per Polli da carne<br/> MOMENTANEAMENTE NON DISPONIBILE
	</th></tr>	
	<% if (TicketDetails.getClosed()!=null && statoGisa.equals("CHIUSA") && (statoRiaperta.equals("SI") || idEsitoClassyfarm == null || !idEsitoClassyfarm.equals("0")))  { %>
	<tr><td colspan="2" align="center"><input type="button" value="INVIA CHECKLIST" onClick="inviaChecklist_bio('<%= idIstanza %>', '<%=TicketDetails.getId()%>')"/></td></tr>
	<% } %>
	<tr><td class="formLabel">STATO GISA</td> <td><%= statoGisa %> <b><%=(statoRiaperta.equals(("SI"))) ? "<mark>RIAPERTA FORZATAMENTE. DA RE-INVIARE.</mark>" : "" %></b> <%if (statoGisa.equalsIgnoreCase("CHIUSA")){ %> <dhv:permission name="chk-classyfarm-riapri-view"><input type="button" value="RIAPRI" onClick="riapriChk_bio('<%=idIstanza%>', '<%=TicketDetails.getId()%>')"/></dhv:permission> <%} %></td></tr>
	<tr <%="0".equals(idEsitoClassyfarm) ? " style= 'background: lime'" : " style= 'background: lightcoral'" %>><td class="formLabel">ESITO ULTIMO INVIO CLASSYFARM</td> <td><%= "0".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA" : "1".equals(idEsitoClassyfarm) ? "CHECKLIST INSERITA CON ERRORI" : "2".equals(idEsitoClassyfarm) ? "CHECKLIST NON INSERITA" : "" %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE MESSAGGIO ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneMessaggioClassyfarm %></td></tr>
	<tr><td class="formLabel">DESCRIZIONE ERRORE ULTIMO INVIO CLASSYFARM</td> <td><%= descrizioneErroreClassyfarm %></td></tr>
	<tr><td class="formLabel">DATA ULTIMO INVIO CLASSYFARM</td> <td><%=dataInvio %></td></tr>
	<tr><td colspan="2"></td></tr>
	</table>
	</div>	
				
<%   } %>