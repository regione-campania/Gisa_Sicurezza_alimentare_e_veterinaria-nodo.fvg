<%if (TicketDetails.isflagBloccoCu()==true){
		%>
		
		<font color = "red" ><%=TicketDetails.getNoteBlocco() %></font><br><br>
	
	<% if (TicketDetails.getClosed() == null && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) { %>
	   
	    <dhv:permission name="operazioni-hd-view">
			<input type="button"
			value="Chiusura Cu Pregresso" onClick="javascript:this.form.action='<%=OrgDetails.getAction()  %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
			</dhv:permission>
		<%} %>
		
		 
	<%
	
	}

TicketDetails.setActionChecklist();
TicketDetails.setActionChecklist();

if(TicketDetails.isTrashed())
{
	%>
	<dhv:permission name="reopen-reopen-delete">
	<input type="button"
			value="Ripristina"
			onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=Restore&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>
	<%
	
}else
	 if (TicketDetails.getClosed() != null || TicketDetails.isChiusura_attesa_esito()==true) {
			if (TicketDetails.getClosed() != null && TicketDetails.getTipoCampione()!=5 && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
			{
	%>
	<dhv:permission name="reopen-reopen-view">
		<input type="button"
			value="APRI DI NUOVO"
			onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ReopenTicket&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>
	<%
			}
			else
			{
				if ( TicketDetails.isChiusura_attesa_esito()==true  && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
				{
					%>
					<%if(TicketDetails.getAltId() > 0) { %>
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&altId=<%=TicketDetails.getAltId() %>')"> --%>
					<% } %>
					
				<%
					
				}
				
			}
	
		} else {
			if (TicketDetails.isflagBloccoCu()==false &&  User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
			{
			
	%>
	<dhv:permission name="<%=permission_op_edit%>">
		<input type="button"
			value="Modifica"
			onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ModifyTicket&auto-populate=true<%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>
	<%} %>
	
	<% if(TicketDetails.isCategoriaisAggiornata() == false  && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {%>
	<dhv:permission name="<%=permission_op_del%>">
		<%
			if ("searchResults".equals(request
								.getParameter("return"))) {
		%>
		
		<% if (TicketDetails.isVincoloRegistro()) {%>
		<%if(TicketDetails.getAltId() > 0) { %>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&altId=<%=TicketDetails.getAltId()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% }  %>
		<%
			} else {
				 if(TicketDetails.isflagBloccoCu() == false  && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
		%>
		<% if(TicketDetails.getAltId() > 0) {%>
		 <input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&altId=<%=TicketDetails.getAltId()%>&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } %> 
		<%
			}}
		
			} else if(TicketDetails.isflagBloccoCu() == false) {
		%>
		<%if(TicketDetails.getAltId() > 0) { %>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&altId=<%=TicketDetails.getAltId()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } %>
			<%
			}
		%>
		
	</dhv:permission>
	
	<%} %>
	
	
		<dhv:permission name="<%=permission_op_edit%>">
	<%
	if (TicketDetails.getTipoCampione()!=5) {
	if(TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
	if (TicketDetails.isControllo_chiudibile()==true )
	{
	%>
		<input type="button"
			value="chiudi tutto il controllo"
			<%if(TicketDetails.getTipologiaOperatore()==1){ %>
			onClick="this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
			<%}
		else{%>	onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
		<%} %>
	<%}
	else
	{
		if(User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		
		%>
			<%if(TicketDetails.getAltId() > 0) {%>
			<input type="button"
			value="chiudi tutto il controllo"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&altId=<%=TicketDetails.getAltId() %>&id=<%= TicketDetails.getId() %>';submit();">
			
			
			<%
		}}
		
	}
	} }
	%>

	</dhv:permission>
	
	
	
	<dhv:permission name="<%="old_permission_op_edit"%>">
	<%
	if(TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
	if (TicketDetails.isControllo_chiudibile()==true )
	{
	%>
		<input type="button"
			value="chiudi tutto il controllo"
			<%if(TicketDetails.getTipologiaOperatore()==1){ %>
			onClick="this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
			<%}
		else{%>	onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
		<%} %>
	<%}
	else
	{
		if(User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		
		%>
			<%if(TicketDetails.getAltId() > 0) {%>
			<input type="button"
			value="chiudi tutto il controllo"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&altId=<%=TicketDetails.getAltId() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% }  %>
			
	
		<%
		}
		
	}
	}
	%>
	
	
		<input type="button"
			value="chiudi tutto il controllo" 
			onClick="this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};"
			/>
	
	</dhv:permission>
	
	<%
	
	if((TicketDetails.getNumeroAudit()>0 || (TicketDetails.isChecklistLibera() && TicketDetails.getPunteggio()>0)) && TicketDetails.isCategoriaisAggiornata() == false && TicketDetails.isCategoriaAggiornabile()==true && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		if(TicketDetails.getAssetId()>0)
		{
		%>
		
		<%if(TicketDetails.getAltId() > 0) {%>
		<input type="button"
			value="Aggiorna Categoria"
			onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getAltId() %>,<%=TicketDetails.getAssetId() %>)">
	<% } %>
	<%
		}else
		{
			
			if(TicketDetails.getAltId() > 0){
			%>
				<input type="button"
			value="Aggiorna Categoria E CHIUDI TUTTO IL CONTROLLO"
			onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getAltId() %>)">
			<%
			}
		}
		}
		}

if(TicketDetails.getSupervisionato_in_data()==null && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
{
	%> 
		<dhv:permission name="vigilanza-vigilanza-supervisiona-view">
	
		&nbsp;&nbsp;&nbsp;&nbsp;<a class="ovalbutton" href ="#dialog10" name = "modal"><span>Supervisiona</span></a>
	</dhv:permission>

	
	<%
	
}
	%>