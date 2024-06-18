function chooseProvinciaReimmissione(provincia) {
	if (provincia == 'BN') {
		document.getElementById( 'comuneReimmissioneBN' ).style.display = "";
		document.getElementById( 'comuneReimmissioneNA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneSA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneCE' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneAV' ).style.display = "none";
		
	}
	else if (provincia == 'NA') {
		document.getElementById( 'comuneReimmissioneBN' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneNA' ).style.display = "";
		document.getElementById( 'comuneReimmissioneSA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneCE' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneAV' ).style.display = "none";
	}	
	else if (provincia == 'AV') {
		document.getElementById( 'comuneReimmissioneBN' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneNA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneSA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneCE' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneAV' ).style.display = "";
	}
	else if (provincia == 'SA') {
		document.getElementById( 'comuneReimmissioneBN' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneNA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneSA' ).style.display = "";
		document.getElementById( 'comuneReimmissioneCE' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneAV' ).style.display = "none";
	}
	else if (provincia == 'CE') {
		document.getElementById( 'comuneReimmissioneBN' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneNA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneSA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneCE' ).style.display = "";
		document.getElementById( 'comuneReimmissioneAV' ).style.display = "none";
	}
	else if (provincia == 'X') {
		document.getElementById( 'comuneReimmissioneBN' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneNA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneSA' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneCE' ).style.display = "none";
		document.getElementById( 'comuneReimmissioneAV' ).style.display = "none";
	}
}



function checkform(form) {
		
	if (form.dataReimmissione.value == '') {
		alert("Inserire la data del rilascio");		
		return false;
	}	
	
	if (form.provinciaReimmissione.value == 'X') {
		alert("Inserire la provincia");			
		return false;
	}	
	
	if (form.provinciaReimmissione.value == 'AV' && form.comuneReimmissioneAV.value == '0') {
		alert("Selezionare il comune AV");			
		return false;
	}
	
	if (form.provinciaReimmissione.value == 'CE' && form.comuneReimmissioneCE.value == '0') {
		alert("Selezionare il comune CE");			
		return false;
	}
	
	if (form.provinciaReimmissione.value == 'BN' && form.comuneReimmissioneBN.value == '0') {
		alert("Selezionare il comune BN");			
		return false;
	}
	
	if (form.provinciaReimmissione.value == 'NA' && form.comuneReimmissioneNA.value == '0') {
		alert("Selezionare il comune NA");			
		return false;
	}
	
	if (form.provinciaReimmissione.value == 'SA' && form.comuneReimmissioneSA.value == '0') {
		alert("Selezionare il comune SA");			
		return false;
	}
			
	
	if (form.luogoReimmissione.value == '') {
		alert("Inserire il luogo del rilascio");			
		return false;
	}
		
	attendere();
	return true;
	
}