function checkform(form) 
{
	if (document.getElementById('dataRichiesta').value == '') {
		alert("Inserire la data della richiesta");	
		document.getElementById('dataRichiesta').focus();
		return false;
	}
	
	if (document.getElementById('dataEsito').value == '') {
		alert("Inserire la data dell'esito");	
		document.getElementById('dataEsito').focus();
		return false;
	}
	
	if(!controllaDataAnnoCorrente(document.getElementById('dataRichiesta'), 'Data richiesta'))
	{
		return false;
	}
	
	if(document.getElementById("idTipoPrelievo").value=="")
	{
		alert("Inserire Tipo prelievo");
		document.getElementById('idTipoPrelievo').focus();
		return false;
	}
	
	if(document.getElementById("idTipoPrelievo").value==4 && document.getElementById("tipoPrelievoAltro").value=="")
	{
		alert("Inserire le note nel campo 'Specificare altro'");
		document.getElementById('tipoPrelievoAltro').focus();
		return false;
		
	}
	
	if(document.getElementById("padreDiagnosi").value=="-1")
	{
		alert("Inserire il campo Matrice");
		document.getElementById('padreDiagnosi').focus();
		return false;
	}
	
	if(document.getElementById("idDiagnosiPadre").value=='-1' ||  (document.getElementById("idDiagnosiPadre").value=='2' && document.getElementById("idDiagnosi").value==""))
	{
		alert("Inserire Diagnosi");
		document.getElementById('idDiagnosi').focus();
		return false;
	}
	
	form.submit();

	return true;

}


function mostraAltro()
{
	if(document.getElementById("idTipoPrelievo").value==4)
	{
		document.getElementById("tipoPrelievoAltroTd1").innerHTML='Specificare altro <font color="red"> *</font>';
		document.getElementById("tipoPrelievoAltro").style.display='block';
	}
	else
	{
		document.getElementById("tipoPrelievoAltroTd1").innerHTML='';
		document.getElementById("tipoPrelievoAltro").style.display='none';
	}
}