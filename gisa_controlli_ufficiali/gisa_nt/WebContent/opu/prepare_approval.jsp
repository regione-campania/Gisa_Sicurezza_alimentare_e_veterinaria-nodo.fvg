<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>



<%@page import="java.sql.Timestamp"%>
<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>
<jsp:useBean id="Operatore" class="org.aspcfs.modules.opu.base.Operatore" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="error" class="java.lang.String" scope="request"/>
<%@ include file="../utils23/initPage.jsp"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script>

function checkForm(form){
	var approval = document.getElementById("approval").value;
	
	var formEsito = true;
	 
	if (approval==''){
		formEsito = false;
		alert('Inserire un approval number!');
	}
	
	
	if (formEsito){
		loadModalWindow();
		form.submit();
	}
	else
		return false;
}
</script>



<%
String param = "stabId="+StabilimentoDettaglio.getIdStabilimento()+"&opId=" + StabilimentoDettaglio.getIdOperatore();
%>

<%if (error!=null){ %>
<font color="red" ><%=error %></font>
<%} %>

<form name="approval" action="OpuStab.do?command=InsertApproval" method="post">
<table class="details" width="100%" style="border:1px solid black">
<tr><th>APPROVAL NUMBER</th></tr>

<tr> <td>
Approval Number
</td></tr>
<tr><td>
<input type="text" id="approval" name="approval"/>

</td></tr>

<tr><td>

<% if (StabilimentoDettaglio.getStato()==3){ %>
<input type ="button" value="CONFERMA" onClick="checkForm(this.form)"/>
<%} else { %>
<INPUT TYPE="button" disabled style="background-color:#D3D3D3; color:#fff;" value="CONFERMA"/> Lo stabilimento è già stato validato.
<%} %>
</td></tr>



<input type ="hidden" name ="stabId" id ="stabId" value="<%=StabilimentoDettaglio.getIdStabilimento() %>" />

</table>
</form>
