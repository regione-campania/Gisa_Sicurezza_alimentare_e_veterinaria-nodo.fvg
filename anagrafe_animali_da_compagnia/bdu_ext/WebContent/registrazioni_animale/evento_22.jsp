<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoEsitoControlli,org.aspcfs.modules.opu.base.*"%>

<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="esitoList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />



<%
	EventoEsitoControlli eventoF = (EventoEsitoControlli) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di inserimento
	controlli</th>

	<tr>
		<td><b><dhv:label name="">Data di registrazione degli esiti</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataEsito())%>&nbsp;</td>
	</tr>

	<%
		if (eventoF.isFlagEhrlichiosi()) {
	%>
	<tr class="containerBody">
		<td valign="top" class="formLabel2"><dhv:label name="">Ehrlichiosi</dhv:label>
		</td>
		<td>Esito <%=esitoList.getSelectedValue(eventoF
								.getEsitoEhrlichiosi())%> del <%=toDateasString(eventoF.getDataEhrlichiosi())%></td>

	</tr>
	<%
		}
	%>
	<%
		if (eventoF.isFlagRickettiosi()) {
	%>
	<tr class="containerBody">
		<td valign="top" class="formLabel2"><dhv:label name="">Rickettiosi</dhv:label>
		</td>

		<td>Esito <%=esitoList.getSelectedValue(eventoF
								.getEsitoRickettiosi())%> del <%=toDateasString(eventoF.getDataRickettiosi())%></td>

	</tr>
	<%
		}
	%>



</table>


</table>







</table>