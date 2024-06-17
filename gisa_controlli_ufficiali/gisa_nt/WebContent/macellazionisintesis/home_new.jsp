<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>
<jsp:useBean id="OrgDetails"
	class="org.aspcfs.modules.sintesis.base.SintesisStabilimento"
	scope="request" />
	
	
	
<%@ include file="../utils23/initPage.jsp"%>

<head>





<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>

<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
<script type="text/javascript" src="javascript/jmesa.js"></script>

</head>

<style>
.green {
    background-color: green !important; 
 }
</style>
	
	
	
<!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/jquery.popupWindow.js"></SCRIPT>
<!-- 
<SCRIPT LANGUAGE="JavaScript">
	document.write(getCalendarStyles());
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
 -->


<script>
function showDialogAlert(msg,mg1,mg2,mg3){
	loadModalWindow();
	$("#dialogMacelliMessaggio").html(msg.replaceAll("\n", "<br/>"));
	$("#dialogMacelliMessaggio1").html(mg1.replaceAll("\n", "<br/>"));
	$("#dialogMacelliMessaggio2").html(mg2.replaceAll("\n", "<br/>"));
	$("#dialogMacelliMessaggio3").html(mg3.replaceAll("\n", "<br/>"));

	$("#dialogMacelli").dialog({
	    resizable: true,
	    height: 'auto',
	    modal : true,
	    width: '800px',
        overflow:'auto',
	    open: function(event, ui) {
	        $(event.target).parent().css('position', 'fixed'); 
	        $(event.target).parent().css('top', '10%');
	        $(event.target).parent().css('left', '30%');
	    }

	});
}

function closeDialog(){
	loadModalWindowUnlock();
	$("#dialogMacelli").dialog("close");
}
</script>


<script>

$( document ).ready( function(){
	calenda('dataNuovaSessione','','');
	calenda('comboSessioniMacellazione2','','');
});

function gestioneSessioni(){
	var tab = document.getElementById("tabellaSessioni");
	if (tab.style.display=='none'){
		tab.style.display='block';
		scrollPageDown();
	}
	else{
		tab.style.display='none';
		scrollPageUp();
	}
}
function scrollPageDown() {
	window.scrollBy(0,200); // horizontal and vertical scroll increments
}
function scrollPageUp() {
	window.scrollBy(0,-200); // horizontal and vertical scroll increments
}


function openPopup(url){
	
	  var res;
    var result;
    	  window.open(url,'popupSelect',
          'height=1280px,width=600px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
	
	function liberoConsumoVeloce(id, data){
	
	var yyyy = data.substring(0,4);
	var mm = data.substring(5,7);
	var dd = data.substring(8,10);
	var dataMac = dd+"/"+mm+"/"+yyyy;
	
	var msg = "Il capo selezionato sarà macellato in libero consumo in data "+dataMac+" con destinatario carni macello corrente.";
	
	if(!confirm(msg))
		return false;
	
	loadModalWindow();
	window.location.href = "MacellazioniImportSintesis.do?command=LiberoConsumoVeloce&idCapo="+id;
	
}</script>



<script type="text/javascript">
	function gestisciCampoDataMacellazione() {
		var select = document.getElementById('comboSessioniMacellazione'); //Recupero la SELECT

		var NewOpt = document.createElement('option');
		//NewOpt.value = document.getElementById('campoDataMacellazione').value;
		//NewOpt.text = document.getElementById('campoDataMacellazione').value;
		NewOpt.selected = true;
		try {
			select.add(NewOpt, null); //Metodo Standard, non funziona con IE
		} catch (e) {
			select.add(NewOpt);
		}
		//document.getElementById('campoDataMacellazione').disabled = true;

		//document.getElementById('campoDataMacellazione').style.display = "";
		//document.getElementById('comboDateMacellazione').disabled = true;
		//document.getElementById('comboDateMacellazione').style.display = "none";
	}
	
	function confrontaDate(data1, data2) {

		var arr1 = data1.split("/");
		var arr2 = data2.split("/");

		var d1 = new Date(arr1[2], arr1[1] - 1, arr1[0]);
		var d2 = new Date(arr2[2], arr2[1] - 1, arr2[0]);

		var r1 = d1.getTime();
		var r2 = d2.getTime();

		if (r1 < r2)
			return -1;
		else if (r1 == r2)
			return 0;
		else
			return 1;
	}

	function controllaFormNuovaData() {
		var pregressa = document.getElementById('seduta_pregressa');
		var newData = document.getElementById('dataNuovaSessione').value;
		if (newData == '') {
			alert('Selezionare una nuova data');
			return false;
		}
		var lastSessione = null;
		
		
		//se ho settato pregressa controlla che la data non sia tra quelle già presenti
		if (pregressa.checked){
			if (document.getElementById('comboSessioniMacellazioneCompleta')!=null){
				var i = 0;
				while (document.getElementById('comboSessioniMacellazioneCompleta')[i]!=null){
					if (document.getElementById('comboSessioniMacellazioneCompleta')[i].value == newData){
						alert('Impossbile aggiungere una sessione di macellazione pregressa ad una data già esistente.');
						return false;
					}
					i++;
				}
			}
			
		}
		else
		{
			if (document.getElementById('comboSessioniMacellazione')!=null && document.getElementById('comboSessioniMacellazione')[0] != null)
			{
				lastSessione = document.getElementById('comboSessioniMacellazione')[0].value;
				var lastData = lastSessione.split('-')[0];
				if (confrontaDate(lastData, newData) >= 0) {
					alert("Selezionare una data superiore all'ultima sessione esistente ("
						+ lastData + ") o selezionare DATA PREGRESSA.");
					return false;
				}
			}
		}
		
		
		var data = new Date();
		var gg, mm, aaaa;
		gg = data.getDate() + "/";
		mm = data.getMonth() + 1 + "/";
		aaaa = parseInt(data.getYear())+1900;
		var dataCorrente = gg+mm+aaaa;
		if (confrontaDate(dataCorrente, newData) < 0) 
		{
			alert("Selezionare una data non superiore ad oggi ");
			return false;
		}
			return true;
	}
	
	function chiudiSeduta(idMacello, data, numero){
		 window.location.href='MacellazioniSintesis.do?command=ToChiudiSeduta&idMacello='+idMacello+'&data='+data+'&numero='+numero;

	}
</script>



<table class="trails" cellspacing="0">
	<tr>
		<td> <%
			if (request.getParameter("return") == null)
				{
		%> <a
			href="StabilimentoSintesisAction.do?command=DettaglioStabilimento&stabId=<%=OrgDetails.getIdStabilimento()%>">Scheda
				Stabilimento</a> > <%
 	}
 		else if (request.getParameter("return").equals("dashboard"))
 		{}
 %> Macellazioni</td>
	</tr>
</table>
<%
	String param1 = "altId=" + OrgDetails.getAltId()+"&stabId=" + OrgDetails.getIdStabilimento(); request.setAttribute("Operatore",OrgDetails.getOperatore());
    String sessioneCorrente = (request.getAttribute("sessioneCorrente")!=null)?((String)request.getAttribute("sessioneCorrente")):("non ci sono sessioni per questo macello");
    String sessionePregressa = (request.getAttribute("sessionePregressa")!=null)?((String)request.getAttribute("sessionePregressa")):("");
    String sedutaChiusa = (request.getAttribute("sedutaChiusa")!=null)?((String)request.getAttribute("sedutaChiusa")):("");

    if(request.getAttribute("sessioneCorrente")==null && request.getAttribute("comboSessioniMacellazione")!=null && ((String)request.getAttribute("comboSessioniMacellazione")).equals("-1"))
    	sessioneCorrente = "nessuna selezionata";
    ArrayList<String> listaSessioniMacellazione = (ArrayList<String>)request.getAttribute("listaSessioniMacellazione");
    ArrayList<String> listaDateMacellazione = (ArrayList<String>)request.getAttribute("listaDateMacellazione");
    ArrayList<String> listaSessioniMacellazioneCompleta = (ArrayList<String>)request.getAttribute("listaSessioniMacellazioneCompleta");
    String vpmData = "";
    String cdSedutaMacellazione = "";
	if(request.getAttribute("sessioneCorrente")!=null && !((String)request.getAttribute("sessioneCorrente")).equals(""))
		vpmData = sessioneCorrente.split("-")[0];
	if(request.getAttribute("sessioneCorrente")!=null && !((String)request.getAttribute("sessioneCorrente")).equals(""))
		cdSedutaMacellazione = sessioneCorrente.split("-")[1];
%>

<dhv:container
	name="sintesismacelli"
	selected="macellazioni" object="Operatore" param="<%=param1%>"
	appendToUrl='<%=addLinkParams(request, "popup|popupType|actionId")%>'
	>

<a href="#" onClick="openPopup('macellazionisintesis/guida/macellinews.jsp')">Ultimi aggiornamenti sul modulo macellazioni</a><br/><br/>

<% 
if(request.getAttribute("sessioneCorrente")==null)
{
%>
	<font color="red" size="3px"><b>Attenzione! Selezionare una sessione per poter aggiungere un capo.</b><br>
<%
} else if (sedutaChiusa.equalsIgnoreCase("true")){
	%>
	<font color="red" size="3px"><b>Seduta chiusa! Impossibile aggiungere capi.</b><br>
	<%@ include file="/controlliufficiali/controlli_ufficiali_macello_informazioni.jsp" %>
<%
}
else
{
%>
  	<font color="red" size="2px"><b>Attenzione! Cliccando su "Aggiungi Capo", si aggiungerà il capo alla sessione corrente del <%=sessioneCorrente%>. <%=sessionePregressa%></b><br>
<%
}
%>   
	Per aggiungere un capo ad una nuova sessione, aggiungere una nuova data utilizzando il bottone rosso in Gestisci Sessioni -> Aggiungi a nuova data.<br>
	</font>

  <H2 align="center"><span style="background-color: #FFFF00">
    Sessione corrente: <%=sessioneCorrente%> <%=sessionePregressa%> <%=(sedutaChiusa.equalsIgnoreCase("true")) ? "SEDUTA CHIUSA" : "" %></span> &nbsp;
   <a href="#" onClick="gestioneSessioni();return false;">Gestisci sessioni</a> </H2> 
   
  <div id="tabellaSessioni" style="display:none">
   
   <table border="1" bordercolor="#729FCF" align="center"
		style="text-align: center;" width="500px">
		<tr>
			<th colspan="2">Aggiungi una sessione di macellazione</th>
		</tr>
		<tr>
			<td>
				<%
		if(listaDateMacellazione.size() > 0){
	%>
	<form name="macellazioniForm"
		action="MacellazioniSintesis.do?command=AddSedutaMacellazione"
		method="post">
		<input type="hidden" name="altId" value="<%=OrgDetails.getAltId()%>" />
		<p>Aggiungi una sessione di macellazione</p>
		<select id="comboSessioniMacellazione"
			name="comboSessioniMacellazione">
			<%
				for(String dataMacellazione : listaDateMacellazione){
			%>
			<option value="<%=dataMacellazione%>"
				<%if(dataMacellazione.equals(request.getAttribute("comboSessioniMacellazione"))){%>
				selected="selected" <%}%>><%=dataMacellazione%></option>
			<%
				}
			%>
			<input type="submit" value="Aggiungi a data esistente"></input>
	</form>
	<%
		}
		else
		{
			out.println("Non ci sono date di macellazione pregresse in cui poter inserire altre sessioni. ");
		}
	%>
	
		<%
		if(listaSessioniMacellazioneCompleta.size() > 0){
	%>
		<select style="display:none" id="comboSessioniMacellazioneCompleta"
			name="comboSessioniMacellazioneCompleta">
			<%
				for(String dataMacellazione : listaSessioniMacellazioneCompleta){
			%>
			<option value="<%=dataMacellazione%>"><%=dataMacellazione%></option>
			
	<%} }
	%>
	<br />
			</td>
			<td>
			<form name="macellazioniForm2" id="macellazioniForm2"
		action="MacellazioniSintesis.do?command=AddSedutaMacellazioneNuovaData"
		method="post">
		<input type="hidden" name="altId" value="<%=OrgDetails.getAltId()%>" />
		<p>Aggiungi a nuova data</p>
		<input type="text" id="dataNuovaSessione" name="dataNuovaSessione" size="10" class="date_picker"/>&nbsp; 
		<script>calenda('dataNuovaSessione','','0');</script>
		
		<input type="button" style="background-color:#cc0000" value="Aggiungi a nuova data" onclick="if(controllaFormNuovaData()){document.getElementById('macellazioniForm2').submit();}"></input>
		<br/>
			<input type="checkbox" id="seduta_pregressa" name="seduta_pregressa"/> DATA PREGRESSA
	</form>
	<br />	
		</td>
	</tr>
	</table>
	
       
	<br />
	<br />
 
<table border="1" bordercolor="#729FCF" align="center"
		style="text-align: center;" width="500px">
		<tr>
			<th>Sessioni esistenti</th>
			<th>Capi NON Macellati</th>
		</tr>
		<tr>
			<td>
				<%
				if(listaSessioniMacellazione.size() > 0){
				%>
				<form name="macellazioniForm" action="MacellazioniSintesis.do?command=List"
					method="post">
					<input type="hidden" name="altId"
						value="<%=OrgDetails.getAltId()%>" />
					<p>Seleziona la sessione di macellazione</p>
					<select id="comboSessioniMacellazione"
						name="comboSessioniMacellazione">
						<%
							for(String sessioneMacellazione : listaSessioniMacellazione){
						%>
						<option value="<%=sessioneMacellazione%>"
							<%if(sessioneMacellazione.equals(request.getAttribute("comboSessioniMacellazione"))){%>
							selected="selected" <%}%>><%=sessioneMacellazione%></option>
						<%
							}
						%>
						<!--	<option value="-1" <%if("-1".equals(request.getAttribute("comboSessioniMacellazione"))){%> selected="selected"<%}%>>Capi non macellati</option>-->
					</select> <!--  input readonly type="text" id="campoDataMacellazione"
						name="campoDataMacellazione" size="10" style="display: none" /-->&nbsp;
					<!--  a href="#"
						onClick="cal19.select(document.forms[0].campoDataMacellazione,'anchor19','dd/MM/yyyy'); return false;"
						NAME="anchor19" ID="anchor19"> <img
						src="images/icons/stock_form-date-field-16.gif" border="0"
						align="absmiddle"></a--> <input type="submit" value="Procedi"></input>
				</form> 
				
					<input type="hidden" name="altId" value="<%=OrgDetails.getAltId()%>" />
					<input onfocus="" type="text" id="comboSessioniMacellazione2" name="comboSessioniMacellazione2" class="date_picker" size="10" value="" />  
			        <a href="#"  style="cursor: pointer;" onclick="document.getElementById('comboSessioniMacellazione2').value='';"><img src="images/delete.gif" align="absmiddle"/></a>
	            	<input type="text" size="3" name="comboSessioniMacellazione2NumSess" id="comboSessioniMacellazione2NumSess" value=""  onchange="isIntPositivo(this.value,'Numero Sessione',this);" />
	            	<input type="button" onclick="procedi();" value="Procedi"></input>
<%
 	}
				else
				{
					out.println("Nessuna");
				}
 %>
 
			</td>
			<td>
				<form name="macellazioniForm" action="MacellazioniSintesis.do?command=List"
					method="post">
					<input type="hidden" name="altId"
						value="<%=OrgDetails.getAltId()%>" /> <input type="hidden"
						name="comboSessioniMacellazione" value="-1" /> <input
						type="submit" value="Procedi"></input>
				</form>
			</td>
		</tr>
	</table>
	<br>
<br>
	
	</div>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-add">
<%
	if(!(request.getAttribute("sessioneCorrente")==null && request.getAttribute("comboSessioniMacellazione")!=null && ((String)request.getAttribute("comboSessioniMacellazione")).equals("-1"))  && !sedutaChiusa.equalsIgnoreCase("true"))
	{
%>	

<script>

function gestioneAggiuntaFile(){
	var div = document.getElementById("divAggiuntaFile");
	if (div.style.display=='none')
		div.style.display='block';
	else
		div.style.display='none';
	
}

function gestioneAggiuntaFile2(){
	var div = document.getElementById("divAggiuntaFile2");
	if (div.style.display=='none')
		div.style.display='block';
	else
		div.style.display='none';
	
}
</script>


       <script>
       
       function checkFormFile(form, vpmData){
		var importOk = true;
		var errorString = '';
		
		var fileCaricato = form.file;

		if (fileCaricato.value=='' || !fileCaricato.value.toLowerCase().endsWith(".csv")){
		errorString+='Errore! Selezionare un file in formato CSV!';
		form.file.value='';
		importOk = false;
	}
		
		if (importOk==false){
			alert(errorString);
			return false;
		}
	
	if (vpmData==''){
			importOk = false;
			errorString +='Errore! Nessuna sessione di macellazione selezionata.';
	}
	
	if (!importOk)
		alert(errorString);
	else
	{
		
		if (!confirm("ATTENZIONE! Cliccando OK i capi presenti nel file saranno importati nella seduta di macellazione corrente ("+vpmData+"). Proseguire?")){
			return false;
		}
		
	alert("L'import impiegherà diversi minuti.");	
	//form.filename.value = fileCaricato.value;	
	form.uploadButton.hidden="hidden";
	form.file.hidden="hidden";
	document.getElementById("image_loading").hidden="";
	document.getElementById("text_loading").hidden="";
	loadModalWindow();
	form.submit();
	}
}</script>


<% 
if(request.getAttribute("sessioneCorrente")!=null)
{
%>		<a href="MacellazioniSintesis.do?command=NuovoCapo&<%=param1%>&vpmData=<%=vpmData%>&cdSedutaMacellazione=<%=cdSedutaMacellazione%>"
			style="text-decoration: none;"><input type="button"
			value="Aggiungi capo" style="margin-left: 1em; margin-bottom: 1em;" /></a>
			
<%} %>
		<input type="button" class="green" value="Importa da file" style="margin-left: 1em; margin-bottom: 1em;" onClick="gestioneAggiuntaFile()"/>
				<dhv:permission name="importmassivomacelli-view">
		
		<input type="button" class="green" value="Importa da file per INALCA" style="margin-left: 1em; margin-bottom: 1em;" onClick="gestioneAggiuntaFile2()"/>
		</dhv:permission>
			
			<div id="divAggiuntaFile" style="display:none; margin-top:1em;">
			 <form method="POST" action="MacellazioniImportSintesis.do?command=ImportDaFile" enctype="multipart/form-data" >
            File:
            <input type="file" name="file" id="file"  /> 
              <img id="image_loading" hidden="hidden" src="gestione_documenti/images/loading.gif" height="15"/>
          <input type="text" disabled id="text_loading" name="text_loading" hidden="hidden" value="Caricamento in corso..."  style="border: none"/>
          
            <input type="hidden" value="/tmp" name="destination"/>
            <input type="hidden" id="vpmData" name="vpmData" value="<%=vpmData%>"/>
            <input type="hidden" id="cdSedutaMacellazione" name="cdSedutaMacellazione" value="<%=cdSedutaMacellazione%>"/>
             <input type="hidden" id="idMacello" name="idMacello" value="<%=OrgDetails.getAltId()%>"/>
                  <input type="button" class="green" value="CONFERMA E INVIA FILE"  id="uploadButton" name="uploadButton"  onClick="checkFormFile(this.form, '<%=vpmData %>')" />
        </form>
        
        
<img src="gestione_documenti/images/pdf_icon.png" width="20"/>  <a href="#" onClick="openPopup('http://www.gisacampania.it/manuali/guidaimportmacelli.pdf');	return false; "> 
<font size="3px">Guida Import</font></a> 

<img src="gestione_documenti/images/csv_icon.png" width="20"/>  <a href="#" onClick="openPopup('macellazionisintesis/guida/FileEsempio_Import.csv');	return false; "> 
<font size="3px">File di esempio</font></a> 

			</div>
			
<div id="divAggiuntaFile2" style="display:none; margin-top:1em; margin-bottom: 1em;">
			 <form method="POST" action="MacellazioniImportSintesis.do?command=ImportDaFile2" enctype="multipart/form-data" >
            File:
            <input type="file" name="file" id="file"  /> 
              <img id="image_loading" hidden="hidden" src="gestione_documenti/images/loading.gif" height="15"/>
          <input type="text" disabled id="text_loading" name="text_loading" hidden="hidden" value="Caricamento in corso..."  style="border: none"/>
          
            <input type="hidden" value="/tmp" name="destination"/>
            <input type="hidden" id="vpmData" name="vpmData" value="<%=vpmData%>"/>
            <input type="hidden" id="cdSedutaMacellazione" name="cdSedutaMacellazione" value="<%=cdSedutaMacellazione%>"/>
             <input type="hidden" id="idMacello" name="idMacello" value="<%=OrgDetails.getAltId()%>"/>
                  <input type="button" class="green" value="CONFERMA E INVIA FILE INALCA"  id="uploadButton" name="uploadButton"  onClick="checkFormFile(this.form, '<%=vpmData %>')" />
        </form>
<img src="gestione_documenti/images/pdf_icon.png" width="20"/>  <a href="#" onClick="openPopup('http://www.gisacampania.it/manuali/guidaimportmacelli_INALCA.pdf');	return false; "> 
<font size="3px">Guida Import INALCA</font></a> 

<img src="gestione_documenti/images/csv_icon.png" width="20"/>  <a href="#" onClick="openPopup('macellazionisintesis/guida/FileEsempio_Import_INALCA.csv');	return false; "> 
<font size="3px">File di esempio INALCA</font></a> 

			</div>
<br/>
<%
	}
%>
	</dhv:permission>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a
			href="MacellazioniDocumentiSintesis.do?command=ToRegistroMacellazioni&<%=param1%>"
			style="text-decoration: none"><input type="button"
			value="Registro macellazioni" style="margin-left: 1em; margin-bottom: 1em;" /></a>
	</dhv:permission>

<%-- 	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view"> --%>
<%-- 		<a href="MacellazioniDocumentiSintesis.do?command=ToArt17&<%=param1%>" --%>
<!-- 			style="text-decoration: none"><input type="button" -->
<!-- 			value="Articolo 17" style="margin-left: 1em; margin-bottom: 1em;" /></a> -->
<%-- 	</dhv:permission> --%>

<% if (request.getAttribute("sessioneCorrente")!=null && !sedutaChiusa.equalsIgnoreCase("true")){ %>
	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<input type="button" value="Chiudi Seduta" style="margin-left: 1em; margin-bottom: 1em;" onClick="chiudiSeduta('<%=OrgDetails.getAltId()%>', '<%=vpmData%>', '<%=cdSedutaMacellazione%>')"/></a>
	</dhv:permission>
<% } %>	

<!-- 	new Flusso 339 -->
<!-- 		<a href="#" style="text-decoration: none"><input type="button" value="Modello 10" style="margin-left: 1em; margin-bottom: 1em;" /></a> -->
	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<input type="button" value="Modello 10" 
		onclick="window.open('MacellazioniDocumentiAction.do?command=ToModello10&tipo=10.1&altId=<%=OrgDetails.getAltId()%>&dataSeduta=<%=vpmData%>&numeroSeduta=<%=cdSedutaMacellazione%>','Modello10','width=1200,height=500')" />
	</dhv:permission>



	<% if(vpmData ==null || vpmData == "") {%>
	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-liberoconsumomassivo-add">
		<a href="MacellazioniSintesis.do?command=ToLiberoConsumoMassivo&<%=param1%>"
			style="text-decoration: none"><input type="button"
			value="LIBERO CONSUMO MASSIVO" style="margin-left: 1em; margin-bottom: 1em;" /></a>
	</dhv:permission>
		<%} %>
	

	<%
		if(ApplicationProperties.getProperty("visibilita_link_macelli").equals("si")){
	%>
	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a href="MacellazioniDocumentiSintesis.do?command=ToMortiStalla&<%=param1%>">Anim.
			morti in stalla/trasporto</a>
	</dhv:permission>



	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a href="MacellazioniDocumentiSintesis.do?command=ToBSE&<%=param1%>">Modulo
			BSE</a>
	</dhv:permission>



	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a href="MacellazioniDocumentiSintesis.do?command=ToAbbattimento&<%=param1%>">Abbattimento</a>
	</dhv:permission>

	<br />
	<br />


	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a
			href="MacellazioniSintesis.do?command=PrintBRCRilevazioneMacelli&file=BRC_rilevazione_macelli.xml&<%=param1%>">BRC
			rilevazione macelli</a>
	</dhv:permission>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a
			href="MacellazioniSintesis.do?command=PrintTBCRilevazioneMacelli&file=TBC_rilevazione_macelli.xml&<%=param1%>">TBC
			rilevazione macelli</a>
	</dhv:permission>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a href="MacellazioniSintesis.do?command=ToModelloIdatidosi&<%=param1%>">Modello
			idatidosi</a>
	</dhv:permission>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a
			href="MacellazioniSintesis.do?command=PrintModelloMarchi&file=modello_marchi.xml&<%=param1%>">Modello
			marchi</a>
	</dhv:permission>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a
			href="MacellazioniSintesis.do?command=PrintMacellazioneAnimaliInfetti&file=macellazione_animali_infetti.xml&<%=param1%>">Macellazione
			animali infetti</a>
	</dhv:permission>

	<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
		<a
			href="MacellazioniSintesis.do?command=PrintDisinfezioneMezziTrasporto&file=disinfezione_mezzi_di_trasporto.xml&<%=param1%>">Disinfezione
			mezzi di trasporto</a>
	</dhv:permission>
	<%
		}
	%>


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font
		color="red"><br /><%=toHtmlValue( (String)request.getAttribute( "messaggio" ) )%></font>
	<br />
	<br />
<br/>

<% 
String messaggioImport = (String)request.getAttribute( "messaggioImport" );

String messaggioLiberoConsumo = (String)request.getAttribute( "messaggioLiberoConsumo" );
%>
<%= messaggioImport!=null ? messaggioImport : ""  %>
<%= messaggioLiberoConsumo!=null ? messaggioLiberoConsumo : ""  %>


	<%
		String sessioneMacellaz = "";
	%>
	<%
		if(request.getAttribute("comboSessioniMacellazione") != null && !request.getAttribute("comboSessioniMacellazione").equals("") && !request.getAttribute("comboSessioniMacellazione").equals("-1") ){ 
			sessioneMacellaz = (String)request.getAttribute("comboSessioniMacellazione");
	%>
			Lista capi <%=sessioneMacellaz.equals("-1") ? "non macellati" : "macellati nella sessione " + sessioneMacellaz%>
	<%
		}
		else if(request.getAttribute("comboSessioniMacellazione").equals("-1"))
		{
			sessioneMacellaz = "-1";
			if(request.getAttribute("comboSessioniMacellazioneData")!=null)
				out.println("Lista capi macellati il " + request.getAttribute("comboSessioniMacellazioneData"));
			else
				out.println("Lista capi non macellati (ATTENZIONE. Per motivi di prestazione saranno mostrati solo i 1000 capi non macellati piu' recenti.)");
		}
		else if(listaSessioniMacellazione.size() > 0)
		{ 
			sessioneMacellaz = listaSessioniMacellazione.get(0);
	%>
			Lista capi della sessione <%=sessioneMacellaz%>
	<%
		}
	%>

<br/>


	<form name="macellazioniForm" method="post"
		action="MacellazioniSintesis.do?command=List">
		<input type="hidden" name="altId" value="<%=OrgDetails.getAltId()%>" />
		<input type="hidden" name="comboSessioniMacellazione"
			value="<%=sessioneMacellaz%>" />
		<%=request.getAttribute( "tabella" )%>
	</form>

	<script type="text/javascript">
		function onInvokeAction(id) {
			$.jmesa.setExportToLimit(id, '');
			$.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
		}
		function onInvokeExportAction(id) {
			var parameterString = $.jmesa.createParameterStringForLimit(id);
			alert(parameterString);
			//location.href = 'MacellazioniSintesis.do?command=List&' + parameterString;
		}
	</script>

</dhv:container>


<script type="text/javascript">
function procedi()
{
	var data = new Date();
var gg, mm, aaaa;
gg = data.getDate() + "/";
mm = data.getMonth() + 1 + "/";
aaaa = parseInt(data.getYear())+1900;
var dataCorrente = gg+mm+aaaa;
	if(document.getElementById('comboSessioniMacellazione2').value!="" && document.getElementById('comboSessioniMacellazione2NumSess').value!="")
	{
		if (confrontaDate(dataCorrente, document.getElementById('comboSessioniMacellazione2').value) < 0)
			alert("Selezionare una data non superiore ad oggi ");
		else
			location.href="MacellazioniSintesis.do?command=List&altId=<%=OrgDetails.getAltId()%>&comboSessioniMacellazione=" + document.getElementById('comboSessioniMacellazione2').value+"-"+document.getElementById('comboSessioniMacellazione2NumSess').value;
	}
	else
	{
		alert("Selezionare una data e il numero sessione");
	}
	
}
</script>


<script type="text/javascript">
function isIntPositivo(Expression,nomeCampo,campo)
{
    Expression = Expression.toLowerCase();
    RefString = "0123456789";
    
    if (Expression.length < 1) 
        return (false);
    
    for (var i = 0; i < Expression.length; i++) 
    {
        var ch = Expression.substr(i, 1);
        var a = RefString.indexOf(ch, 0);
        if (a < 0)
        {
            alert('Inserire un intero positivo nel campo ' + nomeCampo +'.');
            campo.value='';
            campo.focus();
        	return false;
        }
    }
    if(parseInt(Expression)<=0)
    {
    	alert('Inserire un intero positivo nel campo ' + nomeCampo +'.');
        campo.value='';
        campo.focus();
    	return false;
    }
    
    return true;
}


	
</script>
<div id="dialogMacelli" style="display: none; text-align=center;" > 
<input type="button" id="dialogPagoPaButtonX" name="dialogPagoPaButtonX" value="CONTINUA" style="width: 80px; font-size: 10px" onClick="closeDialog()"/>
<font color="green"><p style="margin-top:1em; margin-bottom:1em; text-align:center; color:green;">IMPORT TERMINATO CON SUCCESSO</p></font>
<table style="border-collapse: collapse; margin-left: auto; margin-right: auto" cellpadding="10" cellspacing="10" >
<tr><th style="background-color: #BDCFFF;">RECORD IMPORTATI</th></tr>
<tr><td style="background-color: white" align="center"> <label id="dialogMacelliMessaggio" style="font-size: 15px"></label> </td> </tr>
<tr><th style="background-color: #BDCFFF;">CAPI NON MACELLATI</th></tr>
<tr><td style="background-color: white" align="center"> <label id="dialogMacelliMessaggio3" style="font-size: 15px"></label> </td> </tr>
<tr><th style="background-color: #BDCFFF;">CAPI MACELLATI </th></tr>
<tr><td style="background-color: white" align="center"> <label id="dialogMacelliMessaggio1" style="font-size: 15px"></label> </td> </tr>
<tr><th style="background-color: #BDCFFF;">CAPI DA COMPLETARE</th></tr>
<tr><td style="background-color: white" align="center"> <label id="dialogMacelliMessaggio2" style="font-size: 15px"></label> </td> </tr>

</table>
</div>
