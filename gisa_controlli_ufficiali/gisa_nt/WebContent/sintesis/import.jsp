<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>

<%@ include file="../utils23/initPage.jsp" %> 


<!-- 
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
 -->

  <script>
       $( document ).ready( function(){
    	   calenda('sintesisData','','0');
       });
       
       function checkFormFile(form){
    	   
    	 var sintesisData = document.getElementById("sintesisData").value;  
		var importOk = true;
		var errorString = '';
		
		var fileCaricato = form.file;

		if (fileCaricato.value=='' || !fileCaricato.value.toLowerCase().endsWith(".xls")){
		errorString+='Errore! Selezionare un file in formato XLS!';
		form.file.value='';
		importOk = false;
	}
		
		if (importOk==false){
			alert(errorString);
			return false;
		}
	
	if (sintesisData==''){
			importOk = false;
			errorString +='Errore! Indicare data del documento SINTESIS.';
	}
	
	if (!importOk)
		alert(errorString);
	else
	{
		
		if (!confirm("ATTENZIONE! Proseguire?")){
			return false;
		}
		
	alert("L'import impiegherà diversi minuti.");	
	form.uploadButton.hidden="hidden";
	form.file.hidden="hidden";
	document.getElementById("image_loading").hidden="";
	document.getElementById("text_loading").hidden="";
	loadModalWindow();
	form.submit();
	}
}</script>

<script>
	      
function openPopupLarge(link){
	
	  var res; 
      var result;
      
    //  if (document.all) {
      	  window.open(link,'popupSelectImportLog', 
            'height=1000px,width=1200px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');

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


<jsp:useBean id="msg" class="java.lang.String" scope="request" />
<jsp:useBean id="msgSemaforo" class="java.lang.String" scope="request" />
<jsp:useBean id="log" class="org.aspcfs.modules.sintesis.base.LogImport" scope="request" />


<%if (msg!=null && !msg.equals("") && !msg.equals("null")) {%>
<script>
alert("<%=msg%>");
</script>
<%} %>

<dhv:container name="sintesisimport" selected="Importa da File"  object="" >


<form method="POST" action="StabilimentoSintesisAction.do?command=ImportDaFile" enctype="multipart/form-data" >

<table class="details" id="tableImport" cellpadding="10" cellspacing="10">

<tr>
<td class="formLabel">Data Documento SINTESIS</td>
<td>
 
 <input class="date_picker" type="text" id="sintesisData" name="sintesisData" size="10" />&nbsp; 
 
 </td>
 </tr>
 
 <tr>
 <td class="formLabel">File</td>
 
 <td>
 
 <input type="file" name="file" id="file"  /> 
 <img id="image_loading" hidden="hidden" src="gestione_documenti/images/loading.gif" height="15"/>
 <input type="text" disabled id="text_loading" name="text_loading" hidden="hidden" value="Caricamento in corso..."  style="border: none"/>
 <input type="hidden" value="/tmp" name="destination"/>
 
 </td>
 </tr>
 
 <tr>
 <td colspan="2" class="formLabel">
 
 <input type="button" value="CONFERMA E INVIA FILE"  id="uploadButton" name="uploadButton"  onClick="checkFormFile(this.form)" />
 
 </td>
 </tr>
 </table>
 
</form>

<iframe scrolling="no" src="ServletSemaforoSintesis" id="iframeSemaforo" style="top:0;left: 0;width:100%;height: 100%; border: none; display:none" ></iframe>

<% if (log != null) {%> 
<br/>
<table class="details" cellpadding="20" cellspacing="20" id="tableLogImport">
<tr>
			<th style="text-align: center !important">Data ultimo import</th>
			<th style="text-align: center !important">Data fine procedura</th>
			<th style="text-align: center !important">Data documento sintesis</th>
			<th style="text-align: center !important">Importato da</th>
			<th style="text-align: center !important">Esito</th>
			<th style="text-align: center !important">Recupera file</th>
</tr>
<td align="center"><%=fixData(log.getEntered().toString()) %></td>
<td align="center"><%=fixData(log.getEnded().toString()) %></td> 
<td align="center"><%=toDateasString(log.getDataDocumentoSintesis()) %></td> 
<td align="center"> <dhv:username id="<%= log.getUtenteImport() %>"></dhv:username></td> 
<td align="center"><a href="#" onClick="openPopupLarge('StabilimentoSintesisAction.do?command=EsitoImport&idImport=<%=log.getId()%>&popup=true')">Vedi</a></td>
<td align="center"><%if (log.getHeaderFile()!=null && !"".equals(log.getHeaderFile())){ %><a href="#" onClick="openPopupLarge('GestioneAllegatiUpload.do?command=DownloadPDF&codDocumento=<%=log.getHeaderFile()%>&tipoDocumento=xls&nomeDocumento=Import_<%=log.getId()%>.xls')">Download</a><%} %></td>
</tr>
</table>
<br/><br/><br/><br/
<%}%>

</dhv:container>

<%if (msgSemaforo!=null && !msgSemaforo.equals("") && !msgSemaforo.equals("null")) {%>
<script>
document.getElementById("tableImport").style.display= "none";
document.getElementById("tableLogImport").style.display= "none";
document.getElementById("iframeSemaforo").style.display= "block";

$(function(){setInterval( "refresh()", 2000 );});
 function refresh(){document.getElementById('iframeSemaforo').contentWindow.location.reload(); }
</script>
<%} %>



