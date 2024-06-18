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

function contains(a, obj)
{
	for(var i = 0; i < a.length; i++) 
	{
	    if(a[i] === obj)
	    {
	      return true;
	    }
	}
	return false;
}

function checkform(form) 
{
	if (form.dataRichiesta.value == '') {
		alert("Inserire la data dell'intervento");	
		form.dataRichiesta.focus();
		return false;
	}
	
	if(document.getElementById('idOp').value=='')
	{
		alert("Selezionare almeno un operatore");
		return false;
	}
	
	if(document.getElementById('idOp').value.split(",").length>5)
	{
		alert("Non � possibile selezionare pi� di cinque operatori");
		return false;
	}
	
	attendere();
	form.submit();

}


function confermaModificheOperatori(conferma)
{
	if(conferma)
	{
		document.getElementById('idOp').value = document.getElementById('idOpTemp').value;
		document.getElementById('operatoriSelezionati').innerHTML = document.getElementById('operatoriSelezionatiTemp').innerHTML;
	}
	else
	{
		document.getElementById('idOpTemp').value = document.getElementById('idOp').value;
		document.getElementById('operatoriSelezionatiTemp').innerHTML = document.getElementById('operatoriSelezionati').innerHTML;
	}
}


function popolaOperatoriSelezionati(idOp, descOp)
{
	var op = document.getElementById('idOperatoriTemp').value;
	var opSel = document.getElementById('operatoriSelezionatiTemp').innerHTML;
	var separator = ",";
	var opArray = op.split(",");
	var presente = false;
	var indice;
	for(var i=0;i<opArray.length;i++)
	{
		if(opArray[i]==idOp)
		{
			presente = true;
			break;
		}
	}
	if(document.getElementById('idOperatoriTemp').value=="")
		separator = "";
		
	if(!presente)
	{
		document.getElementById('idOperatoriTemp').value=document.getElementById('idOperatoriTemp').value+separator+idPersInt;
		document.getElementById('operatoriSelezionatiTemp').innerHTML=document.getElementById('operatoriSelezionatiTemp').innerHTML+"<tr><td>"+descOp.replace("***","'")+"</td></tr>";
	}
	else
	{
		opArray.splice(i,1);
		opSel = opSel.replace("<tr><td>"+descOp.replace("***","'")+"</td></tr>","");
		document.getElementById('operatoriSelezionatiTemp').innerHTML = opSel;
	}
}


function selezionaOp()
{
			var op = document.getElementById('idOpTemp').value;
			var opArray = op.split(",");
			var opIniziale = document.getElementById('div_operatori').cloneNode(true);
		
			opIniziale.id="chooseOp";
			opIniziale.style.display="block";
			var inputs = opIniziale.getElementsByTagName("input");
			
			var checkDaSelezionare = new Array(0);
			var esistonoOp = false;
			for(var i=0;i<inputs.length;i++)
			{
				if(inputs[i].type=="checkbox")
				{
					inputs[i].id=inputs[i].id.replace("checkOpIniziale","");
					inputs[i].setAttribute("onclick","popolaOpSelezionati('"+inputs[i].value+"','"+inputs[i].name.replace("op","").replace("'","***")+"');");
					
					esistonoOp = true;
					//Se � stato selezionato prima
					if(contains(opArray,inputs[i].id.replace("op","")))
					{
						inputs[i].checked=true;
						checkDaSelezionare[checkDaSelezionare.length] = inputs[i];
					}
					else
						inputs[i].checked=false;
				}
			}
			
			document.getElementById('div_operatori').appendChild(opIniziale);
			
			mostraPopupChooseOp();
		
}


function confermaModificheOperatori(conferma)
{
	if(conferma)
	{
		document.getElementById('idOp').value = document.getElementById('idOpTemp').value;
		document.getElementById('operatoriSelezionati').innerHTML = document.getElementById('operatoriSelezionatiTemp').innerHTML;
	}
	else
	{
		document.getElementById('idOpTemp').value = document.getElementById('idOp').value;
		document.getElementById('operatoriSelezionatiTemp').innerHTML = document.getElementById('operatoriSelezionati').innerHTML;
	}
}


function popolaOpSelezionati(idOp, descOp)
{
	var op = document.getElementById('idOpTemp').value;
	var opSel = document.getElementById('operatoriSelezionatiTemp').innerHTML;
	var separator = ",";
	var opArray = op.split(",");
	var presente = false;
	var indice;
	for(var i=0;i<opArray.length;i++)
	{
		if(opArray[i]==idOp)
		{
			presente = true;
			break;
		}
	}
	if(document.getElementById('idOpTemp').value=="")
		separator = "";
		
	if(!presente)
	{
		document.getElementById('idOpTemp').value=document.getElementById('idOpTemp').value+separator+idOp;
		document.getElementById('operatoriSelezionatiTemp').innerHTML=document.getElementById('operatoriSelezionatiTemp').innerHTML+"<tr><td>"+descOp.replace("***","'")+"</td></tr>";
	}
	else
	{
		opArray.splice(i,1);
		document.getElementById('idOpTemp').value = opArray;
		opSel = opSel.replace("<tr><td>"+descOp.replace("***","'")+"</td></tr>","");
		document.getElementById('operatoriSelezionatiTemp').innerHTML = opSel;
	}
}

