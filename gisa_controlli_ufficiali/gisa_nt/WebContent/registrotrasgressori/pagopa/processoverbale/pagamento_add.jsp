<%@ page import="java.sql.*" %>
<jsp:useBean id="SanzioneDettaglio" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="Trasgressore" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="Obbligato" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="idControllo" class="java.lang.String" scope="request"/>
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>
<jsp:useBean id="listaPagamentiScaduti" class="java.util.ArrayList" scope="request"/>

<jsp:useBean id="semaforoAttivo" class="java.lang.String" scope="request"/>

<%@ page import="org.aspcfs.modules.registrotrasgressori.base.Pagamento" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>

<%@ include file="../../../utils23/initPage.jsp" %>

<%if (idControllo!=null && !idControllo.equals("")) {%>
<script>
window.opener.location.href="Vigilanza.do?command=TicketDetails&id=<%=idControllo%>";
window.close();
</script>
<% } %>

<script>

function validateEmail(email) 
{
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}

function giorni_differenza(data1,data2){ 
	anno1 = parseInt(data1.substr(0, 4), 10);
	mese1 = parseInt(data1.substr(5, 2),10);
	giorno1 = parseInt(data1.substr(8, 2),10);
	anno2 = parseInt(data2.substr(0, 4),10);
	mese2 = parseInt(data2.substr(5, 2),10);
	giorno2 = parseInt(data2.substr(8, 2),10);
	var dataok1=new Date(anno1, mese1-1, giorno1);
	var dataok2=new Date(anno2, mese2-1, giorno2);

	differenza = dataok1-dataok2;    
	giorni_diff = new String(Math.ceil(differenza/86400000));
	//alert('diff');
	//alert(giorni_diff);
	return giorni_diff;
}

function gestisciNotifica(tipo, cb){
	
	if (cb.checked){
		
		if (cb.value!="I")
			document.getElementById("tipoNotifica"+tipo+"_I").checked=false;
		if (cb.value!="P")
			document.getElementById("tipoNotifica"+tipo+"_P").checked=false;
		if (cb.value!="R")
			document.getElementById("tipoNotifica"+tipo+"_R").checked=false;
		
		if (cb.value=="I"){
			document.getElementById("dataNotifica"+tipo).value='<%=toDateasStringWithFormat(SanzioneDettaglio.getDataFineControllo()!=null ? SanzioneDettaglio.getDataFineControllo() : SanzioneDettaglio.getAssignedDate(), "yyyy-MM-dd")%>';
			document.getElementById("dataNotifica"+tipo).readOnly=true;
			document.getElementById("labelDataNotifica"+tipo).innerHTML="Data di contestazione immediata";
			document.getElementById("divDataNotifica"+tipo).style.display="block";
		}
		else if (cb.value=="R"){
			document.getElementById("dataNotifica"+tipo).value='<%=toDateasStringWithFormat(toAddDays(SanzioneDettaglio.getDataFineControllo()!=null ? SanzioneDettaglio.getDataFineControllo() : SanzioneDettaglio.getAssignedDate(), 160), "yyyy-MM-dd")%>';
			document.getElementById("dataNotifica"+tipo).readOnly=true;
			document.getElementById("labelDataNotifica"+tipo).innerHTML="Data <font color=\"red\">presunta</font> di notifica";
			document.getElementById("divDataNotifica"+tipo).style.display="block";
			showDialogAlert("Si invita a ricorrere alla Raccomandata/Consegna a mano solo se non è disponibile almeno un indirizzo PEC. Pertanto è necessario verificare l'esistenza e la correttezza dell'indirizzo PEC nell'Indice Nazionale degli Indirizzi di PEC istituito dal Ministero dello Sviluppo Economico accessibile sul sito: \n\n <a target=\"_blank\" style=\"font-size:15px\" href=\"https://www.inipec.gov.it/cerca-pec\">https://www.inipec.gov.it/cerca-pec</a> (Liberi professionisti)\n\n <a target=\"_blank\" style=\"font-size:15px\" href=\"https:///www.registroimprese.it\">https://www.registroimprese.itc</a> (Imprese)\n\nSolo se non è stata trovata una PEC è possibile ricorrere alla Raccomandata A/R o alla consegna a mano."); 
		}
		else if (cb.value=="P"){
			document.getElementById("dataNotifica"+tipo).value='';
			document.getElementById("dataNotifica"+tipo).readOnly=false;
			document.getElementById("labelDataNotifica"+tipo).innerHTML="Data <font color=\"red\">presunta</font> di invio PEC";
			document.getElementById("divDataNotifica"+tipo).style.display="block";
			showDialogAlert("L'esistenza e la correttezza dell'indirizzo PEC possono essere verificate nell'Indice Nazionale degli Indirizzi di PEC istituito dal Ministero dello Sviluppo Economico accessibile sul sito: \n\n <a target=\"_blank\" style=\"font-size:15px\" href=\"https://www.inipec.gov.it/cerca-pec\">https://www.inipec.gov.it/cerca-pec</a> (Liberi professionisti)\n\n <a target=\"_blank\" style=\"font-size:15px\" href=\"https:///www.registroimprese.it\">https://www.registroimprese.itc</a> (Imprese)\n\n Indicare come data notifica la data di invio della PEC. Si ricorda che la PEC va inviata obbligatoriamente entro la data indicata, altrimenti non verranno calcolati correttamente i termini di pagamento.");
		}
		else {
			document.getElementById("dataNotifica"+tipo).value='';
			document.getElementById("dataNotifica"+tipo).readOnly=false;
		}
	}
	
	else {
		document.getElementById("dataNotifica"+tipo).value='';
		document.getElementById("dataNotifica"+tipo).readOnly=false;
	}
}

function checkForm(form){
	
	var message = "";
	var flag = true;
	
	if ( form.tipoPagatoreT != null && form.tipoPagatoreT.value==''){
			 message += "\n - TRASGRESSORE: Tipo pagatore mancante.\r\n";
			 flag = false;
	}
	if ( form.nomeT != null && form.nomeT.value==''){
			 message += "\n - TRASGRESSORE: Ragione sociale mancante.\r\n";
			 flag = false;
	} 
	if ( form.pivaT != null && form.pivaT.value==''){
			 message += "\n - TRASGRESSORE: Partita IVA/Codice fiscale mancante.\r\n";
			 flag = false;
	} 
	
	if ( form.tipoPagatoreO != null && form.tipoPagatoreO.value==''){
			 message += "\n - OBBLIGATO IN SOLIDO: Tipo pagatore mancante.\r\n";
			 flag = false;
	}
	if ( form.nomeO != null && form.nomeO.value==''){
			 message += "\n - OBBLIGATO IN SOLIDO: Ragione sociale mancante.\r\n";
			 flag = false;
	} 
	if ( form.pivaO != null && form.pivaO.value==''){
			 message += "\n - OBBLIGATO IN SOLIDO: Partita IVA/Codice fiscale mancante.\r\n";
			 flag = false;
	} 
	
	if (form.mailT!=null && form.mailT.value!= '' && !validateEmail(form.mailT.value)) {
		 message += "\n - TRASGRESSORE: Inserire una mail valida.\r\n"; 
			flag = false;
		}
 	
 	if (form.mailO!=null && form.mailO.value!= '' && !validateEmail(form.mailO.value)) {
		 message += "\n - OBBLIGATO IN SOLIDO: Inserire una mail valida.\r\n"; 
			flag = false;
		}
	
		if (form.dataNotificaT != null && form.tipoNotificaT_P.checked && form.dataNotificaO != null && form.tipoNotificaO_P.checked){
			if (form.dataNotificaT.value=='' && form.dataNotificaO.value != '')
				form.dataNotificaT.value = form.dataNotificaO.value;
			if (form.dataNotificaO.value=='' && form.dataNotificaT.value!='')
				form.dataNotificaO.value = form.dataNotificaT.value;
		} 

		if ( form.dataNotificaT != null && (!form.tipoNotificaT_I.checked && !form.tipoNotificaT_P.checked && !form.tipoNotificaT_R.checked)){
     		 message += "\n - Inserire una modalità di contestazione/notifica per il Trasgressore.\r\n";
     		 flag = false;
  		} 
	
		if ( form.dataNotificaO != null && (!form.tipoNotificaO_I.checked && !form.tipoNotificaO_P.checked && !form.tipoNotificaO_R.checked)){
    		 message += "\n - Inserire una modalità di contestazione/notifica per l'Obbligato in solido.\r\n";
    		 flag = false;
 		} 
	
	  	
   if ((form.tipoNotificaT_I.checked || form.tipoNotificaT_P.checked ||form.tipoNotificaT_R.checked) && form.dataNotificaT.value == ''){
         	 message += "\n - Inserire una data di notifica/contestazione per il Trasgressore.\n(Si ricorda che in presenza di due pagatori con notifica PEC è consentito anche indicare una sola data.)\r\n";
             flag = false;
      		} 
	
   if (form.dataNotificaO!=null && ((form.tipoNotificaO_I.checked || form.tipoNotificaO_P.checked ||form.tipoNotificaO_R.checked) && form.dataNotificaO.value == '')){
        	 message += "\n - Inserire una data di notifica/contestazione per l'Obbligato in solido.\n(Si ricorda che in presenza di due pagatori con notifica PEC è consentito anche indicare una sola data.)\r\n";
        	 flag = false;
     		} 
      	
   if (form.dataNotificaT!=null && form.dataNotificaT.value != '' && giorni_differenza(form.dataNotificaT.value, form.dataCu.value)<0) {
	   message += "\n - Inserire una data di notifica/contestazione Trasgressore uguale o successiva alla data del controllo ufficiale.\r\n";
       flag = false;
   }
  if (form.dataNotificaO!=null && form.dataNotificaO.value != '' && giorni_differenza(form.dataNotificaO.value, form.dataCu.value)<0) {
	  message += "\n - Inserire una data di notifica/contestazione Obbligato uguale o successiva alla data del controllo ufficiale.\r\n";
      flag = false;
   } 	
     	
	    if (!flag){
	    	showDialogAlert("Non si può procedere all'invio. Motivazione: \n" + message);
	  	  	return null;
	    }
	
	
	var confirmString= "";
	confirmString = "Verranno generati i seguenti avvisi di pagamento:\n\n";
	
	if (form.importoTotaleVersamento_1!=null)
		confirmString+= "- Avviso di pagamento ridotto (Trasgressore)\n\n";
	if (form.importoTotaleVersamento_2!=null)
		confirmString+= "- Avviso di pagamento ultraridotto (Trasgressore)\n\n";
	
	if (form.importoTotaleVersamento_1!=null && form.pivaO!=null)
		confirmString+= "- Avviso di pagamento ridotto (Obbligato in solido)\n\n";
	if (form.importoTotaleVersamento_2!=null && form.pivaO!=null)
		confirmString+= "- Avviso di pagamento ultraridotto (Obbligato in solido)\n\n";
	
	confirmString+="\n\n	Salvare e inviare?";
	
	showDialogConfirm(confirmString, form);
}


</script>

<%@ include file="../dialog.jsp" %>

<% if (semaforoAttivo!=null && semaforoAttivo.equals("true")){ %>
<script>
showDialogAlertClose("ATTENZIONE. Su questa sanzione sono in corso delle operazioni di generazione IUV.\n\n Riprovare tra qualche minuto.");
</script>
<% } %>

<% if (messaggio!=null && !messaggio.equals("")){ %>
<script>
showDialogAlert("<%=messaggio%>");
</script>
<% } %>

<form name="formPagoPa" id="formPagoPa" action="GestionePagoPa.do?command=InsertProcessoVerbale" method="post">

<table class="details" id = "tabletrasgressione" cellpadding="10" cellspacing="10" style="border-collapse: collapse">

<tr><th colspan="4">DETTAGLIO SANZIONE</th></tr>

<tr>
<th>Id controllo ufficiale</th>  
<td colspan="2"><%=SanzioneDettaglio.getIdControlloUfficiale() %></td></tr>
<tr>
<th>Id sanzione</th>  
<td colspan="2"><%=SanzioneDettaglio.getId() %></td></tr>
  
<tr><th colspan="3" style="background:yellow">INFORMAZIONI SOGGETTO PAGATORE </th></tr>

<tr>
<td></td>
<th>TRASGRESSORE</th>
<th>OBBLIGATO IN SOLIDO</th>
</tr>

<tr>
<th>Tipo pagatore</th> 
<td><%= toHtml(Trasgressore.getTipoPagatore()).equals("F") ? "Persona Fisica" : toHtml(Trasgressore.getTipoPagatore()).equals("G") ? "Società di persone/Associazioni" : "" %> <select style="display:none" id="tipoPagatoreT" name="tipoPagatoreT"><option value="G" <%=toHtml(Trasgressore.getTipoPagatore()).equals("G") ? "selected" : ""%>>Società di persone/Associazioni</option><option value="F" <%=toHtml(Trasgressore.getTipoPagatore()).equals("F") ? "selected" : ""%>>Persona Fisica</option></select> <font color="red">*</font></td>
<td><% if (Obbligato.getId()>0){ %><%= toHtml(Obbligato.getTipoPagatore()).equals("F") ? "Persona Fisica" : toHtml(Obbligato.getTipoPagatore()).equals("G") ? "Persona Giuridica" : "" %> <select style="display:none" id="tipoPagatoreO" name="tipoPagatoreO"><option value="G" <%=toHtml(Obbligato.getTipoPagatore()).equals("G") ? "selected" : ""%>>Persona Giuridica</option><option value="F" <%=toHtml(Obbligato.getTipoPagatore()).equals("F") ? "selected" : ""%>>Persona Fisica</option></select> <font color="red">*</font> <%} %> </td>
</tr>


<tr>
<th>Partita IVA / Codice fiscale</th>
<td><input type="text" readonly name="pivaT" id="pivaT" value="<%=toHtml(Trasgressore.getPartitaIvaCodiceFiscale())%>" size="20" maxlength="16"/> <font color="red">*</font></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="pivaO" id="pivaO" value="<%=toHtml(Obbligato.getPartitaIvaCodiceFiscale())%>" size="20" maxlength="16"/> <font color="red">*</font><%} %></td>
</tr>

<tr>
<th>Ragione sociale / Nominativo</th>
<td><input type="text" readonly name="nomeT" id="nomeT" size="50" readonly value="<%=toHtml(Trasgressore.getRagioneSocialeNominativo())%>"/> <font color="red">*</font></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="nomeO" id="nomeO" size="50" readonly value="<%=toHtml(Obbligato.getRagioneSocialeNominativo())%>"/> <font color="red">*</font><%} %></td>
</tr>

<tr>
<th>Indirizzo</th>
<td><input type="text" readonly name="indirizzoT" id="indirizzoT" size="50" value="<%=toHtml(Trasgressore.getIndirizzo())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="indirizzoO" id="indirizzoO" size="50" value="<%=toHtml(Obbligato.getIndirizzo())%>"/><%} %></td>
</tr>

<tr>
<th>Civico</th>
<td><input type="text" readonly name="civicoT" id="civicoT" size="5" value="<%=toHtml(Trasgressore.getCivico())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="civicoO" id="civicoO" size="5" value="<%=toHtml(Obbligato.getCivico())%>"/><%} %></td>
</tr>

<tr>
<th>CAP</th>
<td><input type="text" readonly name="capT" id="capT" size="5" value="<%=toHtml(Trasgressore.getCap())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="capO" id="capO" size="5" value="<%=toHtml(Obbligato.getCap())%>"/><%} %></td>
</tr>

<tr>
<th>Comune</th>
<td><input type="text" readonly name="comuneT" id="comuneT" value="<%=toHtml(Trasgressore.getComune())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="comuneO" id="comuneO" value="<%=toHtml(Obbligato.getComune())%>"/><%} %></td>
</tr>

<tr>
<th>Cod Provincia</th>
<td><input type="text" readonly name="provinciaT" id="provinciaT" size="3" maxlength="3" value="<%=toHtml(Trasgressore.getCodProvincia())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="provinciaO" id="provinciaO" size="3" maxlength="3" value="<%=toHtml(Obbligato.getCodProvincia())%>"/><%} %></td>
</tr>

<tr>
<th>Nazione</th>
<td><input type="text" readonly name="nazioneT" id="nazioneT" size="2" maxlength="2" value="<%=toHtml(Trasgressore.getNazione()).toUpperCase()%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly name="nazioneO" id="nazioneO" size="2" maxlength="2" value="<%=toHtml(Obbligato.getNazione()).toUpperCase()%>"/><%} %></td>
</tr>

<tr>
<th>Email</th>
<td><input type="text" name="mailT" id="mailT" size="40" value="<%=toHtml(Trasgressore.getDomicilioDigitale())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" name="mailO" id="mailO" size="40" value="<%=toHtml(Obbligato.getDomicilioDigitale())%>"/><%} %></td>
</tr>

<tr>
<th>Telefono</th>
<td><input type="text" name="telefonoT" id="telefonoT" size="40" value="<%=toHtml(Trasgressore.getTelefono())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" name="telefonoO" id="telefonoO" size="40" value="<%=toHtml(Obbligato.getTelefono())%>"/><%} %></td>
</tr>

<tr>
<th>Modalità di contestazione/notifica</th>
<td>
<input type="checkbox" id="tipoNotificaT_I" name="tipoNotificaT" value="I" onClick="gestisciNotifica('T', this)"/>CONTESTAZIONE IMMEDIATA<br/>
<input type="checkbox" id="tipoNotificaT_P" name="tipoNotificaT" value="P" onClick="gestisciNotifica('T', this)"/>PEC<br/>
<input type="checkbox" id="tipoNotificaT_R" name="tipoNotificaT" value="R" onClick="gestisciNotifica('T', this)"/>RACCOMANDATA A/R oppure consegna a mano<br/>
<div id="divDataNotificaT" style="display:none"> 
<b><label id="labelDataNotificaT">Data di contestazione immediata/notifica</label></b> <input type="date" id="dataNotificaT" name="dataNotificaT" onkeydown="return false"/>
</div> 
</td>
<td><% if (Obbligato.getId()>0){ %>
<input type="checkbox" id="tipoNotificaO_I" name="tipoNotificaO" value="I" onClick="gestisciNotifica('O', this)"/>CONTESTAZIONE IMMEDIATA<br/>
<input type="checkbox" id="tipoNotificaO_P" name="tipoNotificaO" value="P" onClick="gestisciNotifica('O', this)"/>PEC<br/>
<input type="checkbox" id="tipoNotificaO_R" name="tipoNotificaO" value="R" onClick="gestisciNotifica('O', this)"/>RACCOMANDATA A/R oppure consegna a mano<br/>
<div id="divDataNotificaO" style="display:none">
<b><label id="labelDataNotificaO">Data di contestazione immediata/notifica</label></b> <input type="date" id="dataNotificaO" name="dataNotificaO" onkeydown="return false"/>
</div>
</td>
<%} %>
</tr>

<% if (SanzioneDettaglio.getPagamento()>0){ %>

<tr><th colspan="3" style="background:yellow">INFORMAZIONI VERSAMENTO PER PAGAMENTO RIDOTTO </th></tr>

<tr><th>Tipo pagamento</th> <td colspan="2"><input type="radio" checked id="tipoPagamentoPV_1" name="tipoPagamento_1" value="PV"/> Per Processo Verbale</td>
<tr><th>Importo totale versamento</th> <td colspan="2"><input type="text" readonly id="importoTotaleVersamento_1" name="importoTotaleVersamento_1" value="<%= String.format(Locale.US, "%.2f", SanzioneDettaglio.getPagamento())%>"/></td></tr>

<% if (SanzioneDettaglio.getPagamentoUltraridotto()>0){ %>

<tr><th colspan="3" style="background:yellow">INFORMAZIONI VERSAMENTO PER PAGAMENTO ULTRA RIDOTTO </th></tr>

<tr><th>Tipo pagamento</th> <td colspan="2"><input type="radio" checked id="tipoPagamentoPV_2" name="tipoPagamento_2" value="PV"/> Per Processo Verbale</td>
<tr><th>Importo totale versamento</th> <td colspan="2"><input type="text" readonly id="importoTotaleVersamento_2" name="importoTotaleVersamento_2" value="<%=String.format(Locale.US, "%.2f", SanzioneDettaglio.getPagamentoUltraridotto())%>"/></td></tr>

<% } %>

<tr><th colspan="3">
<center>
<dhv:permission name="pagopa_genera_processo_verbale-view">
<br/>
<input type="button" style="font-size: 20px;" id="invia" value="SALVA E INVIA" onClick="checkForm(this.form)"/>
<br/>
</dhv:permission>
<br/><font color="green">Mediante questa funzione, i dati anagrafici dei pagatori verranno salvati <br/>
e gli avvisi di pagamento riportati in questa pagina verranno inviati a PagoPa</font>
</center>
</th></tr>

<% } else {%>
<tr><tD colspan="3" style="background:CORAL" align="center">LA SANZIONE NON PREVEDE PAGAMENTO IN MISURA RIDOTTA. IMPOSSIBILE GENERARE GLI AVVISI PAGOPA.</td></tr>
<%} %>

</table> 
 
<input type="hidden" id="idSanzione" name="idSanzione" value="<%=SanzioneDettaglio.getId()%>"/>
<input type="hidden" id="idTrasgressore" name="idTrasgressore" value="<%=Trasgressore.getId()%>"/>
<input type="hidden" id="idObbligato" name="idObbligato" value="<%=Obbligato.getId()%>"/>
<input type="hidden" id="origine" name="origine" value="ProcessoVerbale"/>
<input type="hidden" id="dataCu" name="dataCu" value="<%=toDateasStringWithFormat(SanzioneDettaglio.getDataFineControllo()!=null ? SanzioneDettaglio.getDataFineControllo() : SanzioneDettaglio.getAssignedDate(), "yyyy-MM-dd")%>"/>

</form>


<!-- inizio riepilogo scaduti-->
<% if (listaPagamentiScaduti.size()>0) { %>
</br>
<table class="details" id = "tabletrasgressioneScaduta" cellpadding="10" cellspacing="10" style="border-collapse: collapse">
<tr><th colspan="3" style="background:coral">RIEPILOGO RAPIDO DEGLI AVVISI DI PAGAMENTO SCADUTI</th></tr>
<tr><th></th><th><center>Avviso</center></th><th><center>Pagatore</center></th></tr>
<% for ( int i = 0; i<listaPagamentiScaduti.size(); i++){
	Pagamento pScaduto = (Pagamento) listaPagamentiScaduti.get(i); %>
<tr>
<td align="center"><%= pScaduto.getTipoPagamento().equals("NO") ? "RATA "+ (pScaduto.getNumeroRate() == 1 ? "UNICA" : pScaduto.getIndice()) + (pScaduto.isRigenerato() ? " (RIGENERATA)" : "")  : pScaduto.getTipoPagamento().equals("PV") && pScaduto.getTipoRiduzione().equals("U") ? "ULTRARIDOTTO" : pScaduto.getTipoPagamento().equals("PV") && pScaduto.getTipoRiduzione().equals("R") ? "RIDOTTO" : "" %></td>
<td align="center"><% if (pScaduto.getHeaderFileAvviso()!=null && !pScaduto.getHeaderFileAvviso().equalsIgnoreCase("")){ %><a href="#" onClick="openRichiestaDownload('<%= pScaduto.getHeaderFileAvviso() %>', 'AVVISO_<%=pScaduto.getIdentificativoUnivocoVersamento()%>', 'true'); return false;"><%=pScaduto.getIdentificativoUnivocoVersamento()%></a><% } else {%><%=pScaduto.getIdentificativoUnivocoVersamento() %><% } %> (<%=pScaduto.getStatoPagamento() %>)<br/><br/><b>Data Scadenza</b>: <%=toDateasStringFromString(pScaduto.getDataScadenza()) %><br/> <b>Importo singolo versamento</b>: <%=pScaduto.getImportoSingoloVersamento() %></a></td>
<td align="center"><%=pScaduto.getPagatore().getRagioneSocialeNominativo() %> / <%=pScaduto.getPagatore().getPartitaIvaCodiceFiscale() %></td>
</tr>

<% } %>

</table>
<% } %>
<!-- fine riepilogo scaduti -->

