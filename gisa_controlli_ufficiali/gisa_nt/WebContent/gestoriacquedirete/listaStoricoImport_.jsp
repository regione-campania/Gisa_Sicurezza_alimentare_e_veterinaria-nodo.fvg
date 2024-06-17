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

<style>

.ric_input{
	width: 120px;
}

</style>

<script>


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
	table = document.getElementById("res_table");
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
  
  		
<table id="res_table" class="details" width="100%">
		<tr>
			<th>Data Import <br> <input class="ric_input" id="ric_data" onkeyup="ricerca(0,'ric_data')" /> </th>
			<th>Importato Da <br> <input class="ric_input" id="ric_import" onkeyup="ricerca(1,'ric_import')" /></th>
			<th>Tipo Richiesta<br> <input class="ric_input" id="ric_tipo" onkeyup="ricerca(2,'ric_tipo')" /></th>
			<th>Gestore Acque <br> <input class="ric_input" id="ric_gestore" onkeyup="ricerca(3,'ric_gestore')" /></th>
			<th>Nome File<br> <input class="ric_input" id="ric_file" onkeyup="ricerca(4,'ric_file')" /></th>
			<th>Log Import</th>
			<th>Recupera file</th>
		</tr>

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
		
	
	</table>
	



		</dhv:container>

</body>
</html>