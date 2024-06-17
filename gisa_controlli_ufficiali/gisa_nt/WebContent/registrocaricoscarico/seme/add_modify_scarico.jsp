<%@page import="org.aspcfs.modules.registrocaricoscarico.base.seme.ScaricoSeme"%>
<%@page import="org.aspcfs.modules.registrocaricoscarico.base.seme.RegistroSeme"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ include file="../../../utils23/initPage.jsp"%>

<jsp:useBean id="Registro" class="org.aspcfs.modules.registrocaricoscarico.base.seme.RegistroSeme" scope="request"/>
<jsp:useBean id="Carico" class="org.aspcfs.modules.registrocaricoscarico.base.seme.CaricoSeme" scope="request"/>
<jsp:useBean id="Scarico" class="org.aspcfs.modules.registrocaricoscarico.base.seme.ScaricoSeme" scope="request"/>

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

<script>
function retryForm(){
	if (confirm("L'operazione sara' annullata. Proseguire?"))
		window.close();
}

function checkForm(form){
	
	var esito = true;
	var msg = "";
	
	if (form.dataVendita.value.trim()==''){
		esito = false;
		msg+= "- Inserire un valore nel campo DATA VENDITA.\n\n";
	}
	if (form.codiceDestinatario.value.trim()==''){
		esito = false;
		msg+= "- Inserire un valore nel campo CODICE DESTINATARIO.\n\n";
	}
	
	if ((form.dosiVendute.value.trim() == '' || parseInt(form.dosiVendute.value.trim(), 10)==0) && (form.dosiDistrutte.value.trim() == '' || parseInt(form.dosiDistrutte.value.trim(), 10)==0)){
		esito = false;
		msg+= "- Inserire un valore maggiore di 0 nel campo DOSI VENDUTE o DOSI DISTRUTTE.\n\n";
	}
	if ((parseInt(form.dosiVendute.value.trim(), 10) + parseInt(form.dosiDistrutte.value.trim(), 10)) > (parseInt(form.dosiResidue.value.trim(), 10)) ){
		esito = false;
		msg+= "- La somma di DOSI DISTRUTTE e DOSI VENDUTE ("+ (parseInt(form.dosiVendute.value.trim(), 10) + parseInt(form.dosiDistrutte.value.trim(), 10)) + ") non puo' superare la somma di DOSI PRODOTTE e DOSI ACQUISTATE residue sul relativo carico (" +  (parseInt(form.dosiResidue.value.trim(), 10)) + ").\n\n";
	}

	if (form.documentoTrasportoUscita.value==""){
		esito = false;
		msg+= "- Inserire un valore nel campo DOCUMENTO TRASPORTO USCITA.\n\n";
	}
	
	if (esito==false){
		alert(msg);
		return false;
	}
	
	if (confirm("Eseguire il salvataggio dei dati inseriti?")){
		loadModalWindow();
		form.submit();
	}
}

</script>

<%if (Messaggio!=null && !Messaggio.equals("")){ %>
<script>
loadModalWindow();
window.opener.loadModalWindow();
window.opener.location.href="GestioneRegistroCaricoScarico.do?command=View&idRegistro=<%=Carico.getIdRegistro()%>";
alert("<%=Messaggio%>");
window.close();
</script>
<% } %>

<form action="GestioneRegistroCaricoScarico.do?command=UpsertScarico" method="post">

<table class="detailsSeme" cellpadding="10" cellspacing="10" style="border-collapse:collapse">

<tr><th colspan="2"><%=Scarico.getId()> 0 ? "AGGIORNAMENTO" : "INSERIMENTO"%> SCARICO NEL REGISTRO CARICO/SCARICO - CENTRI DI PRODUZIONE MATERIALE SEMINALE </th>

<tr>
<td class="formLabel">DATA VENDITA</td>
<td><input type="date" id="dataVendita" name="dataVendita" value="<%=toHtml(Scarico.getDataVendita())%>" min="<%=Carico.getDataProduzione()%>"/></td>
</tr>

<tr>
<td class="formLabel">CODICE DESTINATARIO</td>
<td><input type="text" id="codiceDestinatario" name="codiceDestinatario" value="<%=toHtml(Scarico.getCodiceDestinatario())%>"/></td>
</tr>


<tr>
<td class="formLabel">DOSI VENDUTE</td>
<td><input type="text" onKeyUp="this.value=this.value.replace(/[^\d]/g, '')" id="dosiVendute" name="dosiVendute" value="<%=Scarico.getDosiVendute() > -1 ? Scarico.getDosiVendute() : ""%>"/></td>
</tr>

<tr>
<td class="formLabel">DOSI DISTRUTTE</td>
<td><input type="text" onKeyUp="this.value=this.value.replace(/[^\d]/g, '')" id="dosiDistrutte" name="dosiDistrutte" value="<%=Scarico.getDosiDistrutte() > -1 ? Scarico.getDosiDistrutte() : ""%>"/></td>
</tr>

<tr>
<td class="formLabel">DOCUMENTO TRASPORTO USCITA</td>
<td><input type="text" id="documentoTrasportoUscita" name="documentoTrasportoUscita" value="<%=toHtml(Scarico.getDocumentoTrasportoUscita())%>"/></td>
</tr>


<tr>
<td colspan="2">
<center>
<input type="button" style="background-color: red" value="ANNULLA" onClick="retryForm()"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="<%=Scarico.getId()> 0 ? "AGGIORNA" : "INSERISCI"%>" onClick="checkForm(this.form)"/>
</center>
</td>
</tr>

</table>

<input type="hidden" id="idTipologiaRegistro" name="idTipologiaRegistro" value="<%=RegistroSeme.ID_TIPOLOGIA%>"/>
<input type="hidden" id="idCarico" name="idCarico" value="<%=Carico.getId()%>"/>
<input type="hidden" id="idScarico" name="idScarico" value="<%=Scarico.getId()%>"/>

<%
int dosiResidue = Carico.getDosiAcquistate() + Carico.getDosiProdotte();
for (int i = 0; i<Carico.getListaScarico().size(); i++){
	ScaricoSeme scarico = (ScaricoSeme) Carico.getListaScarico().get(i);
	if (scarico.getTrashedDate() == null && scarico.getId()!=Scarico.getId())
		dosiResidue = dosiResidue - scarico.getDosiDistrutte() - scarico.getDosiVendute();
}
%>
<input type="hidden" id="dosiResidue" name="dosiResidue" value="<%=dosiResidue%>"/>

</form>



