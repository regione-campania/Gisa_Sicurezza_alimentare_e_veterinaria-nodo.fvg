function checkform(form) {
	

	if (form.idStrutturaClinica.value == '-1') {
		alert("Inserire una struttura");	
		return false;
	}
			
	attendere();
	return true;
	
}