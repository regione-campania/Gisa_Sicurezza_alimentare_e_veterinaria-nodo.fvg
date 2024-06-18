function checkform(form) {
	

	if (form.tipologiaTicket.value == '0') {
		alert("Inserire una tipologia");	
		return false;
	}	
	
	if (form.description.value == '') {
		alert("Inserire una descrizione");	
		return false;
	}
	
	if (form.email.value =='') {
		alert("Inserire una mail");	
		return false;
	}
	
	if (form.email.value !='' && checkMail (form.email.value) == false) {
		alert("Inserire una mail corretta");	
		return false;
	}
		
	
	attendere();
	return true;
	
}


function checkMail(str){
	var email = str;
	
	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			
	if (!filter.test(email)) {		
		return false;
	}
	
	return true;
}

	

function checkMail1(str){
    var mail=str;

    if (mail.length > 0) {     
      var i=0;
      while(mail.charAt(i)!='@')
      {
        if (i<mail.length)
        {
        	i++;
        }
        else
        {               
        	return false;
        }
      }
      
      if (mail.charAt(i++)=='.') {
		  return false;
	  }
	  
     	  
                  
      while(mail.charAt(i)!='.')
      {	         	 
    	 if (i<mail.length)
	     {
	      	i++;
	     }
	     else
	     {
	        return false;
	     }
      }
    }
    
    return true;
  }