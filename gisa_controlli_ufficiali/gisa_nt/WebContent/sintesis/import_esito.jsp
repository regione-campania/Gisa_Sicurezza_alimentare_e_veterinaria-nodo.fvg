<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<jsp:useBean id="logImport" class="org.aspcfs.modules.sintesis.base.LogImport" scope="request"/>
<jsp:useBean id="popup" class="java.lang.String" scope="request"/>

<%@page import="org.json.JSONObject"%>

<%@ include file="../utils23/initPage.jsp" %>


<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<script>
function mostraNascondiRecord(btn){
	  var x = document.getElementsByName("tr_"+btn.id);

	  if (btn.value=="+"){
		  btn.value = "-";
		  
		  for (var i = 0; i<x.length; i++){
			  if (x[i].innerHTML != "<td colspan=\"2\"></td>")
			  	x[i].style.display = "table-row";
			  }
		  
	  } else {
		  btn.value = "+";
		  
		   for (var i = 0; i<x.length; i++)
			  x[i].style.display = "none";
		  
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


<%
JSONObject jsonScartati = logImport.getJsonScartati();
JSONObject jsonValidazione = logImport.getJsonValidazione();
%>

<%if (popup==null || !"true".equals(popup)){ %>
<center><font color="green" size="5px"><b>L'import e' terminato con successo.</b></font><br/>
<font color="green" size="3px">Sono stati importati <%=(int) jsonValidazione.get("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA") +  (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA") + (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA") + (int) jsonValidazione.get("TOT_LINEA_NON_MAPPATA") + (int) jsonValidazione.get("TOT_NESSUNA_VARIAZIONE") %> record.</font><br/>
<font size="3px">Questi risultati resteranno disponibili tramite il menu "Storico Import".</font>
</center>

<br/>
<%} %>


<center>
<table class="details" cellpadding="20" cellspacing="20" style="border-collapse: collapse" width="50%">
<col width="70%">
 
<tr><th colspan="2" style="font-size: 18px; text-align: center">ESITO IMPORT</th></tr> 
<tr><td class="formLabel">Id</td><td><%=logImport.getId() %></td></tr>
<tr><td class="formLabel">DATA INIZIO IMPORT</td><td><%=fixData(logImport.getEntered().toString()) %></td></tr>
<tr><td class="formLabel">DATA FINE IMPORT</td><td><%=logImport.getEnded() != null ? fixData(logImport.getEnded().toString()) : "" %></td></tr>
<tr><td class="formLabel">DATA DOCUMENTO SINTESIS</td><td><%=toDateasString(logImport.getDataDocumentoSintesis()) %></td></tr>
<tr><td class="formLabel">UTENTE</td><td><dhv:username id="<%= logImport.getUtenteImport() %>"></dhv:username></td></tr> 

<tr><td colspan="2"></td></tr> 
 
<tr><th colspan="2" style="font-size: 18px; text-align: center">RISULTATI</th></tr> 

<tr style="background:#B3FDCB"><td align="right">ANAGRAFICHE RISULTATE ALLINEATE</td><td><%=jsonValidazione.get("TOT_NESSUNA_VARIAZIONE") %> <% if ( (int) jsonValidazione.get("TOT_NESSUNA_VARIAZIONE")>0){ %><input type="button" style="font-weight: bold !important;  height:25px; width:25px;" value="+" id="btn_NESSUNA_VARIAZIONE" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
<tr style="display:none" id="tr_btn_NESSUNA_VARIAZIONE" name="tr_btn_NESSUNA_VARIAZIONE"><td colspan="2"><%=jsonValidazione.get("MSG_NESSUNA_VARIAZIONE") %></td></tr>

<tr style="background:#B3FDCB"><td align="right">PRATICHE AUTOMATICAMENTE PROCESSATE</td><td><%=(int) jsonValidazione.get("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA") +  (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA") + (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA") %> <% if ( (int) jsonValidazione.get("TOT_INSERISCI_STABILIMENTO_INSERISCI_LINEA") +  (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_INSERISCI_LINEA") + (int) jsonValidazione.get("TOT_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA") >0){ %><input type="button" style="font-weight: bold !important;  height:25px; width:25px;" value="+" id="btn_PROCESSATI" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
<tr style="display:none" id="tr_btn_INSERISCI_STABILIMENTO_INSERISCI_LINEA" name="tr_btn_PROCESSATI"><td colspan="2"><%=jsonValidazione.get("MSG_INSERISCI_STABILIMENTO_INSERISCI_LINEA") %></td></tr>
<tr style="display:none" id="tr_btn_AGGIORNA_STABILIMENTO_INSERISCI_LINEA" name="tr_btn_PROCESSATI"><td colspan="2"><%=jsonValidazione.get("MSG_AGGIORNA_STABILIMENTO_INSERISCI_LINEA") %></td></tr>
<tr style="display:none" id="tr_btn_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA" name="tr_btn_PROCESSATI"><td colspan="2"><%=jsonValidazione.get("MSG_AGGIORNA_STABILIMENTO_AGGIORNA_LINEA") %></td></tr>

<tr style="background:#D77B7B"><td align="right">PRATICHE CON ERRORI E RELATIVI DETTAGLI</td><td><%=(int) jsonValidazione.get("TOT_LINEA_NON_MAPPATA") + (int) jsonScartati.get("TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO") + (int) jsonScartati.get("TOT_SCARTATI_STATO_ANAGRAFE") %> <% if ( (int) jsonValidazione.get("TOT_LINEA_NON_MAPPATA") + (int) jsonScartati.get("TOT_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO") + (int) jsonScartati.get("TOT_SCARTATI_STATO_ANAGRAFE") >0){ %><input type="button" style="font-weight: bold !important;  height:25px; width:25px;" value="+" id="btn_SCARTATI" onClick="mostraNascondiRecord(this); return false;"/><%} %></td></tr>
<tr style="display:none" id="tr_btn_LINEA_NON_MAPPATA" name="tr_btn_SCARTATI"><td colspan="2"><%=jsonValidazione.get("MSG_LINEA_NON_MAPPATA") %></td></tr>
<tr style="display:none" id="tr_btn_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO" name="tr_btn_SCARTATI"><td colspan="2"><%=jsonScartati.get("MSG_SCARTATI_APPROVAL_NUMBER_TROPPO_LUNGO") %></td></tr>
<tr style="display:none" id="tr_btn_SCARTATI_STATO_ANAGRAFE" name="tr_btn_SCARTATI"><td colspan="2"><%=jsonScartati.get("MSG_SCARTATI_STATO_ANAGRAFE") %></td></tr>

</table>
  
  
 
  
  
  </center>
 
<%if (popup==null || !"true".equals(popup)){ %>
  <br/><br/>
  <center>
  <input type="button" value="VAI ALLE PRATICHE" onClick="loadModalWindow(); window.location.href='StabilimentoSintesisAction.do?command=ListaRichiesteAggregate'"/>
  </center>
  <%} %>
