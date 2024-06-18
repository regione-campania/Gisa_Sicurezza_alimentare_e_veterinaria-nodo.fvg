function checkform() {

	var form = document.form;

	if (form.idUtente.value == '') {
		alert("Specificare un utente");
		form.idUtente.focus();
		return false;
	}
	
	if (form.clinica.value == '') {
		alert("Specificare una clinica");
		form.idUtente.focus();
		return false;
	}
	form.submit();
}