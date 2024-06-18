function checkform(form) 
{
	if (form.numeroSinantropo.value == '') {
		alert("Inserire un identificativo del sinantropo da ricercare");			
		return false;
	}	
	
	return true;

}