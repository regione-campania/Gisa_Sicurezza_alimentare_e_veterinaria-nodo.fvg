
<input type="button" value="<dhv:label name="button.insert">Insert</dhv:label>" id="Save" name="Save" class="Save" onClick="javascript:controllaAnaliti();" />

<% if( OrgDetails.getTipologia() != 1000 && (request.getAttribute("isOperatorePrivato") == null || !request.getAttribute("isOperatorePrivato").equals("si") )) { // PREACCETTAZIONE DISABILITATA SU OPERATORI PRIVATI MAIL C.PAOLILLO 21/12/23 %>

<dhv:permission name="campioni-campioni-addconpreaccettazione-view"> 
<input type="button" value="<dhv:label name="">inserisci con preaccettazione</dhv:label>" id="SaveConPreacc" name="SaveConPreacc" class="Save" onClick="javascript:controllaAnalitiConPreacc();" />
 </dhv:permission> 

<% } %>

<% if (OrgDetails.getTipologia() == 2000) { %>
	<input type="button" value="Annulla" onClick="window.location.href='<%=OrgDetails.getAction() %>Vigilanza.do?command=TicketDetails&id=<%=request.getAttribute("idC") %>&altId=<%=OrgDetails.getAltId() %>';this.form.dosubmit.value='false';" />
<% } else { %>
	<input type="button" value="Annulla" onClick="window.location.href='<%=OrgDetails.getAction() %>Vigilanza.do?command=TicketDetails&id=<%=request.getAttribute("idC") %>&idStabilimentoopu=<%=OrgDetails.getIdStabilimento() %>';this.form.dosubmit.value='false';" />
<% } %>
