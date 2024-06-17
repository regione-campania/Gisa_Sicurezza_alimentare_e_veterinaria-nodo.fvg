<div style="display:none; background: #ffe5e5; border: 1px solid black">
<br/><br/>
((Boolean)request.getAttribute("hasChecklistBenessere")) <%=((Boolean)request.getAttribute("hasChecklistBenessere")) %><br/>
((Boolean)request.getAttribute("hasChecklistBiosicurezza")) <%=((Boolean)request.getAttribute("hasChecklistBiosicurezza")) %><br/>
((Boolean)request.getAttribute("hasChecklistCondizionalita")) <%=((Boolean)request.getAttribute("hasChecklistCondizionalita")) %><br/>
((Boolean)request.getAttribute("hasChecklistFarmacosorveglianza")) <%=((Boolean)request.getAttribute("hasChecklistFarmacosorveglianza")) %><br/>
((Boolean)request.getAttribute("isPresenteRegistrazione")) <%=((Boolean)request.getAttribute("isPresenteRegistrazione")) %><br/>
request.getAttribute("hasChecklistBenessere") <%=request.getAttribute("hasChecklistBenessere") %><br/>
request.getAttribute("hasChecklistBiosicurezza") <%=request.getAttribute("hasChecklistBiosicurezza") %><br/>
request.getAttribute("hasChecklistCondizionalita") <%=request.getAttribute("hasChecklistCondizionalita") %><br/>
request.getAttribute("hasChecklistFarmacosorveglianza") <%=request.getAttribute("hasChecklistFarmacosorveglianza") %><br/>
request.getAttribute("isPresenteRegistrazione") <%=request.getAttribute("isPresenteRegistrazione") %><br/>
TicketDetails.getClosed() <%=TicketDetails.getClosed() %><br/>
TicketDetails.getNumeroAudit() <%=TicketDetails.getNumeroAudit() %><br/>
TicketDetails.getStatusId() <%=TicketDetails.getStatusId()  %><br/>
TicketDetails.getSupervisionato_in_data() <%=TicketDetails.getSupervisionato_in_data() %><br/>
TicketDetails.getTipoCampione() <%=TicketDetails.getTipoCampione() %><br/>
TicketDetails.isCategoriaAggiornabile() <%=TicketDetails.isCategoriaAggiornabile() %><br/>
TicketDetails.isCategoriaisAggiornata() <%=TicketDetails.isCategoriaisAggiornata() %><br/>
TicketDetails.isChiusura_attesa_esito() <%=TicketDetails.isChiusura_attesa_esito() %><br/>
TicketDetails.isControllo_chiudibile() <%=TicketDetails.isControllo_chiudibile() %><br/>
TicketDetails.isflagBloccoCu() <%=TicketDetails.isflagBloccoCu() %><br/>
TicketDetails.isTrashed() <%=TicketDetails.isTrashed() %><br/>
User.getRoleId() <%=User.getRoleId() %><br/>
UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo() <%=UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo() %><br/>
User.getUserRecord().getGruppo_ruolo() <%=User.getUserRecord().getGruppo_ruolo() %><br/>
Permesso edit: <%=permission_op_edit %><br/>
Permesso delete: <%=permission_op_del %><br/>
<br/><br/>
</div>
 <br/><br/>
 
  <%if (TicketDetails.isflagBloccoCu()==true){
		%>
		
		<font color = "red" ><%=TicketDetails.getNoteBlocco() %></font><br><br>
	
	<% if (TicketDetails.getClosed() == null && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) { 
		if(TicketDetails.getTipoCampione()!=5) {
	
	 %>
	   
	    <dhv:permission name="operazioni-hd-view">
			<input type="button"
			value="Chiusura Cu Pregresso" onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio()  %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		</dhv:permission>
		<%} else { %>
			
			<dhv:permission name="operazioni-hd-view">
				<input type="button" value="Aggiorna Categoria e chiudi tutto il controllo"  onClick="aggiornaCategoria(<%=TicketDetails.getId() %>,<%=TicketDetails.getOrgId() %>)">		
			</dhv:permission>			
	 <% } 
	}
} %>
 
 
<% if (!TicketDetails.isTrashed() && 
		(TicketDetails.getClosed() != null || TicketDetails.isChiusura_attesa_esito()==true) && 
		(TicketDetails.getTipoCampione()!=5 && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) && 
		(request.getAttribute("isPresenteRegistrazione")==null || !((Boolean)request.getAttribute("isPresenteRegistrazione")) || User.getRoleId()==Role.HD_1LIVELLO || User.getRoleId()==Role.HD_2LIVELLO)) {
		System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#1");
		%>
<dhv:permission name="reopen-reopen-view">
<input type = "button"  value = "Apri di nuovo" onClick = "javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ReopenTicket&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId()%>';submit();">
</dhv:permission>
<%} %>		




<% if (!TicketDetails.isTrashed() && 
		(TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()!=true) &&
		(TicketDetails.isflagBloccoCu()==false &&  User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())) {
		System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#2");
	%>
<dhv:permission name="<%=permission_op_edit%>">
<input type = "button" value = "Modifica"   onClick = "javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ModifyTicket&auto-populate=true';submit();">
</dhv:permission>
<%} %>	


<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.isCategoriaisAggiornata() == false  && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())) {
	  System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#3");%>
	  
<dhv:permission name="<%=permission_op_del%>">
<input type="button" value="Cancella"  onClick="javascript:popURL('<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getOrgId()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
</dhv:permission>
<%} %>			 

<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.getTipoCampione()!=5 && TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) && TicketDetails.isControllo_chiudibile()==true) {
      System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#4");%>
<dhv:permission name="<%=permission_op_edit%>">
<% if (request.getAttribute("hasChecklistBenessere")!=null && (Boolean)request.getAttribute("hasChecklistBenessere")==false) { %> 
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di almeno una checklist benessere salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistCondizionalita")!=null && (Boolean)request.getAttribute("hasChecklistCondizionalita")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist condizionalita' salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistBiosicurezza")!=null && (Boolean)request.getAttribute("hasChecklistBiosicurezza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist biosicurezza salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistFarmacosorveglianza")!=null && (Boolean)request.getAttribute("hasChecklistFarmacosorveglianza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist farmacosorveglianza salvata definitivamente.</font>
	   <% } else { %>
<input type="button" value="Chiudi tutto il controllo"  onClick="this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
<% } %>
</dhv:permission>		
	
<%} %>		

<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.getTipoCampione()==5 && TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) &&
      (TicketDetails.getNumeroAudit()>0 && TicketDetails.isCategoriaisAggiornata() == false && TicketDetails.isCategoriaAggiornabile()==true)) {
      System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#5");%>
<dhv:permission name="<%=permission_op_edit%>">
<input type="button" value="Aggiorna Categoria e chiudi tutto il controllo"  onClick="aggiornaCategoria(<%=TicketDetails.getId() %>,<%=TicketDetails.getOrgId() %>)"></dhv:permission>			
<%} %>

<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.getTipoCampione()==5 && TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) &&
      (TicketDetails.getNumeroAudit()>0 && TicketDetails.isCategoriaisAggiornata() == true && TicketDetails.isCategoriaAggiornabile()==true)) {
      System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#6");%>
<dhv:permission name="<%=permission_op_edit%>">
<input type="button" value="Chiudi tutto il controllo"  onClick="this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
</dhv:permission>			
<%} %>				 

<% if(TicketDetails.getSupervisionato_in_data()==null && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
    System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#7");%>
<dhv:permission name="vigilanza-vigilanza-supervisiona-view">
&nbsp;&nbsp;&nbsp;&nbsp;<a class="ovalbutton" href ="#dialog10" name = "modal"><span>Supervisione Documentale</span></a>
</dhv:permission>
<% }%>
			
			