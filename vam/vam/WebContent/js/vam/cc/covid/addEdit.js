function checkform() 
{
	if (document.getElementById('dataRichiesta').value == '') {
		alert("Inserire la data del test");	
		document.getElementById('dataRichiesta').focus();
		return false;
	}	
	
	if(document.getElementById('idTipoTest').value=="" )
	{
		alert("Selezionare il tipo di test");
		document.getElementById('idTipoTest').focus();
		return false;
	}
	
	/*if(document.getElementById('esito').value=="" )
			{
				alert("Selezionare l'esito");
				document.getElementById('esito').focus();
				return false;
			}*/
	
	document.getElementById('form').submit();

	return true;

}


function disabilitaAnomalie()
{
	var disabled = false;
	if(document.getElementById("diagnosi").checked)
	{
		disabled = true;
	}
	
	var inputs = document.getElementsByTagName("input");
	for(var i=0;i<inputs.length;i++)
	{
		var input = inputs[i];
		if(input.getAttribute("type")=="checkbox" && input.getAttribute("name")!="diagnosi")
		{
			document.getElementById(input.getAttribute("id")).disabled = disabled;
			document.getElementById(input.getAttribute("id")).checked  = false;
		}
	}
}

function calcolaQTCorretto()
{
	var qt = document.getElementById('intervalloQT').value;
	var rr = document.getElementById('intervalloRR').value;
	if(  qt!="" && rr!="" && (parseFloat(rr)>0 || parseFloat(rr)<0) )
	{
		document.getElementById('QTCorretto').value = qt/Math.pow(rr,1/3);
	}
	else
	{
		document.getElementById('QTCorretto').value="";
	}
}