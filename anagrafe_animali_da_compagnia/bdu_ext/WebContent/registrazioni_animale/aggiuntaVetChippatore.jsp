<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>



<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request" />

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<td class="formLabel" nowrap>Cognome</td>
		<td>
			<input type="text" name="cognomeVeterinarioMicrochip" id="cognomeVeterinarioMicrochip" value="" maxlength="250" size="30" /> <font color="red">*</font> 
		</td>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Nome</td>
		<td>
			 <input type="text" name="nomeVeterinarioMicrochip" id="nomeVeterinarioMicrochip" value="" maxlength="250" size="30" /> <font color="red">*</font> 
		</td>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Codice fiscale</td>
		<td>
			<input type="text" name="cfVeterinarioMicrochip" id="cfVeterinarioMicrochip" value="" maxlength="16" size="30" /> <font color="red">*</font> 
		</td>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Data inizio</td>
		<td>
			<input class="date_picker" type="text" name="dataInizioVeterinarioMicrochip" id="dataInizioVeterinarioMicrochip" labelcampo="DATA INIZIO" value="" size="10" /> 
		</td>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Data fine</td>
		<td>
			<input class="date_picker" type="text" name="dataFineVeterinarioMicrochip" id="dataFineVeterinarioMicrochip" onclick="checkDataFine('dataInizioVeterinarioMicrochip','dataFineVeterinarioMicrochip')" value="" size="10" /> 
		</td>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Asl</td>
		<td>
			<%=AslList.getHtmlSelect("aslVeterinarioMicrochip", -1)%> <font color="red">*</font> 
		</td>
	</tr>
</table>


<script>

$( 'document' ).ready( function(){
	calenda('dataInizioVeterinarioMicrochip','','');
	calenda('dataFineVeterinarioMicrochip','','');
});

var selectobject = document.getElementById("aslVeterinarioMicrochip");
for (var i=0; i<selectobject.length; i++) {
    if (selectobject.options[i].value == '14')
        selectobject.remove(i);
}
</script>
</body>
</html>