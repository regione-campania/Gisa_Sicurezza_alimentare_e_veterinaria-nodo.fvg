function chooseSpecie(numero) {	
	
	if (numero == 1) {
		document.getElementById( 'uccelli' ).style.display = "";
		document.getElementById( 'mammiferi' ).style.display = "none";
		document.getElementById( 'rettiliAnfibi' ).style.display = "none";
	}
	else if (numero == 2) {
		document.getElementById( 'uccelli' ).style.display = "none";
		document.getElementById( 'mammiferi' ).style.display = "";
		document.getElementById( 'rettiliAnfibi' ).style.display = "none";
	}
	else if (numero == 3) {
		document.getElementById( 'uccelli' ).style.display = "none";
		document.getElementById( 'mammiferi' ).style.display = "none";
		document.getElementById( 'rettiliAnfibi' ).style.display = "";
	}
	else if (numero == 0) {
		document.getElementById( 'uccelli' ).style.display = "none";
		document.getElementById( 'mammiferi' ).style.display = "none";
		document.getElementById( 'rettiliAnfibi' ).style.display = "none";		
	}
	
}


function checkform(form) {
	
	
	if (form.specieSinantropo.value == '0') {
		alert("Inserire la classe del Sinantropo");			
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
		alert("Selezionare l'et�");	
		form.idEta.focus();
		return false;
	}	
	
			
		
	attendere();
	return true;
	
}