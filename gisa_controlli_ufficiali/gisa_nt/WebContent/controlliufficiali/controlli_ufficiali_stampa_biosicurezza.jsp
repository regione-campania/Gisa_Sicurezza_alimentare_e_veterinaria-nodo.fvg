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
if (TicketDetails.getDataInizioControllo().after(java.sql.Timestamp.valueOf("2023-01-01 00:00:00")) && TicketDetails.getDataInizioControllo().before(java.sql.Timestamp.valueOf("2024-01-01 00:00:00"))) 
	versione = 2022;
else if (TicketDetails.getDataInizioControllo().after(java.sql.Timestamp.valueOf("2024-01-01 00:00:00")))
	versione = 2023;

%>

<% int MAX_COL = 2;
int CURR_COL = 0;%>

<div align="right" style="padding-left: 10px; margin-top: 35px">
<table>

<tr>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuini && versione == 2020) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="122" />
	<jsp:param name="nomeChecklist" value="Suini" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td> 

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniStabulatiAlta && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="122" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti stabulati ad alta capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniSemibradiAlta && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1221" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti semibradi ad alta capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniStabulatiBassa && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1222" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti stabulati a bassa capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniSemibradiBassa && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1223" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti semibradi a bassa capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniStabulatiAlta && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="122" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti stabulati ad alta capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniSemibradiAlta && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1221" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti semibradi ad alta capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniStabulatiBassa && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1222" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti stabulati a bassa capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if (specieAllevamento == 122 && hasBioSicurezzaSuiniSemibradiBassa && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1223" />
	<jsp:param name="nomeChecklist" value="Suini - Allevamenti semibradi a bassa capacita" />
	<jsp:param name="disponibile" value="true" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="132" />
	<jsp:param name="nomeChecklist" value="Tacchini" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="131" />
	<jsp:param name="nomeChecklist" value="Galline ovaiole" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2022) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1310" />
	<jsp:param name="nomeChecklist" value="Polli da Carne" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="132" />
	<jsp:param name="nomeChecklist" value="Tacchini" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="131" />
	<jsp:param name="nomeChecklist" value="Galline ovaiole" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="1310" />
	<jsp:param name="nomeChecklist" value="Polli da Carne" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="13100" />
	<jsp:param name="nomeChecklist" value="Svezzamento" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="13101" />
	<jsp:param name="nomeChecklist" value="Incubatoi" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="13102" />
	<jsp:param name="nomeChecklist" value="Allevamenti avicoli fino a 250 capi" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

<% if ((specieAllevamento == 131 || specieAllevamento == 146) && hasBioSicurezzaAvicoli && versione == 2023) {
CURR_COL++;
%>
<td valign="top">
<jsp:include page="../controlliufficiali/allegati/biosicurezza/view.jsp">
	<jsp:param name="idControllo" value="<%=TicketDetails.getId()%>" />
	<jsp:param name="orgId" value="<%=TicketDetails.getOrgId() %>" />
	<jsp:param name="versione" value="<%=versione%>" />
	<jsp:param name="urlDettaglio" value="<%=TicketDetails.getURlDettaglio()%>" />
	<jsp:param name="closed" value="<%=TicketDetails.getClosed()%>" />
	<jsp:param name="specieChecklist" value="13103" />
	<jsp:param name="nomeChecklist" value="Altre specie oltre 250 capi" />
	<jsp:param name="disponibile" value="false" />
</jsp:include>
</td>

<% if (CURR_COL == MAX_COL){
	CURR_COL = 0;%>
</tr><tr>
<%} %>

<%} %>

</tr>
</table>
</div>
