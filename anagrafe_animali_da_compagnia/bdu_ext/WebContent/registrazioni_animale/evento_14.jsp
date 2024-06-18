<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoRestituzioneACanile,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />

<%
EventoRestituzioneACanile eventoF = (EventoRestituzioneACanile) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della restituzione a canile</th>

	<tr>
		<td><b><dhv:label name="">Data della restituzione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataRestituzioneCanile())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Proprietario originario</dhv:label></b>
		</td>
		<td>
		<%
			Operatore proprietario = eventoF.getVecchioProprietario();
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
		%>
		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Sindaco nuovo proprietario</dhv:label></b></td>
		<td>
		<%
			Operatore sindaco = eventoF.getNuovoProprietarioSindaco();
			if (sindaco != null) {
				Stabilimento stab = (Stabilimento) (sindaco
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(sindaco.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Nuovo detentore canile</dhv:label></b></td>
		<td>
		
		<%
			Operatore canile = eventoF.getNuovoDetentoreCanile();
			if (proprietario != null) {
				Stabilimento stab = (Stabilimento) (canile
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(canile.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
		
		
	</tr>


</table>