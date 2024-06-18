function chooseProvinciaCattura(provincia) {
	if (provincia == 'BN') {
		document.getElementById( 'comuneCatturaBN' ).style.display = "";
		document.getElementById( 'comuneCatturaNA' ).style.display = "none";
		document.getElementById( 'comuneCatturaSA' ).style.display = "none";
		document.getElementById( 'comuneCatturaCE' ).style.display = "none";
		document.getElementById( 'comuneCatturaAV' ).style.display = "none";
		
	}
	else if (provincia == 'NA') {
		document.getElementById( 'comuneCatturaBN' ).style.display = "none";
		document.getElementById( 'comuneCatturaNA' ).style.display = "";
		document.getElementById( 'comuneCatturaSA' ).style.display = "none";
		document.getElementById( 'comuneCatturaCE' ).style.display = "none";
		document.getElementById( 'comuneCatturaAV' ).style.display = "none";
	}	
	else if (provincia == 'AV') {
		document.getElementById( 'comuneCatturaBN' ).style.display = "none";
		document.getElementById( 'comuneCatturaNA' ).style.display = "none";
		document.getElementById( 'comuneCatturaSA' ).style.display = "none";
		document.getElementById( 'comuneCatturaCE' ).style.display = "none";
		document.getElementById( 'comuneCatturaAV' ).style.display = "";
	}
	else if (provincia == 'SA') {
		document.getElementById( 'comuneCatturaBN' ).style.display = "none";
		document.getElementById( 'comuneCatturaNA' ).style.display = "none";
		document.getElementById( 'comuneCatturaSA' ).style.display = "";
		document.getElementById( 'comuneCatturaCE' ).style.display = "none";
		document.getElementById( 'comuneCatturaAV' ).style.display = "none";
	}
	else if (provincia == 'CE') {
		document.getElementById( 'comuneCatturaBN' ).style.display = "none";
		document.getElementById( 'comuneCatturaNA' ).style.display = "none";
		document.getElementById( 'comuneCatturaSA' ).style.display = "none";
		document.getElementById( 'comuneCatturaCE' ).style.display = "";
		document.getElementById( 'comuneCatturaAV' ).style.display = "none";
	}
	else if (provincia == 'X') {
		document.getElementById( 'comuneCatturaBN' ).style.display = "none";
		document.getElementById( 'comuneCatturaNA' ).style.display = "none";
		document.getElementById( 'comuneCatturaSA' ).style.display = "none";
		document.getElementById( 'comuneCatturaCE' ).style.display = "none";
		document.getElementById( 'comuneCatturaAV' ).style.display = "none";
	}
	
}

function checkform(form) {
		
		
	if (form.dataCattura.value == '') {
		alert("Inserire la data rinvenimento");		
		return false;
	}	
	
	if (form.provinciaCattura.value == 'X') {
		alert("Inserire la provincia");			
		return false;
	}	
	
	if (form.provinciaCattura.value == 'AV' && form.comuneCatturaAV.value == '0') {
		alert("Selezionare il comune AV");			
		return false;
	}
	
	if (form.provinciaCattura.value == 'CE' && form.comuneCatturaCE.value == '0') {
		alert("Selezionare il comune CE");			
		return false;
	}
	
	if (form.provinciaCattura.value == 'BN' && form.comuneCatturaBN.value == '0') {
		alert("Selezionare il comune BN");			
		return false;
	}
	
	if (form.provinciaCattura.value == 'NA' && form.comuneCatturaNA.value == '0') {
		alert("Selezionare il comune NA");			
		return false;
	}
	
	if (form.provinciaCattura.value == 'SA' && form.comuneCatturaSA.value == '0') {
		alert("Selezionare il comune SA");			
		return false;
	}
			
	
	if (form.luogoCattura.value == '') {
		alert("Inserire il luogo del rinvenimento");			
		return false;
	}
		
	attendere();
	return true;
	
}