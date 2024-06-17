<%@ page import="java.sql.*" %>
<jsp:useBean id="SanzioneDettaglio" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="Trasgressore" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="Obbligato" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
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


<script>

function gestisciImportoDecimale(campo){
	 
	 var valore = campo.value.trim();
	 campo.value = valore;
	 
	 if (valore == '')
		 return false;
	 
	 if (isNaN(valore)){
		 alert('Inserire un importo numerico nel formato XX.yy')
		 campo.value = '';
		 return false;
	 }
	 
	 var val = valore.split(".");
	 
	 if (val.length==1)
		 campo.value = val[0]+".00";
	 else if (val.length==2 && val[1].length==1)
		 campo.value = val[0]+"."+val[1]+"0";
	 else if (val.length==2 && val[1].length>2)
		 campo.value = val[0]+"."+val[1].substring(0,2);
	 else if (val.length==2 && val[1].length==2)
		 campo.value = val[0]+"."+val[1];
	 else {
		 alert('Inserire un importo numerico nel formato XX.yy')
		 campo.value = '';
		 return false;
	 }
	 
}

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
			document.getElementById("dataNotifica"+tipo).readOnly=false;
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

function gestisciNumeroRate(val){
	var importo = val.value;

	if (importo <= 99) 
		abilitaRate(1);
	else if (importo <= 149) 
		abilitaRate(2);
	else if (importo <= 199) 
		abilitaRate(3);
	else if (importo <= 500)
		abilitaRate(4);
	else if (importo <= 1000)
		abilitaRate(8);
	else if (importo <= 3000)
		abilitaRate(16);
	else if (importo <= 10000)
		abilitaRate(24);
	else if (importo <= 50000)
		abilitaRate(30);
	else if (importo > 50000)
		abilitaRate(72);
}

function abilitaRate(max){
	
	for (var i = 1; i<= 72; i++){
		
		if (i<=max){
			document.getElementById("numeroRate"+i).disabled = false;
			document.getElementById("tdNumeroRate"+i).style.visibility = 'visible';
		}
		else {
			document.getElementById("numeroRate"+i).disabled = true;
			document.getElementById("numeroRate"+i).checked = false;
			document.getElementById("tdNumeroRate"+i).style.visibility = 'hidden';
		}
			
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
	
       
   	if (form.importoTotaleVersamento!=null && form.importoTotaleVersamento.value== '') {
		 message += "\n - Inserire un importo.\r\n"; 
			flag = false;
		}
   	
	if (form.numeroRate!=null && form.numeroRate.value== '') {
		 message += "\n - Indicare un numero di rate.\r\n"; 
			flag = false;
		}
     	     	
	    if (!flag){
	    	showDialogAlert("Non si può procedere all'invio. Motivazione: \n" + message);
	  	  	return null;
	    }
	
	
	var confirmString= "";
	
	var numeroRate = form.numeroRate.value;
	var importoTotale = form.importoTotaleVersamento.value;
	var importoSingolaRata = (importoTotale/numeroRate).toFixed(2);
	
	if (numeroRate>0)
		confirmString= 'Sono state selezionate '+numeroRate+' rate con un importo totale di '+importoTotale+' euro. \n\n Saranno quindi generati '+numeroRate+' avvisi di pagamento da '+importoSingolaRata+' euro ciascuno, per ogni pagatore.';
	
	if (numeroRate>1 && importoSingolaRata <50){
		showDialogAlert("Non si può procedere all'invio. Motivazione: \n\n Sono state selezionate "+numeroRate+" rate con un importo totale di "+importoTotale+" euro. \n\n Sarebbero quindi generati "+numeroRate+" avvisi di pagamento da "+importoSingolaRata+" euro ciascuno, per ogni pagatore.\n\n Impossibile generare rate inferiori a 50 euro. \n\nScegliere una soluzione in rata unica per tale importo.\n");
  	  	return null;
	}
	
	confirmString+="\n\nSalvare e inviare?";
	
	if (numeroRate>10)
		confirmString+= "\n\n(ATTENZIONE. E' STATO SCELTO UN ALTO NUMERO DI RATE. NON CHIUDERE LA PAGINA DURANTE LA PROCEDURA CHE POTREBBE IMPIEGARE DIVERSI MINUTI.)";
	
	showDialogConfirm(confirmString);
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

<form name="formPagoPa" id="formPagoPa" action="GestionePagoPa.do?command=InsertNumeroOrdinanza" method="post">

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
<td><input type="text" readonly  name="indirizzoT" id="indirizzoT" size="50" value="<%=toHtml(Trasgressore.getIndirizzo())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly  name="indirizzoO" id="indirizzoO" size="50" value="<%=toHtml(Obbligato.getIndirizzo())%>"/><%} %></td>
</tr>

<tr>
<th>Civico</th>
<td><input type="text" readonly  name="civicoT" id="civicoT" size="5" value="<%=toHtml(Trasgressore.getCivico())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly  name="civicoO" id="civicoO" size="5" value="<%=toHtml(Obbligato.getCivico())%>"/><%} %></td>
</tr>

<tr>
<th>CAP</th>
<td><input type="text" readonly  name="capT" id="capT" size="5" value="<%=toHtml(Trasgressore.getCap())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly  name="capO" id="capO" size="5" value="<%=toHtml(Obbligato.getCap())%>"/><%} %></td>
</tr>

<tr>
<th>Comune</th>
<td><input type="text" readonly  name="comuneT" id="comuneT" value="<%=toHtml(Trasgressore.getComune())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly  name="comuneO" id="comuneO" value="<%=toHtml(Obbligato.getComune())%>"/><%} %></td>
</tr>

<tr>
<th>Cod Provincia</th>
<td><input type="text" readonly  name="provinciaT" id="provinciaT" size="3" maxlength="3" value="<%=toHtml(Trasgressore.getCodProvincia())%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly  name="provinciaO" id="provinciaO" size="3" maxlength="3" value="<%=toHtml(Obbligato.getCodProvincia())%>"/><%} %></td>
</tr>

<tr>
<th>Nazione</th>
<td><input type="text" readonly  name="nazioneT" id="nazioneT" size="2" maxlength="2" value="<%=toHtml(Trasgressore.getNazione()).toUpperCase()%>"/></td>
<td><% if (Obbligato.getId()>0){ %><input type="text" readonly  name="nazioneO" id="nazioneO" size="2" maxlength="2" value="<%=toHtml(Obbligato.getNazione()).toUpperCase()%>"/><%} %></td>
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
<div style="display:none"><input type="checkbox" id="tipoNotificaT_I" name="tipoNotificaT" value="I" onClick="gestisciNotifica('T', this)"/>CONTESTAZIONE IMMEDIATA<br/></div>
<input type="checkbox" id="tipoNotificaT_P" name="tipoNotificaT" value="P" onClick="gestisciNotifica('T', this)"/>PEC<br/>
<input type="checkbox" id="tipoNotificaT_R" name="tipoNotificaT" value="R" onClick="gestisciNotifica('T', this)"/>RACCOMANDATA A/R oppure consegna a mano<br/>
<div id="divDataNotificaT" style="display:none"> 
<b><label id="labelDataNotificaT">Data di contestazione immediata/notifica</label></b> <input type="date" id="dataNotificaT" name="dataNotificaT" onkeydown="return false"/>
</div> 
</td>
<td><% if (Obbligato.getId()>0){ %>
<div style="display:none"><input type="checkbox" id="tipoNotificaO_I" name="tipoNotificaO" value="I" onClick="gestisciNotifica('O', this)"/>CONTESTAZIONE IMMEDIATA<br/></div>
<input type="checkbox" id="tipoNotificaO_P" name="tipoNotificaO" value="P" onClick="gestisciNotifica('O', this)"/>PEC<br/>
<input type="checkbox" id="tipoNotificaO_R" name="tipoNotificaO" value="R" onClick="gestisciNotifica('O', this)"/>RACCOMANDATA A/R oppure consegna a mano<br/>
<div id="divDataNotificaO" style="display:none">
<b><label id="labelDataNotificaO">Data di contestazione immediata/notifica</label></b> <input type="date" id="dataNotificaO" name="dataNotificaO" onkeydown="return false"/>
</div>
</td>
<%} %>
</tr>

<tr><th colspan="3" style="background:yellow">INFORMAZIONI VERSAMENTO </th></tr>

<tr><th>Tipo pagamento</th> <td colspan="2"><input type="radio" checked id="tipoPagamentoNO" name="tipoPagamento" value="NO"/> Per Numero Ordinanza</td>

<tr><th>Importo totale versamento</th> <td colspan="2"><input type="text" id="importoTotaleVersamento" name="importoTotaleVersamento" value="" onChange="gestisciImportoDecimale(this); gestisciNumeroRate(this);" placeholder="100.00"/></td></tr>

<tr><th>Numero Rate</th> <td colspan="2">

<table cellpadding="5" cellspacing="2">
<% for (int i = 1; i<=72; i++) { %>

<% if (i == 1) {%><tr><%} %>

<td id="tdNumeroRate<%=i%>">
<input type="radio" name="numeroRate" id="numeroRate<%=i %>" value="<%=i %>" <% if (i>1){ %>onchange="showDialogAlert('Attenzione!\n\nSelezionando un numero di rate maggiore di 1, IMPORTO TOTALE VERSAMENTO verrà diviso tra tutte le rate.'); return false;" <% } %>/> <%=i %>
</td>

<% if (i>1 && i%10 == 0) {%></tr><tr><%} %>

<% if (i == 72) {%></tr><%} %>

<%} %>
</table>

</td></tr>

<tr><th colspan="3">
<center>
<dhv:permission name="pagopa_genera_numero_ordinanza-view">
<br/>
<input type="button" style="font-size: 20px;" id="invia" value="SALVA E INVIA" onClick="checkForm(this.form)"/>
<br/>
</dhv:permission>
<br/><font color="green">Mediante questa funzione, i dati anagrafici dei pagatori verranno salvati <br/>
e gli avvisi di pagamento riportati in questa pagina verranno inviati a PagoPa</font>
</center>
</th></tr>

</table>

<input type="hidden" id="idSanzione" name="idSanzione" value="<%=SanzioneDettaglio.getId()%>"/>
<input type="hidden" id="idTrasgressore" name="idTrasgressore" value="<%=Trasgressore.getId()%>"/>
<input type="hidden" id="idObbligato" name="idObbligato" value="<%=Obbligato.getId()%>"/>
<input type="hidden" id="origine" name="origine" value="NumeroOrdinanza"/>
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
