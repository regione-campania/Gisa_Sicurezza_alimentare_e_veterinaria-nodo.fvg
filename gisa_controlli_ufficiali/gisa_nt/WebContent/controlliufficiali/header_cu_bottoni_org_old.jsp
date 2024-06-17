<%if (TicketDetails.isflagBloccoCu()==true )
		{
		%>
		
	
	<% if (TicketDetails.getClosed() == null && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) { %>
	   
	    <dhv:permission name="<%=permission_op_edit %>">
			
		
		 <%
	   if (TicketDetails.isControllo_chiudibile()==false  && TicketDetails.getClosed()==null)
	   {
	   %>
		<input type="button"
			value="Chiusura CU Pregresso"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';loadModalWindow();submit();">
			
			<%}else {
			
				if ( (TicketDetails.isChiusura_attesa_esito()==true ))
				{
					%>
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
					
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&orgId=<%=TicketDetails.getOrgId() %>')"> --%>
					
					
					
			
				<%
					
				}%>
			<%} %>
			
			 <%
	   if (TicketDetails.isControllo_chiudibile()==true && TicketDetails.getClosed()==null)
	   {
	   %>
		
		<% if (request.getAttribute("hasChecklistBenessere")!=null && (Boolean)request.getAttribute("hasChecklistBenessere")==false) { %> 
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di almeno una checklist benessere salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistCondizionalita")!=null && (Boolean)request.getAttribute("hasChecklistCondizionalita")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist condizionalita' salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistBiosicurezza")!=null && (Boolean)request.getAttribute("hasChecklistBiosicurezza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist biosicurezza salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistFarmacosorveglianza")!=null && (Boolean)request.getAttribute("hasChecklistFarmacosorveglianza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist farmacosorveglianza salvata definitivamente.</font>
	   <% } else { %>
	   <input type="button" value="chiusura cu pregresso" onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		<%} %>	
			
						
			<%
	   }
			
	%>
		
		 </dhv:permission>
	<%}
	
	}
	

TicketDetails.setActionChecklist();
TicketDetails.setActionChecklist();
if(TicketDetails.isTrashed())
{
	%>
	<dhv:permission name="reopen-reopen-delete">
	<input type="button"
			value="Ripristina"
			onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=Restore&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';loadModalWindow();submit();">
	</dhv:permission>
	<%
	
}else
	 if (TicketDetails.getClosed() != null || TicketDetails.isChiusura_attesa_esito()==true) {
		if ((TicketDetails.getClosed() != null && TicketDetails.getTipoCampione()!=5 && TicketDetails.isflagBloccoCu()==false)&& User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
			{
	%>
	<dhv:permission name="reopen-reopen-view">
<%
if(request.getAttribute("isPresenteRegistrazione")==null || !((Boolean)request.getAttribute("isPresenteRegistrazione")) || User.getRoleId()==Role.HD_1LIVELLO || User.getRoleId()==Role.HD_2LIVELLO)
{
%>
	
		<input type="button"
			value="<dhv:label name="button.reopen">Reopen</dhv:label>"
			onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ReopenTicket&TimeIni=<%=System.currentTimeMillis() %>&stabId=<%=TicketDetails.getIdStabilimento() %>&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';loadModalWindow();submit();">
<%
}
%>
	</dhv:permission>
	<%
			}
			else
			{
				if ( (TicketDetails.isChiusura_attesa_esito()==true && TicketDetails.isflagBloccoCu()==false)&& User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
				{
					%>
<!-- 					<input type="button" -->
<!-- 					value="Annulla Chiusura Momentanea" -->
					
<%-- 					onClick="javascript:riapriChiusuraTemp('PrintReportVigilanza.do?command=AnnullaChiusuraTemp&id=<%= TicketDetails.getId() %>','<%= TicketDetails.getURlDettaglio() %>Vigilanza.do?command=TicketDetails&id=<%=TicketDetails.getId() %>&orgId=<%=TicketDetails.getOrgId() %>')"> --%>
					
					
					
			
				<%
					
				}
				
			}
	
		} else {
			
			if (TicketDetails.isflagBloccoCu()==false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
			{
	%>
	<dhv:permission name="<%=permission_op_edit%>">
		<input type="button"
			value="Modifica"
			onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ModifyTicket&auto-populate=true<%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';loadModalWindow();submit();">
	</dhv:permission>
	
	<%}%>
	
		
	<% 
	if(TicketDetails.isCategoriaisAggiornata() == false && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo()) {%>
	<dhv:permission name="<%=permission_op_del%>">
	
	<% 
	//if (TicketDetails.isVincoloRegistro()) {%>
		<%
			if ("searchResults".equals(request
								.getParameter("return"))) {
		%>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getOrgId()%>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
		<%
			} else if(TicketDetails.isflagBloccoCu() == false) {
		%>
		 <input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ConfirmDelete&assetId=<%=TicketDetails.getAssetId() %>&codiceallerta=<%= TicketDetails.getCodiceAllerta() %>&id=<%= TicketDetails.getId() %>&orgId=<%=TicketDetails.getOrgId()%>&popup=true', 'Delete_ticket','320','200','yes','no');"> 
		<%
			}
		%>
	<%// } %>	
		
		
	</dhv:permission>
	
	<%} %>
	
		<dhv:permission name="<%=permission_op_edit%>">
	<%
	if(TicketDetails.getTipoCampione() !=5) {
	if(TicketDetails.isflagBloccoCu() == false) {
	if (TicketDetails.isControllo_chiudibile()==true && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
	{
	%>
		
		
		<% if (request.getAttribute("hasChecklistBenessere")!=null && (Boolean)request.getAttribute("hasChecklistBenessere")==false) { %> 
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di almeno una checklist benessere salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistCondizionalita")!=null && (Boolean)request.getAttribute("hasChecklistCondizionalita")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist condizionalita' salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistBiosicurezza")!=null && (Boolean)request.getAttribute("hasChecklistBiosicurezza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist biosicurezza salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistFarmacosorveglianza")!=null && (Boolean)request.getAttribute("hasChecklistFarmacosorveglianza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist farmacosorveglianza salvata definitivamente.</font>
	   <% } else { %>
	   <input type="button" value="chiudi tutto il controllo" onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		<%} %>	
		
	<%}
	else 
	{	
		if( User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		%>
			<input type="button"
			value="chiudi tutto il controllo"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';loadModalWindow();submit();">
			
			
	
		<%
		}
		
	}
	} }//fine if presenza blocco
	%>
	</dhv:permission>
	
	
	
	
	<dhv:permission name="<%="old_permission_op_edit"%>">
	<%
	if(TicketDetails.isflagBloccoCu() == false) {
	if ((TicketDetails.isControllo_chiudibile()==true || TicketDetails.getTipoCampione()==5) && User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
	{
	%>

		<% if (request.getAttribute("hasChecklistBenessere")!=null && (Boolean)request.getAttribute("hasChecklistBenessere")==false) { %> 
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di almeno una checklist benessere salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistCondizionalita")!=null && (Boolean)request.getAttribute("hasChecklistCondizionalita")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist condizionalita' salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistBiosicurezza")!=null && (Boolean)request.getAttribute("hasChecklistBiosicurezza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist biosicurezza salvata definitivamente.</font>
	   <% } else if (request.getAttribute("hasChecklistFarmacosorveglianza")!=null && (Boolean)request.getAttribute("hasChecklistFarmacosorveglianza")==false) { %>
	   <font color="red">Attenzione. Il controllo non puo' essere chiuso perche' mancante di una checklist farmacosorveglianza salvata definitivamente.</font>
	   <% } else { %>
	   <input type="button" value="chiudi tutto il controllo" onClick="javascript:this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};">
		<%} %>			


	<%}
	else 
	{
		if( User.getUserRecord().getGruppo_ruolo()==UserUtils.getUserFormId(request, TicketDetails.getEnteredBy()).getGruppo_ruolo())
		{
		%>
			<input type="button"
			value="chiudi tutto il controllo"
			title="Chiude il Controllo in maniera momentanea in attesa di esito di campioni e tamponi"
			onClick="javascript:alert('ATTENZIONE! Stai per chiudere il controllo in maniera momentanea in attesa di esito di campioni e tamponi.');this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';loadModalWindow();submit();">
			
			
	
		<%
		}
		
	}
	}//fine if presenza blocco
	%>
	
		<input type="button"
			value="chiudi tutto il controllo" 
			onClick="this.form.action='<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=ChiudiTutto&TimeIni=<%=System.currentTimeMillis() %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere il Controllo Ufficiale? \n Attenzione! La pratica verrà chiusa e non sarà più possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){loadModalWindow();submit()};"
			/>
				
			
	
	</dhv:permission>
	
	
	

	
	
	<%
	
	if(TicketDetails.getNumeroAudit()>0 && TicketDetails.isCategoriaisAggiornata() == false && TicketDetails.isCategoriaAggiornabile()==true)
		{
		if(TicketDetails.getAssetId()>0)
		{
		%>
		<input type="button"
			value="Aggiorna Categoria"
			onClick="aggiornaCategoria(<%=TicketDetails.getId() %>,<%=TicketDetails.getOrgId() %>,<%=TicketDetails.getAssetId() %>)">
	
	<%
		}else
		{
			%>
				<input type="button"
			value="Aggiorna Categoria E CHIUDI TUTTO IL CONTROLLO"
			onClick="aggiornaCategoria(<%=TicketDetails.getId() %>,<%=TicketDetails.getOrgId() %>)">
			<%
			
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