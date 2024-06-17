<jsp:useBean id="idAsl" class="java.lang.String" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="report" class="org.aspcfs.modules.reportisticainterna.base.Report" scope="request"/>

<%@ include file="../utils23/initPage.jsp" %>

<script>
function filtraRighe() {
	  // Declare variables
	  var input, filter, table, tr, td, i, txtValue;
	  var sizeColonne = document.getElementById("sizeColonne").value;
	  
	  var inputs = [];
	  var filters = [];
	  var tds = [];
	  var txtValues = [];

	  for (var k = 0; k<sizeColonne; k++){
		  inputs[k] = document.getElementById("myInput"+k);
		  filters[k] = inputs[k].value.toUpperCase();
	  }
	 	  
	  table = document.getElementById("tableRisultato");
	  tr = table.getElementsByTagName("tr");

	  // Loop through all table rows, and hide those who don't match the search query
	  for (i = 1; i < tr.length; i++) {
		  for (var k = 0; k<sizeColonne; k++){
			  tds[k] = tr[i].getElementsByTagName("td")[k];
			  txtValues[k] = tds[k].textContent || tds[k].innerText;
	  }
	   

   	 if (tds[0]) {
   		 var esito = true;
   		 for (var p = 1; p<=sizeColonne; p++){
   				esito = esito && (txtValues[p-1].toUpperCase().indexOf(filters[p-1]) > -1);
   		 }
   		   if (esito) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	      esito = true;
	   }
	  }
	}
</script>


<table class="details" width="100%" cellspacing="10" cellpadding="10" style="border-collapse: collapse" >
<col width="50%">
<tr><th colspan="2"><font size="5px">REPORTISTICA INTERNA PER L'ASL <font color="red"><%=SiteList.getSelectedValue(idAsl) %></font></font></th></tr>
<tr><th colspan="2"><font size="5px"><%=report.getNome() %></font></th></tr>
<tr><th colspan="2"><font size="5px"><%=report.getDescrizione() %></font></th></tr>
</table>

<table class="details" width="100%" cellspacing="10" cellpadding="10" style="border-collapse: collapse; overflow-y: auto; height: 100px;" id="tableRisultato">
<% String risultato = report.getResultQuery();
String righe[] = risultato.split("::");

for (int i = 0; i<1; i++) {%>
<tr>
	<%String colonne[] = righe[i].split(";;");
	for (int j = 0; j<colonne.length; j++) {%>
	
	<% if (i==0 && j==0){ %>
	<input type="hidden" id="sizeColonne" value="<%=colonne.length%>"/>
	<%} %>
	
	<th style="position: sticky; top: 0;"><%=toHtml(colonne[j]) %> <br/> <input type="text" id="myInput<%=j %>" onkeyup="filtraRighe()" placeholder="FILTRA" size="10"></th>
	<%} %>
	</tr>
<%}

for (int i = 1; i<righe.length; i++) {%>
<tr>
	<%String colonne[] = righe[i].split(";;");
	for (int j = 0; j<colonne.length; j++) {%>
		<td><%=toHtml(colonne[j]) %></td>
	<%} %>
	</tr>
<%} %>
</table>
 
