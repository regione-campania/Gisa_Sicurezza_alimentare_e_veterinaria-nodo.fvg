<%if (TicketDetails.isflagBloccoCu()==true){
		%>
		
		<font color = "red" ><%=TicketDetails.getNoteBlocco() %></font><br><br>
	
	<% if (TicketDetails.getClosed() == null && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) { %>
	   
	   <%
	   if (TicketDetails.isControllo_chiudibile()==true && TicketDetails.getClosed()==null)
	   {
	   %>
	    <dhv:permission name="<%=permission_op_edit %>">
			<input type="button"
			value="Chiusura Cu Pregresso" onClick="javascript:this.form.action='<%=OrgDetails.getAction()  %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdStabilimento() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
			
			
					
			</dhv:permission>
		<%} }%>
		
		
		 <%
	   if (TicketDetails.isControllo_chiudibile()==false && TicketDetails.getClosed()==null)
	   {
	   %>
		<%if(TicketDetails.getIdStabilimento() > 0) {%>
			<input type="button"
			value="Chiusura Cu Pregresso"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdStabilimento() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% } else { %>
			<input type="button"
			value="Chiusura Cu Pregresso"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdApiario() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% } }
	   else
		 if ( TicketDetails.isChiusura_attesa_esito()==true   && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
				{
					%>
					
					<%if(TicketDetails.getIdStabilimento() > 0) { %>
					
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
					
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&idStabilimentoopu=<%=TicketDetails.getIdStabilimento() %>')"> --%>
					<% } else { %>
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&idStabilimentoopu=<%=TicketDetails.getIdApiario() %>')"> --%>
					
					<% } %>
					
			
				<%
					
				}
		 
		
	
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
	
<%
if(request.getAttribute("isPresenteRegistrazione")==null || !((Boolean)request.getAttribute("isPresenteRegistrazione")) || User.getRoleId()==Role.HD_1LIVELLO || User.getRoleId()==Role.HD_2LIVELLO)
{
%>
		<input type="button"
			value="<dhv:label name="button.reopen">Reopen</dhv:label>"
			onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ReopenTicket&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
<%
}
%>

	</dhv:permission>
	<%
			}
			else
			{
				if ( TicketDetails.isChiusura_attesa_esito()==true  && TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
				{
					%>
					<%if(TicketDetails.getIdStabilimento() > 0) { %>
					
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
					
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&idStabilimentoopu=<%=TicketDetails.getIdStabilimento() %>')"> --%>
					<% } else { %>
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&idStabilimentoopu=<%=TicketDetails.getIdApiario() %>')"> --%>
					
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
		<%if(TicketDetails.getIdStabilimento() > 0) { %>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdStabilimento()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } else { %>
			<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdApiario()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } %>
		<%
			} else {
				 if(TicketDetails.isflagBloccoCu() == false  && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
		%>
		<% if(TicketDetails.getIdStabilimento() > 0) {%>
		 <input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdStabilimento()%>&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } else { %>
			<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdApiario()%>&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } %> 
		<%
			}}
		
			} else if(TicketDetails.isflagBloccoCu() == false) {
		%>
		<%if(TicketDetails.getIdStabilimento() > 0) { %>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdStabilimento()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
			<% } else { %>
			<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=OrgDetails.getAction() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getIdApiario()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
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
	if (TicketDetails.isControllo_chiudibile()==true)
	{
	%>
		<input type="button"
			value="chiudi tutto il controllo 2"
			<%if(TicketDetails.getTipologiaOperatore()==1){ %>
			onClick="this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
			<%}
		else{%>	onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
		<%} %>
		
	<%-- if (request.getAttribute("shedaBenessere")!=null){ %>
		<input type="button" style="background:green"
			value="Chiudi CU senza lista di riscontro in assenza di non conformità"
			 onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiInAssenzaDiNc&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		<% } --%>
			
	<%}
	else
	{
		if(User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		
		%>
			<%if(TicketDetails.getIdStabilimento() > 0) {%>
			<input type="button"
			value="chiudi tutto il controllo 4"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdStabilimento() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% } else { %>
			<input type="button"
			value="chiudi tutto il controllo 7"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdApiario() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% } %>
			
	
		<%
		}
		
	}
	} }
	%>

	</dhv:permission>
	
	
	
	<dhv:permission name="<%="old_permission_op_edit"%>">
	<%
	if(TicketDetails.isflagBloccoCu() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {
	if (TicketDetails.isControllo_chiudibile()==true || TicketDetails.getTipoCampione()==5)
	{
	%>
		<input type="button"
			value="chiudi tutto il controllo 1"
			<%if(TicketDetails.getTipologiaOperatore()==1){ %>
			onClick="this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
			<%}
		else{%>	onClick="javascript:this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">
		<%} %>
		
			<%-- if (request.getAttribute("shedaBenessere")!=null){ %>
		<input type="button" style="background:green"
			value="Chiudi CU senza lista di riscontro in assenza di non conformità"
			 onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiInAssenzaDiNc&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		<% } --%>
		
	<%}
	else
	{
		if(User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		
		%>
			<%if(TicketDetails.getIdStabilimento() > 0) {%>
			<input type="button"
			value="chiudi tutto il controllo 9"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdStabilimento() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% } else { %>
			<input type="button"
			value="chiudi tutto il controllo 12"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=OrgDetails.getAction() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&idStabilimentoopu=<%=TicketDetails.getIdApiario() %>&id=<%= TicketDetails.getId() %>';submit();">
			<% } %>
			
	
		<%
		}
		
	}
	}
	%>
	
	
		<input type="button"
			value="chiudi tutto il controllo 45" 
			onClick="this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};"
			/>
	
	</dhv:permission>
	
	<%
	
	if(TicketDetails.getNumeroAudit()>0 && TicketDetails.isCategoriaisAggiornata() == false && TicketDetails.isCategoriaAggiornabile()==true && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		if(TicketDetails.getAssetId()>0)
		{
		%>
		
		<%if(TicketDetails.getIdStabilimento() > 0) {%>
		<input type="button"
			value="Aggiorna Categoria"
			onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getIdStabilimento() %>,<%=TicketDetails.getAssetId() %>)">
	<% } else { %>
	<input type="button"
			value="Aggiorna Categoria"
			onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getIdApiario() %>,<%=TicketDetails.getAssetId() %>)">
	<% } %>
	<%
		}else
		{
			
			if(TicketDetails.getIdStabilimento() > 0){
			%>
				<input type="button"
			value="Aggiorna Categoria E CHIUDI TUTTO IL CONTROLLO 99"
			onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getIdStabilimento() %>)">
			<%
			}else{%>
				
				<input type="button"
			value="Aggiorna Categoria E CHIUDI TUTTO IL CONTROLLO 55"
			onClick="aggiornaCategoria('<%=OrgDetails.getAction()%>CheckList',<%=TicketDetails.getId() %>,<%=TicketDetails.getIdApiario() %>)">
			<% }
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