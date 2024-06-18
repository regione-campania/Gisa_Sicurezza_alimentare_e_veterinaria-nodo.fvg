if(typeof String.prototype.trim !== 'function')
{
	String.prototype.trim = function()
	{
		return this.replace(/^\s+|\s+$/g, '');
	}
} 


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
	if (form.dataRichiesta.value == '') {
		alert("Inserire la data della richiesta");	
		form.dataRichiesta.focus();
		return false;
	}
		
	form.submit();

}

