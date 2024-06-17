<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcfs.utils.StatoPreaccettazione"%>
<%@page import="org.aspcfs.utils.Asl"%>

<% ArrayList<StatoPreaccettazione> listaStati = (ArrayList<StatoPreaccettazione>)request.getAttribute("listaStati"); %>
<% ArrayList<Asl> listaAsl = (ArrayList<Asl>)request.getAttribute("listaAsl"); %>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<script src="javascript/jquery-ui.js"></script>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="ReportPreaccettazione.do?command=SearchForm">CERCA PREACCETTAZIONE</a> > GENERA REPORT PREACCETTAZIONE
		</td>
	</tr>
</table>

<div align="center">
<form id="reportForm" name="reportForm" action="">
	 <table class="details">
		 <tr><th colspan="2">GENERA REPORT</th></tr>
		 <tr>
			 <td>Data Inizio</td>
			 <td><input id="dataInizio" type="text" class="date_picker" /></td>
		 </tr>
		 <tr>
			 <td>Data Fine</td>
			 <td><input id="dataFine" type="text" class="date_picker" onclick="checkDataFine('dataInizio','dataFine')" /></td>
		 </tr>
		 <tr>
		 	<td>STATO</td>
		 	<td>
		 		<select id="idStato">
				<% if(listaStati.size() > 0){
						for(StatoPreaccettazione s : listaStati){
				%>
							<option value="<%= s.getId() %>"><%= s.getId() +" - "+ s.getDescrizione() %></option>
				<% 			
						} 
				   }
				%>
		 		</select>
		 	</td>
		 </tr>
		 <tr>
		 	<td>ASL</td>
		 	<td>
		 		<select id="descAsl">
		 		<option value="-1">Tutte</option>
				<% if(listaAsl.size() > 0){
						for(Asl a : listaAsl){
				%>
							<option value="<%= a.getDescription() %>"><%= a.getDescription() %></option>
				<% 			
						} 
				   }
				%>
		 		</select>
		 	</td>
		 </tr>
	 </table>
	 
	 <br><input type="button" onclick="checkForm(this.form)" value="INVIA"/>
</form>
</div>

<script>

$( document ).ready(function() {
	calenda('dataInizio','','0');
	calenda('dataFine','','0');
	
	var data = new Date();
	
	var gg = data.getDate();
	if(gg.toString().length == 1)
		gg = "0"+gg;
	var mm = data.getMonth()+1;
	if(mm.toString().length == 1)
		mm = "0"+mm;
	var yyyy = data.getFullYear();
	
	$("#dataInizio").val("01/01/"+yyyy);
	$("#dataFine").val(gg+"/"+mm+"/"+yyyy);
	
});


function checkForm(form){
	
	formTest = true;
	message = "";
	
	if ($('#dataInizio').val() == null || $('#dataInizio').val() == '') {
		 message += "- Selezionare Data Inizio.\r\n";
	     formTest = false;
	}
	
	if ($('#dataFine').val() == null || $('#dataFine').val() == '') {
		 message += "- Selezionare Data Fine.\r\n";
	     formTest = false;
	}
	 
	if (formTest == false) {
		alert("La form non può essere salvata, si prega di verificare quanto segue:\r\n\r\n" + message);
	    return false;
	}else{
		loadModalWindow();
		var dataInizio = $("#dataInizio").val();
		var dataFine = $("#dataFine").val();
		var idStato = $('#idStato').find(":selected").val();
		var descAsl = $('#descAsl').find(":selected").val();
		window.location.href='ReportPreaccettazione.do?command=Report&dataInizio='+dataInizio+'&dataFine='+dataFine+'&idStato='+idStato+'&descAsl='+descAsl;
	}
}

</script>