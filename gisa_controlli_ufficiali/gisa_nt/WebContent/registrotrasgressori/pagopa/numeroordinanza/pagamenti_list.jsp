<jsp:useBean id="SanzioneDettaglio" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="Trasgressore" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="Obbligato" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="listaPagamenti" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="listaPagamentiScaduti" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>

<jsp:useBean id="importoTotaleRichiesto" class="java.lang.String" scope="request"/>
<jsp:useBean id="importoTotaleVersato" class="java.lang.String" scope="request"/> 
<jsp:useBean id="importoTotaleResiduo" class="java.lang.String" scope="request"/>
<jsp:useBean id="possibilitaRigenera" class="java.lang.String" scope="request"/>

<jsp:useBean id="doppiPagamenti" class="java.util.ArrayList" scope="request"/>

<jsp:useBean id="semaforoAttivo" class="java.lang.String" scope="request"/>

<%@ page import="org.aspcfs.modules.registrotrasgressori.base.Pagamento" %>

<%@ include file="../../../utils23/initPage.jsp"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

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

<style>
body {
  padding-top: 10px;
  padding-left: 50px;
  padding-bottom: 50px;
}
</style>

<script>

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
		
		if (cb.value!="P")
			document.getElementById("tipoNotifica"+tipo+"_P").checked=false;
		if (cb.value!="R")
			document.getElementById("tipoNotifica"+tipo+"_R").checked=false;
		
		if (cb.value=="P")
			showDialogAlert("L'esistenza e la correttezza dell'indirizzo PEC possono essere verificate nell'Indice Nazionale degli Indirizzi di PEC istituito dal Ministero dello Sviluppo Economico accessibile sul sito: \n\n https://www.inipec.gov.it/cerca-pec\n\nIndicare come data notifica la data di invio della PEC. Si ricorda che la PEC va inviata obbligatoriamente entro la data indicata, altrimenti non verranno calcolati correttamente i termini di pagamento.");
		if (cb.value=="R")
			showDialogAlert("Si invita a ricorrere alla Raccomandata/Consegna a mano solo se non è disponibile almeno un indirizzo PEC. Pertanto è necessario verificare l'esistenza e la correttezza dell'indirizzo PEC nell'Indice Nazionale degli Indirizzi di PEC istituito dal Ministero dello Sviluppo Economico accessibile sul sito: \n\n https://www.inipec.gov.it/cerca-pec \n\nSolo se non è stata trovata una PEC è possibile ricorrere alla Raccomandata A/R o alla consegna a mano."); 
	
	}
	
	else {
		document.getElementById("dataNotifica"+tipo).value='';
		document.getElementById("dataNotifica"+tipo).readOnly=false;
	}
}

function aggiornaNotifica(tipo, form){
	
	var notificaI = document.getElementById("tipoNotifica"+tipo+"_I");
	var notificaP = document.getElementById("tipoNotifica"+tipo+"_P");
	var notificaR = document.getElementById("tipoNotifica"+tipo+"_R");
	
	if (!notificaI.checked && !notificaP.checked && !notificaR.checked) {
		showDialogAlert("Errore.\n\n- Indicare una modalità di contestazione/notifica.");
	    return false;
	}

	var dataNotifica = document.getElementById("dataNotifica"+tipo).value;
	
	if (dataNotifica== '') {
		showDialogAlert("Errore.\n\n- Indicare una data notifica.");
	    return false;
	}
	
	var dataOggi = new Date();
	var dataNotificaDate = new Date(dataNotifica);
	
// 	if (dataNotificaDate.setHours(0,0,0,0) > dataOggi.setHours(0,0,0,0)) {
// 		showDialogAlert("Errore.\n\n- La data di notifica non può essere successiva alla data odierna.");
// 	    return false;
// 	}
	
	 var x = document.getElementsByName("dataGenerazioneIuv");	
	 for (var i = 0; i<x.length; i++){
		 var data =  new Date(x[i].value);
			if (dataNotificaDate.setHours(0,0,0,0) < data.setHours(0,0,0,0)) { 
				showDialogAlert("Errore.\n\n- La data di notifica non può essere antecedente alla data generazione IUV.");
		   		return false;
			}
	 }
	 
	  if (giorni_differenza(dataNotifica, form.dataCu.value)<0) {
		  showDialogAlert("Errore.\n\n- Inserire una data di notifica/contestazione uguale o successiva alla data del controllo ufficiale.");
           return false;
       }

	form.action = "GestionePagoPa.do?command=AggiornaNotifica&tipo="+tipo;
	showDialogConfirm("Attenzione.\n\nProseguendo, la data di scadenza di tutti gli avvisi di pagamento SOLO A CARICO DI QUESTO PAGATORE sarà ricalcolata a partire dalla data di notifica indicata.\n\n(Prima rata: data notifica + 30 giorni; Rate successive: data scadenza rata precedente + 30 giorni)\n\nProseguire?");
}

function testPaga(idPagamento, form){
	form.action = "GestionePagoPa.do?command=TestPaga";
	form.idPagamento.value = idPagamento;
	showDialogConfirm("Attenzione.\n\nProseguendo, l'avviso di pagamento sara' pagato.\n\nProseguire?");
	}
function testScadi(idPagamento, form){
	form.action = "GestionePagoPa.do?command=TestScadi";
	form.idPagamento.value = idPagamento;
	showDialogConfirm("Attenzione.\n\nProseguendo, l'avviso di pagamento sara' fatto scadere.\n\nProseguire?");
	}
function annulla(idPagamento, form){
	form.action = "GestionePagoPa.do?command=Annulla";
	form.idPagamento.value = idPagamento;
	showDialogConfirm("Attenzione.\n\nProseguendo, l'avviso di pagamento sara' annullato.\n\nProseguire?");
	}
function elimina(idPagamento, form){
	form.action = "GestionePagoPa.do?command=Elimina";
	form.idPagamento.value = idPagamento;
	showDialogConfirm("Attenzione.\n\nProseguendo, l'avviso di pagamento sara' eliminato da GISA.\n\nProseguire?");
	}	

function annullaTutto(form){
	form.action = "GestionePagoPa.do?command=AnnullaTutto";
	showDialogConfirm("Attenzione.\n\nProseguendo, tutti gli avvisi di pagamento non scaduti saranno annullati.\n\nProseguire?");
}

function annullaTuttoSanzione(form){
	form.action = "GestionePagoPa.do?command=AnnullaTutto&cancellaSanzione=si";
	showDialogConfirm("Attenzione.\n\nProseguendo, tutti gli avvisi di pagamento non scaduti saranno annullati e la sanzione sarà eliminata.\n\nProseguire?");
}

function verifica(idPagamento, form){
	loadModalWindow();
	$(window).scrollTop(0);
	form.action = "GestionePagoPa.do?command=Verifica";
	form.idPagamento.value = idPagamento;
	form.submit();
	
}
function aggiorna(idPagamento, form){
	
	var dataScadenza = document.getElementById("dataScadenza_"+idPagamento).value;
		
	if (dataScadenza == '') {
	    showDialogAlert("Errore.\n\n- Indicare una data scadenza.");
	    dataScadenza.value = '';
	    return false;
	}

	form.idPagamento.value = idPagamento;
	showDialogConfirm("Attenzione.\n\nProseguendo, la data di scadenza del pagamento sara' aggiornata.\n\nProseguire?");
	}
	
function aggiornaNotificaRigenerata(idPagamento, form){
	
	var dataNotificaRigenerata = document.getElementById("dataNotificaRigenerata_"+idPagamento).value;
		
	if (dataNotificaRigenerata == '') {
	    showDialogAlert("Errore.\n\n- Indicare una data notifica.");
	    dataNotificaRigenerata.value = '';
	    return false;
	}

	form.idPagamento.value = idPagamento;
	form.action = "GestionePagoPa.do?command=AggiornaNotificaRigenerata";
	showDialogConfirm("Attenzione.\n\nProseguendo, la data di scadenza del pagamento sara' aggiornata.\n\nProseguire?");
	}	
	
function mostraNascondiRigenera(){
	if (document.getElementById('tableRigenera').style.display=='none'){
		document.getElementById('tableRigenera').style.display='block';
		document.getElementById('funzioneRigenera').style.display='none';
		document.getElementById('importoTotaleVersamento').onchange();
	}
	else {
		document.getElementById('tableRigenera').style.display='none';
		document.getElementById('funzioneRigenera').style.display='block';
		document.getElementById('importoTotaleVersamento').value= '<%=importoTotaleResiduo%>';
	}
	}

function rigenera(form){
	
	var numeroRate = form.numeroRate.value;
	var importoTotale = form.importoTotaleVersamento.value;
	var dataNotifica = form.dataNotifica.value;
	
	var confirmString= "";

	if (numeroRate == '') {
	    showDialogAlert("Errore.\n\n- Indicare un numero di rate.");
	    return false;
	}
	if (importoTotale == '') {
	    showDialogAlert("Errore.\n\n- Indicare un importo totale versamento.");
	    return false;
	}
	if (dataNotifica == '') {
	    showDialogAlert("Errore.\n\n- Indicare una data notifica.");
	    form.dataNotifica.value = '';
	    return false;
	}
	
	var importoSingolaRata = (importoTotale/numeroRate).toFixed(2);
	
	var nomeRate = "RATE";
	if (numeroRate == 1)
		nomeRate = "RATA";
	
	confirmString= numeroRate+ ' ' +nomeRate +' con un importo totale di '+importoTotale+' euro. \n\n Saranno quindi generati '+numeroRate+' avvisi di pagamento da '+importoSingolaRata+' euro ciascuno, per ogni pagatore. Le date di scadenza saranno valorizzate a partire da 30 giorni dalla data di notifica '+dataNotifica+'.';
	
	if (numeroRate>1 && importoSingolaRata <50){
		showDialogAlert("Non si può procedere all'invio. Motivazione: \n\n Sono state selezionate "+numeroRate+" rate con un importo totale di "+importoTotale+" euro. \n\n Sarebbero quindi generati "+numeroRate+" avvisi di pagamento da "+importoSingolaRata+" euro ciascuno, per ogni pagatore.\n\n Impossibile generare rate inferiori a 50 euro. \n\nScegliere una soluzione in rata unica per tale importo.\n");
  	  	return null;
	}

	form.action = "GestionePagoPa.do?command=Rigenera";
	
	confirmString ="Proseguendo, gli avvisi di pagamento nello stato 'PAGAMENTO NON INIZIATO' saranno annullati, e ne saranno inseriti di nuovi come indicato di seguito:\n\n"+confirmString+"\n\nProseguire?";

	if (numeroRate>10)
		confirmString+= "\n\n(ATTENZIONE. E' STATO SCELTO UN ALTO NUMERO DI RATE. NON CHIUDERE LA PAGINA DURANTE LA PROCEDURA CHE POTREBBE IMPIEGARE DIVERSI MINUTI.)";
	
	showDialogConfirm(confirmString);
	
	}

function nascondiFunzioni(almenoUnPagato, almenoUnIuvVuoto, almenoUnIuvProcessoVerbale, almenoUnIuvTrasgressore, almenoUnIuvObbligato) {
	if (almenoUnPagato=="true"){
		document.getElementById("funzioneAnnulla").style.display="none";
		document.getElementById("funzioneRigenera").style.display="block";
		
		if (document.getElementById("aggiornaNotificaT")!=null){
			document.getElementById("aggiornaNotificaT").style.display="none";
			document.getElementById("tipoNotificaT_I").disabled=true;
			document.getElementById("tipoNotificaT_P").disabled=true;
			document.getElementById("tipoNotificaT_R").disabled=true;
			document.getElementById("dataNotificaT").disabled=true;
		}
		if (document.getElementById("aggiornaNotificaO")!=null){
			document.getElementById("aggiornaNotificaO").style.display="none";
			document.getElementById("tipoNotificaO_I").disabled=true;
			document.getElementById("tipoNotificaO_P").disabled=true;
			document.getElementById("tipoNotificaO_R").disabled=true;
			document.getElementById("dataNotificaO").disabled=true;
		}
		
		}
	if (almenoUnIuvVuoto=="true"){
		}
	
	if (almenoUnIuvProcessoVerbale=="true"){
		
		if (document.getElementById("aggiornaNotificaT")!=null){
			document.getElementById("aggiornaNotificaT").style.display="none";
			document.getElementById("tipoNotificaT_I").disabled=true;
			document.getElementById("tipoNotificaT_P").disabled=true;
			document.getElementById("tipoNotificaT_R").disabled=true;
			document.getElementById("dataNotificaT").disabled=true;
		}
		if (document.getElementById("aggiornaNotificaO")!=null){
			document.getElementById("aggiornaNotificaO").style.display="none";
			document.getElementById("tipoNotificaO_I").disabled=true;
			document.getElementById("tipoNotificaO_P").disabled=true;
			document.getElementById("tipoNotificaO_R").disabled=true;
			document.getElementById("dataNotificaO").disabled=true;
		}
		document.getElementById("divRiepilogoImporti").style.display = "none";
	}
	
	if (almenoUnIuvTrasgressore=="false"){
		
		if (document.getElementById("tdNotificaT")!=null){
			document.getElementById("aggiornaNotificaT").style.display="none";
		}
	}
	
	if (almenoUnIuvObbligato=="false"){
		
		if (document.getElementById("tdNotificaO")!=null){
			document.getElementById("tdNotificaO").style.display="none";
		}
	}
	
}



function openRichiestaArchivioAvvisi(idSanzione){
	
	var res;
	var result=
		window.open('GestionePagoPa.do?command=DownloadAll&idSanzione='+idSanzione,'popupSelectDownloadZipPagoPa',
		'height=200px,width=842px,left=200px, top=200px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
		var text = document.createTextNode('GENERAZIONE ARCHIVIO IN CORSO.');
		span = document.createElement('span');
		span.style.fontSize = "30px";
		span.style.fontWeight = "bold";
		span.style.color ="#ff0000";
		span.appendChild(text);
		var br = document.createElement("br");
		var text2 = document.createTextNode('Attendere la generazione del file entro qualche secondo...');
		span2 = document.createElement('span');
		span2.style.fontSize = "20px";
		span2.style.fontStyle = "italic";
		span2.style.color ="#000000";
		span2.appendChild(text2);
		result.document.body.appendChild(span);
		result.document.body.appendChild(br);
		result.document.body.appendChild(span2);
		result.focus();
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

function gestisciImportoDecimale(campo){
	 
	 var valore = campo.value.trim();
	 campo.value = valore;
	 
	 if (valore == '')
		 return false;
	 
	 if (isNaN(valore)){
		 alert('Inserire un importo numerico nel formato XX.yy')
		 campo.value = '<%=importoTotaleResiduo%>';
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

</script>

<%@ include file="../dialog.jsp" %>

<% if (semaforoAttivo!=null && semaforoAttivo.equals("true")){ %>
<script>
showDialogAlertClose("ATTENZIONE. Su questa sanzione sono in corso delle operazioni di generazione IUV. \n\nRiprovare tra qualche minuto.");
</script>
<% } %>

<% if (messaggio!=null && !messaggio.equals("")){ %>
<script>
showDialogAlert("<%=messaggio%>");
</script>
<% } %>

<form name="formPagoPa" id="formPagoPa" action="GestionePagoPa.do?command=Update" method="post">

<table class="details" cellpadding="10" cellspacing="10" style="border-collapse: collapse">

<tr><th colspan="3" style="background:yellow">INFORMAZIONI SANZIONE</th></tr>


<tr>
<th>Id controllo ufficiale</th>  
<td colspan="2"><%=SanzioneDettaglio.getIdControlloUfficiale() %></td></tr>
<tr>
<th>Id sanzione</th>  
<td colspan="2"><%=SanzioneDettaglio.getId() %></td></tr>
<tr>
<th>Operazioni</th>
<td colspan="2">

<div id="funzioneAnnulla">
<dhv:permission name="pagopa_annulla_tutto-view">
<center>
<input type="button" style="background: red; font-size: 15px;" value="ANNULLA AVVISI DI PAGAMENTO" onClick="annullaTutto(this.form);"/> 
<br/> <font color="green">Mediante questa funzione, tutti gli avvisi di pagamento non scaduti mostrati in questa pagina<br/> 
verranno annullati in PagoPa, eliminati in GISA e sarà possibile effettuare nuovamente l'invio. <br/>
La sanzione non sarà eliminata.</font>
</center>
</dhv:permission>
</div>

<div id="funzioneRigenera" style="display:none">
<% if (Double.parseDouble(importoTotaleResiduo) > 0) { %>
<dhv:permission name="pagopa_rigenera-view">
<center>
<input type="button" <% if (possibilitaRigenera!=null && possibilitaRigenera.equals("false")) {%>disabled style="background: grey; font-size: 15px;" <%} else {%> style="background: green; font-size: 15px;" <%} %> value="RIGENERA AVVISI DI PAGAMENTO" onClick="mostraNascondiRigenera(); return false;"/> 
<br/> <font color="green">Mediante questa funzione, tutti gli avvisi di pagamento nello stato "PAGAMENTO NON INIZIATO" mostrati in questa pagina<br/> 
verranno annullati in PagoPa, eliminati in GISA e rigenerati tramite una nuova rateazione. <br/>
Gli altri avvisi di pagamento non saranno modificati.</font>
</center>
</dhv:permission>
<%} %>
</div>

<table id="tableRigenera" style="display:none; border-collapse:collapse">
<tr><th colspan="2"><center>RIGENERA AVVISI DI PAGAMENTO</center></th></tr>

<tr><th>Importo totale versamento</th> 
<td colspan="2"><input type="text" id="importoTotaleVersamento" name="importoTotaleVersamento" value="<%=importoTotaleResiduo %>" readonly onChange="gestisciImportoDecimale(this); gestisciNumeroRate(this);" placeholder="100.00"/></td>
</tr>

<tr><th>Numero Rate</th> 
<td colspan="2">
<table cellpadding="5" cellspacing="2">
<% for (int i = 1; i<=72; i++) { %>

<% if (i == 1) {%><tr><%} %>

<td id="tdNumeroRate<%=i%>">
<input type="radio" name="numeroRate" id="numeroRate<%=i %>" value="<%=i %>" /> <%=i %>
</td>

<% if (i>1 && i%10 == 0) {%></tr><tr><%} %>

<% if (i == 72) {%></tr><%} %>

<%} %>
</table>

</td>
</tr>

<tr><th>Data Notifica</th>
<td><input type="date" id="dataNotifica" name="dataNotifica" onkeydown="return false" value=""/></td></tr>

<script>
var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0 so need to add 1 to make it 1!
var yyyy = today.getFullYear();
if(dd<10){
  dd='0'+dd
} 
if(mm<10){
  mm='0'+mm
} 

today = yyyy+'-'+mm+'-'+dd;
document.getElementById("dataNotifica").setAttribute("min", today);
</script>

<tr><td colspan="2"><center>

<input type="button" style="font-size: 15px;" value="ANNULLA" onClick="mostraNascondiRigenera();"/>

<input type="button" style="background: green; font-size: 15px;" value="RIGENERA" onClick="rigenera(this.form); return false;"/>

</center></td></tr> 

</table>
  
<tr><th colspan="3" style="background:yellow">INFORMAZIONI SOGGETTO PAGATORE </th></tr>

<tr>
<td></td>
<th>TRASGRESSORE</th>
<th>OBBLIGATO IN SOLIDO</th>
</tr>

<tr>
<th>Tipo pagatore</th> 
<td><select disabled id="tipoPagatoreT" name="tipoPagatoreT"><option value="G" <%=Trasgressore.getTipoPagatore().equals("G") ? "selected" : ""%>>Società di persone/Associazioni</option><option value="F" <%=Trasgressore.getTipoPagatore().equals("F") ? "selected" : ""%>>Persona Fisica</option></select></td>
<% if (Obbligato.getId()>0){%><td><select disabled id="tipoPagatoreO" name="tipoPagatoreO"><option value="G" <%=Obbligato.getTipoPagatore().equals("G") ? "selected" : ""%>>Persona Giuridica</option><option value="F" <%=Obbligato.getTipoPagatore().equals("F") ? "selected" : ""%>>Persona Fisica</option></select></td><%} %>
</tr>

<tr>
<th>Partita IVA / Codice fiscale</th>
<td><input disabled type="text" name="pivaT" id="pivaT" value="<%=Trasgressore.getPartitaIvaCodiceFiscale()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="pivaO" id="pivaO" value="<%=Obbligato.getPartitaIvaCodiceFiscale()%>"/></td><%} %>
</tr>

<tr>
<th>Ragione sociale / Nominativo</th>
<td><input disabled type="text" name="nomeT" id="nomeT" size="50" value="<%=Trasgressore.getRagioneSocialeNominativo()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="nomeO" id="nomeO" size="50" value="<%=Obbligato.getRagioneSocialeNominativo()%>"/></td><%} %>
</tr>

<tr>
<th>Indirizzo</th>
<td><input disabled type="text" name="indirizzoT" id="indirizzoT" size="50" value="<%=Trasgressore.getIndirizzo()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="indirizzoO" id="indirizzoO" size="50" value="<%=Obbligato.getIndirizzo()%>"/></td><%} %>
</tr>

<tr>
<th>Civico</th>
<td><input disabled type="text" name="civicoT" id="civicoT" size="5" value="<%=Trasgressore.getCivico()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="civicoO" id="civicoO" size="5" value="<%=Obbligato.getCivico()%>"/></td><%} %>
</tr>

<tr>
<th>CAP</th>
<td><input disabled type="text" name="capT" id="capT" size="5" value="<%=Trasgressore.getCap()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="capO" id="capO" size="5" value="<%=Obbligato.getCap()%>"/></td><%} %>
</tr>

<tr>
<th>Comune</th>
<td><input disabled type="text" name="comuneT" id="comuneT" value="<%=Trasgressore.getComune()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="comuneO" id="comuneO" value="<%=Obbligato.getComune()%>"/></td><%} %>
</tr>

<tr>
<th>Cod Provincia</th>
<td><input disabled type="text" name="provinciaT" id="provinciaT" size="3" value="<%=Trasgressore.getCodProvincia()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="provinciaO" id="provinciaO" size="3" value="<%=Obbligato.getCodProvincia()%>"/></td><%} %>
</tr>

<tr>
<th>Nazione</th>
<td><input disabled type="text" name="nazioneT" id="nazioneT" value="<%=Trasgressore.getNazione()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="nazioneO" id="nazioneO" value="<%=Obbligato.getNazione()%>"/></td><%} %>
</tr>

<tr>
<th>Email</th>
<td><input disabled type="text" name="mailT" id="mailT" size="40" value="<%=Trasgressore.getDomicilioDigitale()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="mailO" id="mailO" size="40" value="<%=Obbligato.getDomicilioDigitale()%>"/></td><%} %>
</tr>

<tr>
<th>Telefono</th>
<td><input disabled type="text" name="telefonoT" id="telefonoT" size="40" value="<%=Trasgressore.getTelefono()%>"/></td>
<% if (Obbligato.getId()>0){%><td><input disabled type="text" name="telefonoO" id="telefonoO" size="40" value="<%=Obbligato.getTelefono()%>"/></td><%} %>
</tr>

<tr><th colspan="3" style="background:yellow">INFORMAZIONI MODALITA' DI CONTESTAZIONE/NOTIFICA</th></tr>

<tr>
<th>Modalità di contestazione/notifica</th>
<td id="tdNotificaT">
<input type="checkbox" id="tipoNotificaT_I" name="tipoNotificaT" value="I" <% if (Trasgressore.getNotifica()==null || (Trasgressore.getNotifica().getTipoNotifica() == null || "".equals(Trasgressore.getNotifica().getTipoNotifica()))) { %> onClick="gestisciNotifica('T', this)" <%} else if ("I".equals(Trasgressore.getNotifica().getTipoNotifica())) { %> checked onClick="return false" <%} else { %> onClick="return false" <%} %> /> CONTESTAZIONE IMMEDIATA<br/>
<input type="checkbox" id="tipoNotificaT_P" name="tipoNotificaT" value="P" <% if (Trasgressore.getNotifica()==null || (Trasgressore.getNotifica().getTipoNotifica() == null || "".equals(Trasgressore.getNotifica().getTipoNotifica()))) { %> onClick="gestisciNotifica('T', this)" <%} else if ("P".equals(Trasgressore.getNotifica().getTipoNotifica())) { %> checked onClick="return false" <%} else { %> onClick="return false" <%} %> /> PEC<br/>
<input type="checkbox" id="tipoNotificaT_R" name="tipoNotificaT" value="R" <% if (Trasgressore.getNotifica()==null || (Trasgressore.getNotifica().getTipoNotifica() == null || "".equals(Trasgressore.getNotifica().getTipoNotifica()))) { %> onClick="gestisciNotifica('T', this)" <%} else if ("R".equals(Trasgressore.getNotifica().getTipoNotifica())) { %> checked onClick="return false" <%} else { %> onClick="return false" <%} %> /> RACCOMANDATA A/R oppure consegna a mano<br/>

<b>
<% if ("I".equalsIgnoreCase(Trasgressore.getNotifica().getTipoNotifica())){ %>
Data di contestazione immediata
<%} else if ("P".equalsIgnoreCase(Trasgressore.getNotifica().getTipoNotifica())){ %>
Data <%=!Trasgressore.getNotifica().isNotificaAggiornata() ? "<font color=\"red\">presunta</font>" : "" %> di invio PEC
<%} else if ("R".equalsIgnoreCase(Trasgressore.getNotifica().getTipoNotifica())){ %>
Data <%=!Trasgressore.getNotifica().isNotificaAggiornata() ? "<font color=\"red\">presunta</font>" : "" %> di notifica
<%} %>
</b>

<input type="date" <%=(Trasgressore.getNotifica()==null || Trasgressore.getNotifica().getTipoNotifica() == null || "".equals(Trasgressore.getNotifica().getTipoNotifica()) || ("R".equals(Trasgressore.getNotifica().getTipoNotifica())) || ("P".equals(Trasgressore.getNotifica().getTipoNotifica()))) ? "" : "readonly" %> id="dataNotificaT" name="dataNotificaT" onkeydown="return false" value="<%=(Trasgressore.getNotifica()!=null) ? Trasgressore.getNotifica().getDataNotifica() : ""%>"/> <br/>

<dhv:permission name="pagopa_modifica_notifica-view">
<input type="button" style="background: green; font-size: 15px; <%=(Trasgressore.getNotifica()==null || Trasgressore.getNotifica().getTipoNotifica() == null || "".equals(Trasgressore.getNotifica().getTipoNotifica()) || ("R".equals(Trasgressore.getNotifica().getTipoNotifica())) || ("P".equals(Trasgressore.getNotifica().getTipoNotifica()))) ? "; display:block;" : "display:none" %>" id="aggiornaNotificaT" value="AGGIORNA DATA DI NOTIFICA" onClick="aggiornaNotifica('T', this.form)"/>
</dhv:permission>
 
</td>
<td id="tdNotificaO"><% if (Obbligato.getId()>0){ %> 
<input type="checkbox" id="tipoNotificaO_I" name="tipoNotificaO" value="I" <% if (Obbligato.getNotifica()==null || (Obbligato.getNotifica().getTipoNotifica() == null || "".equals(Obbligato.getNotifica().getTipoNotifica()))) { %> onClick="gestisciNotifica('O', this)" <%} else if ("I".equals(Obbligato.getNotifica().getTipoNotifica())) { %> checked onClick="return false" <%} else { %> onClick="return false" <%} %> /> CONTESTAZIONE IMMEDIATA<br/>
<input type="checkbox" id="tipoNotificaO_P" name="tipoNotificaO" value="P" <% if (Obbligato.getNotifica()==null || (Obbligato.getNotifica().getTipoNotifica() == null || "".equals(Obbligato.getNotifica().getTipoNotifica()))) { %> onClick="gestisciNotifica('O', this)" <%} else if ("P".equals(Obbligato.getNotifica().getTipoNotifica())) { %> checked onClick="return false" <%} else { %> onClick="return false" <%} %> /> PEC<br/>
<input type="checkbox" id="tipoNotificaO_R" name="tipoNotificaO" value="R" <% if (Obbligato.getNotifica()==null || (Obbligato.getNotifica().getTipoNotifica() == null || "".equals(Obbligato.getNotifica().getTipoNotifica()))) { %> onClick="gestisciNotifica('O', this)" <%} else if ("R".equals(Obbligato.getNotifica().getTipoNotifica())) { %> checked onClick="return false" <%} else { %> onClick="return false" <%} %> /> RACCOMANDATA A/R oppure consegna a mano<br/>

<b>
<% if ("I".equalsIgnoreCase(Obbligato.getNotifica().getTipoNotifica())){ %>
Data di contestazione immediata
<%} else if ("P".equalsIgnoreCase(Obbligato.getNotifica().getTipoNotifica())){ %>
Data <%=!Obbligato.getNotifica().isNotificaAggiornata() ? "<font color=\"red\">presunta</font>" : "" %> di invio PEC
<%} else if ("R".equalsIgnoreCase(Obbligato.getNotifica().getTipoNotifica())){ %>
Data <%=!Obbligato.getNotifica().isNotificaAggiornata() ? "<font color=\"red\">presunta</font>" : "" %> di notifica
<%} %>
</b> 

<input type="date" <%=(Obbligato.getNotifica()==null || Obbligato.getNotifica().getTipoNotifica() == null || "".equals(Obbligato.getNotifica().getTipoNotifica()) || ("R".equals(Obbligato.getNotifica().getTipoNotifica())) || ("P".equals(Obbligato.getNotifica().getTipoNotifica()))) ? "" : "readonly" %> id="dataNotificaO" name="dataNotificaO" onkeydown="return false" value="<%=(Obbligato.getNotifica()!=null) ? Obbligato.getNotifica().getDataNotifica() : ""%>"/> <br/>

<dhv:permission name="pagopa_modifica_notifica-view">
<input type="button" style="background: green; font-size: 15px; <%=(Obbligato.getNotifica()==null || Obbligato.getNotifica().getTipoNotifica() == null || "".equals(Obbligato.getNotifica().getTipoNotifica()) || ("R".equals(Obbligato.getNotifica().getTipoNotifica()))  || ("P".equals(Obbligato.getNotifica().getTipoNotifica()))) ? "; display:block;" : "display:none" %>" id="aggiornaNotificaO" value="AGGIORNA DATA DI NOTIFICA" onClick="aggiornaNotifica('O', this.form)"/>
</dhv:permission> 
</td>
<%} %>
</tr>

</table>

<br/>

<!-- inizio riepilogo importi -->
<div id="divRiepilogoImporti">
</br>
<table class="details" id = "tableRiepilogoImporti" cellpadding="20" cellspacing="20" style="border-collapse: collapse" width="30%">
<col width="60%">
<tr><th colspan="2" style="background:yellow">RIEPILOGO RAPIDO DEGLI IMPORTI ORDINANZA</th>
<tr><th>Importo totale richiesto</th><td><%=importoTotaleRichiesto %></td></tr>
<tr><th>Importo totale versato</th><td><%=importoTotaleVersato %></td></tr>
<tr><th>Importo totale residuo</th><td><%=importoTotaleResiduo %></td></tr>
</table>
</br>
</div>
<!-- fine riepilogo -->

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

<!-- inizio riepilogo -->
</br>
<table class="details" id = "tabletrasgressione" cellpadding="10" cellspacing="10" style="border-collapse: collapse">
<tr><th colspan="3" style="background:yellow">RIEPILOGO RAPIDO DEGLI AVVISI DI PAGAMENTO <input type="button" value="SCARICA TUTTI" onClick="openRichiestaArchivioAvvisi('<%=SanzioneDettaglio.getId()%>'); return false;"/></th>
<tr><th></th><th><center>Trasgressore</center></th><th><center>Obbligato in solido</center></th></tr>
<%
int maxIndice = -1;
for (int i = 0; i<listaPagamenti.size(); i++){ 
	Pagamento p = (Pagamento) listaPagamenti.get(i);
	if (p.getIndice()>maxIndice)
		maxIndice = p.getIndice();
}	

Pagamento pagamentoCorrente = null;
Pagamento pagamentoGemello = null;

boolean esisteRiga = false;
for (int j = 1; j<=maxIndice; j++) { 
pagamentoCorrente = null;
esisteRiga = false;
%>

<% 
for (int i = 0; i<listaPagamenti.size(); i++){ 
	Pagamento p = (Pagamento) listaPagamenti.get(i);
	if (p.getIndice()== j){
		pagamentoCorrente = p;
		esisteRiga = true;
		break;
	}
} 
%>
<% if (pagamentoCorrente!=null) {%>
<tr><td align="center"><%= pagamentoCorrente.getTipoPagamento().equals("NO") ? "RATA "+ (pagamentoCorrente.getNumeroRate() == 1 ? "UNICA" : pagamentoCorrente.getIndice()) + (pagamentoCorrente.isRigenerato() ? " (RIGENERATA)" : "")  : pagamentoCorrente.getTipoPagamento().equals("PV") && pagamentoCorrente.getTipoRiduzione().equals("U") ? "ULTRARIDOTTO" : pagamentoCorrente.getTipoPagamento().equals("PV") && pagamentoCorrente.getTipoRiduzione().equals("R") ? "RIDOTTO" : "" %>

<% if (doppiPagamenti.contains(j)){ %><div style="border: 1px solid red" align="center"><font color="RED"><b>ATTENZIONE!<br/> RISULTANO DUE PAGAMENTI COMPLETATI SULLA STESSA RATA!</b></font></div><%} %>

</td>
<%} %>

<% if (esisteRiga){
pagamentoCorrente = null;
pagamentoGemello = null;
for (int i = 0; i<listaPagamenti.size(); i++){ 
	Pagamento p = (Pagamento) listaPagamenti.get(i);
	if (p.getIndice()== j && p.getPagatore().getId() == Obbligato.getId()){
		pagamentoGemello = p;
	}
	if (p.getIndice()== j && p.getPagatore().getId() == Trasgressore.getId()){
		pagamentoCorrente = p;
		break;
	}
}
%>
<% if (pagamentoCorrente!=null) {%>
<td align="center"> 

<% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())){ %>
<% 		if (pagamentoCorrente.getHeaderFileRicevuta()!=null && !pagamentoCorrente.getHeaderFileRicevuta().equalsIgnoreCase("")){ %>
			<a href="#" onClick="openRichiestaDownload('<%= pagamentoCorrente.getHeaderFileRicevuta() %>', 'RT_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>', 'true'); return false;"><%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%></a>
<%		} else { %>		
			<a href="#" onClick="openRichiestaPDFRicevutaPagoPa('<%= pagamentoCorrente.getId() %>', '<%=pagamentoCorrente.getIdSanzione() %>', 'RT_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>'); return false;"><%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%></a>
<% 		} %>
<%} else if (pagamentoCorrente.getHeaderFileAvviso()!=null && !pagamentoCorrente.getHeaderFileAvviso().equalsIgnoreCase("")){ %>
		<a href="#" onClick="openRichiestaDownload('<%= pagamentoCorrente.getHeaderFileAvviso() %>', 'AVVISO_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>', 'true'); return false;"><%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%></a>
<% } %>

(<%=pagamentoCorrente.getStatoPagamento() %> <% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %> <img src="images/icons/pallino_verde.JPG" width="10px"/><% } else if (Pagamento.PAGAMENTO_IN_CORSO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %> <img src="images/yellow.png" width="10px"/><% } else if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %> <img src="images/icons/pallino_rosso.JPG" width="10px"/><% } %> )
<br/><br/> 
<a href="#IUV_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>" style="text-decoration: none;">
<% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %><b>Data pagamento</b>: <%=toDateasStringFromString(pagamentoCorrente.getRicevuta().getDataEsitoSingoloPagamento()) %> <% } else { %><b>Data Scadenza</b>: <%=toDateasStringFromString(pagamentoCorrente.getDataScadenza()) %> <% } %>
<br/> <b>Importo singolo versamento</b>: <%=pagamentoCorrente.getImportoSingoloVersamento() %>
</a>

</td>
<%} else { %><td></td><%} %>
<%} %>

<% if (esisteRiga){
pagamentoCorrente = null;
pagamentoGemello = null;
for (int i = 0; i<listaPagamenti.size(); i++){ 
	Pagamento p = (Pagamento) listaPagamenti.get(i);
	if (p.getIndice()== j && p.getPagatore().getId() == Trasgressore.getId()){
		pagamentoGemello = p;
	}
	if (p.getIndice()== j && p.getPagatore().getId() == Obbligato.getId()){
		pagamentoCorrente = p;
		break;
	}
}
%>
<% if (pagamentoCorrente!=null) {%>
<td align="center"> 

<% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())){ %>
<% 		if (pagamentoCorrente.getHeaderFileRicevuta()!=null && !pagamentoCorrente.getHeaderFileRicevuta().equalsIgnoreCase("")){ %>
			<a href="#" onClick="openRichiestaDownload('<%= pagamentoCorrente.getHeaderFileRicevuta() %>', 'RT_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>', 'true'); return false;"><%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%></a>
<%		} else { %>		
			<a href="#" onClick="openRichiestaPDFRicevutaPagoPa('<%= pagamentoCorrente.getId() %>', '<%=pagamentoCorrente.getIdSanzione() %>', 'RT_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>'); return false;"><%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%></a>
<% 		} %>
<%} else if (pagamentoCorrente.getHeaderFileAvviso()!=null && !pagamentoCorrente.getHeaderFileAvviso().equalsIgnoreCase("")){ %>
		<a href="#" onClick="openRichiestaDownload('<%= pagamentoCorrente.getHeaderFileAvviso() %>', 'AVVISO_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>', 'true'); return false;"><%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%></a>
<% } %>

(<%=pagamentoCorrente.getStatoPagamento() %> <% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %> <img src="images/icons/pallino_verde.JPG" width="10px"/><% } else if (Pagamento.PAGAMENTO_IN_CORSO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %> <img src="images/yellow.png" width="10px"/><% } else if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %> <img src="images/icons/pallino_rosso.JPG" width="10px"/><% } %> )
<br/><br/> 
<a href="#IUV_<%=pagamentoCorrente.getIdentificativoUnivocoVersamento()%>" style="text-decoration: none;">
<% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamentoCorrente.getStatoPagamento())) { %><b>Data pagamento</b>: <%=toDateasStringFromString(pagamentoCorrente.getRicevuta().getDataEsitoSingoloPagamento()) %> <% } else { %><b>Data Scadenza</b>: <%=toDateasStringFromString(pagamentoCorrente.getDataScadenza()) %> <% } %>
<br/> <b>Importo singolo versamento</b>: <%=pagamentoCorrente.getImportoSingoloVersamento() %>
</a>

</td>
</tr>
<%} else {%><td></td></tr><%} } }%> 
</table>
</br>
<!-- fine riepilogo -->

<br/>

<table class="details" id = "tabletrasgressione" cellpadding="10" cellspacing="10" style="border-collapse: collapse" width="80%">
<col width="30%">
<% 
boolean almenoUnPagato = false;
boolean almenoUnIuvVuoto = false;
boolean almenoUnIuvProcessoVerbale = false;
boolean almenoUnIuvTrasgressore = false;
boolean almenoUnIuvObbligato = false;

String pagatorePrecedente = "";

for (int i = 0; i<listaPagamenti.size(); i++) { 
Pagamento p = (Pagamento) listaPagamenti.get(i); 

if (p.getStatoPagamento()!=null && (p.getStatoPagamento().equalsIgnoreCase(Pagamento.PAGAMENTO_COMPLETATO) || p.getStatoPagamento().equalsIgnoreCase(Pagamento.PAGAMENTO_IN_CORSO)))
	almenoUnPagato = true;
if (p.getIdentificativoUnivocoVersamento()==null || p.getIdentificativoUnivocoVersamento().equals(""))
	almenoUnIuvVuoto = true;
if (p.getTipoPagamento()!=null && p.getTipoPagamento().equals("PV"))
	almenoUnIuvProcessoVerbale = true;

if (p.getPagatore().getId() == Trasgressore.getId())
	almenoUnIuvTrasgressore = true;
if (p.getPagatore().getId() == Obbligato.getId())
	almenoUnIuvObbligato = true;

%>

<% 
String pagatoreCorrente = (p.getPagatore().getId() == Trasgressore.getId() ? "TRASGRESSORE" : "OBBLIGATO IN SOLIDO");
if (!pagatorePrecedente.equals(pagatoreCorrente) ){ 
pagatorePrecedente = pagatoreCorrente;
%>
<tr><th colspan="2" style="background:lightgrey; font-size:20px; text-align:center;">AVVISI DI PAGAMENTO A CARICO DI: <%=pagatoreCorrente %> </th></tr>
<% } %>

<tr><th colspan="2" id="IUV_<%=p.getIdentificativoUnivocoVersamento()%>">RICHIESTA DI PAGAMENTO #<%=p.getIndice() %> <%=p.isRigenerato() ? " RIGENERATA " : "" %></th></tr>

<tr><th colspan="2" style="background:yellow">INFORMAZIONI SOGGETTO PAGATORE </th></tr>

<tr>
<th>Soggetto pagatore</th> 
<td> <%=p.getPagatore().getRagioneSocialeNominativo() %> (<b><%= (p.getPagatore().getId() == Trasgressore.getId() ? "TRASGRESSORE" : "OBBLIGATO IN SOLIDO") %></b>) </td>
</tr>

<tr><th colspan="2" style="background:yellow">INFORMAZIONI VERSAMENTO </th></tr>
<tr><th>Tipo pagamento</th> <td><input disabled type="radio" id="tipoPagamentoPV_<%=p.getId() %>" name="tipoPagamento_<%=p.getId() %>" value="PV" <%=p.getTipoPagamento().equals("PV") ? "checked" : "" %>/> Per Processo Verbale <input disabled type="radio" id="tipoPagamentoNO_<%=p.getId() %>" name="tipoPagamento_<%=p.getId() %>" value="NO" <%=p.getTipoPagamento().equals("NO") ? "checked" : "" %>/> Per Numero Ordinanza</td>
<tr <%= (p.getTipoRiduzione()==null || p.getTipoRiduzione().equals("")) ? "style=\"display:none\"" : "" %>><th>Tipo riduzione</th> <td><%= ("R").equalsIgnoreCase(p.getTipoRiduzione()) ? "RIDOTTO" :  ("U").equalsIgnoreCase(p.getTipoRiduzione()) ? "ULTRARIDOTTO" : "" %></td>
<tr><th>Data scadenza pagamento</th> <td><input type="date" readonly id="dataScadenza_<%=p.getId() %>" name="dataScadenza_<%=p.getId() %>" value="<%=p.getDataScadenza() %>" onkeydown="return false"/> 

<%-- <% if (p.getIdentificativoUnivocoVersamento()!=null && Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento()) && p.getTipoPagamento().equals("NO") && p.getNumeroRate() == 1 && p.isRigenerato()) { %> <dhv:permission name="pagopa_rigenera-view"> <script>document.getElementById("dataScadenza_<%=p.getId() %>").readOnly=false;</script> <input type="button" value="AGGIORNA DATA DI SCADENZA"  onClick="aggiorna('<%= p.getId()%>', this.form)"/ > </dhv:permission> <% } %> --%>

<% if (p.getIdentificativoUnivocoVersamento()!=null && Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento()) && p.getTipoPagamento().equals("NO") && p.getNumeroRate() == 1 && p.isRigenerato()) { 

	String dataNotificaTemp = "";
	try {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    java.util.Date parsedDate = dateFormat.parse(p.getDataScadenza());
	    Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
	    Calendar cal = Calendar.getInstance();
	    cal.setTimeInMillis(timestamp.getTime());
	    cal.add(Calendar.DAY_OF_MONTH, -30);
	    dataNotificaTemp = String.valueOf(dateFormat.format(cal.getTime().getTime()));
	} catch(Exception e) { //this generic but you can control another types of exception
	    // look the origin of excption 
	}	
	
%> 
<dhv:permission name="pagopa_rigenera-view"> 
<br/><br/>
<b>Data Notifica:</b> <input type="date" id="dataNotificaRigenerata_<%=p.getId() %>" name="dataNotificaRigenerata_<%=p.getId() %>" onkeydown="return false" value="<%=dataNotificaTemp%>"/> <input type="button" value="AGGIORNA DATA DI NOTIFICA"  onClick="aggiornaNotificaRigenerata('<%= p.getId()%>', this.form)"/ > 
<script>
document.getElementById("dataNotificaRigenerata_<%=p.getId() %>").setAttribute("min", today);
</script>
</dhv:permission> 
<% } %>

</td></tr>

<tr><th>Importo totale versamento</th> <td><input disabled type="text" id="importoSingoloVersamento_<%=p.getId() %>" name="importoSingoloVersamento_<%=p.getId() %>" value="<%=p.getImportoSingoloVersamento() %>"/></td></tr>

<tr><th>Identificativo Univoco Dovuto (IUD) GISA</th> <td><%=p.getIdentificativoUnivocoDovuto() %></td></tr>
<tr><th>Identificativo Univoco Versamento (IUV) PagoPa</th> <td><%=toHtml(p.getIdentificativoUnivocoVersamento()) %></td></tr>
<tr><th>Data generazione IUV</th> <td><%=toDateasString(p.getDataGenerazioneIuv()) %> <input type="hidden" name="dataGenerazioneIuv" value="<%=p.getDataGenerazioneIuv()%>"/></td></tr>
<tr><th>Codice Avviso PagoPa</th> <td><%=toHtml(p.getCodiceAvviso()) %></td></tr>

<tr><th>Avviso PagoPa</th> <td>

<% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())){ %>
<% 		if (p.getHeaderFileRicevuta()!=null && !p.getHeaderFileRicevuta().equalsIgnoreCase("")){ %>
			<a href="#" onClick="openRichiestaDownload('<%= p.getHeaderFileRicevuta() %>', 'RT_<%=p.getIdentificativoUnivocoVersamento()%>', 'true'); return false;">Stampa Ricevuta di Pagamento</a>
<%		} else { %>		
			<a href="#" onClick="openRichiestaPDFRicevutaPagoPa('<%= p.getId() %>', '<%=p.getIdSanzione() %>', 'RT_<%=p.getIdentificativoUnivocoVersamento()%>'); return false;">Stampa Ricevuta di Pagamento</a>
<% 		} %>
<%} else if (p.getHeaderFileAvviso()!=null && !p.getHeaderFileAvviso().equalsIgnoreCase("")){ %>
		<a href="#" onClick="openRichiestaDownload('<%= p.getHeaderFileAvviso() %>', 'AVVISO_<%=p.getIdentificativoUnivocoVersamento()%>', 'true'); return false;">Stampa Avviso di Pagamento</a>
<% } %>

</td></tr>

<tr><th>Stato pagamento PagoPa</th> 
<td>

<% if (!p.isAggiornatoConPagoPa()) { %><div style="background:red; display:none">ATTENZIONE. DATO NON ALLINEATO CON PAGOPA. IL SERVIZIO POTREBBE ESSERE NON RAGGIUNGIBILE O AVER IMPIEGATO TROPPO TEMPO PER LA RISPOSTA.</div><br/><%} %>

<%=toHtml(p.getStatoPagamento()) %> 

<% if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())) { %> <img src="images/icons/pallino_verde.JPG" width="10px"/><% } %> 
<% if (Pagamento.PAGAMENTO_IN_CORSO.equalsIgnoreCase(p.getStatoPagamento())) { %> <img src="images/yellow.png" width="10px"/><% } %> 
<% if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento())) { %> <img src="images/icons/pallino_rosso.JPG" width="10px"/><% } %> 

<%-- <%if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())) { %><br/> --%>
<%-- <b>Identificativo univoco riscossione: </b> <%=p.getRicevuta().getIdentificativoUnivocoRiscossione() %> <br/> --%>
<%-- <b>Denoninazione beneficiario: </b> <%=p.getRicevuta().getDenominazioneBeneficiario() %> <br/> --%>
<%-- <b>Denoninazione attestante: </b> <%=p.getRicevuta().getDenominazioneAttestante() %> <br/> --%>
<%-- <b>Esito singolo pagamento: </b> <%=p.getRicevuta().getEsitoSingoloPagamento() %> <br/> --%>
<%-- <b>Importo erogato: </b> <%=p.getRicevuta().getSingoloImportoPagato() %> <br/> --%>
<%-- <b>Data pagamento: </b> <%=p.getRicevuta().getDataEsitoSingoloPagamento()  %> <br/> --%>
<%-- <b>Data scadenza pagamento: </b> <%=p.getDataScadenza()  %>  --%>
<%--  <%} %> --%>
</td></tr>

<% if (p.getStatoPagamento()==null || !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())) { %>
<tr><th>Esito ultima interazione PagoPa</th>

<td style="background: <%= p.getEsitoInvio().equalsIgnoreCase("OK") ? "lime" : (p.getEsitoInvio().equalsIgnoreCase("KO")) ? "lightpink" : "" %>">
<% if (p.getEsitoInvio().equalsIgnoreCase("OK")) { %> <b>OK!</b> <% }  else if (p.getEsitoInvio().equalsIgnoreCase("KO"))  {%> <b>KO! <div id="errore<%=p.getId() %>" style="display:none"> <a href="#" onClick="document.getElementById('errore<%=p.getId() %>').style.display='none'; return false;">Nascondi Errore</a>  <xmp><%=p.getDescrizioneErrore()%></xmp></div> <a href="#" onClick="document.getElementById('errore<%=p.getId() %>').style.display='block'; return false;">Vedi Errore</a></b>  <% } %>
<br/>(<dhv:username id="<%= p.getInviatoBy() %>" /> <%=toDateWithTimeasString(p.getDataInvio()) %>)</td>
</tr>

<tr><th>Operazioni</th> <td colspan="2">
<% if (p.getIdentificativoUnivocoVersamento()!=null && (p.getStatoPagamento()==null || !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento()))) { %> <input type="button" style="font-size: 15px;" value="VERIFICA STATO AVVISO DI PAGAMENTO" onClick="verifica('<%=p.getId()%>', this.form)"/> <br/> <font color="green">Mediante questa funzione, sarà verificato lo stato del pagamento in PagoPA e sarà eventualmente aggiornato in GISA alla voce "Stato Pagamento PagoPa".</font> <%} %>

<dhv:permission name="pagopa_annulla_singolo-view">
<% if (p.getIdentificativoUnivocoVersamento()!=null && (p.getStatoPagamento()!=null || Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento()))) { %>  <br/><br/>  <input type="button" style="font-size: 15px; background-color: red" value="ANNULLA AVVISO DI PAGAMENTO" onClick="annulla('<%=p.getId()%>', this.form)"/> <br/> <font color="red">Mediante questa funzione, sarà annullato in PagoPA ed eliminato da GISA questo singolo avviso di pagamento.<br/> USARE SOLO IN CASO DI DATI SPORCHI.</font><%} %>
</dhv:permission>
 
<dhv:permission name="pagopa_elimina_singolo-view">
<% if (p.getIdentificativoUnivocoVersamento()==null || (p.getStatoPagamento()==null || (!Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento()) && !Pagamento.PAGAMENTO_IN_CORSO.equalsIgnoreCase(p.getStatoPagamento()) && !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento()))) || (p.getDescrizioneErrore() != null && p.getDescrizioneErrore().contains("Dovuto non presente o in pagamento nel database"))) { %>  <br/><br/>  <input type="button" style="font-size: 15px; background-color: purple" value="ELIMINA AVVISO DI PAGAMENTO" onClick="elimina('<%=p.getId()%>', this.form)"/> <br/> <font color="red">Mediante questa funzione, sarà eliminato da GISA questo singolo avviso di pagamento.<br/> USARE SOLO IN CASO DI DATI SPORCHI.</font><%} %>
</dhv:permission>

<dhv:permission name="pagopa_paga_singolo-view">
<% if (p.getIdentificativoUnivocoVersamento()!=null && (p.getStatoPagamento()!=null && !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento()))) { %>  <br/><br/>  <input type="button" style="font-size: 15px; background-color: orange" value="TEST - PAGA AVVISO DI PAGAMENTO" onClick="testPaga('<%=p.getId()%>', this.form)"/> <br/> <font color="red">Mediante questa funzione, sarà simulato (esclusivamente lato GISA) il pagamento di questo avviso.<br/> USARE SOLO IN FASE DI COLLAUDO.</font><%} %>
</dhv:permission>

<dhv:permission name="pagopa_scadi_singolo-view">
<% if (p.getIdentificativoUnivocoVersamento()!=null && (p.getStatoPagamento()!=null && !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento()))) { %>  <br/><br/>  <input type="button" style="font-size: 15px; background-color: purple" value="TEST - FA SCADERE AVVISO DI PAGAMENTO" onClick="testScadi('<%=p.getId()%>', this.form)"/> <br/> <font color="red">Mediante questa funzione, sarà simulata (esclusivamente lato GISA) la scadenza di questo avviso.<br/> USARE SOLO IN FASE DI COLLAUDO.</font><%} %>
</dhv:permission>

</td></tr>
<%} %>

<tr><td colspan="4"></td></tr>

<% } %>


</table>

<input type="hidden" id="idSanzione" name="idSanzione" value="<%=SanzioneDettaglio.getId()%>"/>
<input type="hidden" id="idPagamento" name="idPagamento" value=""/>
<input type="hidden" id="origine" name="origine" value="NumeroOrdinanza"/>
<input type="hidden" id="tipoPagamento" name="tipoPagamento" value="NO"/>
<input type="hidden" id="idPagatoreT" name="idPagatoreT" value="<%=Trasgressore.getId()%>"/>
<input type="hidden" id="idPagatoreO" name="idPagatoreO" value="<%=Obbligato.getId()%>"/>
<input type="hidden" id="dataCu" name="dataCu" value="<%=toDateasStringWithFormat(SanzioneDettaglio.getDataFineControllo()!=null ? SanzioneDettaglio.getDataFineControllo() : SanzioneDettaglio.getAssignedDate(), "yyyy-MM-dd")%>"/>

</form>

<script>
nascondiFunzioni('<%=almenoUnPagato%>', '<%=almenoUnIuvVuoto%>',  '<%=almenoUnIuvProcessoVerbale%>', '<%=almenoUnIuvTrasgressore%>', '<%=almenoUnIuvObbligato%>');
</script>



