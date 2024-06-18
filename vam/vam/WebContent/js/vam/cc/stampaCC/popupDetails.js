function ctr(sezione,div)
{
	obj = document.getElementById(sezione);
	if(!obj.checked){
		document.getElementById(div).style.display = 'none';
	}
	else {
		document.getElementById(div).style.display = 'block';
	}
/*	if(sezione == 1){
		document.getElementById('divDet').style.display = 'block';
	}
	else if(sezione == 2 && document.getElementById('diario').checked){
		document.getElementById('divDiario').style.display = 'block';
	}
	else if(sezione == 3 && document.getElementById('ricov').checked){
		document.getElementById('divRic').style.display = 'block';
	}
	else if(sezione == 4 && document.getElementById('diag').checked){
		document.getElementById('divDiagn').style.display = 'block';
	}
	else if(sezione == 5 && document.getElementById('dimismalt').checked){
		document.getElementById('divDimis').style.display = 'block';
	}
	else if(sezione == 6 && document.getElementById('chir').checked){
		document.getElementById('divChir').style.display = 'block';
	}	
	else if(sezione == 7 && document.getElementById('terap').checked){
		document.getElementById('divTerap').style.display = 'block';
	}
	else if(sezione == 8 && document.getElementById('trasf').checked){
		document.getElementById('divTrasf').style.display = 'block';
	}
	else if(sezione == 9 && document.getElementById('lista').checked){
		document.getElementById('divList').style.display = 'block';
	}
	else {
		document.getElementById('divDet').style.display = 'block';
	}*/	
}
