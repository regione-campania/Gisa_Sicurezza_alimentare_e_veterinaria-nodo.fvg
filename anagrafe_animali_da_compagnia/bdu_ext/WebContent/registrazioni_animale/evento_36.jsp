<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoInserimentoVaccinazioni,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="tipoVaccinazione"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoFarmaco"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoVaccinoInoculato"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="veterinariList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />

<%
	EventoInserimentoVaccinazioni eventoF = (EventoInserimentoVaccinazioni) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>

<jsp:useBean id="animaleDettaglio" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di inserimento
	vaccinazione
<%
	if(eventoF.getIdTipoVaccino()==1 && (User.getRoleId()==new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) || User.getRoleId()==new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2")) || User.getRoleId() == 18))
	{
%>
		--  <a href="#"
			onclick="openRichiestaPDF('PrintCertificatoVaccinazioneAntiRabbia', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento() %>');"
			id="" target="_self">Stampa certificato</a>
<%
	} 
%>
</th>

	<tr>
		<td><b><dhv:label name="">Data della vaccinazione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataVaccinazione())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Tipologia vaccinazione</dhv:label></b>
		</td>
		<td><%=tipoVaccinazione.getSelectedValue(eventoF.getIdTipoVaccino())%></td>
	</tr>
	<% if(eventoF.getFarmaco() > 0){ %>
	<tr>
		<td><b><dhv:label name="">Farmaco</dhv:label></b></td>
		<td><%=tipoFarmaco.getSelectedValue(eventoF.getFarmaco())%></td>
	</tr>
	<% } %>
	<tr>
		<td width="20%"><b><dhv:label name="">Tipo vaccino inoculato</dhv:label></b>
		</td>
		<td><%=tipoVaccinoInoculato.getSelectedValue(eventoF.getIdTipologiaVaccinoInoculato())%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Nr. lotto vaccino</dhv:label></b></td>
		<td><%=(eventoF.getNumeroLottoVaccino() != null && !("").equals(eventoF.getNumeroLottoVaccino())) ? eventoF.getNumeroLottoVaccino() : "---"%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Dosaggio</dhv:label></b></td>
		<td><%=(eventoF.getDosaggio() != null && !("").equals(eventoF.getDosaggio())) ? eventoF.getDosaggio() : "--"  %></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Scadenza vaccino</dhv:label></b></td>
		<td><%=(eventoF.getDataScadenzaVaccino() != null && !("").equals(eventoF.getDataScadenzaVaccino())) ? toDateasString(eventoF.getDataScadenzaVaccino()) : "--"  %></td>
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Veterinario esecutore</dhv:label></b></td>
		<td><%=(eventoF.getIdVeterinarioEsecutoreAccreditato() > 0) ? veterinariList.getSelectedValue(eventoF.getIdVeterinarioEsecutoreAccreditato()) :( (eventoF.getVeterinarioEsecutore() != null && !("").equals(eventoF.getVeterinarioEsecutore())) ? (eventoF.getVeterinarioEsecutore()) : "--")  %></td>
	</tr>
	

	
	
</table>