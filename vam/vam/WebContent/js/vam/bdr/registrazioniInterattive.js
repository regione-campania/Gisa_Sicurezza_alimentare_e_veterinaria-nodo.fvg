function registrazioneInserita(microchip, specie, idTipoRegBdrDaInserire)
{
	var toReturn = true;
	TestBdr.registrazioneInserita(microchip, specie, idTipoRegBdrDaInserire,
											{
													callback:function(inserita) 
													{ 
														if(!inserita)
														{
															alert("La registrazione non � stata effettuata: procedere all'inserimento.");
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
  return toReturn;
	
}