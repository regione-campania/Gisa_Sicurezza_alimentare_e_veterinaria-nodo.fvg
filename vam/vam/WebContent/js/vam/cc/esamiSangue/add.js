function checkform(form) {
		
	if (form.dataRichiesta.value == '') {
		alert("Inserire la data della richiesta");
		form.dataRichiesta.focus();
		return false;
	}	
	
	if(!controllaDataAnnoCorrente(form.dataRichiesta, 'Data'))
	{
		return false;
	}
	
	var i=1;
	
	while(document.getElementById('sangue' + i) != null) 
	{
		
		if (!testFloating(document.getElementById('sangue' + i).value) && document.getElementById('sangue' + i).value != '') {
			alert ("Non è possibile inserire valori non numerici");					
			return false; 
		}
		
		i++;
	}		
		
	attendere();
	return true;
	
}

function testFloating(str) {    
    return /^[+]?[0-9]+([\.,][0-9]+)?$/.test(str);
}