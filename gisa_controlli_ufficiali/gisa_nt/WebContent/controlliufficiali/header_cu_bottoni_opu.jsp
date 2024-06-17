<div style="display:none; background: #ffe5e5; border: 1px solid black">
<br/><br/>
((Boolean)request.getAttribute("isPresenteRegistrazione")) <%=((Boolean)request.getAttribute("isPresenteRegistrazione")) %><br/>
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
	   
	  	if(TicketDetails.getTipoCampione()!=5) {%>
	   
	    <dhv:permission name="operazioni-hd-view">
			<input type="button"
			value="Chiusura Cu Pregresso" onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio()  %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		</dhv:permission>
		<%} else { %>
			
			<dhv:permission name="operazioni-hd-view">
				<input type="button" value="Aggiorna Categoria e chiudi tutto il controllo"  onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getIdStabilimento() > 0 ? TicketDetails.getIdStabilimento() : TicketDetails.getIdApiario() > 0 ? TicketDetails.getIdApiario() : -1 %>)">		
				
			</dhv:permission>			
	 <% }  } 
}%> 
		
<% if (!TicketDetails.isTrashed() && 
		(TicketDetails.getClosed() != null || TicketDetails.isChiusura_attesa_esito()==true) && 
		(TicketDetails.getTipoCampione()!=5 && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) && 
		(request.getAttribute("isPresenteRegistrazione")==null || !((Boolean)request.getAttribute("isPresenteRegistrazione")) || User.getRoleId()==Role.HD_1LIVELLO || User.getRoleId()==Role.HD_2LIVELLO)) {
		System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#1");
		%>
<dhv:permission name="reopen-reopen-view">
<input type = "button"  value = "Apri di nuovo" onClick = "javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ReopenTicket&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId()%>';submit();">
</dhv:permission>
<%} %>		


	


<% if (!TicketDetails.isTrashed() && 
		(TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()!=true) &&
		(TicketDetails.isflagBloccoCu()==false &&  User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())) {
		System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#2");
	%>
<dhv:permission name="<%=permission_op_edit%>">
<input type = "button" value = "Modifica"   onClick = "javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ModifyTicket&auto-populate=true';submit();">
</dhv:permission>
<%} %>	


<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.isCategoriaisAggiornata() == false  && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())) {
	  System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#3");%>
	  
<dhv:permission name="<%=permission_op_del%>">
<input type="button" value="Cancella"  onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdStabilimento() > 0 ? TicketDetails.getIdStabilimento() : TicketDetails.getIdApiario() > 0 ? TicketDetails.getIdApiario() : -1%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
</dhv:permission>
<%} %>			 

<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.getTipoCampione()!=5 && TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) && TicketDetails.isControllo_chiudibile()==true) {
      System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#4");%>
<dhv:permission name="<%=permission_op_edit%>">
<input type="button" value="Chiudi tutto il controllo"  onClick="this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
</dhv:permission>			
<%} %>		

<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.getTipoCampione()==5 && TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) &&
      (TicketDetails.getNumeroAudit()>0 && TicketDetails.isCategoriaisAggiornata() == false && TicketDetails.isCategoriaAggiornabile()==true)) {
      System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#5");%>
<dhv:permission name="<%=permission_op_edit%>">
<input type="button" value="Aggiorna Categoria e chiudi tutto il controllo"  onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getIdStabilimento() > 0 ? TicketDetails.getIdStabilimento() : TicketDetails.getIdApiario() > 0 ? TicketDetails.getIdApiario() : -1 %>)"></dhv:permission>			
<%} %>

<% if (!TicketDetails.isTrashed() &&
	  (TicketDetails.getClosed() == null && TicketDetails.isChiusura_attesa_esito()==false) && 
	  (TicketDetails.getTipoCampione()==5 && TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) &&
      (TicketDetails.getNumeroAudit()>0 && TicketDetails.isCategoriaisAggiornata() == true && TicketDetails.isCategoriaAggiornabile()==true)) {
      System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#6");%>
<dhv:permission name="<%=permission_op_edit%>">
<input type="button" value="Chiudi tutto il controllo"  onClick="this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
</dhv:permission>			
<%} %>				 

<% if(TicketDetails.getSupervisionato_in_data()==null && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
    System.out.println("Dettaglio CU ["+TicketDetails.getId()+"] IF#7");%>
<dhv:permission name="vigilanza-vigilanza-supervisiona-view">
&nbsp;&nbsp;&nbsp;&nbsp;<a class="ovalbutton" href ="#dialog10" name = "modal"><span>Supervisione Documentale</span></a>
</dhv:permission>
<% }%>
			
			