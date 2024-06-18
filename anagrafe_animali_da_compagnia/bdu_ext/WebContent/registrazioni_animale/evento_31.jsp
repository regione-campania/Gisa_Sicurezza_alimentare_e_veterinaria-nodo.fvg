<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoCanile,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoTrasferimentoCanile eventoF = (EventoTrasferimentoCanile) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli del trasferimento di canile</th>

	<tr>
		<td><b><dhv:label name="">Data del trasferimento</dhv:label></b></td>
		<td><%=toDateasString(eventoF
									.getDataTrasferimentoCanile())%>&nbsp;</td>
	</tr>


	<tr>
		<td><b><dhv:label name="">Proprietario (sindaco) </dhv:label></b></td>
		<td>
		<%
			Operatore proprietario = eventoF.getProprietario();
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
		<td><b><dhv:label name="">Detentore canile (prima del trasferimento) </dhv:label></b></td>
		<td>
		<%
			Operatore detentoreOLD = eventoF.getCanileOld();
			if (detentoreOLD != null) {
				Stabilimento stab = (Stabilimento) (detentoreOLD
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(detentoreOLD.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
	</tr>


	<tr>
		<td><b><dhv:label name="">Nuovo canile detentore </dhv:label></b></td>
		<td>
		<%
			Operatore detentore = eventoF.getCanileDetentore();
			if (detentore != null) {
				Stabilimento stab = (Stabilimento) (detentore
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(detentore.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
	</tr>
	<tr>
	 <tr>
		<td><b><dhv:label name="">Dati del detentore fuori regione</dhv:label></b></td>
		<% if (eventoF.getDatiDetentoreFuoriRegione() != null && !("").equals(eventoF.getDatiDetentoreFuoriRegione())){%>
		
		<td><%=	eventoF.getDatiDetentoreFuoriRegione()%></td>

		<%}%>
</tr>
</table>