<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoCessione,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoCessione eventoF = (EventoCessione) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della cessione</th>

	<tr>
		<td><b><dhv:label name="">Data della cessione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataCessione())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Proprietario originario / Asl</dhv:label></b>
		</td>
		<td>
		<%
			Operatore proprietarioold = eventoF.getVecchioProprietario();
			if (proprietarioold != null) {
				Stabilimento stab = (Stabilimento) (proprietarioold
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietarioold.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%> / <%=AslList.getSelectedValue(eventoF.getIdAslVecchioProprietario())%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Nuovo proprietario / Asl</dhv:label></b></td>
		<td>
		<%
			Operatore proprietario = eventoF.getNuovoProprietario();
			if (proprietario != null) {
				Stabilimento stab = (Stabilimento) (proprietario
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietario.getRagioneSociale())%></a>
		<%
			} else {
		%> <%=eventoF.getDestinazione() %> <%
			}
		%>/ <%=AslList.getSelectedValue(eventoF.getIdAslNuovoProprietario())%>
		</td>
	</tr>


</table>