<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="riferimentoId" class="java.lang.String" scope="request"/>
<jsp:useBean id="riferimentoIdNomeTab" class="java.lang.String" scope="request"/>
<jsp:useBean id="RagioneSociale" class="java.lang.String" scope="request"/>
<jsp:useBean id="NumRegistrazioneStab" class="java.lang.String" scope="request"/>

<%@ include file="../../utils23/initPage.jsp"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="registrocaricoscarico/css/style.css" />

<script>

function checkForm(but, form){
	
	form.idTipologiaRegistro.value = but.value;
	loadModalWindow();
	form.submit();

}

function backForm(rifId){
		loadModalWindow();
		window.location.href="GestioneAnagraficaAction.do?command=Details&stabId="+rifId;
}
</script>
<%-- Trails --%>
	<table class="trails" cellspacing="0">
	<tr>
	<td>
	<a href="GestioneAnagraficaAction.do?command=Details&stabId=<%=riferimentoId%>"><%=RagioneSociale %> (<%=NumRegistrazioneStab %>)</a> > 
	REGISTRO CARICO/SCARICO 
	</td>
	</tr>
	</table>
<%-- Trails --%>

<center>

<font size="5px">
Per questa anagrafica sono disponibili pi&ugrave; tipi di registri carico/scarico.<br/>
Selezionare quello desiderato.
</font>

<br/><br/>

<form action="GestioneRegistroCaricoScarico.do?command=View" method="post">

<table cellpadding="10" cellspacing="10">
<tr>
<td>
<dhv:permission name="registro_carico_scarico_seme-view">
<button style="background-color: #00ffff; color: #000000; width:250px; height: 150px; font-size: 20px; word-wrap: break-word; display: inline-block;" id="tipologiaRegistro1" name="tipologiaRegistro1" value="1" onClick="checkForm(this, this.form)">CENTRI DI PRODUZIONE MATERIALE SEMINALE</button>
</dhv:permission>
</td>

<td>
<dhv:permission name="registro_carico_scarico_recapiti-view">
<button style="background-color: #008000; color: #000000; width:250px; height: 150px; font-size: 20px; word-wrap: break-word; display: inline-block;" id="tipologiaRegistro2" name="tipologiaRegistro2" value="2" onClick="checkForm(this, this.form)">RECAPITI</button>
</dhv:permission>
</td>
</tr>
</table>
 

<br/><br/><br/>
<a href="#" onClick="backForm('<%=riferimentoId%>'); return false;">Torna indietro</a>

<input type="hidden" id="riferimentoId" name="riferimentoId" value="<%=riferimentoId%>"/>
<input type="hidden" id="riferimentoIdNomeTab" name="riferimentoIdNomeTab" value="<%=riferimentoIdNomeTab%>"/>
<input type="hidden" id="idTipologiaRegistro" name="idTipologiaRegistro" value=""/>

</form>

</center>
