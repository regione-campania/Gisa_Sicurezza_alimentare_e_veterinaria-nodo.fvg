<%@page import="java.util.Date"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="java.io.*,java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.opu.base.*, org.aspcfs.modules.registrazioniAnimali.base.*, java.sql.* "%>
 
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="animale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />
<jsp:useBean id="animalenewinfo"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />
<jsp:useBean id="oldAnimale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />
<jsp:useBean id="Cane"
	class="org.aspcfs.modules.anagrafe_animali.base.Cane" scope="request" />
<jsp:useBean id="Gatto"
	class="org.aspcfs.modules.anagrafe_animali.base.Gatto" scope="request" />
<jsp:useBean id="registrazioniList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="provinceList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="EventoRitrovamento"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRitrovamento"
	scope="request" />
<jsp:useBean id="EventoSterilizzazione"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoSterilizzazione"
	scope="request" />
<jsp:useBean id="EventoReimmissione"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoReimmissione"
	scope="request" />
	
	<jsp:useBean id="EventoRitrovamentoNonDenunciato"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRitrovamentoNonDenunciato"
	scope="request" />
	
<jsp:useBean id="EventoAdozioneDaCanile"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneDaCanile"
	scope="request" />
<jsp:useBean id="EventoRestituzioneACanile"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRestituzioneACanile"
	scope="request" />
<jsp:useBean id="EventoAdozioneDaColonia"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneDaColonia"
	scope="request" />
<jsp:useBean id="EventoTrasferimento"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimento"
	scope="request" />
	<jsp:useBean id="EventoTrasferimentoSindaco"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoSindaco"
	scope="request" />
<jsp:useBean id="EventoTrasferimentoFuoriRegioneSoloProprietario"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoFuoriRegioneSoloProprietario"
	scope="request" />
	<jsp:useBean id="EventoTrasferimentoFuoriStato"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoFuoriStato"
	scope="request" />
	<jsp:useBean id="EventoTrasferimentoFuoriRegione"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoFuoriRegione"
	scope="request" />
<jsp:useBean id="EventoTrasferimentoCanile"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoCanile"
	scope="request" />
<jsp:useBean id="EventoRientroFuoriRegione"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRientroFuoriRegione"
	scope="request" />
<jsp:useBean id="EventoCambioDetentore"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoCambioDetentore"
	scope="request" />
	<jsp:useBean id="EventoRestituzioneAProprietario"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRestituzioneAProprietario"
	scope="request" />
<jsp:useBean id="EventoCessione"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoCessione"
	scope="request" />
<jsp:useBean id="cessioneaperta"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoCessione"
	scope="request" />
<jsp:useBean id="passaportoInCorso"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRilascioPassaporto"
	scope="request" />
<jsp:useBean id="decesso"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoDecesso"
	scope="request" />
<jsp:useBean id="datatocheck" class="java.lang.String" scope="request" />
<jsp:useBean id="labeldatatocheck" class="java.lang.String" scope="request" />
<jsp:useBean id="EventoPresaInCaricoDaCessione"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoPresaInCaricoDaCessione"
	scope="request" />
<jsp:useBean id="reimmissionePrecedente"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoReimmissione"
	scope="request" />	
<jsp:useBean id="EventoPresaInCaricoDaAdozioneFuoriAsl"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoPresaInCaricoDaAdozioneFuoriAsl"
	scope="request" />
	<jsp:useBean id="EventoAdozioneFuoriAsl"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneFuoriAsl"
	scope="request" />
<jsp:useBean id="EventoPresaCessioneImport"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoPresaCessioneImport"
	scope="request" />
<jsp:useBean id="EventoSbloccoAnimale"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoSbloccoAnimale"
	scope="request" />
	<jsp:useBean id="adozioneaperta"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneFuoriAsl"
	scope="request" />

	
	
<jsp:useBean id="EventoCattura"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoCattura"
	scope="request" />
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="statoList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="EventoRientroFuoriStato"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRientroFuoriStato"
	scope="request" />

<!-- Errore wkf nell'invio precedente -->

<jsp:useBean id="ErroreWKF" class="java.lang.String" scope="request" />

<!-- Action di provenienza -->
<jsp:useBean id="actionFrom" class="java.lang.String" scope="request"/>

<meta charset="utf-8" />
<link rel="stylesheet" href="css/jquery-ui_new.css" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<!-- <script src="javascript/jquery-1.9.1_new.js"></script> -->
<!-- <script src="javascript/jquery-ui_new.js"></script> -->


<!-- <script language="javascript" SRC="javascript/CalendarPopup.js"></script> -->
<script language="javascript" SRC="javascript/CalendarPopup2.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/gestoreCodiceFiscale.js"></SCRIPT>
<script language="JavaScript" SRC="javascript/dateControl.js"></script>

<!-- 
<script language="javascript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
 -->
 
<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/PraticaList.js"> </script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/Animale.js"> </script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/Operatore.js"> </script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/LineaProduttiva.js"> </script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/EventoRilascioPassaporto.js"> </script>



<body>

<h1 style="color:red;"> ATTENZIONE, DOPO AVER INSERITO LA REGISTRAZIONE RIVERIFICARE I DATI INSERITI ED EFFETTUARE LA SINCRONIZZAZIONE MANUALMENTE VERSO SINAC</h1>


<form name="addReg"
	action="RegistrazioniAnimale.do?command=TrasferimentoFuoriRegioneOpInsert"
	method="post">
		<input type="hidden" value="<%=animale.getIdSpecie() %>"	name="idSpecie" />
	
	<table style="border-collapse:collapse; border: solid 1px">
	<tr><td>
	<input type="hidden" name="animaleId" id="animaleId" value="<%=request.getParameter("id_animale")%>">
	<label for="registrazione">Data Registrazione</label></td>
	<td><input
	type="date" name="registrazione"  id="registrazione"nomecampo="registrazione"
	labelcampo="Data Registrazione" /></td></tr> 
		<tr><td><label for="codice">Codice Struttura Sinac</label></td>	
		<td><input type="text" name="codice" id="codice" placeholder="Codice Struttura" /></td></tr>
		<tr><td><label for="ragione">Ragione Sociale Struttura</label></td>
	<td><input type="text"  name="ragione" id="ragione" placeholder="ragione sociale" /></td></tr>
	<tr><td><label for="comune">Codice istat Comune</label></td>
	<td><input type="number" min="0" max="999" name="comune" id="comune" placeholder="comune" /></td></tr>
	<tr><td><label for="provincia">Sigla Provincia</label></td>
	<td><input type="text" name="provincia" id="provincia"  placeholder="provincia"/></td></tr>
		<tr><td><label for="indirizzo">Indirizzo</label></td>
	
	<td><input type="text" name="indirizzo" id="indirizzo" placeholder="indirizzo"/></td></tr>
			<tr><td><label for="cap">cap</label></td>
	
	<td><input type="text" name="cap" id="cap" placeholder="cap" /></td></tr>
	
	<tr><td><label for="note">Note</label></td>
		<td><input type="text" name="note" id="note" placeholder="note" /></td></tr>
		
	</table>
	<button type="submit">INVIA</button>
</form>