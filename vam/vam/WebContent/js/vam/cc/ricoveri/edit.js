function checkform(form) {
	
	if (form.ricoveroData.value == '') {
		alert("Inserire una data");	
		return false;
	}	
	
	if(!controllaDataAnnoCorrente(form.ricoveroData, 'Data'))
	{
		return false;
	}

	if (form.idStrutturaClinica.value == '-1') {
		alert("Inserire una struttura");	
		return false;
	}
	
		
	attendere();
	return true;
	
}