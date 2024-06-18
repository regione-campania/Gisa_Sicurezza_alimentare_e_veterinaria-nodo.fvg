function checkform(form) 
{
	if (form.dataRichiesta.value == '') {
		alert("Inserire la data della richiesta");	
		form.dataRichiesta.focus();
		return false;
	}	
	
	form.submit();
}