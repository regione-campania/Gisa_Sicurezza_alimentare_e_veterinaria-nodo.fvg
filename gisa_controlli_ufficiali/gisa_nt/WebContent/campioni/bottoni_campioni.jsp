
<% System.out.println("URLDettaglio:"+CU.getURlDettaglio()); %>

<input type="button" value="<dhv:label name="button.insert">Insert</dhv:label>" id="Save" 
name="Save" class="Save" onClick="javascript:controllaAnaliti();" />

<% if (OrgDetails.getTipologia() != 12) { // PREACCETTAZIONE DISABILITATA SU OPERATORI NON ALTROVE MAIL C.PAOLILLO 21/12/23 %>
<dhv:permission name="campioni-campioni-addconpreaccettazione-view"> 
<input type="button" value="<dhv:label name="">inserisci con preaccettazione</dhv:label>" id="SaveConPreacc" name="SaveConPreacc" class="Save" onClick="javascript:controllaAnalitiConPreacc();" />
</dhv:permission>  
<%} %>

<input type="button" value="Annulla" 
onClick="window.location.href='<%=CU.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=request.getAttribute("idC") %>&orgId=<%=OrgDetails.getOrgId() %>';this.form.dosubmit.value='false';" />
