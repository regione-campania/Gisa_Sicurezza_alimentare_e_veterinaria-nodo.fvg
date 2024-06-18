function checkform() 
{
	if (document.getElementById('dataRichiesta').value == '') {
		alert("Inserire la data della richiesta");	
		document.getElementById('dataRichiesta').focus();
		return false;
	}	
	
	if(!controllaDataAnnoCorrente(document.getElementById('dataRichiesta'), 'Data richiesta'))
	{
		return false;
	}
	
	
	if (document.getElementById('ritmo').value == '') {
		alert("Selezionare un ritmo");	
		document.getElementById('ritmo').focus();
		return false;
	}
	
	if((document.getElementById('intervalloQT').value=="" && document.getElementById('intervalloRR').value!=""))
	{
		alert("Inserire intervallo QT");
		document.getElementById('intervalloQT').focus();
		return false;
	}
	
	if((document.getElementById('intervalloQT').value!="" && document.getElementById('intervalloRR').value==""))
	{
		alert("Inserire intervallo RR");
		document.getElementById('intervalloRR').focus();
		return false;
	}
	
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