<script type="text/javascript" src="dwr/interface/DwrDocumentale.js"> </script>

<script>
function openUploadAllegatoSanzione(idSanzione, tipoUpload){
	var res;
	var result;
	
	if (document.all || 1==1) {
		window.open('GestioneAllegatiTrasgressori.do?command=PrepareUploadAllegatoSanzione&tipo='+tipoUpload+'&tipoAllegato='+tipoUpload+'&ticketId='+idSanzione,null,
		'height=450px,width=480px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=no,resizable=no ,modal=yes');
		
		
		} else {
		
			res = window.showModalDialog('GestioneAllegatiTrasgressori.do?command=PrepareUploadAllegatoSanzione&tipo='+tipoUpload+'&tipoAllegato='+tipoUpload+'&ticketId='+idSanzione,null,
			'dialogWidth:480px;dialogHeight:450px;center: 1; scroll: 0; help: 1; status: 0');
		
		}
		} 
		
		
function recuperaOggettoAllegato(header){
	DwrDocumentale.Documentale_InfoService(header, {callback:recuperaOggettoAllegatoCallBack,async:false});
}
function recuperaOggettoAllegatoCallBack(returnValue)
{
	var dati = returnValue;
	var obj;
	obj = JSON.parse(dati);
	if(obj!=null && obj.oggetto != ""){        			
		document.getElementById(obj.header).innerHTML = obj.oggetto;
	}  else {
	}  
}
	
</script>

<%String permesso = TicketDetails.getPermission_ticket(); 
String permesso_nonconformita=permesso+"-nonconformita-view";%>

<br/>

<table cellpadding="4" cellspacing="0" width="100%" class="details">
<tr><th colspan="2">ALLEGATI SANZIONE</td> </tr>

<tr><td class="formLabel">PROCESSO VERBALE</td> <td> 
<%for (int i = 0; i<TicketDetails.getListaAllegatiPV().size(); i++){ 
String codDocumento = (String) TicketDetails.getListaAllegatiPV().get(i)[0];
String oggetto = (String) TicketDetails.getListaAllegatiPV().get(i)[1];
String nomeClient = (String) TicketDetails.getListaAllegatiPV().get(i)[2];
%>
<a href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=codDocumento%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %></a><br/><br/>
<%} %>

<dhv:permission name="<%=permesso_nonconformita %>">
<% if (TicketDetails.getClosed()==null && TicketDetails.getListaAllegatiPV().size()<1){ %>
<a href = "javascript:openUploadAllegatoSanzione('<%=TicketDetails.getId() %>', 'SanzionePV')" id="allegaPV">Allega PDF Processo Verbale</a>
<br/>ASL: In caso di competenza UOD, si consiglia di caricare l'allegato 7A. In caso contrario, si consiglia di caricare l'allegato 7B.
<br/>FORZE DELL'ORDINE: Si consiglia di caricare la propria modulistica.
<%} %>

<% if (TicketDetails.getListaAllegatiPV().size()>0){ %>
<a href = "javascript:openUploadAllegatoSanzione('<%=TicketDetails.getId() %>', 'SanzionePV')" id="allegaPV" onClick="alert('ATTENZIONE. Si raccomanda di caricare un PDF congruente con la sanzione e gli Avvisi di Pagamento eventualmente già generati.')">Sostituisci PDF Processo Verbale</a> 
<%} %>
</dhv:permission>

</td></tr>

<tr><td class="formLabel">ALTRI ALLEGATI INSERITI DAGLI AGENTI</td> <td> 
<%for (int i = 0; i<TicketDetails.getListaAllegatiAL().size(); i++){ 
	String codDocumento = (String) TicketDetails.getListaAllegatiAL().get(i)[0];
	String oggetto = (String) TicketDetails.getListaAllegatiAL().get(i)[1];
	String nomeClient = (String) TicketDetails.getListaAllegatiAL().get(i)[2]; %>
<a href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=codDocumento%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %></a><br/><br/>
<%} %>
<% if (TicketDetails.getClosed()==null){ %>
<dhv:permission name="<%=permesso_nonconformita %>">
<a href = "javascript:openUploadAllegatoSanzione('<%=TicketDetails.getId() %>', 'SanzioneAL')" id="allegaAL">Allega altri documenti (ad es. notifiche)</a>
</dhv:permission>
<%} %>
</td></tr>

</table>