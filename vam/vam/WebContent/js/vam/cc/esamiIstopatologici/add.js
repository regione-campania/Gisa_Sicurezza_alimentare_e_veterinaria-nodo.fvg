function checkform(form)
{
	var ret = true;
	
	if(isFuturo(form.dataRichiesta.value))
	{
		alert("Non � possibile inserire una DATA RICHIESTA futura");
		ret = false;
	}
	
	if(!controllaDataAnnoCorrente(form.dataRichiesta, 'Data richiesta'))
	{
		ret = false;
	}
	
	//Flusso 170 si commenta
	/*if(form.dataSmaltimento.value!='' && confrontaDate(form.dataRichiesta.value,form.dataSmaltimento.value)>0)
	{
		alert("La data dell'esame istopatologico non pu� essere successiva alla data dello smaltimento("+form.dataSmaltimento.value+")");	
		form.dataRichiesta.focus();
		return false;
	}*/
	
	
	/*if( form.idTumoriPrecedenti.value == 2 )//tumori precedenti = si
	{
		if( ret && !isVoidOrIntPositivo(form.t.value,'T',form.t) )
		{
			ret = false;
		}
		
		if( ret  && !isVoidOrIntPositivo(form.n.value,'N',form.n) )
		{
			ret = false;
		}
		
		if( ret && !isVoidOrIntPositivo(form.m.value,'M',form.m) )
		{
			ret = false;
		}
	}*/
	

	if( ret && !isVoidOrIntPositivo(form.dimensione.value,'Dimensione',form.dimensione) )
	{
		ret = false;
	}

	if(ret && form.padreSedeLesione.value == '-1')
	{
		alert("Inserire la sede della lesione");			
		ret = false;
	}
	
	if( ret )
	{
		attendere();
	}
	
	return ret;
}


function checkformIzsm(form)
{
	var ret = true;
	
	if(form.dataEsito.value=='')
	{
		alert("Inserire la data esito");
		form.dataEsito.focus();
		ret= false;
	}else if(isFuturo(form.dataEsito.value))
	{
		alert("Non e' possibile inserire una data esito futura");
		ret= false;
	}
	if(ret==true && document.getElementById('idTipoDiagnosi').value=="-1")
	{
		alert("Selezionare una diagnosi");
		ret= false;
	}
	else if(ret==true && document.getElementById('idTipoDiagnosi').value=="3" && document.getElementById('diagnosiNonTumorale').value=="")
	{
		alert("Specificare la diagnosi non tumorale");
		ret= false;
	}
	
	if( ret )
	{
		attendere();
	}
	
	return ret;
}
