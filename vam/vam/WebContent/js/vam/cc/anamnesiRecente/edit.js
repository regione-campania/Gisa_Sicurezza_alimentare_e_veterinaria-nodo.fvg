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
	        document.form.anamnesiRecenteDescrizione.value='';
	     } 
	  
	  
}
