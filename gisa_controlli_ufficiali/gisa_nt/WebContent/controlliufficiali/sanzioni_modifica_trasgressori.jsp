 <script>
 function modificaForzataSanzione(idSanzione){
		
		if (!confirm("Attenzione. Tramite questa funzionalità sarà possibile modificare TRASGRESSORE ed OBBLIGATO IN SOLIDO della sanzione selezionata.\n\nSarà inoltre possibile modificare alcuni elementi del Registro Trasgressori.\n\n Assicurarsi di utilizzare la fuzionalità in coerenza con eventuali processi verbali già emessi. \n\n La funzionalità non sarà disponibile se sulla sanzione sono già stati generati avvisi di pagamento.\n\n Ogni modifica sarà tracciata. \n\n Proseguire? "))
		 return false;
	 
		var windowModifica = window.open('GestionePagoPa.do?command=ModificaForzataSanzione&idSanzione='+idSanzione,'popupModificaForzataSanzione'+idSanzione,
	         'height=800px,width=800px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
		
		windowModifica.focus();

}
 </script>
 
<dhv:permission name="sanzioni_modifica_trasgressori-view"> <!-- LIVELLO 1: PERMESSO SUL RUOLO -->
<% if (PopolaCombo.hasCfPermission(User.getContact().getCodiceFiscale(), "sanzioni_modifica_trasgressori-view" )) { %> <!-- LIVELLO 2: PERMESSO SUL CF -->
<br/>
<center>
<input type="button" value="MODIFICA FORZATA SANZIONE" onClick="modificaForzataSanzione('<%=TicketDetails.getId()%>')"/>
</center>
<%} %>
</dhv:permission>


