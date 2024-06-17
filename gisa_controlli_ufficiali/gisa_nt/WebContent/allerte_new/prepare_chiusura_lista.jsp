<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*" %>
<%@page import="org.aspcfs.modules.allerte_new.base.*"%>

<jsp:useBean id="ListaDistribuzione" class="org.aspcfs.modules.allerte_new.base.ListaDistribuzione" scope="request"/>
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
	calenda('data_chiusura', '', '');
});

function checkForm(form){
	if (document.getElementById("data_chiusura").value=='')
		alert("Inserire la data chiusura!");
	else{
		loadModalWindow();
		form.submit();
	}
}
</script>

<form name="addticket"  action="TroubleTicketsAllerteNew.do?command=ChiusuraLista&auto-populate=true" method="post">


<form name ="addticket" id="addticket">
<table cellpadding="4" cellspacing="0" width="100%" class="details">
	
	<tr>
    <th colspan="2">
      <strong><dhv:label name="">Chiusura Lista di distribuzione</dhv:label></strong>
    </th>
	</tr>
	
  
  <tr>
  <td nowrap class="formLabel">Data chiusura</td>
 <td>
 <input class="editField date_picker" type="text" id="data_chiusura" name="data_chiusura" size="10" value=""/>
 </td></tr>
 
 <%if (forzata!=null && forzata.equals("true")) {%>
 
 <tr><td nowrap class="formLabel">Chiusura forzata</td>
 <td>
 <input type="checkbox" id="chiusuraForzata" name="chiusuraForzata" readonly checked onClick="return false;"/>
 </td></tr>
 
 <tr>
  <td colspan="2">
 <font color="red">ATTENZIONE! Per questa lista di distribuzione non sono stati eseguiti tutti i CU pianificati.<br/>
 La lista sarà chiusa in modo forzato. </font>
 </td></tr>
 
 
 <%} %>
 

<tr><td colspan="2">
 <input type="hidden" id="idLista" name="idLista" value="<%=ListaDistribuzione.getId()%>"/>
<input type="button" value="CHIUDI LISTA DI DISTRIBUZIONE" name="Save" onClick="return checkForm(this.form)">
</td></tr>
</table>
</form>
</body>