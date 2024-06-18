<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoPresaInCaricoDaCessione,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
EventoPresaInCaricoDaCessione eventoF = (EventoPresaInCaricoDaCessione) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della cessione</th>

	<tr>
		<td><b><dhv:label name="">Data presa in carico da cessione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataPresaCessione())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Proprietario corrente</dhv:label></b>
		</td>
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
		%> -- <%
			}
		%> </td>
	</tr>
	

</table>