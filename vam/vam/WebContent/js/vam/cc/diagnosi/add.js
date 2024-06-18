function checkform(form) {
	

	if (form.dataDiagnosi.value == '') {
		alert("Inserire una data");	
		form.dataDiagnosi.focus();
		return false;
	}	
	
	attendere();
	return true;
	
	

}