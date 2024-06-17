<jsp:useBean id="listaFlussi" class="org.aspcfs.modules.devdoc.base.FlussoList" scope="request" />
<jsp:useBean id="idModulo" class="java.lang.String" scope="request" />
<jsp:useBean id="idFlusso" class="java.lang.String" scope="request" />
<jsp:useBean id="listaTipiModulo" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="Errore" class="java.lang.String" scope="request" />
<jsp:useBean id="listaTipiPriorita" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="listaReferenti" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="listaStati" class="org.aspcfs.utils.web.LookupList" scope="request" />

<%@page import="org.aspcfs.modules.devdoc.base.Modulo"%>
<%@page import="org.aspcfs.modules.devdoc.base.ModuloList"%>
<%@page import="org.aspcfs.modules.devdoc.base.FlussoList"%>
<%@page import="org.aspcfs.modules.devdoc.base.Flusso"%>
<%@page import="java.util.regex.*"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	
	$(document).ready(function(){
		
		calenda('data-sviluppo','','');
		calenda('data-collaudo','','');

	});
</SCRIPT>

<%@ include file="../../utils23/initPage.jsp"%>

<!-- fontawesome css -->
<link href="icons/fontawesome-free/css/all.css" rel="stylesheet">
<!-- filter css -->
<link href="devdoc/utils/filter/filter.css" rel="stylesheet">


<script>
	function checkFormNoteFlusso(event) {
		event.stopPropagation()
		event.preventDefault()
		let nota = document.getElementById("nuova-nota")
		nota.value = nota.value.trim()
		if(nota.value == "")
			alert("Attenzione! L'inserimento di una nota vuota non � consentito.")
		else {
			loadModalWindow()
			document.getElementById("form-aggiungi-nota").submit()
		}
			
	}
</script>


<style>
.visualizza {
	background-color: #b2ffb2;
}

.aggiungi {
	background-color: #fddcd3;
}

.nondisponibile {
	background-color: #D3D3D3;
}

.row_<%=Flusso.STATO_CONSEGNATO%> {
	background-color: #ddffdd;
}

.row_<%=Flusso.STATO_STANDBY%> {
	background-color: #ffff7f;
}

.row_<%=Flusso.STATO_APERTO%> {
	background-color: #ffffff;
}

.row_<%=Flusso.STATO_ANNULLATO%> {
	background-color: #ffb2b2;
}

.row_<%=Flusso.STATO_COLLAUDATO%> {
	background-color: #b2b2ff;
}

.row_<%=Flusso.STATO_CHIARIMENTI%> {
	background-color: #a5d9fd;
}
</style>


</style>
<%!public static String zeroPad(int id) {
		String toRet = String.valueOf(id);
		while (toRet.length() < 3)
			toRet = "0" + toRet;
		return toRet;

	}

	public String getFirst10Words(String arg) {
		Pattern pattern = Pattern.compile("([\\S]+\\s*){1,10}");
		Matcher matcher = pattern.matcher(arg);
		matcher.find();
		return matcher.group();
	}%>

<script>
function sleep(milliseconds) {
	  var start = new Date().getTime();
	  for (var i = 0; i < 1e7; i++) {
	    if ((new Date().getTime() - start) > milliseconds){
	      break;
	    }
	  }
	}
	
function aggiungiCampoNote(idUtente){
	var aggiungi = document.getElementById("aggiungiNote"+idUtente);
	var tr = document.getElementById("trAggiungiNote"+idUtente);
	aggiungi.style.display = "none";
	tr.style.display = "table-row"; 
}

function modificaCampoNote(idUtente){
	var input = document.getElementById("note"+idUtente);
	var modifica = document.getElementById("modifica"+idUtente);
	var salva = document.getElementById("salva"+idUtente);
	input.readOnly  = false;
	input.className="scrittura";
	modifica.style.display = "none";
	salva.style.display = "block";
}


function salvaCampoNote(form, idUtente){
	var salva = document.getElementById("salva"+idUtente);
	salva.style.display="none";
	document.getElementById("idUtente").value = idUtente;
	loadModalWindow();
	form.submit();
}

function modificaCampoNote(idUtente){
	var input = document.getElementById("note"+idUtente);
	var modifica = document.getElementById("modifica"+idUtente);
	var salva = document.getElementById("salva"+idUtente);
	input.readOnly  = false;
	input.className="scrittura";
	modifica.style.display = "none";
	salva.style.display = "block";
}

function aggiungi(tipo){
	document.getElementById("idTipo").value = tipo;
	switch(tipo) {
		case 1: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(1)%>"; break;
		case 2: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(2)%>"; break;
		case 3: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(3)%>"; break;
		case 4: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(4)%>"; break;
		case 5: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(5)%>"; break;
		case 6: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(6)%>"; break;
		case 7: document.getElementById("idTipoLabel").innerHTML = "<%=listaTipiModulo.getSelectedValue(7)%>"; break;
		default: break;
	}
	
	document.getElementById("tr-checkbox").hidden = tipo == 6 || tipo == 7 ? true : false; //nascondi 'Invio Mail' se il modulo � VCE o AL

	document.getElementById("bottoniAggiungi").style.display="none";
	document.getElementById("nuovo").style.display="block"; 
	
	if(tipo==1){
		document.getElementById("ambito-gisa").removeAttribute("disabled")
				document.getElementById("ambito-gisa1").removeAttribute("disabled")

		document.getElementById("ambito").removeAttribute("hidden")

	}else{
		document.getElementById("ambito-gisa").setAttribute("disabled","")
				document.getElementById("ambito-gisa1").setAttribute("disabled","")

		document.getElementById("ambito").setAttribute("hidden","")

	}
	
	if(tipo==2){
		document.getElementById("giornate").removeAttribute("hidden")
		document.getElementById("giornate2").removeAttribute("hidden")
		document.getElementById("data").removeAttribute("hidden")
		document.getElementById("data2").removeAttribute("hidden")
		
		document.getElementById("giornate-elapsed").removeAttribute("disabled")
		document.getElementById("giornate-effort").removeAttribute("disabled")
		document.getElementById("data-sviluppo").removeAttribute("disabled")
		document.getElementById("data-collaudo").removeAttribute("disabled")
			document.getElementById("label1-sviluppo").removeAttribute("hidden")
			document.getElementById("label1-collaudo").removeAttribute("hidden")
			document.getElementById("label2-sviluppo").setAttribute("hidden","")
			document.getElementById("label2-collaudo").setAttribute("hidden","")

	}else{
		if(tipo==3){
			document.getElementById("data").removeAttribute("hidden")
			document.getElementById("data2").removeAttribute("hidden")
			document.getElementById("data-sviluppo").removeAttribute("disabled")
			document.getElementById("data-collaudo").removeAttribute("disabled")

			document.getElementById("giornate").setAttribute("hidden","")
			document.getElementById("giornate2").setAttribute("hidden","")
			document.getElementById("giornate-elapsed").setAttribute("disabled","")
			document.getElementById("giornate-effort").setAttribute("disabled","")
			document.getElementById("label2-sviluppo").removeAttribute("hidden")
			document.getElementById("label2-collaudo").removeAttribute("hidden")

		}else{
			
			document.getElementById("giornate").setAttribute("hidden","")
			document.getElementById("giornate2").setAttribute("hidden","")
			document.getElementById("data").setAttribute("hidden","")
			document.getElementById("data2").setAttribute("hidden","")
			
			document.getElementById("giornate-elapsed").setAttribute("disabled","")
			document.getElementById("giornate-effort").setAttribute("disabled","")
			document.getElementById("data-sviluppo").setAttribute("disabled","")
			document.getElementById("data-collaudo").setAttribute("disabled","")
		
		}
		document.getElementById("label1-sviluppo").setAttribute("hidden","")
		document.getElementById("label1-collaudo").setAttribute("hidden","")
	} 
		
	
	
	
	
}

function aggiungiConFlusso(tipo, idFlusso){
	aggiungi(tipo);
	document.getElementById("idFlusso").value=idFlusso;
	switch(tipo) {
		case 1: document.getElementById("tipoModulo").value = 'B'; break;
		case 2: document.getElementById("tipoModulo").value = 'C'; break;
		case 3: document.getElementById("tipoModulo").value = 'D'; break;
		case 4: document.getElementById("tipoModulo").value = 'CH'; break;
		case 5: document.getElementById("tipoModulo").value = 'A'; break;
		case 6: document.getElementById("tipoModulo").value = 'VCE'; break;
		case 7: document.getElementById("tipoModulo").value = 'AL'; break;
		default: break;
	}
	document.getElementById("aggiuntaDaFlusso").value='SI';
	recuperaFlusso();
	document.getElementById("file1").value = null;
}

function chiudi(){
	document.getElementById("nuovo").style.display="none";
	document.getElementById("bottoniAggiungi").style.display="table-row"; 
	
	document.getElementById("descrizione").value="";
	document.getElementById("descrizione").readOnly=false;
	document.getElementById("descrizione").style.background="";
	document.getElementById("tags").value="";

	document.getElementById("aggiuntaDaFlusso").value='';
	document.getElementById("idFlusso").value='';
	document.getElementById("tipoEstensione").value='';
	document.getElementById("tipoModulo").value='';
	
	document.getElementById("idReferente").value="-1";
	document.getElementById("idReferente").disabled=false;

	rimuoviFile(1);
}
function checkForm(form){

	
	
	if (document.getElementById("file1").value==''){
		alert('Allegare un file.');
		return false;
	}
	
	if (document.getElementById("descrizione").value.trim()==''){
		alert('Inserire una descrizione.');
		return false;
	}
	
	if (document.getElementById("tags").value.trim()==''){
		alert('Inserire i tag.');
		return false;
	}
	
	if (!document.getElementById("giornate-effort").disabled){
		if(document.getElementById("giornate-effort").value=='')
		{alert('Inserire giornate effort');
		return false;}
	}
	
	if (!document.getElementById("giornate-elapsed").disabled){
		if(document.getElementById("giornate-elapsed").value=='')
		{alert('Inserire giornate elapsed');
		return false;}
	}
	
	if (!document.getElementById("data-sviluppo").disabled){
		if(document.getElementById("data-sviluppo").value=='')
		{alert('Inserire data inizio sviluppo');
		return false;}
	}
	
	if (!document.getElementById("data-collaudo").disabled){
		if(document.getElementById("data-collaudo").value=='')
		{alert('Inserire data previsto collaudo');
		return false;}
	}
	
	if(document.getElementById("ambito-gisa1").checked==true)
		document.getElementById("ambito-gisa").value=true
		
		if(document.getElementById("ambito-gisa1").checked == false)
			document.getElementById("ambito-gisa").value=false
	
	loadModalWindow();
	form.action="GestioneFlussoSviluppo.do?command=Insert";
	form.submit();
}

function apriDettaglioModulo(idModulo)
{
	resetScadenza();
	loadModalWindow();
		
		$.ajax({
	    	type: 'POST',
	   		dataType: "html",
	   		cache: false,
	  		url: 'GestioneFlussoSviluppo.do?command=DettaglioModulo&popup=true',
	        data: { "id": idModulo} , 
	    	success: function(msg) {
	    		loadModalWindowUnlock();
	       		document.getElementById('dettaglioModulo').innerHTML=msg ; 
	       		$('#dettaglioModulo').dialog('open');
	   		},
	   		error: function (err, errore) {
	   			alert('ko '+errore);
	        }
			});
	
}


$(function () {
	$( "#dettaglioModulo" ).dialog({
		autoOpen: false,
	    resizable: false,
	    closeOnEscape: true,
	   	title:"DETTAGLIO MODULO <input type=\"button\" value=\"CHIUDI\" onclick=\"javascript:$('#dettaglioModulo').dialog('close');\" />",
	    width:950,
	    height:750,
	    draggable: false,
	    modal: true
	   
	}).prev(".ui-dialog-titlebar");
	});
$(".ui-widget-overlay").live("click", function() {  $("#dettaglioModulo").dialog("close"); } );	

//dettaglio flusso


function apriDettaglioFlusso(idFlusso)
{

	loadModalWindow();
		
		$.ajax({
	    	type: 'POST',
	   		dataType: "html",
	   		cache: false,
	  		url: 'GestioneFlussoSviluppo.do?command=DettaglioFlusso&popup=true',
	        data: { "id": idFlusso} , 
	    	success: function(msg) {
	    		loadModalWindowUnlock();
	       		document.getElementById('dettaglioFlusso').innerHTML=msg ; 
	       		$('#dettaglioFlusso').dialog('open');
	   		},
	   		error: function (err, errore) {
	   			alert('ko '+errore);
	        }
			});
	
}


$(function () {
	$( "#dettaglioFlusso" ).dialog({
		autoOpen: false,
	    resizable: false,
	    closeOnEscape: true,
	   	title:"DETTAGLIO RICHIESTA <input type=\"button\" value=\"CHIUDI\" onclick=\"javascript:$('#dettaglioFlusso').dialog('close');\" />",
	    width:950,
	    height:750,
	    draggable: false,
	    modal: true
	   
	}).prev(".ui-dialog-titlebar");
	});
$(".ui-widget-overlay").live("click", function() {  $("#dettaglioFlusso").dialog("close"); } );	


</script>

<script type="text/javascript" src="dwr/interface/DwrFlussoSviluppo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<script>
function recuperaFlusso()
{
	var idFlusso = document.getElementById("idFlusso").value;
	if (idFlusso!='')
		DwrFlussoSviluppo.recuperaFlusso(idFlusso,{callback:recuperaFlussoCallBack,async:false});
	
}
function recuperaFlussoCallBack(val)
{
	var id = val[0];
	var desc = val[1];
	var tags = val[2];
	var ref = val[3];

	if (id!=null && id!=''){
			document.getElementById("descrizione").value=val[1];
			document.getElementById("descrizione").readOnly=true;
			document.getElementById("descrizione").style.background="grey";
			document.getElementById("tags").value=val[2];
			document.getElementById("idReferente").value=val[3];
			document.getElementById("idReferente").disabled=true;
	}
	else {
		document.getElementById("descrizione").readOnly=false;
		document.getElementById("descrizione").style.background="";
		document.getElementById("idReferente").disabled=false;
	}
			
	}


function nonPresenzaModulo(idTipo, idFlusso)
{ 
	if (confirm('Sei sicuro di voler segnare il modulo come NON DISPONIBILE?')){
		DwrFlussoSviluppo.nonPresenzaModulo(idFlusso, idTipo,{callback:nonPresenzaModuloCallBack,async:false});
	}
}
function nonPresenzaModuloCallBack(val)
{
	loadModalWindow();
	window.location.href="GestioneFlussoSviluppo.do?command=Dashboard";
}

function openPopupScadenzario(){
	  window.open('GestioneFlussoSviluppo.do?command=Scadenzario','popupSelect',
      'height=400px,width=500px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>



	<form method="post" action="" enctype="multipart/form-data"
		onSubmit="loadModalWindow()" acceptcharset="UTF-8">
		<center>
		<table>
			<tr id="bottoniAggiungi">
					<dhv:permission name="devdoc-mod-a-add">
						<td>
							<input class="yellowBigButton" id="buttonA" type="button"
								value="AGGIUNGI MODULO A" onClick="aggiungi(5)">
						</td>
					</dhv:permission>
					<dhv:permission name="devdoc-mod-b-add">
						<td>
							<input class="yellowBigButton" id="buttonB" type="button"
								value="AGGIUNGI MODULO B" onClick="aggiungi(1)">
						</td>
					</dhv:permission>
<%-- 					<dhv:permission name="devdoc-mod-ch-add"> --%>
<!-- 						<td> -->
<!-- 							<input class="yellowBigButton" id="buttonCH" type="button" -->
<!-- 								value="AGGIUNGI MODULO CH" onClick="aggiungi(4)"> -->
<!-- 						</td> -->
<%-- 					</dhv:permission> --%>
<%-- 					<dhv:permission name="devdoc-mod-c-add"> --%>
<!-- 						<td> -->
<!-- 							<input class="yellowBigButton" id="buttonC" type="button" -->
<!-- 								value="AGGIUNGI MODULO C" onClick="aggiungi(2)"> -->
<!-- 						</td> -->
<%-- 					</dhv:permission> --%>
<%-- 					<dhv:permission name="devdoc-mod-d-add"> --%>
<!-- 						<td> -->
<!-- 							<input class="yellowBigButton" id="buttonD" type="button" -->
<!-- 								value="AGGIUNGI MODULO D" onClick="aggiungi(3)"> -->
<!-- 						</td> -->
<%-- 					</dhv:permission> --%>
				</tr>
				<tr>
					<td colspan="3">

						<table id="nuovo" style="display: none; border: 1px solid;" cellpadding="4">
							<tr>
								<td>Modulo</td>
								<td><b><label id="idTipoLabel"></label></b></td>
							</tr>
							<tr>
								<td>Descrizione</td>
								<td><textarea cols="100" rows="3" id="descrizione"
										name="descrizione"></textarea></td>
							</tr>
							<tr>
								<td>Tags</td>
								<td><textarea cols="100" rows="3" id="tags" name="tags"></textarea></td>
							</tr>
							<tr>
								<td>Referente</td>
								<td><%=listaReferenti.getHtmlSelect("idReferente", -1) %></td>
							</tr>
							
								<tr id="ambito">
								<td>Ambito GISA</td>
								<td>
								<input type='hidden' id="ambito-gisa" name="ambito-gisa" value='true'>
								<input type="checkbox" id="ambito-gisa1" name="ambito-gisa1" checked>
								</td>
							</tr>
							
							
							<tr id="giornate">
								<td>Giornate stimate (Effort)</td>
								<td>
								<input type="number" id="giornate-effort" name="giornate-effort">
								</td>
							</tr>
							
							<tr id="giornate2">
								<td>Giornate stimate (Elapsed)</td>
								<td>
								<input type="number" id="giornate-elapsed" name="giornate-elapsed" >
								</td>
							</tr>
							
							
							<tr id="data">
								<td id="label1-sviluppo">Data Presunta Inizio Sviluppo</td>
								<td id="label2-sviluppo">Data Inizio Sviluppo</td>
								<td>
								<input class="date_picker" type="text" name="data-sviluppo" id="data-sviluppo" size="15"
								nomecampo="data-sviluppo" tipocontrollo="" labelcampo="data-sviluppo" placeholder="" />
								</td>
							</tr>
							
							<tr id="data2">
								<td id="label1-collaudo">Data Presunta Collaudo</td>
								<td id="label2-collaudo">Data Previsto Collaudo</td>
								<td>
								<input class="date_picker" type="text" name="data-collaudo" id="data-collaudo" size="15"
								nomecampo="data-collaudo" tipocontrollo="" labelcampo="data-collaudo" placeholder="" />
								</td>
							</tr>
							
							
							
							
							<tr>
								<td colspan="2"><%@ include file="allegaFile.jsp"%></td>
							</tr>
							<tr id="tr-checkbox">
								<td>						
									<input type="checkbox" id="flag-invio-mail" name="flag-invio-mail" value="checked" checked>
									<label for="flag-invio-mail">Invio notifica via mail</label>
								</td>
							</tr>
							<tr>
								<td align="left"><input type="button" value="ANNULLA"
									onClick="chiudi();return false"></td>
								<td align="right"><input type="button" value="INSERISCI"
									onClick="checkForm(this.form)"></td>
							</tr>
							
							<input type="hidden" id="idTipo" name="idTipo" value="" />
							<input type="hidden" id="aggiuntaDaFlusso"
								name="aggiuntaDaFlusso" value="" />

						</table>
					</td>
				</tr>	
		</table>
		</center>
	</form>
	<br>

<!-- <div align="right"> -->
<!-- 	<a href="#" onClick="openPopupScadenzario()">Scadenzario</a> -->
<!-- </div> -->

<table class="details" width="100%" cellpadding="4" id="tabellaFlussi">

<thead>
	<tr>
		<th style="position: sticky; top: 0">Anno</th>
		<th style="position: sticky; top: 0">ID</th>
		<th style="position: sticky; top: 0">Richiesta</th>
		<th style="position: sticky; top: 0">Referente</th>
		<th style="position: sticky; top: 0">Ambito</th>
		<th style="position: sticky; top: 0">Priorita'</th>
		<th style="position: sticky; top: 0">Stato</th>
		<dhv:permission name="devdoc-mod-a-view">
			<th style="position: sticky; top: 0">Modulo A</th>
		</dhv:permission>
		<dhv:permission name="devdoc-mod-b-view">
			<th style="position: sticky; top: 0">Modulo B</th>
		</dhv:permission>
		<dhv:permission name="devdoc-mod-ch-view">
			<th style="position: sticky; top: 0">Modulo CH</th>
		</dhv:permission>
		<dhv:permission name="devdoc-mod-c-view">
			<th style="position: sticky; top: 0">Modulo C</th>
		</dhv:permission>
		<dhv:permission name="devdoc-mod-d-view">
			<th style="position: sticky; top: 0">Modulo D</th>
		</dhv:permission>
		<dhv:permission name="devdoc-mod-vce-view">
			<th style="position: sticky; top: 0">Modulo VCE</th>
		</dhv:permission>
		<th style="position: sticky; top: 0">Altri Allegati</th>
		<th style="position: sticky; top: 0">Tempistiche Sviluppo</th>
		<th style="position: sticky; top: 0">Ultima modifica</th>
		<th style="position: sticky; top: 0">Operazioni</th>
	</tr>
</thead>

	<%
		for (int i = 0; i < listaFlussi.size(); i++) {
			Flusso flusso = (Flusso) listaFlussi.get(i);
			ModuloList listaModuli = flusso.getModuli();
			Modulo modA = null;
			Modulo modB = null;
			Modulo modCH = null;
			Modulo modC = null;
			Modulo modD = null;
			Modulo modVCE = null;
			Modulo modAL = null;

			for (int k = 0; k < listaModuli.size(); k++) {
				Modulo mod = (Modulo) listaModuli.get(k);
				switch (mod.getIdTipo()) {
					case 1 :
						modB = mod; break;
					case 2 :
						modC = mod; break;
					case 3 :
						modD = mod; break;
					case 4 :
						modCH = mod; break;
					case 5 :
						modA = mod; break;
					case 6 :
						modVCE = mod; break;
					case 7 :
						modAL = mod; break;
					default : break;
				}
			}
%>

	<tr class="row_<%=flusso.getIdStato()%>">
		<td><%=flusso.getData().getYear() + 1900%></td>
		<td> <%=zeroPad(flusso.getIdFlusso())%> </td>
		<td>
		<a href="#" onClick="apriDettaglioFlusso('<%=flusso.getIdFlusso()%>'); return false;"><%=getFirst10Words(flusso.getDescrizione())%></a>
		</td>
		<td><%=listaReferenti.getSelectedValue(flusso.getIdReferente())%>
		<td><%=flusso.getAmbito()%></td>
		<td><%=listaTipiPriorita.getSelectedValue(flusso.getIdPriorita())%>
		</td>

		<td>
			<%= listaStati.getSelectedValue(flusso.getIdStato()) %>
			
		</td>
	<dhv:permission name="devdoc-mod-a-view">
		<td>
			<%
				if (modA != null) {
			%> <%
 	if (!modA.isNonDisponibile()) {
 %> 
 		<a href="#" onClick="apriDettaglioModulo('<%=modA.getId()%>'); return false;">
 			<span class="visualizza">Visualizza</span>
 		</a> 
 <%
 	} else {
 %> <i>NON DISPONIBILE</i> <%
 	}
 %> <%
 	} else if (flusso.getIdStato() != Flusso.STATO_CONSEGNATO && flusso.getIdStato() != Flusso.STATO_COLLAUDATO) {
 %> <dhv:permission name="devdoc-mod-a-add">
		<a href="#" onClick="aggiungiConFlusso(5, '<%=flusso.getIdFlusso()%>')">
			<span class="aggiungi">Aggiungi</span>
		</a>
	</dhv:permission>
	<dhv:permission name="devdoc-edit">
		<br />
<%-- 		<a href="#" onClick="nonPresenzaModulo(5, '<%=flusso.getIdFlusso()%>')"> --%>
<!-- 			<span class="nondisponibile">Non disponibile</span> -->
<!-- 		</a> -->
	</dhv:permission> <%
 	}
 %>
		</td>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-b-view">
		<td>
			<%
				if (modB != null) {
			%> <%
 	if (!modB.isNonDisponibile()) {
 %> 
 		<a href="#" onClick="apriDettaglioModulo('<%=modB.getId()%>'); return false;">
 			<span class="visualizza">Visualizza</span>
 		</a>
 		
 <%
 	} else {
 %> <i>NON DISPONIBILE</i> <%
 	}
 %> <%
 	} if (flusso.getIdStato() != Flusso.STATO_CONSEGNATO && flusso.getIdStato() != Flusso.STATO_COLLAUDATO) {
 %> <dhv:permission name="devdoc-mod-b-add">
		<a href="#" onClick="aggiungiConFlusso(1, '<%=flusso.getIdFlusso()%>')">
			<span class="aggiungi">Aggiungi</span>
		</a>
	</dhv:permission>
	<dhv:permission name="devdoc-edit">
		<br />
<%-- 		<a href="#" onClick="nonPresenzaModulo(1, '<%=flusso.getIdFlusso()%>')"> --%>
<!-- 			<span class="nondisponibile">Non disponibile</span> -->
<!-- 		</a> -->
	</dhv:permission> <%
 	}
 %>
		</td>
	</dhv:permission>
<dhv:permission name="devdoc-mod-ch-view">
		<td>
			<%
				if (modCH != null) {
			%> <%
 	if (!modCH.isNonDisponibile()) {
 %> 
 	
 		<a href="#" onClick="apriDettaglioModulo('<%=modCH.getId()%>'); return false;">
 			<span class="visualizza">Visualizza</span>
 		</a>
 <%
 	} else {
 %> <i>NON DISPONIBILE</i> <%
 	}
 %> <%
 	} else if (flusso.getIdStato() != Flusso.STATO_CONSEGNATO && flusso.getIdStato() != Flusso.STATO_COLLAUDATO) {
 %> <dhv:permission name="devdoc-mod-ch-add">
		<a href="#" onClick="aggiungiConFlusso(4, '<%=flusso.getIdFlusso()%>')">
			<span class="aggiungi">Aggiungi</span>
		</a>
	</dhv:permission>
	<dhv:permission name="devdoc-edit">
		<br />
		<a href="#" onClick="nonPresenzaModulo(4, '<%=flusso.getIdFlusso()%>')">
			<span class="nondisponibile">Non disponibile</span>
		</a>
	</dhv:permission>		
	 <%
 	}
 %>
		</td>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-c-view">
	<td>
			<%
	if (modC != null) {
	%> 
		<a href="#" onClick="apriDettaglioModulo('<%=modC.getId()%>'); return false;">
			<span class="visualizza">Visualizza</span>
		</a>
	 <%
 	} if (flusso.getIdStato() != Flusso.STATO_CONSEGNATO && flusso.getIdStato() != Flusso.STATO_COLLAUDATO) {
 %> <dhv:permission name="devdoc-mod-c-add">
		<a href="#" onClick="aggiungiConFlusso(2, '<%=flusso.getIdFlusso()%>')">
			<span class="aggiungi">Aggiungi</span>
		</a>
	</dhv:permission> <%
 	}
 %>
	</td>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-d-view">
	<td>
			<%
	if (modD != null) {
	%> 
		<a href="#" onClick="apriDettaglioModulo('<%=modD.getId()%>'); return false;">
			<span class="visualizza">Visualizza</span>
		</a>
	 <%
 	} else if (flusso.getIdStato() != Flusso.STATO_CONSEGNATO && flusso.getIdStato() != Flusso.STATO_COLLAUDATO) {
 %> <dhv:permission name="devdoc-mod-d-add">
		<a href="#" onClick="aggiungiConFlusso(3, '<%=flusso.getIdFlusso()%>')">
			<span class="aggiungi">Aggiungi</span>
		</a>
	</dhv:permission> <%
 	}
 %>
	</td>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-vce-view">	
	<td>
				<%
	if (modVCE != null) {
	%> 
		<a href="#" onClick="apriDettaglioModulo('<%=modVCE.getId()%>'); return false;">
			<span class="visualizza">Visualizza</span>
		</a> <%
 	}
 			if (1==1/*flusso.getIdStato() != Flusso.STATO_CONSEGNATO*/) {
 %> <dhv:permission name="devdoc-mod-vce-add">
		<a href="#" onClick="aggiungiConFlusso(6, '<%=flusso.getIdFlusso()%>')">
			<span class="aggiungi">Aggiungi</span>
		</a>
	</dhv:permission> <%
 	}
 %>
	</td>
	</dhv:permission>
	<td>
	<% if (modAL != null) { %> 
			<a href="#" onClick="apriDettaglioModulo('<%=modAL.getId()%>'); return false;">
				<span class="visualizza">Visualizza</span>
			</a> 
	<% } if (flusso.getIdStato() != Flusso.STATO_CONSEGNATO) { %> 
			<a href="#" onClick="aggiungiConFlusso(7, '<%=flusso.getIdFlusso()%>')">
				<span class="aggiungi">Aggiungi</span>
			</a>
	 <% } %>
	</td>
	
	<td>
	<script>
	</script>
	<%if(flusso.getDataInizioSviluppo()!=null){ %>
	<b>Giornate Stimate Effort:</b> <%=flusso.getGiornateEffort()%>GG<br><b>Giornate Stimate Elapsed:</b> <%=flusso.getGiornateElapsed()%>GG<br><b>Data Inizio Sviluppo:</b> <%=toDateasStringFromString(flusso.getDataInizioSviluppo())%><br><b>Data Previsto Collaudo:</b> <%=toDateasStringFromString(flusso.getDataPrevistaCollaudo())%>  
	<%} %>	
	</td>
	
	
	
		<td>
			<%
				if (flusso.getDataUltimaModifica() != null) {
			%> <%=toDateWithTimeasString(flusso.getDataUltimaModifica())%> <%
 	}
 %>
		</td>

	<td>
	 
	</td>
		

	</tr>

	<%
		}
	%>
	<%--

<td valign="top">

<table class="details" width="100%" cellpadding="4">
<tr><th colspan="4"><%=header %></th></tr>
<%for (int i = 0; i<lista.size(); i++) {
Modulo mod = (Modulo) lista.get(i);%>
<tr class="row<%=i%2%>"> <td valign="middle"> 
<a href="#" onClick="apriDettaglioModulo('<%=mod.getId() %>'); return false;">
<%=mod.getDescrizione()%></a> 


</td></tr>
<%} %>
</table>

</td>

<%} %>

</tr>
</table>

</table>
--%>

	<div id="dettaglioFlusso"></div>

	<div id="dettaglioModulo"></div>

	<div id="consegnaFlusso"></div>

	<div id="standbyFlusso"></div>

	<div id="annullamentoFlusso"></div>


	<script>
$(document).ready(function() {
	<%if (idModulo != null && !idModulo.equals("null") && !idModulo.equals("")) {%>
	apriDettaglioModulo('<%=idModulo%>');
	<%} else if (idFlusso != null && !idFlusso.equals("null") && !idFlusso.equals("")) {%>
	apriDettaglioFlusso('<%=idFlusso%>');
	<%}%>
});
</script>


	<%
		if (Errore != null && !Errore.equals("")) {
	%>
	<script>
alert("<%=Errore%>");
	</script>
	<%
		}
	%>

<!-- fontawesome js -->	
<script src="icons/fontawesome-free/js/all.js"></script>
<!-- filter js -->
<script src="devdoc/utils/filter/filter.js"></script>