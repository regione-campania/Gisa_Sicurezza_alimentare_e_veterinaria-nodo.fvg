<jsp:useBean id="trasgressoreObbligato" class="java.lang.String" scope="request"/>

<script>
function checkForm(form){
	if ((form.piva.value.length<6) && (form.nome.value.length<6)){
		alert('Indicare almeno uno tra Partita IVA e Ragione sociale (min 6 caratteri)');
		return false;
	}
	form.submit();
	
}
</script>


<form name="addticket" action="GestionePagoPa.do?command=SearchPagatore&auto-populate=true" method="post">
<table class="details">
<tr><td><b>Partita IVA / Codice fiscale</b></td><td><input type="text" name="piva" id="piva" maxlength="16"/></td></tr>
<tr><td><b>Ragione sociale / Nominativo</b></td><td><input type="text" name="nome" id="nome" /> </td></tr>
<tr><td colspan="2"><input type="button" onClick="checkForm(this.form)" value="CERCA"/></td></tr>
</table>
<input type="hidden" id="trasgressoreObbligato" name="trasgressoreObbligato" value="<%=trasgressoreObbligato%>"/>
</form>


