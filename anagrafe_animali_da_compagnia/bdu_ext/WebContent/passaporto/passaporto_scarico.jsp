<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.microchip.base.*,java.text.DateFormat" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript">
</script>

<script language="JavaScript">
	
	function doCheck(form) {
      if (form.dosubmit.value == "false") {
      	return true;
     } else {
      return(checkMC(form));
     }
   	}
   	
	function checkForm(){
		formTest = true;
    	message = "";
    	
    	/* alert("checking");
    	alert(document.forms[0].nrPassaporto.value.length); */
    	if ( !( (document.forms[0].nrPassaporto.value.length == 13) &&  ( /^[a-z0-9]+$/i.test( document.forms[0].nrPassaporto.value )) )){
    		message += label("", "- La lunghezza del passaporto deve essere di 13 caratteri alfanumerici\r\n");
      		formTest = false;
    	}
    	
    	if (formTest == false) {
      		alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      		
      		return false;
    	}else{
    		document.forms[0].submit();
    	}
	}

</script>


<body>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  Scarico passaporto
</td>
</tr>
</table>
<%-- End Trails --%>
<form action="Passaporto.do?command=EseguiScarico&auto-populate=true" method="post" onSubmit="return checkForm(this);">


<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="100%" valign="top">
    
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	  <tr>
	    <th colspan="2">
		  <strong>Scarico Passaporto a priori</strong>
		</th>
	  </tr>
	  
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Inserisci valore passaporto da invalidare
	    </td>
	    <td>
	      <input name="nrPassaporto" type="text" size="20" maxlength="13"> <font color="red">*</font>
	    </td>
	  </tr>
	  
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Motivazione
	    </td>
	    <td>
	      Passaporto non utilizzabile
	    </td>
	  </tr>

	</table>
		  
    <%= showError( request, "errore") %>
    
    <% if ( request.getAttribute("ok") != null ) { %>
    	<br>
    	<%= showAttribute( request, "ok") %>
    <% } %>
    
   </td>
  </tr>
</table>
<br />
<input type="button" value="Esegui Scarico" onclick="javascript:checkForm();">
<input type="hidden" name="dosubmit" value="true" />
</form>
</body>