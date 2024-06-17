<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*" %>
<%@page import="org.aspcfs.modules.allerte_new.base.*"%>

<jsp:useBean id="idAllerta" class="java.lang.String" scope="request"/>
<jsp:useBean id="forzata" class="java.lang.String" scope="request"/>


<%@ include file="../utils23/initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

<!-- 
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
 -->
 
<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>


<script>
$( document ).ready( function(){
	calenda('data_trasmissione', '', '');
});

function checkForm(form){
	if (document.getElementById("data_trasmissione").value=='')
		alert("Inserire la data trasmissione!");
	else if (document.getElementById("note")!=null && document.getElementById("note").value=='')
		alert("Inserire le note!");
	else{
		loadModalWindow();
		form.submit();
	}
}
</script>

<form name="addticket"  action="TroubleTicketsAllerteNew.do?command=ChiusuraAllerta&auto-populate=true" method="post">


<form name ="addticket" id="addticket">
<table cellpadding="4" cellspacing="0" width="100%" class="details">
	<tr>
    <th colspan="2">
      <strong><dhv:label name="">Chiusura Allerta</dhv:label></strong>
    </th>
	</tr>
	
  
  <tr>
  <td nowrap class="formLabel">Data trasmissione</td>
 <td>
 <input class="editField date_picker" type="text" id="data_trasmissione" name="data_trasmissione" size="10" value=""/>
 </td></tr>
 
 
 <%if (forzata!=null && forzata.equals("true")) {%>
 
 <tr>
 <td  nowrap class="formLabel">
 CHIUSURA FORZATA
 </td>
 
 <td>
 <input type="checkbox" id="chiusuraForzata" name="chiusuraForzata" readonly checked onClick="return false;"/>
 </td>
 </tr>
 
 <tr>
  <td  nowrap class="formLabel">
 Motivo/Note
 </td>
 
 
 <td> 
 <textarea name="note" id="note" cols="30" rows="3"></textarea>
 </td>
 </tr>
 
  <tr>
 <td colspan="2">
 <font color="red">ATTENZIONE! Per questa allerta non sono state chiuse tutte le liste di distribuzione associate.<br/>
 Le liste e l'allerta saranno chiuse in modo forzato con Data Chiusura uguale alla Data Trasmissione dell'allerta.</font>
 </td>
 </tr>
 
 <%} %>
 
 <input type="hidden" id="idAllerta" name="idAllerta" value="<%=idAllerta%>"/>
 

 
 <tr>
 <td colspan="2">
<input type="button" value="CHIUDI ALLERTA" name="Save" onClick="return checkForm(this.form)">
</td>
</tr>


</table>
</form>
</body>