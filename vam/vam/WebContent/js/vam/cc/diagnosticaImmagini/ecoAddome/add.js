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


function hiddenDiv( targetId){ 
	  if (document.getElementById){ 
	        target = document.getElementById( targetId ); 
	        target.style.display = "none"; 
	     } 
}

function hiddenDiv( targetId1 , targetId2 ){ 
	  if (document.getElementById){ 
	        target = document.getElementById( targetId1 ); 
	        if(target!=null)
	        	target.style.display = "none"; 
	        target = document.getElementById( targetId2 ); 
	        if(target!=null)
	        	target.style.display = "none";
	     } 
}

function checkform(form) 
{
	if (form.dataRichiesta.value=='') {
		alert("Inserire la data della richiesta");	
		form.dataRichiesta.focus();
		return false;
	}	
	
	if(!(form.gravidanza1.value=='' && form.gravidanza2.value=='' && form.gravidanza3.value=='') && !(form.gravidanza1.value!='' && form.gravidanza2.value!='' && form.gravidanza3.value!='')) 
	{
		alert("Valorizzare tutti i valori della dimensione camera ovulare intrauterina");	
		return false;
	}
	form.submit();
}