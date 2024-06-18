function toggleGroup( targetId ){ 
	  if (document.getElementById){ 
	        target = document.getElementById( targetId ); 
	           if (target.style.display == "none"){ 
	              target.style.display = ""; 
	           } else { 
	              target.style.display = "none"; 
	           } 
	     } 
	} 


function hiddenDiv( targetId ){ 
	  if (document.getElementById){ 
	        target = document.getElementById( targetId ); 
	        target.style.display = "none"; 
	           
	     } 
}






function checkform(form)
{
	if( form.dataEsameObiettivo.value == '' )
	{
		alert("Inserire una data");
		form.dataEsameObiettivo.focus();
		return false;
	}
	else if( compareDates( form.dataAccettazione.value, "dd/MM/yyyy", form.dataEsameObiettivo.value, "dd/MM/yyyy" ) != 0 )
	{
		alert("La data dell'esame non pu� essere antecedente alla data di accettazione");
		form.dataEsameObiettivo.focus();
		return false;
	}
	
	if(!controllaDataAnnoCorrente(form.dataEsameObiettivo, 'Data'))
	{
		return false;
	}

	// -------------------------------------------------------------------
	// compareDates(date1,date1format,date2,date2format)
	//   Compare two date strings to see which is greater.
	//   Returns:
	//   1 if date1 is greater than date2
	//   0 if date2 is greater than date1 of if they are the same
	//  -1 if either of the dates is in an invalid format
	// -------------------------------------------------------------------
	
	attendere();
	return true;
}


function esitiMutuamenteEsclusivi(esitiDaEscludere)
{
	for(var i=0; i<esitiDaEscludere.length;i++)
	{
		document.getElementById('op_'+esitiDaEscludere[i]).checked=false;
	}
}
