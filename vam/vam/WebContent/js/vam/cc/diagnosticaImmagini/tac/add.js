function checkform(form) 
{
	attendere();
	if (form.dataRichiesta.value=='') {
		$( "#dialog-modal" ).dialog( "close" );
		alert("Inserire la data della richiesta");	
		form.dataRichiesta.focus();
		return false;
	}	
	
	form.submit();
}