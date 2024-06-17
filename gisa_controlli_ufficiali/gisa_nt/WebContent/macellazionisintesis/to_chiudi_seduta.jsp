<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="Macello" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request"/>
<jsp:useBean id="Data" class="java.lang.String" scope="request"/>
<jsp:useBean id="Numero" class="java.lang.String" scope="request"/>
<jsp:useBean id="Esito" class="java.lang.String" scope="request"/>
<jsp:useBean id="Errore" class="java.lang.String" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>
<jsp:useBean id="OggettoControllo" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%@ page  import="org.json.*"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ include file="../../utils23/initPage.jsp"%>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script>

function openPopupFull(url){
	var res;
	var result;
		window.open(url,'popupSelectMacelloChiudiSedutaCU',
		'height=500px,width=980px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=no,resizable=no ,modal=yes');
		
}

function checkForm(form){
	
	var esito = true;
	var msg = '';
	
	var listaMotivi = document.getElementsByName("idMotivoTemp");
	
	if (listaMotivi.length<=0){
		esito = false;
		msg+= '- Indicare almeno un motivo del controllo.\n';
	}
	
	if (form.oggettoControllo.value == '' || form.oggettoControllo.value == -1 || form.oggettoControllo.value == '-1'){
		esito = false;
		msg+= '- Indicare almeno un oggetto del controllo.\n';
	}
	
	var componenti = document.getElementsByName("qualificaStrutturaComponenteId");
	if (componenti.length <1){
		esito = false;
		msg+= '- Indicare almeno un componente del nucleo ispettivo.\n';
	} else {
		for (var i = 0; i<componenti.length; i++){
			form.listaComponenti.value += componenti[i].value + ";";
		}
	}
	
	
	if (esito == false) {
		alert('Errori nel salvataggio: \n\n' + msg);
		return false;
	}
	
	if (confirm("Chiudere la seduta e generare il controllo ufficiale?")){
		
		var listaTemp = document.getElementsByName("idMotivoTemp");
		var listaDef = document.getElementById("idMotivo");
		for (var i = 0; i<listaTemp.length; i++)
			listaDef.value += (i>0 ? ";" : "") + listaTemp[i].value;	
			
		listaTemp = document.getElementsByName("idPianoTemp");
		listaDef = document.getElementById("idPiano");
		for (var i = 0; i<listaTemp.length; i++)
			listaDef.value += (i>0 ? ";" : "") + listaTemp[i].value;	
			
		listaTemp = document.getElementsByName("idPerContoDiTemp");
		listaDef = document.getElementById("idPerContoDi");
		for (var i = 0; i<listaTemp.length; i++)
			listaDef.value += (i>0 ? ";" : "") + listaTemp[i].value;	
			
		loadModalWindow();
		form.submit();
	}
}

function chiudi(idMacello, data, numero){
	window.loadModalWindow();
	window.location.href='MacellazioniSintesis.do?command=List&altId='+idMacello+'&comboSessioniMacellazione='+data+'-'+numero;
}
</script>

<% if (Esito!=null && !Esito.equals("")){
	JSONObject jsonEsito = new JSONObject(Esito);
	String _esito = (String) jsonEsito.get("Esito");
	String _messaggio = (String) jsonEsito.get("Messaggio");
	if (_esito.equals("OK")){ %>
		<script>
		alert("<%=_esito %>: <%=_messaggio%>");
		chiudi("<%=Macello.getAltId()%>", "<%=Data%>", "<%=Numero%>");
		</script>
	<% } else { %>
		<script>
		alert("<%=_esito %>: <%=_messaggio%>");
		</script>
	<% } }%>
	
	<% if (Errore!=null && !Errore.equals("")){%>
		<script>
		alert("<%=Errore %>");
		chiudi("<%=Macello.getAltId()%>", "<%=Data%>", "<%=Numero%>");
		</script>
	<% }%>
	
<center>
<form action="MacellazioniSintesis.do?command=ChiudiSeduta" method="post">
<font size="3px">Proseguendo, la seduta sara' chiusa e sara' generato un controllo ufficiale associato ad essa. <br/>
I capi presenti <b><font color="red">non saranno piu' modificabili.</font></b><br/>
Per proseguire, indicare i dati del controllo ufficiale. <br/>
</font>
</center>


<table cellpadding="4" cellspacing="0" width="100%" class="details">
<col width="10%">
<tr><th colspan="2">CHIUDI SEDUTA E  Aggiungi Controllo Ufficiale </th></tr>
<tr><td class="formLabel">Tecnica di controllo</td><td>ISPEZIONE SEMPLICE <input type="hidden" id="idTecnica" name="idTecnica" value="4"/></td></tr>
<tr><td class="formLabel">A.S.L.</td><td><input type="hidden" id="idAsl" name="idAsl" value="<%=Macello.getIdAsl()%>"/> <%=SiteIdList.getSelectedValue(Macello.getIdAsl()) %></td></tr>
<tr><td class="formLabel">Operatore sottoposto a controllo</td><td><%= Macello.getOperatore().getRagioneSociale() %> (<%=Macello.getApprovalNumber() %>)</td></tr>
<tr><td class="formLabel">Motivo</td><td>

<div id="listaMotivi"></div>

<input type="hidden" id="idMotivo" name="idMotivo"/>
<input type="hidden" id="idPiano" name="idPiano"/>
<input type="hidden" id="idPerContoDi" name="idPerContoDi"/>

<br/> <a href="#" onclick="openPopupFull('Vigilanza.do?command=AddMotivoCUSeduta&idAsl=<%=Macello.getIdAsl()%>&idMacello=<%= Macello.getAltId()%>&data=<%= Data%>&numero=<%=Numero %>'); return false;">Seleziona motivo/per conto di</a></td></tr>
<tr><td class="formLabel">Data Inizio Controllo</td><td><input type="text" readonly id="dataInizioControllo" name="dataInizioControllo" value="<%=Data%>"/></td></tr>
<tr><td class="formLabel">Oggetto del controllo</td><td><%OggettoControllo.setSelectSize(9); OggettoControllo.setMultiple(true);%> <%=OggettoControllo.getHtmlSelect("oggettoControllo",-1) %></td></tr>
<tr><td class="formLabel">Nucleo Ispettivo</td><td><%@ include file="../controlliufficiali/dialog_nucleo_ispettivo_macelli_new.jsp" %><input type="hidden" id="listaComponenti" name="listaComponenti"/></td></tr>
<tr><td colspan="2" align="center">
<input type="button" onClick="chiudi('<%=Macello.getAltId()%>', '<%=Data%>', '<%=Numero%>')" value="Annulla"/> &nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onClick="checkForm(this.form)" value="Conferma"/>
</td></tr>
 
</table>

<br/><br/>
<input type="hidden" id="data" name="data" value="<%=Data%>"/>
<input type="hidden" id="numero" name="numero" value="<%=Numero%>"/>
<input type="hidden" id="idMacello" name="idMacello" value="<%=Macello.getAltId()%>"/>
<input type="hidden" id="siteId" name="siteId" value="<%=Macello.getIdAsl()%>"/>
</form>






