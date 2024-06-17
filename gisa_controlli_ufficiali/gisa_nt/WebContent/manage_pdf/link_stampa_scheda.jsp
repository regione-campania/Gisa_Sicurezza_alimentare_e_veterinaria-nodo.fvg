
<script language="JavaScript" TYPE="text/javascript"
	SRC="gestione_documenti/generazioneDocumentale.js"></script>
<% if((OrgDetails.getTipoDest()!=null)&& (OrgDetails.getTipoDest().equals("Autoveicolo"))){
        	
    %>
   <%-- img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa scheda" value="Stampa scheda"	onClick="javascript:window.location.href='SchedaPrint.do?command=PrintReport&file=account_attivitaMobili.xml&id=<%= OrgDetails.getId() %>&addressid=<%= addressid%>&addressid2=<%= addressid2%>&addressid3=<%= addressid3%>';">
   
   <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa scheda" value="Visualizza scheda PDF"	onClick="javascript:window.location.href='SchedaPrint.do?command=StampaScheda&file=account_attivitaMobili.xml&id=<%= OrgDetails.getId() %>&addressid=<%= addressid%>&addressid2=<%= addressid2%>&addressid3=<%= addressid3%>';"--%>
   
    <%-- img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa scheda" value="Stampa scheda"	onClick="openRichiestaPDF('<%= OrgDetails.getId() %>', '<%= addressid%>', '<%= addressid2%>', '<%= addressid3%>', 'account_attivitaMobili.xml', 'SchedaImpresa');"--%>
   
   <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa Scheda" value="Stampa Scheda"	onClick="openRichiestaPDF2('<%= OrgDetails.getId() %>', '<%= addressid%>', '<%= addressid2%>', '<%= addressid3%>','12');">
   
 <%}else{
 		%>
  <%--img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
  <input type="button" title="Stampa scheda" value="Stampa scheda"	onClick="javascript:window.location.href='SchedaPrint.do?command=PrintReport&file=account.xml&id=<%= OrgDetails.getId() %>&addressid=<%= addressid%>&addressid2=<%= addressid2%>&addressid3=<%= addressid3%>';">

<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa scheda" value="Visualizza scheda PDF"	onClick="javascript:window.location.href='SchedaPrint.do?command=StampaScheda&file=account.xml&id=<%= OrgDetails.getId() %>&addressid=<%= addressid%>&addressid2=<%= addressid2%>&addressid3=<%= addressid3%>';"--%>
   
  <%-- <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa scheda" value="Stampa scheda"	onClick="openRichiestaPDF('<%= OrgDetails.getId()', '<%= addressid%>', '<%= addressid2%>', '<%= addressid3%>', 'account.xml', 'SchedaImpresa');"> --%>
   
    <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
   <input type="button" title="Stampa Scheda" value="Stampa Scheda"	onClick="openRichiestaPDF2('<%= OrgDetails.getId() %>', '<%= addressid%>', '<%= addressid2%>', '<%= addressid3%>','1');">
   

<%} %>

	
	
 

