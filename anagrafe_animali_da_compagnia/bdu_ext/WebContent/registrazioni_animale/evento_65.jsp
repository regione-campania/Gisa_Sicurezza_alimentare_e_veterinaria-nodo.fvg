<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<jsp:useBean id="listaMedicoEsecutore" class="org.aspcfs.utils.web.LookupList"	scope="request" />
<jsp:useBean id="listaInterventoEseguito" class="org.aspcfs.utils.web.LookupList"	scope="request" />
<jsp:useBean id="listaCausale" class="org.aspcfs.utils.web.LookupList"	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="veterinariList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="veterinariAslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoMutilazione eventoMut = (EventoMutilazione) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>

<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoMutilazione"%>

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di mutilazione  
	<a href="#" onclick="openRichiestaPDF('PrintDocumentoMutilazione', '<%=eventoMut.getIdAnimale()%>','<%=eventoMut.getSpecieAnimaleId()%>', '-1', '-1', <%=eventoMut.getIdEvento() %>)" id="" target="_self">Documento di mutilazione</a>
	</th>

	<tr>
		<td><b><dhv:label name="">Data della mutilazione</dhv:label></b></td>
		<td><%=toDateasString(eventoMut.getDataMutilazione())%>&nbsp;
		</td>
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Medico esecutore</dhv:label></b></td>
		<td><%=listaMedicoEsecutore.getSelectedValue(eventoMut.getIdMedicoEsecutore())%></td>
	</tr>
	
	<% if (eventoMut.getIdMedicoEsecutore() == EventoMutilazione.idTipoSoggettoASL) { %>
	<tr>
		<td><b>Veterinario ASL</b></td>
		<td><%=veterinariAslList.getSelectedValue(eventoMut.getIdVeterinarioASL())%></td>
	</tr>
	<% } else if (eventoMut.getIdMedicoEsecutore() == EventoMutilazione.idTipoSoggettoLLPP) { %>
	<tr>
		<td><b>Veterinario LLPP</b></td>
		<td><%=veterinariList.getSelectedValue(eventoMut.getIdVeterinarioLLPP())%></td>
	</tr>
	<% } %>
	
	<tr>
		<td><b><dhv:label name="">Intervento eseguito</dhv:label></b></td>
		<td><%=listaInterventoEseguito.getSelectedValue(eventoMut.getIdInterventoEseguito())%></td>
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Causale</dhv:label></b></td>
		<td><%=listaCausale.getSelectedValue(eventoMut.getIdCausale())%></td>
	</tr>

</table>