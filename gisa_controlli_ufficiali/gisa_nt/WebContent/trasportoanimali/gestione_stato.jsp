<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<script>

function checkForm() {
	
	 formTest = true;
	 message = "";
	 
	 if (document.getElementById('dataCambioStato').value == '') {
	     message += label("","- Controllare che la data sia stata settata\r\n");
	      formTest = false;
	 }
	 
	 if (formTest == false) {
	      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
	      return false;
	    } else {
	      return true;
	    }
	 
}



</script>

<table class="trails" cellspacing="0">
<tr>
<td>
<a class="close" href="#">
<font color="red">CHIUDI</font>
</a>
</td>
</tr>
</table>

<form method="post" action="TrasportoAnimali.do?command=CambiaStato&orgId=<%=request.getParameter("orgId") %>" name="viewData">
<input type="hidden" name = "chiusuraUfficio" id = "chiusuraUfficio" value="">
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
   <tr>
    <th colspan="2">
      <strong><dhv:label name="">Data cambio stato</dhv:label></strong> 
    </th>
  </tr>
   	<tr class="containerBody">
	 <td nowrap class="formLabel">
      	<dhv:label name="">Data</dhv:label>
	 </td>
	 <td>
		<input readonly type="text" id="dataCambioStato" name="dataCambioStato" value = "" size="10" />
		<a href="#" onClick="cal19.select(document.viewData.dataCambioStato,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
	 </td>
	</tr>
	
</table>		
<input type = "submit" onclick="return checkForm();" value = "Salva">
<input type = "hidden" name="stato_impresa" id="stato_impresa" value="">
</form>