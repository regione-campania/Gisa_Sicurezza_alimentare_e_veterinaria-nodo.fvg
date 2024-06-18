function checkform(idUtente,idAnimale)
{
	if(document.getElementById('dataRichiesta').value=='')
	{
		alert("Selezionare la data richiesta.");
		document.getElementById('dataRichiesta').focus();
		return false;
	}
	
	if(!controllaDataAnnoCorrente(document.getElementById('dataRichiesta'), 'Data richiesta'))
	{
		return false;
	}
	
	
	if(confrontaDate(document.getElementById('dataRichiesta').value,document.getElementById('dataApertura').value)<0)
	{
		alert("La data richiesta deve essere uguale o successiva alla data di apertura della CC");
		return false;
	}

    var idClinicaDestinazione = document.getElementById('clinicaDestinazioneId').value;
	var toReturn = true;

	
		Test.check(opSelezionate, idUtente, idAnimale, 
 			'', idClinicaDestinazione, 'trasferimento', 0, false,false,
 												{
   														callback:function(msg) 

   														{ 
   															if(msg!=null && msg!='' /*&& !myConfirm(msg)*/){
   																alert(msg);
   																toReturn = false;
   																$( "#dialog-modal" ).dialog( "close" );
   															}
   														},
   														async: false,
   														timeout:20000,
   														errorHandler:function(message, exception)
   														{
   														    //Session timedout/invalidated
   														    if(exception && exception.javaClassName=='org.directwebremoting.impl.LoginRequiredException')
   														    {
   														        alert(message);
   														        //Reload or display an error etc.
   														        window.location.href=window.location.href;
   														    }
   														    else
   														        alert('Errore Nella Chiamata Remota : '+exception.javaClassName);
   														 }
										 			});
		
		
		var selezionateOperazioni = false;
		for(var i=0;i<=opSelezionate.length-1;i++){
			if  (document.getElementById("op_"+opSelezionate[i]).checked==true){	
				selezionateOperazioni = true;
			}
		}
		if(!selezionateOperazioni)
		{
			alert("Selezionare almeno un'operazione");
			toReturn = false;
			$( "#dialog-modal" ).dialog( "close" );
		}
		
    return toReturn;
	
}


function popolaOpSelezionate(idOp)
{
	if(document.getElementById('op_' + idOp).checked==true)
		opSelezionate[opSelezionate.length] = idOp;
	else
		opSelezionate.splice(opSelezionate.indexOf(idOp), 1);
}