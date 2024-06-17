function showHide(name){
	  var elems = document.getElementsByName(name);
			for(var i = 0; i < elems.length; i++) {
			    // set attribute to property value
			    if (elems[i].style.visibility=='hidden')
			    	elems[i].style.visibility='visible';
			    else
			    	elems[i].style.visibility='hidden';
			}
	
	
}


function goTo(link){
	
	if (link=='')
		alert('da implementare');
	else{
		loadModalWindow();
		window.location.href=link;
	}
	
	
}
