<%@page import="org.aspcfs.modules.gestoriacquenew.base.GestoreAcque"%>
<%@page import="org.aspcfs.modules.gestoriacquenew.base.StoricoImport"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="org.aspcfs.modules.sintesis.base.LogImport"%>
<%@ include file="../utils23/initPage.jsp" %>

<jsp:useBean id="downloadURL" class="java.lang.String" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="storicoImportList" class="java.util.ArrayList" scope="request" />

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<link rel="stylesheet" type="text/css" href="javascript/jquerypluginTableSorter/css/theme.css"></link>
<link rel="stylesheet" type="text/css" href="javascript/jquerypluginTableSorter/css/jquery.tablesorter.pages.css"></link>

<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.pager.js"></script>

<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.widgets.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/tableJqueryFilterDialogImportAcque.js"></script>

<style>

.ric_input{
	width: 120px;
}

</style>

<script>

// $( document ).ready( function(){
// 	$("#tablelistaimportacque").tablesorter();
// });

function ricerca(n, id) {
  var input, filter, table, tr, td, i = 0, txtValue;
  var th = document.getElementsByTagName("th");
  
  while (i < $('.ric_input').size()){
	  var x = $('.ric_input')[i];
	  if($(x).attr('id') != id)
		  $(x).val('');
	  i++;
  }
  	input = document.getElementById(id);
	filter = input.value.toUpperCase();
	table = document.getElementById("tablelistaimportacque");
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[n];
		if (td) {
			txtValue = td.textContent || td.innerText;
			if (txtValue.toUpperCase().indexOf(filter) > -1) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}       
	}
}


function openPopup(link){
	
		  var res;
	        var result;
	        
	      //  if (document.all) {
	        	  window.open(link,'popupSelect',
	              'height=400px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');

		}
	      
function processaImport(id){
	loadModalWindow();
	window.location.href="StabilimentoGestoriAcqueReteNewAction.do?command=StoricoImport&idImport="+id;
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
	  toRet =giorno+"/"+mese+"/"+anno+" "+ora+":"+minuto+":"+secondi;
	  return toRet;
	  
  }%>

    <br>
   
  <dhv:container name="storicoImport" selected="Storico Import" object=""  param="">
 
 <%
 	ArrayList storico1 = ((ArrayList<StoricoImport>)storicoImportList);
 %>
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
			<option value="<%=storico1.size()%>">Tutti</option>
		</select> / <%=storico1.size()%>
	</div>
  		
<table id="tablelistaimportacque" class="details tablesorter" width="100%">
	<thead>
		<tr>
			<th>Data Import</th>
			<th>Importato Da</th>
			<th>Tipo Richiesta</th>
			<th>Gestore Acque</th>
			<th>Nome File</th>
			<th class="sorter-false">Log Import</th>
			<th class="sorter-false">Recupera file</th>
		</tr>
	</thead>
	
	<tbody>
<%
	if (!storicoImportList.isEmpty()) 
	{
		for (StoricoImport storico: ((ArrayList<StoricoImport>)storicoImportList))
		{
%>
			<tr>
				<td>
					<%=toDateasStringWitTime(storico.getDataImport())%>
				</td> 
				<td> 
					<dhv:username id="<%=storico.getIdUtente()%>"></dhv:username>
				</td>
				<td> 
					<%=storico.getTipoRichiesta()%>
				</td>
				<td> 
					<%=storico.getNomeGestoreAcque()%>
				</td>
				<td> 
					<%=storico.getNomeFile()%>
				</td>
				<td>
					<%
						if( (storico.getErroreInsert()!=null && !storico.getErroreInsert().equals("")) || (storico.getErroreParsingFile()!=null && !storico.getErroreParsingFile().equals("")))
						{
					%>
							<a href="#" onClick="window.open('StabilimentoGestoriAcqueReteNewAction.do?command=VediErrori&idImport=<%=storico.getId()%>','popupSelect',
				              'height=700px,width=700px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes')
								">Vedi</a>
					<%
						}
						else
						{
							out.println("N.D.");
						}
					%>
				</td>
				<td>
<%
					String url = "StabilimentoGestoriAcqueReteNewAction.do?command=DownloadImport&idImport=" + storico.getId();
					if(storico.getCodDocumento()!=null && !storico.getCodDocumento().equals(""))
					{
						String estensione = storico.getNomeFile().split("\\.")[1];
						url = "GestioneAllegatiUpload.do?command=DownloadPDF&codDocumento=" + storico.getCodDocumento() + "&tipoDocumento="+estensione+"&nomeDocumento=" + storico.getNomeFile();
%>
						<%
					}
%>	
					<a href="#" onClick="openPopup('<%=url%>')">Download</a>
					
				</td>
			</tr>
<%
		} 
	}
	else 
	{
%>
			<tr>
				<td colspan="6">
					Non sono stati generati import
				</td>
			</tr> 
		
<% 	
	} 
%>
		
	</tbody>
	</table>
	
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
			<option value="<%=storico1.size()%>">Tutti</option>
		</select> / <%=storico1.size()%>
	</div>


		</dhv:container>

</body>
</html>