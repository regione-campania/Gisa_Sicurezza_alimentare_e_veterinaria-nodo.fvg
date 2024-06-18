function chooseSpecie(numero) {	
	
	if (numero == 1) {
		document.getElementById( 'selaci' ).style.display = "none";
		document.getElementById( 'mammiferiCetacei' ).style.display = "";
		document.getElementById( 'rettiliTestuggini' ).style.display = "none";
	}
	else if (numero == 2) {
		document.getElementById( 'selaci' ).style.display = "none";
		document.getElementById( 'mammiferiCetacei' ).style.display = "none";
		document.getElementById( 'rettiliTestuggini' ).style.display = "";
	}
	else if (numero == 3) {
		document.getElementById( 'selaci' ).style.display = "";
		document.getElementById( 'mammiferiCetacei' ).style.display = "none";
		document.getElementById( 'rettiliTestuggini' ).style.display = "none";
	}
	else if (numero == 0) {
		document.getElementById( 'selaci' ).style.display = "none";
		document.getElementById( 'mammiferiCetacei' ).style.display = "none";
		document.getElementById( 'rettiliTestuggini' ).style.display = "none";		
	}
	
}


function checkform(form) {
	
	
	if (form.specieSinantropo.value == '0') {
		alert("Inserire la classe dell'animale marino");			
		return false;
	}
	
	if (form.specieSinantropo.value == '1' && form.tipologiaSinantropoU.value == '0') {
		alert("Selezionare il tipo di uccello");			
		return false;
	}
	
	if (form.specieSinantropo.value == '2' && form.tipologiaSinantropoM.value == '0') {
		alert("Selezionare il tipo di mammifero");			
		return false;
	}
	
	if (form.specieSinantropo.value == '3' && form.tipologiaSinantropoRA.value == '0') {
		alert("Selezionare il tipo di rettile/anfibio");			
		return false;
	}	
	
	if (form.sesso.value == 'X') {
		alert("Inserire il sesso del sinantropo");			
		return false;
	}	
			
	if (form.idEta.value == '-1') {
		alert("Selezionare l'età");	
		form.idEta.focus();
		return false;
	}	
	
			
		
	attendere();
	return true;
	
}