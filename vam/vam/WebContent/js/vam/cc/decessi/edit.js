function checkform(form) {
	
	
	if (form.dataMorte.value == '') {
		alert("Inserire la data del decesso");	
		form.dataMorte.focus();
		return false;
	}
	
	
	
	attendere();
	return true;
	
	
}