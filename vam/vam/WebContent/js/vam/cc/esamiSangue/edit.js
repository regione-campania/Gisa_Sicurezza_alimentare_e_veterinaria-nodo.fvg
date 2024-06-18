function checkform(form) {
			
	var i=1;
	
	while(document.getElementById('sangue' + i) != null) 
	{
		
		if (!testFloating(document.getElementById('sangue' + i).value) && document.getElementById('sangue' + i).value != '') {
			alert ("Non è possibile inserire valori non numerici");					
			return false; 
		}
		
		i++;
	}
	
	if(!controllaDataAnnoCorrente(form.dataRichiesta, 'Data'))
	{
		return false;
	}
		
	attendere();
	return true;
	
}

function testFloating(str) {    
    return /^[+]?[0-9]+([\.,][0-9]+)?$/.test(str);
}