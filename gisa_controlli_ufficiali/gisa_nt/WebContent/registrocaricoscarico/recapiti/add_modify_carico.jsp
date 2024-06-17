<%@page import="org.aspcfs.modules.registrocaricoscarico.base.recapiti.RegistroRecapiti"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ include file="../../../utils23/initPage.jsp"%>

<jsp:useBean id="Registro" class="org.aspcfs.modules.registrocaricoscarico.base.recapiti.RegistroRecapiti" scope="request"/>
<jsp:useBean id="Carico" class="org.aspcfs.modules.registrocaricoscarico.base.recapiti.CaricoRecapiti" scope="request"/>

<jsp:useBean id="Messaggio" class="java.lang.String" scope="request"/>

<jsp:useBean id="TipiSpecie" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaBovini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaEquini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaSuini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaAsini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiSeme" class="org.aspcfs.utils.web.LookupList" scope="request" />

<%@page import="org.aspcfs.modules.registrocaricoscarico.base.*"%>
<%@page import="org.aspcfs.utils.web.*"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="registrocaricoscarico/css/style.css" />

<script type="text/javascript" src="dwr/interface/DwrRegistroCaricoScarico.js"> </script>

<script>
function retryForm(){
	if (confirm("L'operazione sara' annullata. Proseguire?"))
		window.close();
}

function checkForm(form){
	
	var esito = true;
	var msg = "";
	
	if (form.dataRegistrazioneEntrata.value.trim()==''){
		esito = false;
		msg+= "- Inserire un valore nel campo DATA REGISTRAZIONE ENTRATA.\n\n";
	}
	if (form.codiceMittente.value.trim()==''){
		esito = false;
		msg+= "- Inserire un valore nel campo CODICE MITTENTE.\n\n";
	}
	if (form.matricolaRiproduttoreMaschio.value.trim()=='' && form.matricolaRiproduttoreFemmina.value.trim()==''){
		esito = false;
		msg+= "- Inserire un valore nel campo MATRICOLA RIPRODUTTORE MASCHIO o nel campo MATRICOLA RIPRODUTTORE FEMMINA.\n\n";
	}
	if (form.matricolaRiproduttoreMaschio.value.trim()!='' && form.matricolaRiproduttoreFemmina.value.trim()!=''){
		esito = false;
		msg+= "- Inserire solo un valore tra il campo MATRICOLA RIPRODUTTORE MASCHIO e il campo MATRICOLA RIPRODUTTORE FEMMINA.\n\n";
	}
	if (form.identificazionePartita.value.trim()==''){
		esito = false;
		msg+= "- Inserire un valore nel campo IDENTIFICAZIONE PARTITA.\n\n";
	}
	if (form.idSpecie.value==-1){
		esito = false;
		msg+= "- Indicare una SPECIE.\n\n";
	}
	if (form.idRazzaBovini.value==-1 && form.idRazzaEquini.value==-1 && form.idRazzaSuini.value==-1 && form.idRazzaAsini.value==-1){
		esito = false;
		msg+= "- Indicare una RAZZA.\n\n";
	}
	if (form.idTipoSeme.value==""){
		esito = false;
		msg+= "- Inserire un valore nel campo TIPO SEME/EMBRIONE.\n\n";
	}
	if (form.dosiAcquistate.value.trim() == '' || parseInt(form.dosiAcquistate.value.trim(), 10)==0){
		esito = false;
		msg+= "- Inserire un valore maggiore di 0 nel campo DOSI/EMBRIONI ACQUISTATE.\n\n";
	}
	
	if (form.documentoCommercialeEntrata.value==""){
		esito = false;
		msg+= "- Inserire un valore nel campo DOCUMENTO COMMERCIALE ENTRATA.\n\n";
	}
	
	if (esito==false){
		alert(msg);
		return false;
	}
	
	if (confirm("Eseguire il salvataggio dei dati inseriti?")){
		loadModalWindow();
		
		form.nomeCapo.disabled = false;	
		form.idSpecie.disabled = false;	
		form.idRazzaBovini.disabled = false;	
		form.idRazzaSuini.disabled = false;	
		form.idRazzaEquini.disabled = false;	
		form.idRazzaAsini.disabled = false;	
		
		form.submit();
	}
}
function gestisciSpecie(sel){
	
	document.getElementById("idRazzaBovini").value = -1;
	document.getElementById("idRazzaSuini").value = -1;
	document.getElementById("idRazzaEquini").value = -1;
	document.getElementById("idRazzaAsini").value = -1;

	if (sel.value=="1"){
		document.getElementById("idRazzaBovini").style.display="block";
		document.getElementById("idRazzaSuini").style.display="none";
		document.getElementById("idRazzaEquini").style.display="none";
		document.getElementById("idRazzaAsini").style.display="none";
	}
	else if (sel.value=="2"){
		document.getElementById("idRazzaBovini").style.display="none";
		document.getElementById("idRazzaSuini").style.display="block";
		document.getElementById("idRazzaEquini").style.display="none";
		document.getElementById("idRazzaAsini").style.display="none";
	}
	else if (sel.value=="3"){
		document.getElementById("idRazzaBovini").style.display="none";
		document.getElementById("idRazzaSuini").style.display="none";
		document.getElementById("idRazzaEquini").style.display="block";
		document.getElementById("idRazzaAsini").style.display="none";
	}
	else if (sel.value=="4"){
		document.getElementById("idRazzaBovini").style.display="none";
		document.getElementById("idRazzaSuini").style.display="none";
		document.getElementById("idRazzaEquini").style.display="none";
		document.getElementById("idRazzaAsini").style.display="block";
	}
	else {
		document.getElementById("idRazzaBovini").style.display="none";
		document.getElementById("idRazzaSuini").style.display="none";
		document.getElementById("idRazzaEquini").style.display="none";
		document.getElementById("idRazzaAsini").style.display="none";
	}
}

function gestisciMatricola(mat){
	
	var matM = document.getElementById("matricolaRiproduttoreMaschio");
	var matF = document.getElementById("matricolaRiproduttoreFemmina");
	
	if (mat.id == matM.id && matM.value.trim() != "")
		document.getElementById("matricolaRiproduttoreFemmina").value = "";
	if (mat.id == matF.id && matF.value.trim() != "")
		document.getElementById("matricolaRiproduttoreMaschio").value = "";
	
	if (matM.value.trim() != "" && matF.value.trim() == "") {
			document.getElementById("idTipoSeme_1").disabled = false;
			document.getElementById("idTipoSeme_2").disabled = false;
			document.getElementById("idTipoSeme_3").disabled = false;
			
			document.getElementById("idTipoSeme_4").disabled = true;
			document.getElementById("idTipoSeme_4").checked = false;
			
			matF.disabled = true;
	}
	if (matM.value.trim() == "" && matF.value.trim() != "") {
			document.getElementById("idTipoSeme_1").disabled = true;
			document.getElementById("idTipoSeme_2").disabled = true;
			document.getElementById("idTipoSeme_3").disabled = true;
			
			document.getElementById("idTipoSeme_4").disabled = false;
			document.getElementById("idTipoSeme_4").checked = true;
			
			matM.disabled = true;
	}
	if (matM.value.trim() == "" && matF.value.trim() == "") {
			document.getElementById("idTipoSeme_1").disabled = false;
			document.getElementById("idTipoSeme_1").checked = false;

			document.getElementById("idTipoSeme_2").disabled = false;
			document.getElementById("idTipoSeme_2").checked = false;

			document.getElementById("idTipoSeme_3").disabled = false;
			document.getElementById("idTipoSeme_3").checked = false;

			document.getElementById("idTipoSeme_4").disabled = false;
			document.getElementById("idTipoSeme_4").checked = false;

			
			matM.disabled = false;
			matF.disabled = false;
	}
	
}

function recuperoInfoCapo(matricola, idRegistro){
	DwrRegistroCaricoScarico.getInfoCapo(matricola, idRegistro, {callback:recuperaInfoCapoCallBack,async:false});
}
function recuperaInfoCapoCallBack(returnValue)
{
	if (returnValue == null || returnValue == '' || returnValue == '{}'){
		document.getElementById("nomeCapo").disabled = false;	
		document.getElementById("idSpecie").disabled = false;	
		document.getElementById("idRazzaBovini").disabled = false;	
		document.getElementById("idRazzaSuini").disabled = false;	
		document.getElementById("idRazzaEquini").disabled = false;	
		document.getElementById("idRazzaAsini").disabled = false;	
		return null;
	}
		
	var dati = returnValue;
	var obj;
	obj = JSON.parse(dati);
	if(obj!=null && obj.matricola != ""){    
		
		if (document.getElementById("matricolaRiproduttoreMaschio").value != "")
			document.getElementById("matricolaRiproduttoreMaschio").value = obj.matricola;
		else if (document.getElementById("matricolaRiproduttoreFemmina").value != "")
			document.getElementById("matricolaRiproduttoreFemmina").value = obj.matricola;
		
		
		document.getElementById("nomeCapo").value = obj.nomeCapo;
		
		document.getElementById("idSpecie").value = obj.idSpecie;
		gestisciSpecie(document.getElementById("idSpecie"));
		
		if (obj.idSpecie == 1){
			document.getElementById("idRazzaBovini").value = obj.idRazza;
		}
		if (obj.idSpecie == 2){
			document.getElementById("idRazzaSuini").value = obj.idRazza;
		}
		if (obj.idSpecie == 3){
			document.getElementById("idRazzaEquini").value = obj.idRazza;
		}
		if (obj.idSpecie == 4){
			document.getElementById("idRazzaAsini").value = obj.idRazza;
		}
				
		document.getElementById("nomeCapo").disabled = true;	
		document.getElementById("idSpecie").disabled = true;	
		document.getElementById("idRazzaBovini").disabled = true;	
		document.getElementById("idRazzaSuini").disabled = true;	
		document.getElementById("idRazzaEquini").disabled = true;	
		document.getElementById("idRazzaAsini").disabled = true;	
		
		
	}  else {
		document.getElementById("nomeCapo").disabled = false;	
		document.getElementById("idSpecie").disabled = false;	
		document.getElementById("idRazzaBovini").disabled = false;	
		document.getElementById("idRazzaSuini").disabled = false;	
		document.getElementById("idRazzaEquini").disabled = false;	
		document.getElementById("idRazzaAsini").disabled = false;			
	}  
	
		
}
</script>

<%if (Messaggio!=null && !Messaggio.equals("")){ %>
<script>
loadModalWindow();
window.opener.loadModalWindow();
window.opener.location.href="GestioneRegistroCaricoScarico.do?command=View&idRegistro=<%=Registro.getId()%>";
alert("<%=Messaggio%>");
window.close();
</script>
<% } %>

<form action="GestioneRegistroCaricoScarico.do?command=UpsertCarico" method="post">

<table class="detailsRecapito" cellpadding="10" cellspacing="10" style="border-collapse:collapse">

<tr><th colspan="2"><%=Carico.getId()> 0 ? "AGGIORNAMENTO" : "INSERIMENTO"%> CARICO NEL REGISTRO CARICO/SCARICO - RECAPITI</th>

<% if (!toHtml(Carico.getNumRegistrazione()).equals("")) {%>
<tr>
<td class="formLabel">NUM. REGISTRAZIONE</td>
<td><input type="text" readonly id="numRegistrazione" name="numRegistrazione" value="<%=toHtml(Carico.getNumRegistrazione())%>"/></td>
</tr>
<%} %>

<tr>
<td class="formLabel">DATA REGISTRAZIONE ENTRATA</td>
<td><input type="date" id="dataRegistrazioneEntrata" name="dataRegistrazioneEntrata" value="<%=toHtml(Carico.getDataRegistrazioneEntrata())%>"/></td>
</tr>

<tr>
<td class="formLabel">CODICE MITTENTE</td>
<td><input type="text" id="codiceMittente" name="codiceMittente" value="<%=toHtml(Carico.getCodiceMittente())%>"/></td>
</tr>

<tr>
<td class="formLabel">CODICE SPECIE</td>
<td> 
<% TipiSpecie.setJsEvent("onChange=\"gestisciSpecie(this)\""); %>
<%=TipiSpecie.getHtmlSelect("idSpecie", Carico.getIdSpecie()) %></td>
</tr>

<tr>
<td class="formLabel">CODICE RAZZA</td>
<td> 

<center>
<% if (Carico.getIdSpecie()!=1)
	TipiRazzaBovini.setJsEvent("style=\"display:none\""); %>
<%=TipiRazzaBovini.getHtmlSelect("idRazzaBovini", Carico.getIdRazza()) %>

<% if (Carico.getIdSpecie()!=2)
	TipiRazzaSuini.setJsEvent("style=\"display:none\""); %>
<%=TipiRazzaSuini.getHtmlSelect("idRazzaSuini", Carico.getIdRazza()) %>

<% if (Carico.getIdSpecie()!=3)
	TipiRazzaEquini.setJsEvent("style=\"display:none\""); %>
<%=TipiRazzaEquini.getHtmlSelect("idRazzaEquini", Carico.getIdRazza()) %>

<% if (Carico.getIdSpecie()!=4)
	TipiRazzaAsini.setJsEvent("style=\"display:none\""); %>
<%=TipiRazzaAsini.getHtmlSelect("idRazzaAsini", Carico.getIdRazza()) %>
</center>

</td>
</tr>

<tr>
<td class="formLabel">NOME CAPO</td>
<td><input type="text" id="nomeCapo" name="nomeCapo" value="<%=toHtml(Carico.getNomeCapo())%>"/></td>
</tr>

<tr>
<td class="formLabel">MATRICOLA RIPRODUTTORE MASCHIO</td>
<td><input type="text" id="matricolaRiproduttoreMaschio" name="matricolaRiproduttoreMaschio" value="<%=toHtml(Carico.getMatricolaRiproduttoreMaschio())%>" onChange="gestisciMatricola(this); recuperoInfoCapo(this.value, '<%=Registro.getId()%>')"/></td>
</tr>

<tr>
<td class="formLabel">MATRICOLA RIPRODUTTORE FEMMINA</td>
<td><input type="text" id="matricolaRiproduttoreFemmina" name="matricolaRiproduttoreFemmina" value="<%=toHtml(Carico.getMatricolaRiproduttoreFemmina())%>" onChange="gestisciMatricola(this); recuperoInfoCapo(this.value, '<%=Registro.getId()%>')"/></td>
</tr>

<tr>
<td class="formLabel">IDENTIFICAZIONE PARTITA</td>
<td><input type="text" id="identificazionePartita" name="identificazionePartita" value="<%=toHtml(Carico.getIdentificazionePartita())%>"/></td>
</tr>

<tr>
<td class="formLabel">TIPO SEME/EMBRIONE)</td>
<td> 

<% for (int i = 0; i<TipiSeme.size(); i++) {
	LookupElement ts = (LookupElement) TipiSeme.get(i);
	if (ts.getCode() > 0) {%>
		<input type="radio" id="idTipoSeme_<%=ts.getCode() %>" name="idTipoSeme" value="<%=ts.getCode()%>" <%=Carico.getIdTipoSeme() == ts.getCode() ? "checked" : "" %>> <%=ts.getDescription() %><br/>  
	<%}  } %>

</td>

<script>
gestisciMatricola(document.getElementById("matricolaRiproduttoreMaschio"));
gestisciMatricola(document.getElementById("matricolaRiproduttoreFemmina"));
</script>

<% if (Registro.getId() > 0) { %>
<script>
recuperoInfoCapo(document.getElementById("matricolaRiproduttoreMaschio").value, '<%=Registro.getId()%>');
recuperoInfoCapo(document.getElementById("matricolaRiproduttoreFemmina").value, '<%=Registro.getId()%>');
</script>
<% } %>

</tr>

<tr>
<td class="formLabel">DOSI/EMBRIONI ACQUISTATE</td>
<td><input type="text" onKeyUp="this.value=this.value.replace(/[^\d]/g, '')" id="dosiAcquistate" name="dosiAcquistate" value="<%=Carico.getDosiAcquistate() > -1 ? Carico.getDosiAcquistate() : ""%>"/></td>
</tr>

<tr>
<td class="formLabel">DOCUMENTO COMMERCIALE ENTRATA</td>
<td><input type="text" id="documentoCommercialeEntrata" name="documentoCommercialeEntrata" value="<%=toHtml(Carico.getDocumentoCommercialeEntrata())%>"/></td>
</tr>

<tr>
<td colspan="2">
<center>
<input type="button" style="background-color: red" value="ANNULLA" onClick="retryForm()"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="<%=Carico.getId()> 0 ? "AGGIORNA" : "INSERISCI"%>" onClick="checkForm(this.form)"/>
</center>
</td>
</tr>

</table>

<input type="hidden" id="idTipologiaRegistro" name="idTipologiaRegistro" value="<%=RegistroRecapiti.ID_TIPOLOGIA%>"/>
<input type="hidden" id="idRegistro" name="idRegistro" value="<%=Registro.getId()%>"/>
<input type="hidden" id="idCarico" name="idCarico" value="<%=Carico.getId()%>"/>
<input type="hidden" id="numRegistrazioneStab" name="numRegistrazioneStab" value="<%=Registro.getNumRegistrazioneStab()%>"/>

</form>
