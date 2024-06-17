<% if (org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA")!=null && org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA").equalsIgnoreCase("si")) { %>	  
<script>
function openPopupStampa(tipo, idsanzione) {
	 window.open('GestionePagoPa.do?command=StampaSanzione&tipo='+tipo+'&idSanzione='+idsanzione,'popupSelectPA',
     'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>

<div align="center"><a href="#" onClick="openPopupStampa('PV', '<%=TicketDetails.getId()%>')">Stampa per Processo Verbale</a></div><br/>
<div align="center"><a href="#" onClick="openPopupStampa('NO', '<%=TicketDetails.getId()%>')">Stampa per Numero Ordinanza</a></div><br/>
<% } %>