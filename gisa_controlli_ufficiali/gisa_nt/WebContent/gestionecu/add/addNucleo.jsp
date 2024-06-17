<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="jsonControllo" class="org.json.JSONObject" scope="request"/>
<jsp:useBean id="ListaQualifiche" class="java.util.ArrayList" scope="request"/>


<%@ page import="org.aspcfs.modules.gestionecu.base.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<script>
function checkForm(form){
	var msg = "";
	var esito = true;
	
	var almenoUnNucleo = false;

	var x = document.getElementsByName("componenteId");
	for (var i = 0; i<x.length; i++) {
		if (x[i].value!=''){
			almenoUnNucleo = true;
		}
	}
	
	if (!almenoUnNucleo){
		msg +="Selezionare almeno un nucleo ispettivo.\n";
		esito = false;
	}
		
	if (!esito){
		alert(msg);
		return false;
	}
	
	loadModalWindow();
	form.submit();
}

function backForm(form){
	form.action="GestioneCU.do?command=AddMotivo";
	loadModalWindow();
	form.submit();
}

function filtraRigheNucleo() {
	  // Declare variables
	  var input, filter, table, tr, td, i, txtValue;
	  input0 = document.getElementById("myInputQualifica");

	  filter0 = input0.value.toUpperCase();

	  table = document.getElementById("tableNucleo");
	  tr = table.getElementsByTagName("tr");

	  // Loop through all table rows, and hide those who don't match the search query
	  for (i = 0; i < tr.length; i++) {
	    td0 = tr[i].getElementsByTagName("td")[0];
	    
	    if (td0) {
	      txtValue0 = td0.textContent || td0.innerText;
	      
	      if (txtValue0.toUpperCase().indexOf(filter0) > -1 ) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }
	  }
	}
	
function apriComponenti(qualificaId){
	popupComponenti =  window.open('GestioneCUUtil.do?command=CaricaComponenti&idQualifica='+qualificaId, 'popupComponenti',
    'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	document.getElementById("qualificaIdSelezionato").value = qualificaId;
}

function eliminaComponente(componenteId){
	var div = document.getElementById("div_componente_"+componenteId);
	div.parentNode.removeChild(div);
}
</script>

<form name="aggiungiCU" action="GestioneCU.do?command=AddRiepilogo&auto-populate=true" onSubmit="" method="post">

<center>

<!-- RIEPILOGO -->
<%@ include file="riepilogo.jsp"%>
<!-- RIEPILOGO -->

<br/>
<table class="details" id ="tableNucleo" name="tableNucleo" cellpadding="10" cellspacing="10" width="100%" style="border-collapse: collapse">
<col width="20%">
<tr><th colspan="2"><center><b>NUCLEO ISPETTIVO</b></center></th></tr>

<tr>
<th>Qualifica</th>
<th></th>
</tr>

<tr>
<th><input type="text" id="myInputQualifica" onkeyup="filtraRigheNucleo()" placeholder="FILTRA QUALIFICA" style="width: 100%"></th>
<th></th>
</tr>

<% 
for (int i = 0; i<ListaQualifiche.size(); i++) {
Qualifica qual = (Qualifica) ListaQualifiche.get(i);  %>
	
<tr>
<td><%= qual.isGruppo() ? "<b>" : ""%> <%= qual.getNome() %> <%= qual.isGruppo() ? "</b>" : ""%></td>
<td>
<% if (!qual.isGruppo()) { %>
<a href="#" onClick="apriComponenti('<%=qual.getId()%>'); return false;">Seleziona Componenti</a> 

<div id="div_<%=qual.getId()%>"></div>
<% } %>
</td>
</tr>	
	
<%} %>

</table>	

</td></tr>
</table>

<!-- BOTTONI -->
<table class="details" cellpadding="10" cellspacing="10" width="100%">
<tr>
<td colspan="2" align="center"><br/><br/>
<input type="button" value="INDIETRO" onclick="backForm(this.form)" style="font-size:40px; background-color:red"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" style="font-size:40px" value="PROSEGUI" onclick="checkForm(this.form)"/>
</td>
</tr>
</table>
<!-- BOTTONI -->

</center>

<!--JSON -->
<br/><br/><br/><br/>
<textarea rows="10" cols="200" readonly id="jsonControllo" name="jsonControllo"><%=jsonControllo%></textarea>
<!--JSON -->

</form>

<input type="hidden" id="qualificaIdSelezionato" name="qualificaIdSelezionato"/>
