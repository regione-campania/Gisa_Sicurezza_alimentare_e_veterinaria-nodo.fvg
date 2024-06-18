function checkform(form) {
	
	
	if (form.closureDescription.value == '') {
		alert("Inserire una descrizione di chiusura");	
		return false;
	}	
		
	attendere();
	return true;
	
}