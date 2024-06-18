function checkform(form) 
{
	if(form.tipoFind.value == 'cc' && form.numeroCC.value == '')
	{
		alert("Inserire Numero Cartella Clinica");	
		form.numeroCC.focus();
		return false;
	}
	
	if(form.tipoFind.value == 'mc' && form.numeroMC.value == '')
	{
		alert("Inserire Numero identificativo animale");	
		form.numeroMC.focus();
		return false;		
	}
	
	attendere();
	return true;
	
	
}