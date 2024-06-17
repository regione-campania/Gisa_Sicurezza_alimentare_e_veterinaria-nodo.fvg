<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>



<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<jsp:useBean id="listaRichieste" class="java.util.LinkedHashMap" scope="request"/>

<jsp:useBean id="limit" class="java.lang.String" scope="request"/>

<jsp:useBean id="msg" class="java.lang.String" scope="request"/>
<jsp:useBean id="jsonValidazione" class="org.json.JSONObject" scope="request"/>
<jsp:useBean id="jsonScartati" class="org.json.JSONObject" scope="request"/>



<jsp:useBean id="idImport" class="java.lang.String" scope="request"/>


<%@page import="org.aspcfs.modules.sintesis.base.StabilimentoSintesisImport"%>

<%@ include file="../utils23/initPage.jsp" %>

<link rel="stylesheet" type="text/css"
	href="javascript/jquerypluginTableSorter/css/theme.css"></link>
<link rel="stylesheet" type="text/css"
	href="javascript/jquerypluginTableSorter/css/jquery.tablesorter.pages.css"></link>
<script type="text/javascript"
	src="javascript/jquerypluginTableSorter/jquery.tablesorter.js"></script>
<script type="text/javascript"
	src="javascript/jquerypluginTableSorter/jquery.tablesorter.pager.js"></script>
<script type="text/javascript"
	src="javascript/jquerypluginTableSorter/jquery.tablesorter.widgets.js"></script>
<script type="text/javascript"
	src="javascript/jquerypluginTableSorter/tableJqueryFilterPraticheSintesis.js"></script>
<script src="javascript/jquery.searchable-1.0.0.min.js"></script>


  <link rel="stylesheet" type="text/css" media="screen" href="css/jquery.ui.combogrid.css"/>
  <script type="text/javascript" src="javascript/jquery.ui.combogrid.js"></script>
<style>
<!--

.combogrid{
	/*max-width: 800px;
	min-width: 500px;*/
	font-size: 0.8em !important;
	width: 25%;
	height: 50%;
	overflow: scroll;
	
	
}
.cg-colHeader-label {
	padding: 10;
	margin:10;
	float:center;
}
.cg-DivItem {
	
	float:center;
	font-size: 0.8em;
	overflow: visible;
	height: auto;
}
-->
</style>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<script>function refreshLista(form){
	loadModalWindow();
	form.submit();
}</script>

<script>
function mostraNascondi(campo){
	var table = document.getElementById(campo);
	if (table.style.display=="block")
		table.style.display="none";
	else
		table.style.display="none";
}

</script>

 <script>
  function processaDatiIgnora(form){

	  if (confirm('ATTENZIONE: ignorare gli errori sui flussi e processare tutta la coda?')){
	   	form.ignoraFlussoStati.value="ok";
	   	loadModalWindow();
   		form.submit();
   }
   else
   	return false;
   }
  
  function mostraNascondiRecord(btn){
	  var tr = document.getElementById("tr_"+btn.id);
	  
	  if (btn.value=="+"){
		  btn.value = "-";
		  tr.style.display = 'table-row';
	  } else {
		  btn.value = "+";
		  tr.style.display = 'none';
	  }
  }
  </script>
  
 <%! public static String fixData(String timestring)
  {
	  String toRet = "";
	  if (timestring == null)
		  return toRet;
	  String anno = timestring.substring(0,4);
	  String mese = timestring.substring(5,7);
	  String giorno = timestring.substring(8,10);
	  String ora = timestring.substring(11,13);
	  String minuto = timestring.substring(14,16);
	  String secondi = timestring.substring(17,19);
	  toRet =giorno+"/"+mese+"/"+anno+" "+ora+":"+minuto;
	  return toRet;
	  
  }%>

    <br>
   
  <dhv:container name="sintesisimport" selected="Pratiche" object="">
  
 <% if (msg!=null && !msg.equals("null") && !msg.equals("")){ %>
  <center><font color="green" size="5px"><b><%=msg %></b></font></center>
  <br/><br/>
  <%} %>
  
  <% if (jsonValidazione!=null && jsonValidazione.length() > 0){ %>
  
  <center>
  <table class="details" cellpadding="20" cellspacing="20" width="50%">
  <tr><th colspan="2">RECORD PROCESSATI</th></tr>
  <tr><th colspan="2">PRATICHE PROCESSATE CON SUCCESSO IN ANAGRAFICA</th></tr>
  <tr><td>NUOVI STABILIMENTI INSERITI IN ANAGRAFICA</td><td><%=jsonValidazione.get("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA") %> <% if ( (int) jsonValidazione.get("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA")>0){ %><input type="button" value="+" id="btn_INSERISCI_STABILIMENTO_INSERISCI_LINEA" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_INSERISCI_STABILIMENTO_INSERISCI_LINEA"><td colspan="2"><%=jsonValidazione.get("MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA") %></td></tr>
  <tr><td>NUOVE LINEE AGGIUNGE A STABILIMENTI ESISTENTI IN ANAGRAFICA</td><td><%=jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA") %> <% if ( (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA")>0){ %><input type="button" value="+" id="btn_AGGIORNA_STABILIMENTO_INSERISCI_LINEA" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_AGGIORNA_STABILIMENTO_INSERISCI_LINEA"><td colspan="2"><%=jsonValidazione.get("MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA") %></td></tr>
  <tr><td>AGGIORNAMENTI AD ANAGRAFICHE ESISTENTI</td><td><%=jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA") %> <% if ( (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA")>0){ %><input type="button" value="+" id="btn_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA"><td colspan="2"><%=jsonValidazione.get("MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA") %></td></tr>
  <tr><th colspan="2">PRATICHE NON PROCESSATE A CAUSA DI ERRORI</th></tr>
  <tr><td>MANCATO MAPPING LINEA</td><td><%=jsonValidazione.get("TOT_LINEA_NON_MAPPATA") %> <% if ( (int) jsonValidazione.get("TOT_LINEA_NON_MAPPATA")>0){ %><input type="button" value="+" id="btn_LINEA_NON_MAPPATA" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_LINEA_NON_MAPPATA"><td colspan="2"><%=jsonValidazione.get("MSG_LINEA_NON_MAPPATA") %></td></tr>
  <tr><td>ALTRI MOTIVI</td><td><%=jsonValidazione.get("TOT_IGNORA") %> <% if ( (int) jsonValidazione.get("TOT_IGNORA")>0){ %><input type="button" value="+" id="btn_IGNORA" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_IGNORA"><td colspan="2"><%=jsonValidazione.get("MSG_IGNORA") %></td></tr>
  </table>
  </center>
  <br/><br/>
  
 <% } %>

<% if (jsonScartati!=null && jsonScartati.length() > 0){ %>

  <center>
  <table class="details" cellpadding="20" cellspacing="20" width="50%">
  <tr><th colspan="2">RECORD SCARTATI E NON INSERITI TRA LE PRATICHE</th></tr>
  <tr><td>GIA' ESISTENTI IN PRATICHE PREGRESSE</td><td><%=jsonScartati.get("TOT_SCARTATI_PRATICA_ESISTENTE") %> <% if ( (int) jsonScartati.get("TOT_SCARTATI_PRATICA_ESISTENTE")>0){ %><input type="button" value="+" id="btn_SCARTATI_PRATICA_ESISTENTE" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_SCARTATI_PRATICA_ESISTENTE"><td colspan="2"><%=jsonScartati.get("MSG_SCARTATI_PRATICA_ESISTENTE") %></td></tr>
  <tr><td>APPROVAL NUMBER TROPPO LUNGO</td><td><%=jsonScartati.get("TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO") %> <% if ( (int) jsonScartati.get("TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO")>0){ %><input type="button" value="+" id="btn_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO"><td colspan="2"><%=jsonScartati.get("MSG_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO") %></td></tr>
  <tr><td>STATO ANAGRAFE</td><td><%=jsonScartati.get("TOT_SCARTATI_STATO_ANAGRAFE") %> <% if ( (int) jsonScartati.get("TOT_SCARTATI_STATO_ANAGRAFE")>0){ %><input type="button" value="+" id="btn_SCARTATI_STATO_ANAGRAFE" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_SCARTATI_STATO_ANAGRAFE"><td colspan="2"><%=jsonScartati.get("MSG_SCARTATI_STATO_ANAGRAFE") %></td></tr>
  <tr><td>ALTRI MOTIVI</td><td><%=jsonScartati.get("TOT_SCARTATI_ALTRO") %> <% if ( (int) jsonScartati.get("TOT_SCARTATI_ALTRO")>0){ %><input type="button" value="+" id="btn_SCARTATI_ALTRO" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
  <tr style="display:none" id="tr_btn_SCARTATI_ALTRO"><td colspan="2"><%=jsonScartati.get("MSG_SCARTATI_ALTRO") %> </td></tr>
 </table>
  </center>
  <br/><br/>
  
  <% } %>
  
  
  <center><b>Lista pratiche</b></center>
  		
  		<div class="pager">
	Page: <select class="gotoPage"></select>		
	<img src="javascript/img/first.png" class="first" alt="First" title="First page" />
	<img src="javascript/img/prev.png" class="prev" alt="Prev" title="Previous page" />
	<img src="javascript/img//next.png" class="next" alt="Next" title="Next page" />
	<img src="javascript/img/last.png" class="last" alt="Last" title= "Last page" />
	<select class="pagesize">
		<option value="10">10</option>
		<option value="20">20</option>
		<option value="30">30</option>
		<option value="40">40</option>
		<option value="50">50</option>
	</select>
</div>
		<table class="tablesorter" id = "tablelistapratichesintesis">

			<thead>
				<tr class="tablesorter-headerRow" role="row">
				
				<th
						aria-label="Data Documento Sintesis: No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="0"
						data-placeholder="FILTRO PER DATA DOCUMENTO SINTESIS"
						class="sorter-shortDate dateFormat-ddmmyyyy"><div
							class="tablesorter-header-inner">Data Documento SINTESIS</div></th>

					<th
						aria-label="Stato sede operativa: No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="0"
						data-placeholder="FILTRO PER STATO SEDE OPERATIVA"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">Stato sede operativa</div></th>

					<th
						aria-label="Approval number ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER APPROVAL NUMBER"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">Approval number</th>
					<th
						aria-label="Denominazione sede operativa ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER DENOMINAZIONE SEDE OPERATIVA"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">Denominazione sede operativa</th>
					<th
						aria-label="Partita IVA ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER PARTITA IVA"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">PARTITA IVA</th>
					<th
						aria-label="Indirizzo ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER INDIRIZZO"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">INDIRIZZO</th>
					<th
						aria-label="Attivita ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER ATTIVITA"
						class="first-name filter-select"><div
							class="tablesorter-header-inner">ATTIVITA</th>
					
					<th
						aria-label="Descrizione attivita ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER DESCRIZIONE ATTIVITA"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">DESCRIZIONE ATTIVITA</th>
					
					<th
						aria-label="Stato ( filter-match ): No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="1"
						data-placeholder="FILTRO PER STATO"
						class="filter-match tablesorter-header tablesorter-headerUnSorted"><div
							class="tablesorter-header-inner">STATO</th>
					
					<th
						aria-label="Caricamento in anagrafica: No sort applied, activate to apply an ascending sort"
						aria-sort="none" style="-moz-user-select: none;" unselectable="on"
						aria-controls="table" aria-disabled="false" role="columnheader"
						scope="col" tabindex="0" data-column="0"
						class="filter-false tablesorter-header"><div
							class="tablesorter-header-inner">CARICAMENTO IN ANAGRAFICA</div>
					</th>
				</tr>
			</thead>
  		

		<tbody aria-relevant="all" aria-live="polite">
			<%
			
			LinkedHashMap<String, ArrayList<StabilimentoSintesisImport>> listaRichiesteHash = listaRichieste; 
			int j = 0;
			for ( String key : listaRichiesteHash.keySet() ) {
				
			    ArrayList<StabilimentoSintesisImport> listaRichiesteAggreg = (ArrayList<StabilimentoSintesisImport>) listaRichiesteHash.get(key);
			    j++;
				for (int i=0;i<listaRichiesteAggreg.size(); i++){
					StabilimentoSintesisImport stab = (StabilimentoSintesisImport) listaRichiesteAggreg.get(i);
					
			  %>
			  	<tr class="row<%=j%2%>">
			  	
			<% if(stab.getDataSintesis() != null ){%>
			<td ><%= fixData(stab.getDataSintesis().toString())%></td> 
			<%}else{ %>
			<td></td> 
			<%} %>
			<td ><%= stab.getStatoSedeOperativa()%></td> 
			<td ><%=stab.getApprovalNumber() %></td> 
			<td > <%=stab.getDenominazioneSedeOperativa() %></td> 
			<td > <%=stab.getPartitaIva() %> </td> 
			<td> <%=stab.getIndirizzo() %> <%=stab.getComune() %> <%=stab.getProvincia() %></td> 
			
			  	
			  	
			<td><%=stab.getAttivita() %> </td> 
			<td><%=stab.getDescrizioneSezione() %> </td> 
			<td><%=stab.getStatoAttivita() %> </td> 
			
			<td> 
			
			<% if (stab.getStatoImport()== StabilimentoSintesisImport.IMPORT_DA_VALIDARE){ %>
			<dhv:permission name="sintesis-add">
				<a href="StabilimentoSintesisAction.do?command=DettaglioCompletaRichiesta&id=<%=stab.getId()%>" title="Elaborazione e completamento del dato SINTESIS per caricamento in anagrafica GISA" style="text-decoration:none"><font size ="3px">[» »]</font></a>
				</dhv:permission>
				<%} else {  %>
				
				<% if (stab.getStatoImport()== StabilimentoSintesisImport.IMPORT_RIFIUTATO){ %>
				RIFIUTATO<br/>
				<%} else {%>
				PROCESSATO<br/>
				<%} %>
				
				<b>Elaborato da: </b><br/> <dhv:username id="<%= stab.getIdUtenteProcess() %>" /><br/>
				<b>in data: </b> <%=toDateasString(stab.getDataProcess()) %>
			<%} %>
			</td>
			
			</tr> 
			  
			  <%
			}	
			}
			%>
	 </tbody>
	</table>
	
<br/><br/>
<div class="pager">
	Page: <select class="gotoPage"></select>		
	<img src="javascript/img/first.png" class="first" alt="First" title="First page" />
	<img src="javascript/img/prev.png" class="prev" alt="Prev" title="Previous page" />
	<img src="javascript/img//next.png" class="next" alt="Next" title="Next page" />
	<img src="javascript/img/last.png" class="last" alt="Last" title= "Last page" />
	<select class="pagesize">
		<option value="10">10</option>
		<option value="20">20</option>
		<option value="30">30</option>
		<option value="40">40</option>
		<option value="50">50</option>
	</select>
</div>

<form id="sel" name="sel" action="StabilimentoSintesisAction.do?command=ListaRichiesteAggregate&auto-populate=true" method="post">
<!-- <div align="right"> -->


<!-- <select id="limit" name="limit" onChange="refreshLista(this.form)")> -->
<%-- <option value="10" <%=limit.equals("10") ? "selected" : "" %>>10</option> --%>
<%-- <option value="50" <%=limit.equals("50") ? "selected" : "" %>>50</option> --%>
<%-- <option value="100" <%=limit.equals("100") ? "selected" : "" %>>100</option> --%>
<%-- <option value="-1" <%=limit.equals("-1") ? "selected" : "" %>>Tutte</option> --%>
<!-- </select>   -->
<!-- </div> -->
</form>
	</dhv:container>

<br/><br/>

</body>
</html>