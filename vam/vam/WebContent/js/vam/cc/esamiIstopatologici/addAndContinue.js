function checkform(form)
{
	var ret = true;
	
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
