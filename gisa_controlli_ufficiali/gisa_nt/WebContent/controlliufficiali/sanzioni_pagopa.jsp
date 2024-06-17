<% if (org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA")!=null && org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA").equalsIgnoreCase("si")) { %>	  
		
<% if (PopolaCombo.isPrevistoPagoPA(TicketDetails.getId())){ %>
<br/>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
<tr><th colspan="2">PAGOPA</td> </tr>
<tr><td class="formLabel">AVVISI DI PAGAMENTO</td> <td> 
<dhv:permission name="pagopa_gestione-view">

<% if (TicketDetails.getListaAllegatiPV().size()>0) { %>
<input type="button" value="Gestione PagoPA" onClick="window.open('GestionePagoPa.do?command=View&origine=ProcessoVerbale&idSanzione=<%=TicketDetails.getId()%>','popupPagoPa<%=TicketDetails.getId() %>','height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes').focus()"/>
<% } else { %>
<font color="red">Attenzione. Su questa sanzione non &egrave; ancora stato caricato l'allegato Processo Verbale. La gestione PagoPA sar&agrave; disponibile dopo il caricamento.</font>
<% } %>
</dhv:permission> 
</td></tr>
</table>	  
<%} %>
		
<%} %>