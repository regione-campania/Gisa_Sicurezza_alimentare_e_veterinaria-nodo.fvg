<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="tutti" class="java.lang.String" scope="request"/>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<jsp:useBean id="listaImport" class="java.util.ArrayList" scope="request"/>


<%@page import="org.aspcfs.modules.sintesis.base.LogImport"%>

<%@ include file="../utils23/initPage.jsp" %>


<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>



<script>
function openPopup(link){
	
		  var res;
	        var result;
	        
	      //  if (document.all) { 
	        	  window.open(link,'popupSelect',
	              'height=400px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');

		}
	      
function openPopupLarge(link){
	
	  var res; 
      var result;
      
    //  if (document.all) {
      	  window.open(link,'popupSelectImportLog', 
            'height=1000px,width=1200px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');

	}
    	      
function processaImport(id){
	loadModalWindow();
	window.location.href="StabilimentoSintesisAction.do?command=ProcessaCoda&idImport="+id;
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
   
  <dhv:container name="sintesisimport" selected="Storico Import" object=""  param="">
  
  		
<table  class="details" width="100%">

		<tr>
			<th style="text-align: center !important">ID</th>
			<th style="text-align: center !important">Data import</th>
			<th style="text-align: center !important">Data sintesis</th>
			<th style="text-align: center !important">Importato da</th>
			<th style="text-align: center !important">Esito</th>
			<th style="text-align: center !important">Recupera file</th>
<!-- 			<th>Processa</th> -->
		</tr>
			<%

	if (listaImport.size()>0) {
		for (int i=0;i<listaImport.size(); i++){
			LogImport log = (LogImport) listaImport.get(i);
			
			%>
			
			<tr>
			<td align="center"><%=log.getId() %></td> 
			<td align="center"><%=fixData(log.getEntered().toString()) %></td> 
			<td align="center"><%=toDateasString(log.getDataDocumentoSintesis()) %></td> 
			<td align="center"> <dhv:username id="<%= log.getUtenteImport() %>"></dhv:username></td> 
			<td align="center"><%if (log.getEnded()!=null) { %><a href="#" onClick="openPopupLarge('StabilimentoSintesisAction.do?command=EsitoImport&idImport=<%=log.getId()%>&popup=true')">Vedi</a> <% } else { %> <font color="red">IMPORT IN CORSO <%if (log.getEndedLetturaFile()==null) { %><dhv:permission name="sintesis-add"><a href="StabilimentoSintesisAction.do?command=RestartImportDaFile&idImport=<%=log.getId()%>"><b>IMPORT BLOCCATO? RICOMINCIA</b></a></dhv:permission> <% } %></font> <% } %></td>
			<td align="center"><%if (log.getHeaderFile()!=null && !"".equals(log.getHeaderFile())){ %><a href="#" onClick="openPopup('GestioneAllegatiUpload.do?command=DownloadPDF&codDocumento=<%=log.getHeaderFile()%>&tipoDocumento=xls&nomeDocumento=Import_<%=log.getId()%>.xls')">Download</a><%} %></td>
<%-- 			<td><a href="#" onClick="processaImport('<%=log.getId()%>')">Processa</a></td>  --%>
		</tr>
		<%} } else {%>
		<tr><td colspan="6"> Non sono stati caricati import.</td></tr> 
		<% } %>
	</table>
	
	<% if (tutti==null || !"si".equals(tutti)) { %>
	<br/>	<br/>
	<center>Ultimi 20 import caricati.<br/>
	<a href="StabilimentoSintesisAction.do?command=StoricoImport&tutti=si" onClick="loadModalWindow()">Mostra tutti</a>
	</center>
	<% } %>

	</dhv:container>

</body>
</html>