function checkform(form) {
		
			
	if (form.dataDecesso.value == '') {
		alert("Inserire la data di decesso");	
		form.dataDecesso.focus();
		return false;
	}	
	
	if (form.causaMorte.value == 0) {
		alert("Inserire la causa del decesso");	
		form.causaMorte.focus();
		return false;
	}	
		
		
	attendere();
	return true;
	
}