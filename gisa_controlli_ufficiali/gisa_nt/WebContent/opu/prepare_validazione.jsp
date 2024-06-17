<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>



<%@page import="java.sql.Timestamp"%>
<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>
<jsp:useBean id="Operatore" class="org.aspcfs.modules.opu.base.Operatore" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../utils23/initPage.jsp"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script>
function gestisciNote(val){
	var si = document.getElementById("esitoSI");
	var no = document.getElementById("esitoNO");
	var note = document.getElementById("note");
	
	if (val=='true'){
		note.value='';
		note.style.display = 'none';
	}
	else {
		note.style.display = 'block';
	}
}

function checkForm(form){
	var si = document.getElementById("esitoSI");
	var no = document.getElementById("esitoNO");
	var note = document.getElementById("note");
	
	var formEsito = true;
	 
	if (!si.checked && !no.checked){
		formEsito = false;
		alert('Selezionare un esito per la validazione!');
	}
	if (no.checked && note.value==''){
		formEsito = false;
		alert('Inserire le note in caso di respingimento!');
	}
	if (formEsito){
		loadModalWindow();
		form.submit();
	}
	else
		return false;
}
</script>



<%
String param = "stabId="+StabilimentoDettaglio.getIdStabilimento()+"&opId=" + StabilimentoDettaglio.getIdOperatore();
%>

<form name="validazione" action="OpuStab.do?command=Valida" method="post">
<table class="details" width="100%" style="border:1px solid black">
<tr><th>VERIFICA DOCUMENTALE</th></tr>

<tr> <td>

<input type ="radio" name ="esitoValidazione" id ="esitoSI" value="true" onClick="gestisciNote(this.value)"/> CONFORME
<input type ="radio" name ="esitoValidazione" id ="esitoNO" value="false" onClick="gestisciNote(this.value)" /> NON CONFORME

</td></tr>

<tr><td>
<textarea style="display:none" id="note" name="note" rows="3" cols="70" placeholder="Inserire le note per il respingimento"></textarea>

</td></tr>

<tr><td>

<% if (StabilimentoDettaglio.getStato()==7){ %>
<input type ="button" value="CONFERMA" onClick="checkForm(this.form)"/>
<%} else { %>
<INPUT TYPE="button" disabled style="background-color:#D3D3D3; color:#fff;" value="CONFERMA"/> Lo stabilimento è già stato validato.
<%} %>
</td></tr>



<input type ="hidden" name ="stabId" id ="stabId" value="<%=StabilimentoDettaglio.getIdStabilimento() %>" />

</table>
</form>
