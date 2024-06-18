<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoSindaco,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoTrasferimentoSindaco eventoF = (EventoTrasferimentoSindaco) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli del trasferimento</th>

	<tr>
		<td><b><dhv:label name="">Data del trasferimento</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataTrasferimento())%>&nbsp;</td>
	</tr>


	<tr>
		<td><b><dhv:label name="">Vecchio Proprietario </dhv:label></b></td>
		<td>
		<%
			Operatore proprietarioVecchio = eventoF.getVecchioProprietario();
			if (proprietarioVecchio != null) {
				Stabilimento stab = (Stabilimento) (proprietarioVecchio
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietarioVecchio.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
	</tr>


	<tr>
		<td><b><dhv:label name="">Vecchio Detentore </dhv:label></b></td>
		<td>
		<%
			Operatore detentoreOLD = eventoF.getVecchioDetentore();
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
		<td><b><dhv:label name="">Nuovo Proprietario </dhv:label></b></td>
		<td>
		<%
			Operatore proprietario = eventoF.getProprietario();
			if (proprietarioVecchio != null) {
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
		<td><b><dhv:label name="">Nuovo Detentore </dhv:label></b></td>
		<td>
		<%
			Operatore detentore = eventoF.getDetentore();
			if (detentoreOLD != null) {
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

</table>