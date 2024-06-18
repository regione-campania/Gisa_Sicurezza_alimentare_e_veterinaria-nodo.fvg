function checkformSmaltimentoCarogna() 
{
	if(document.form.dataSmaltimentoCarogna.value == '')
	{
		alert("Inserire la data");
		document.form.dataSmaltimentoCarogna.focus();
		return false;
	}
	
	if(confrontaDate(document.form.dataSmaltimentoCarogna.value,document.form.dataApertura.value)<0)
	{
		alert("La data del trasporto spoglie non può essere antecedente alla data di apertura dell'accettazione(" + document.form.dataApertura.value + ")");	
		document.form.dataSmaltimentoCarogna.focus();
		return false;
	}
	
	if(!myConfirm('Attenzione, i dati della registrazione trasporto spoglie non saranno modificabili dopo l\'inserimento, proseguire?'))
	{
		return false;
	}
	
	if(!controllaDataAnnoCorrente(document.form.dataSmaltimentoCarogna,'Data'))
	{
		return false;
	}
	
	attendere();
	return true;
}