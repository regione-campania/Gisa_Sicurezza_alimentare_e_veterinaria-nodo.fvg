<%@page import="org.aspcfs.modules.anagrafe_animali.base.Animale"%>

<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoRegistrazioneBDU,org.aspcfs.modules.opu.base.*"%><jsp:useBean
	id="tipoSoggettoSterilizz" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="listaPratiche" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
	
	<jsp:useBean id="provinceList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"	scope="request" />
	<jsp:useBean id="nazioniList" class="org.aspcfs.utils.web.LookupList"	scope="request" />
	
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />

<%
	EventoRegistrazioneBDU eventoF = (EventoRegistrazioneBDU) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>

<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoSterilizzazione"%>

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di inserimento in BDU</th>

	<tr>
		<td><b><dhv:label name="">Data dell'inserimento</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataRegistrazione())%>&nbsp;</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Proprietario/Detentore destinatari registrazione</dhv:label></b></td>
		<td>
			<%
				Operatore proprietario = eventoF.getIdProprietarioOriginarioRegistrazione();
				if (proprietario != null) {
					Stabilimento stab = (Stabilimento) (proprietario.getListaStabilimenti().get(0));
					LineaProduttiva linea = (LineaProduttiva) (stab.getListaLineeProduttive().get(0));
			%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietario.getRagioneSociale())%></a>
			<%
				} else {
			%> -- <%
				}
			%>/ <%
				Operatore detentore = eventoF.getIdDetentoreOriginarioRegistrazione();
				if (detentore != null) {
					Stabilimento stab1 = (Stabilimento) (detentore.getListaStabilimenti().get(0));
					LineaProduttiva linea1 = (LineaProduttiva) (stab1.getListaLineeProduttive().get(0));
			%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea1.getId()%>"><%=toHtml(detentore.getRagioneSociale())%>&nbsp;</a>
			<%
				} else {
			%> -- <%
				}
			%>
		</td>
		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Attivit&agrave; in anagrafe itinerante</dhv:label></b></td>
		<td><%=(eventoF.isFlagAttivitaItinerante()) ? "SI" : "NO"%></td>
		<% if (eventoF.isFlagAttivitaItinerante()){%>
			<tr>
				<td><b><dhv:label name="">Data svolgimento attivit&agrave;</dhv:label></b></td>
				<td><%=toDateasString(eventoF.getDataAttivitaItinerante())%>&nbsp;
				</td>
			</tr>
			<tr>
				<td><b><dhv:label name="">Comune svolgimento attivit&agrave;</dhv:label></b></td>
				<td><%=comuniList.getSelectedValue(eventoF.getIdComuneAttivitaItinerante())%>
				</td>
			</tr>
			<tr>
				<td><b><dhv:label name="">Luogo svolgimento attivit&agrave;</dhv:label></b></td>
				<td><%=eventoF.getLuogoAttivitaItinerante()%></td>
			</tr>
		<%} %>
	</tr>
	
	
	
	
				<!-- GESTIONE ORIGINE ANIMALE -->
			<tr>
				<th colspan="2"><strong>Dati provenienza animale mai anagrafato</strong>
				</th>
			
			</tr>
			<% boolean origine = false; 
			if (eventoF.getProvenienza_origine()!=null && !eventoF.getProvenienza_origine().equals("")){ origine=true; %>
				<tr>
					<td><dhv:label name="">Origine animale</dhv:label></td>
					<td><%=(eventoF.getProvenienza_origine().contains("in") ? "In regione" : "Fuori regione")%></td>
				</tr>
			<% } %>
			
			
			<% if(eventoF.getIdProprietarioProvenienza()>0){ origine=true;%>
				<tr>
					<td><dhv:label name="">Provienienza</dhv:label></td>
					<td>Da proprietario</td>
				</tr>
				<tr>
					<td><dhv:label name="">Proprietario</dhv:label></td>
					<td>
					<% Operatore proprietarioProvenienza = eventoF.getIdProprietarioProvenienzaOp();
					if (proprietarioProvenienza != null) {
						if (proprietarioProvenienza.getIdOperatore()<10000000){
							Stabilimento stab = (Stabilimento) (proprietarioProvenienza.getListaStabilimenti().get(0));
							LineaProduttiva linea = (LineaProduttiva) (stab.getListaLineeProduttive().get(0));
							%> 
							<a href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietarioProvenienza.getRagioneSociale())%></a><br>
							<%
						}else{ 
						if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){%>
							<%=toHtml(proprietarioProvenienza.getRagioneSociale())%><br>
					<%	}}
					} %></td></tr>
			<% } %>

				<%
				if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){
				if(eventoF.getId_animale_madre()>0){  origine=true; %>
				<tr>
					<td ><dhv:label name="">Microchip Madre</dhv:label></td>
					<td>
					<% Animale animaleMadre = eventoF.getIdAnimaleMadreOgg();
					if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))){%>
					<%=toHtml(animaleMadre.getMicrochip())%><br>
					<%}else{ %>
					
					<a href="AnimaleAction.do?command=Details&animaleId=<%=animaleMadre.getIdAnimale()%>&idSpecie=<%=animaleMadre.getIdSpecie()%>"><%=toHtml(animaleMadre.getMicrochip())%></a><br>
					<%} %>
					</td></tr>
					
						<% } else if(eventoF.getMicrochip_madre()!=null){ %>
						<tr>
						<td><dhv:label name="">Microchip Madre</dhv:label></td>
						<td>
						<%=toHtml(eventoF.getMicrochip_madre())%><br>
						<%} %>
						</td></tr>

					<% if(!(("").equals(eventoF.getCodice_fiscale_proprietario_provenienza())) || eventoF.getCodice_fiscale_proprietario_provenienza() == null){  origine=true; %>
					<tr>
					<td><dhv:label name="">Codice Fiscale proprietario</dhv:label></td>
					<td> 
					<%=toHtml(eventoF.getCodice_fiscale_proprietario_provenienza())%><br>
					</td></tr>
					
					
						<% } %>
				<% if(!(("").equals(eventoF.getRagione_sociale_prov()))|| eventoF.getRagione_sociale_prov()==null ){  origine=true; %>
				<tr>
					<td><dhv:label name="">Ragione sociale provenienza</dhv:label></td>
					<td> 
					<%=toHtml(eventoF.getRagione_sociale_prov())%><br>
					</td></tr>
					
					
						<% } }%>
			<% if (eventoF.getData_ritrovamento()!= null && !eventoF.getData_ritrovamento().equals("")){ origine=true;%>
			<tr>
				<td><dhv:label name="">Provienienza</dhv:label></td>
				<td>Da ritrovamento</td>
			</tr>
			<tr>
				<td><dhv:label name="">Dettaglio ritrovamento</dhv:label></td><td>
			<%	out.println("Ritrovato in "+eventoF.getIndirizzo_ritrovamento()+", "+comuniList.getSelectedValue(Integer.parseInt(eventoF.getComune_ritrovamento()))+" - "+provinceList.getSelectedValue(Integer.parseInt(eventoF.getProvincia_ritrovamento()))+" in data ");
				out.println(eventoF.getData_ritrovamento()); %></td></tr>
			<% } %>

			<% if(eventoF.isFlag_anagrafe_estera()){ origine=true; %>
				<tr>
					<td><dhv:label name="">Origine animale</dhv:label></td>
					<td>Provenienza da nazione estera</td>
				</tr>
				<tr>
					<td><dhv:label name="">Nazione di provenienza</dhv:label></td>
					<td><%	out.print(nazioniList.getSelectedValue(Integer.parseInt(eventoF.getNazione_estera()))+"<br>");
							out.print("Note: "+eventoF.getNazione_estera_note());%>
					</td>
				</tr>
			<% } %>
			
			<% if(eventoF.isFlag_anagrafe_fr()){ origine=true;%>
				<tr>
					<td><dhv:label name="">Proveniente da anagrafe altra regione</dhv:label></td>
					<% String regione = "";
					
					  if (eventoF.getRegione_anagrafe_fr()!=null && !eventoF.getRegione_anagrafe_fr().equals("")){
						  regione= regioniList.getSelectedValue(Integer.parseInt(eventoF.getRegione_anagrafe_fr()));
					  }
					  String note ="";
					  if(eventoF.getRegione_anagrafe_fr_note()!= null ) 
					     note =   eventoF.getRegione_anagrafe_fr_note() ; 
					  
					%>
					<td><% out.print("Regione "+  regione +"<br>");
						   out.print("Note: "+ note);	%>
					</td>
				</tr>
			<% } %>

			<% if(eventoF.isFlag_acquisto_online()){ origine=true;%>
				<tr>
					<td><dhv:label name="">Acquisto online tramite</dhv:label></td>
					<td><% out.print(eventoF.getSito_web_acquisto());	%>
					</td>
				</tr>
			<% } %>
			
			<% if (!origine){ %>
				<tr>
					<td colspan="2">Informazioni mancanti sull'origine dell'animale</td>
				</tr>
			<% } %>
			<!-- FINE ORIGINE -->			
</table>