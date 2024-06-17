<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.campioni.base.*" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.text.DateFormat, org.aspcfs.modules.actionplans.base.*, org.json.*" %>

<%@ include file="../utils23/initPage.jsp" %>

<jsp:useBean  id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.campioni.base.Ticket" scope="request"/>
<jsp:useBean id="DestinatarioCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Motivazione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Piani" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Attivita" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="idCapo" class="java.lang.String" scope="request"/>
<jsp:useBean id="matricola" class="java.lang.String" scope="request"/>
<jsp:useBean id="dataPrelievo" class="java.lang.String" scope="request"/>
<jsp:useBean id="jsonResult" class="java.lang.String" scope="request"/>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<script>
function annullaCampioneCapoMacello(){
	if(confirm("Annullare l'inserimento del campione?"))
		window.close();
}
function checkFormCampioneCapoMacello(form){
	
	var idMotivo = form.idMotivo.value;
	var idPiano = form.idPiano.value;
	var idAttivita = form.idAttivita.value;
	
	var sizeMatrici = form.size1.value;
	var sizeAnaliti = form.size.value;
	
	var idLaboratorio = form.idLaboratorio.value;
	
	var msg = '';
	
	if (idMotivo < 0 || idMotivo == '' || (idMotivo == '89' && (idPiano == '' || idPiano < 0)) || (idMotivo == '0' && (idAttivita == '' || idAttivita < 0)))
		msg+= "Selezionare la motivazione del campione.\n";
	if (sizeMatrici < 1)
		msg+= "Selezionare la matrice del campione.\n";
	if (sizeAnaliti < 1)
		msg+= "Selezionare il tipo di analisi del campione.\n";
	if (idLaboratorio < 0 || idLaboratorio == '')
		msg+= "Selezionare il laboratorio di destinazione.\n";
	
	if (msg != ''){
		alert("Impossibile proseguire.\n\n"+msg);
		return false;
	}
	
	if(confirm("Confermare l'inserimento del campione?")){
		loadModalWindow();
		form.submit();
	}
}

function gestisciMotivazione(mot){
	if (mot.value == '89'){ //ho selezionato piano
		document.getElementById("idPiano").value = -1;
		document.getElementById("idPiano").style.display ="block";
		document.getElementById("idAttivita").value = -1;
		document.getElementById("idAttivita").style.display ="none";
	}
	else if (mot.value == '0'){ // ho selezionato attivita
		document.getElementById("idPiano").value = -1;
		document.getElementById("idPiano").style.display ="none";
		document.getElementById("idAttivita").value = -1;
		document.getElementById("idAttivita").style.display ="block";
	}
	else {
		document.getElementById("idPiano").value = -1;
		document.getElementById("idPiano").style.display ="none";
		document.getElementById("idAttivita").value = -1;
		document.getElementById("idAttivita").style.display ="none";
	}
}
function addCampione(id, dataPrelievo, matrice, analiti, motivazione, note) {
	
	var table = window.opener.document.getElementById("listaCampioni");
	var row = table.insertRow(2);
	
	var cell1 = row.insertCell(0);
	cell1.innerHTML = dataPrelievo;

	var cell2 = row.insertCell(1);
	cell2.innerHTML = motivazione;

	var cell3 = row.insertCell(2);
	cell3.innerHTML = matrice;

	var cell4 = row.insertCell(3);
	cell4.innerHTML = analiti;

	var cell5 = row.insertCell(4);
	cell5.innerHTML = note;
	
	var cell6 = row.insertCell(5);
	cell6.innerHTML = "<input type=\"hidden\" value=\""+id+"\" name=\"idCampioneCapo\"/><input type=\"button\" value=\"Elimina\" onClick=\"$(this).parent().parent().remove();\"/>";
		
}

	
</script>

<% if (jsonResult != null && !jsonResult.equals("")) {
JSONObject json = new JSONObject(jsonResult);

int _id = (int) json.get("Id");
String _esito = (String) json.get("Esito");
String _messaggio = (String) json.get("Messaggio");
String _dataPrelievo = (String) json.get("DataPrelievo");
String _matrice = (String) json.get("Matrice");
String _analiti = (String) json.get("Analiti");
String _motivazione = (String) json.get("Motivazione");
String _note = (String) json.get("Note");

if (_esito.equals("OK")){%>
	<script>
	alert("<%=_esito%> : <%=_messaggio%>");
	addCampione("<%=_id%>", "<%=_dataPrelievo%>", "<%=_matrice%>", "<%=_analiti%>", "<%=_motivazione%>", "<%=_note%>");
	window.close();
	</script>
<%} else if (_esito.equals("KO")){%>
	<script>
	alert("<%=_esito%>: <%=_messaggio%>");
	</script>
<%}
}
%>

<form name="addticket" action="StabilimentoSintesisActionCampioni.do?command=InsertCapoMacello&auto-populate=true" method="post">

<table cellpadding="4" cellspacing="0" width="100%" class="details">

<tr><th colspan="2"><strong>Aggiungi Campione</strong></th></tr>

<tr class="containerBody">
<td valign="top" class="formLabel">Macello</td>
<td><%=OrgDetails.getName() %> (<%=OrgDetails.getApprovalNumber() %>) <input type="hidden" id="altId" name="altId" value="<%=OrgDetails.getAltId()%>"/> <input type="hidden" id="idCapo" name="idCapo" value="<%=-1%>"/> <!-- Se passo idCapo non funziona elimina campione!--> </td></tr>

<tr class="containerBody">
<td valign="top" class="formLabel">Matricola</td>
<td><%=matricola %> <input type="hidden" id="matricola" name="matricola" value="<%=matricola%>"/></td></tr>

<tr class="containerBody">
    <td valign="top" class="formLabel">
     Motivazione
    </td>
   
    <td>
     
     <table class="noborder">
     <tr>
     <td>
      <%Motivazione.setJsEvent("onChange=\"gestisciMotivazione(this)\""); %> 
      <%=Motivazione.getHtmlSelect("idMotivo",-1) %> 
       
      <%Piani.setJsEvent("style=\"display:none\""); %>    
      <%=Piani.getHtmlSelect("idPiano",-1) %>    
      
      <%Attivita.setJsEvent("style=\"display:none\""); %>    
      <%=Attivita.getHtmlSelect("idAttivita",-1) %>     
   	  <FONT color="red">*</FONT>
     
    </td>
    </tr>

</table>     
     
    </td>
  </tr>


<tr class="containerBody">
<td valign="top" class="formLabel">Numero Verbale</td>
<td>
<input type="radio" id="locationRadio1" checked value="Genera" onClick="javascript:setVerbale('Genera');"/>Genera Verbale Prelievo<br><br>
<input type="text" readonly id="numeroVerbale" name="numeroVerbale" value="AUTOMATICO"/>
</td>
</tr> 

<tr class="containerBody">
<td nowrap class="formLabel">Data Prelievo</td>
<td><input type="text" id="dataPrelievo" name="dataPrelievo" size="10" class="date_picker" readonly value="<%=dataPrelievo%>"/>
</td>
 </tr>
  
<%@ include file="/campioni/matrici_analiti_tree.jsp" %>
    
<tr><td nowrap class="formLabel">Laboratorio di Destinazione</td>
<td><%= DestinatarioCampione.getHtmlSelect("idLaboratorio",-1) %></td></tr>

<tr>
<td valign="top" class="formLabel">Note</td>
<td><textarea name="note" cols="55" rows="8"></textarea></td>
</tr>
  
</table> 

</br>

<input type="button" onClick="annullaCampioneCapoMacello()" value="ANNULLA"/>
<input type="button" onClick="checkFormCampioneCapoMacello(this.form)" value="INSERISCI"/>

</form>




