
try{
	
var domain = window.location.hostname;
domain = domain.substring(domain.indexOf('.')+1);
//alert(domain);
document.domain = domain;
//alert(document.domain);
}catch (err){
	//alert('Errore setting domain !!');
	
}



//alert('Domain BDU d:  ' +document.domain);

try{
	//alert(idEvento);
sendIdEventoToVam2(idEvento);
}catch (e) {
	//alert('Attenzione, si e\' verificato un errore nella comunicazione BDU -> VAM, contatta cortesemente l\'Help Desk. Dettagli errore: ' +e);
}



function sendIdEventoToVam2(idEvento){ //Funzione con gestione cambiamento dominio VAM BDU
	//alert(document.domain);
	window.top.continueVam(idEvento);
}