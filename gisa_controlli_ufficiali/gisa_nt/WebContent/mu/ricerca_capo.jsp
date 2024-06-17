<script>
function checkForm(form){
	var matricola = form.matricola.value;
	var message = '';
	var esito = true;
	if (matricola.length < 5){
		message += 'Inserire almeno cinque caratteri nel campo MATRICOLA.';
		esito = false;
	}
		if (esito==false)
			alert (message);
		return esito;
}
</script>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="MacellazioneUnica.do?command=List&orgId=51251">Home macellazioni
		</td>
	</tr>
</table>

 <form name="ricercaCapo" id="ricercaCapo" action="MacellazioneUnica.do?command=CercaCapo" method="post" >
 
<input type="hidden" id="idMacello" name="idMacello" value="<%=request.getParameter("orgId")%>"/> 
<table class="details" layout="fixed" width="50%">
<col width="180px">
<th colspan="2">Ricerca capo</th> 
<tr><td class="formLabel">Matricola</td> <td><input type="text" id="matricola" name="matricola"/></td></tr>
</table>

<input type="button" value="CERCA" onClick="if (checkForm(this.form)){this.form.submit();}"/> 

</form>