<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<script>
function checkForm(form){
	
	var iuv = form.iuv.value;
	if (iuv.trim().length < 15) {
		alert('Inserire un IUV valido!');
		return false;
	}
	loadModalWindow();
	form.submit();
	
}
</script>

<body>

<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="RegistroTrasgressori.do?command=RegistroSanzioni">Registro Trasgressori</a> > 
Cerca Avviso di Pagamento
</td>
</tr>
</table>
<%-- End Trails --%>


<form name="searchAvviso" action="RegistroTrasgressori.do?command=SearchAvviso&auto-populate=true" method="post">

<center>
<table class="details" cellpadding="10" cellspacing="10" width="50%">
<col width="30%">
<tr><th colspan="2">RICERCA AVVISO DI PAGAMENTO</th></tr>

<tr>
<td class="formLabel">Identificativo Univoco Versamento (IUV)</td>
<td><input type="text" id="iuv" name="iuv" size="20"/></td>
</tr>

<tr>
<td colspan="2"><input type="button" onClick="checkForm(this.form)" value="RICERCA"/></td>
</tr>

</table>
</center>

</form>



</body>

</html>